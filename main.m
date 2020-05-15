%% ---------������ MIMO and SISO-------- 
clear;clc;close all;
%% ����������
flag_chanel = 'RAYL'; % 'AWGN' ,'RAYL','STATIC', 'BAD'
flag_cor_MIMO = 2; % 1-��������� ��� (���������� ��� MIMO) 2-��������
flag_cor_SISO = 1; % ��������� ��� (���������� ��� SISO)
flag_wav_MIMO = 1; % ������� �������������� ��� MIMO
flag_wav_SISO = 1; % ������� �������������� ��� SISO
%% ��������� ������� MIMO
prm.numTx = 2; % ���-�� ���������� �����
prm.numRx = 2; % ���-�� �������� �����
prm.numSTS = prm.numTx; % ���-�� �������
prm.M = 16;% ������� ���������
prm.bps = log2(prm.M); % ����-�� ��� �� ������ � �������
%% ��������� ������� SISO
prm.M_siso = 16;% ������� ���������
prm.bps_siso = log2(prm.M_siso); % ����-�� ��� �� ������ � �������
prm.Nsymb_ofdm_p = 1; % ���-�� �������� �������� OFDM 
%% ��������� OFDM 
prm.numSC = 450; % ���-�� �����������
prm.N_FFT = 512; % ����� FFT ��� OFDM
prm.Nsymb_ofdm = 100; % ���-�� �������� OFDM �� ������ �������
prm.CyclicPrefixLength = 64;  % ����� �������� ���������� = 2*Ngi
prm.tmp_NCI = prm.N_FFT - prm.numSC;
prm.NullCarrierIndices = [1:prm.tmp_NCI/2 prm.N_FFT-prm.tmp_NCI/2+1:prm.N_FFT]'; % Guards and DC
%------- 
prm.n = prm.bps*prm.Nsymb_ofdm*prm.numSC*prm.numTx;% ����� ��������� ������
prm.n_pilot = prm.Nsymb_ofdm_p*prm.numSC; % ���-�� ��� �� ������ SISO
prm.n_siso = prm.bps_siso*prm.Nsymb_ofdm*prm.numSC;% ����� ��������� ������
%% ��������� ������
prm.SampleRate = 40e6;
dt = 1/prm.SampleRate;
prm.tau = [0 1*dt 2*dt];
prm.pdB = [0 -9 -12];
%% ---------��� ������--------
if flag_cor_MIMO == 2
    ostbcEnc = comm.OSTBCEncoder('NumTransmitAntennas',prm.numTx);
    ostbcComb = comm.OSTBCCombiner('NumReceiveAntennas',prm.numRx);
    prm.n = prm.n/prm.numTx;
end 
SNR = 0+floor(10*log10(prm.bps)):50+floor(10*log10(prm.bps));
Exp = 50;% ���-�� �������
for indExp = 1:Exp
    %% �������� ������
    [H,H_siso] = create_chanel(flag_chanel,prm);  
    for indSNR = 1:length(SNR) 
        %% ��������� ������       
        Inp_data = randi([0 1],prm.n,1); % ������������ ������    
        Inp_Mat = reshape(Inp_data,length(Inp_data)/prm.bps,prm.bps); %���������� ���� 
        Inp_Sym = bi2de(Inp_Mat);  % ������� ������ � ��������
        % SISO
        Inp_data_siso = randi([0 1],prm.n_siso,1); % ������������ ������    
        Inp_Mat_siso = reshape(Inp_data_siso,length(Inp_data_siso)/prm.bps_siso,prm.bps_siso); %���������� ���� 
        Inp_Sym_siso = bi2de(Inp_Mat_siso);  % ������� ������ � ��������
        % ��������� ������ ��� SISO 
        Inp_data_pilot = randi([0 1],prm.n_pilot,1);%  ����� ������� � �����
        %% ���������
        % MIMO
        Mod_data_inp_tmp = qammod(Inp_Sym,prm.M);% ��������� QAM-M ��� �������� ���
        if flag_cor_MIMO == 2
            Mod_data_inp_tmp = ostbcEnc(Mod_data_inp_tmp);
        end 
        Mod_data_inp = reshape(Mod_data_inp_tmp,prm.numSC,prm.Nsymb_ofdm,prm.numTx);
        % ��������� �������  MIMO
        [preambula,ltfSC] = My_helperGenPreamble(prm);
        % ��������� �������  SISO
        Mod_data_inp_pilot = pskmod(Inp_data_pilot,2);
        % SISO
        Mod_data_inp_tmp_siso = qammod(Inp_Sym_siso,prm.M_siso);% ��������� QAM-M ��� �������� ���
        Mod_data_inp_tmp_siso1 = cat(1,Mod_data_inp_pilot,Mod_data_inp_tmp_siso );
        Mod_data_inp_siso = reshape(Mod_data_inp_tmp_siso1,prm.numSC,prm.Nsymb_ofdm+prm.Nsymb_ofdm_p,1);
        %% ��������� OFDM
        OFDM_data = ofdmmod(Mod_data_inp,prm.N_FFT,prm.CyclicPrefixLength,...
                     prm.NullCarrierIndices);               
        OFDM_data_siso = ofdmmod(Mod_data_inp_siso,prm.N_FFT,prm.CyclicPrefixLength,...
                     prm.NullCarrierIndices);        
        OFDM_data = [preambula ; OFDM_data];        
        %% ����������� ������
        switch flag_chanel
            case 'RAYL'
%                 H.Visualization = 'Impulse and frequency responses';
%                 H.AntennaPairsToDisplay = [2,1];
                [Chanel_data, H_ist] = H(OFDM_data);
                [Chanel_data_siso, H_ist_siso] = H_siso(OFDM_data_siso);            
            otherwise                  
                Chanel_data  = OFDM_data*H;
                Chanel_data_siso  = OFDM_data_siso*H_siso; 

        end   
        %% �����������  ���
        [Noise_data,sigma] = my_awgn(Chanel_data,SNR(indSNR));%SNR(indSNR)
        [Noise_data_siso,sigma_siso] = my_awgn(Chanel_data_siso,SNR(indSNR));%SNR(indSNR)
        %% ����������� OFDM
        Mod_data_out = ofdmdemod(Noise_data,prm.N_FFT,prm.CyclicPrefixLength,prm.CyclicPrefixLength, ...
            prm.NullCarrierIndices);
        Mod_data_out_siso = ofdmdemod(Noise_data_siso,prm.N_FFT,prm.CyclicPrefixLength,prm.CyclicPrefixLength, ...
            prm.NullCarrierIndices);  
        %% ������ ������  
        H_estim = My_helperMIMOChannelEstimate(Mod_data_out(:,1:prm.numSTS,:),ltfSC,prm);
        H_estim_siso = Mod_data_out_siso(:,1)./Mod_data_inp_pilot;
        Mod_data_out_siso(:,1:prm.Nsymb_ofdm_p) = [];
        %% ������� ��������������
        if flag_wav_SISO == 1
            H_estim_siso = H_WAV_my(H_estim_siso);
        end
        if flag_wav_MIMO == 1
            H_estim = H_WAV_my_mimo(H_estim);
        end
        %% ���������� 
        %ZF MIMO
        if flag_cor_MIMO == 1
            Mod_data_out_ZF_tmp= My_MIMO_Equalize_ZF_numSC(Mod_data_out(:,prm.numTx+1:end,:),H_estim);
            Mod_data_out_ZF = reshape(Mod_data_out_ZF_tmp,prm.numSC*prm.Nsymb_ofdm,prm.numRx);
        elseif flag_cor_MIMO == 2
            Mod_data_out_ZF_tmp = Mod_data_out(:,prm.numTx+1:end,:);
            for i = 1:prm.Nsymb_ofdm
                Mod_data_out_ZF(:,i) = ostbcComb(squeeze(Mod_data_out_ZF_tmp(:,i,:)),H_estim);
            end
        else
            Mod_data_out_ZF_tmp = Mod_data_out(:,prm.numTx+1:end,:);
            Mod_data_out_ZF = reshape(Mod_data_out_ZF_tmp,prm.numSC*prm.Nsymb_ofdm,prm.numRx);
        end
        %ZF SISO
        if flag_cor_SISO == 1
            for i = 1:size(Mod_data_out_siso,2)
                Mod_data_out_siso_ZF(:,i) = Mod_data_out_siso(:,i)./H_estim_siso;
            end
        else
            Mod_data_out_siso_ZF = Mod_data_out_siso;
        end
        %% �����������
        Mod_data_out_tmp = Mod_data_out_ZF(:);
        Out_Sym = qamdemod(Mod_data_out_tmp,prm.M);    
        Mod_data_out_siso_tmp = Mod_data_out_siso_ZF(:);
        Out_Sym_siso = qamdemod(Mod_data_out_siso_tmp,prm.M_siso);
        %% �������� ������
        Out_Mat = de2bi(Out_Sym);
        Out_data = Out_Mat(:);
        Out_Mat_siso = de2bi(Out_Sym_siso);
        Out_data_siso  = Out_Mat_siso(:);  
        [~,ber(indExp,indSNR)] = biterr(Out_data,Inp_data);
        [~,ber_siso(indExp,indSNR)] = biterr(Out_data_siso,Inp_data_siso);
        fprintf('Complete %d db \n',SNR(indSNR)); 
    end
    fprintf('Complete %d  \n',indExp);
end
if flag_cor_MIMO ~= 2 
    prm.bps = prm.bps*prm.numTx;
end
ber_mean = mean(ber,1);
ber_siso_mean = mean(ber_siso,1);
Eb_N0 = 0:40;
ther_ber_1 = berfading(Eb_N0,'qam',16,1);
% ther_ber_1 = berawgn(Eb_N0,'qam',128);
figure(2)
plot_ber(ther_ber_1,Eb_N0,1,'g',1.5,0)
plot_ber(ber_mean,SNR,prm.bps,'k',1.5,0)
plot_ber(ber_siso_mean,SNR,prm.bps_siso,'b',1.5,0)
legend('������������� qam 256',['MIMO' num2str(prm.M)],...
    ['SISO' num2str(prm.M_siso)])%,"������������� order = 4")
str = ['corM=' num2str(flag_cor_MIMO) '_' num2str(prm.numTx) 'x' num2str(prm.numRx) '_' flag_chanel '_Wm=' num2str(flag_wav_MIMO)...
    '_Ws=' num2str(flag_wav_SISO) '_Mm=' num2str(prm.M)...
    '_Ms=' num2str(prm.M_siso) '_Exp=' num2str(Exp) '.mat'];
save(str,'ber_mean','ber_siso_mean','SNR','prm')