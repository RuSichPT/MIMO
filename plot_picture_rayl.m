clc; clear; close all;
Eb_N0 = 0:55;
% �� QAM 16 256
figure()
ther_ber = berfading(Eb_N0,'qam',4,1);
plot_ber(ther_ber,Eb_N0,2,'+k',1.5,0);
load('DataBase/corM=1_2x2_RAYL_Wm=0_Ws=0_Mm=16_Ms=256_Exp=100');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_mean,SNR,prm.bps,'k',1.5,0);
plot_ber(ber_siso_mean,SNR,prm.bps_siso,'-',1.5,0,[0.45 0.45 0.45]);

load('DataBase/corM=1_2x2_RAYL_Wm=1_Ws=1_Mm=16_Ms=256_Exp=100.mat');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_mean,SNR,prm.bps,'--k' ,1.5,0);
plot_ber(ber_siso_mean,SNR,prm.bps_siso,'--',1.5,0,[0.45 0.45 0.45]);
xlim ([0 50]);
legend('������������� QAM4 MIMO','MIMO QAM16','SISO QAM256','MIMO QAM16 wavelet',...
    'SISO QAM256 wavelet','Location','southwest');

% ���� QAM 16 256
figure(2)
ther_ber = berfading(Eb_N0,'qam',4,1);
plot_ber(ther_ber,Eb_N0,2,'b',1.5,0);
load('DataBase/corM=1_2x2_RAYL_Wm=0_Ws=0_Mm=16_Ms=256_Exp=100');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_mean,SNR,prm.bps,'k',1.5,0);
plot_ber(ber_siso_mean,SNR,prm.bps_siso,'r',1.5,0);

load('DataBase/corM=1_2x2_RAYL_Wm=1_Ws=1_Mm=16_Ms=256_Exp=100.mat');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_mean,SNR,prm.bps,'--k' ,1.5,0);
plot_ber(ber_siso_mean,SNR,prm.bps_siso,'--r',1.5,0);
xlim ([0 50]);
legend('������������� QAM4 MIMO','MIMO QAM16','SISO QAM256','MIMO QAM16 wavelet',...
    'SISO QAM256 wavelet','Location','southwest');

% �� QAM 32
figure(3)
ther_ber = berfading(Eb_N0,'qam',4,1);
plot_ber(ther_ber,Eb_N0,2,'+k',1.5,0);
load('DataBase/corM=1_2x2_RAYL_Wm=0_Ws=0_Mm=32_Ms=32_Exp=100');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_mean,SNR,prm.bps,'k',1.5,0);
plot_ber(ber_siso_mean,SNR,prm.bps_siso,'-',1.5,0,[0.45 0.45 0.45]);

load('DataBase/corM=1_2x2_RAYL_Wm=1_Ws=1_Mm=32_Ms=32_Exp=100.mat');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_mean,SNR,prm.bps,'--k' ,1.5,0);
plot_ber(ber_siso_mean,SNR,prm.bps_siso,'--',1.5,0,[0.45 0.45 0.45]);
xlim ([0 40]);
ylim([10^-5 10^0]);
title('QAM32')
legend('������������� QAM4 MIMO','MIMO','SISO','MIMO wavelet',...
    'SISO wavelet','Location','southwest');

% ���� QAM 32
figure(4)
ther_ber = berfading(Eb_N0,'qam',4,1);
plot_ber(ther_ber,Eb_N0,2,'b',1.5,0);
load('DataBase/corM=1_2x2_RAYL_Wm=0_Ws=0_Mm=32_Ms=32_Exp=100');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_mean,SNR,prm.bps,'k',1.5,0);
plot_ber(ber_siso_mean,SNR,prm.bps_siso,'r',1.5,0);

load('DataBase/corM=1_2x2_RAYL_Wm=1_Ws=1_Mm=32_Ms=32_Exp=100.mat');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_mean,SNR,prm.bps,'--k' ,1.5,0);
plot_ber(ber_siso_mean,SNR,prm.bps_siso,'--r',1.5,0);
xlim ([0 40]);
ylim([10^-5 10^0]);
title('QAM32')
legend('������������� QAM4 MIMO','MIMO','SISO','MIMO wavelet',...
    'SISO wavelet','Location','southwest');

% �� QAM 4 16
figure(5)
ther_ber = berfading(Eb_N0,'qam',4,1);
plot_ber(ther_ber,Eb_N0,2,'+k',1.5,0);
load('DataBase/corM=1_2x2_RAYL_Wm=0_Ws=0_Mm=4_Ms=16_Exp=100');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_mean,SNR,prm.bps,'k',1.5,0);
plot_ber(ber_siso_mean,SNR,prm.bps_siso,'-',1.5,0,[0.45 0.45 0.45]);

load('DataBase/corM=1_2x2_RAYL_Wm=1_Ws=1_Mm=4_Ms=16_Exp=100');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_mean,SNR,prm.bps,'--k' ,1.5,0);
plot_ber(ber_siso_mean,SNR,prm.bps_siso,'--',1.5,0,[0.45 0.45 0.45]);
% ylim([5*10^-5 10^0]);
xlim ([0 40]);
legend('������������� QAM4 MIMO','MIMO QAM4','SISO QAM16','MIMO QAM4 wavelet',...
    'SISO QAM16 wavelet','Location','southwest');

figure(6)

% �� QAM 16
ther_ber = berfading(Eb_N0,'qam',4,1);
plot_ber(ther_ber,Eb_N0,2,'+k',1.5,0);
load('DataBase/corM=1_2x2_RAYL_Wm=0_Ws=0_Mm=16_Ms=256_Exp=100');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_mean,SNR,prm.bps,'k',1.5,0);
load('DataBase/corM=1_2x2_RAYL_Wm=0_Ws=0_Mm=4_Ms=16_Exp=100');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_siso_mean,SNR,prm.bps_siso,'-',1.5,0,[0.45 0.45 0.45]);
load('DataBase/corM=1_2x2_RAYL_Wm=1_Ws=1_Mm=16_Ms=256_Exp=100.mat');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_mean,SNR,prm.bps,'--k' ,1.5,0);
load('DataBase/corM=1_2x2_RAYL_Wm=1_Ws=1_Mm=4_Ms=16_Exp=100');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_siso_mean,SNR,prm.bps_siso,'--',1.5,0,[0.45 0.45 0.45]);
xlim ([0 40]);
ylim([10^-5 10^0]);
title('QAM16')
legend('������������� QAM4 MIMO','MIMO','SISO','MIMO wavelet',...
    'SISO wavelet','Location','southwest');

figure(7)

% ���� QAM 16
ther_ber = berfading(Eb_N0,'qam',4,1);
plot_ber(ther_ber,Eb_N0,2,'b',1.5,0);
load('DataBase/corM=1_2x2_RAYL_Wm=0_Ws=0_Mm=16_Ms=256_Exp=100');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_mean,SNR,prm.bps,'k',1.5,0);
load('DataBase/corM=1_2x2_RAYL_Wm=0_Ws=0_Mm=4_Ms=16_Exp=100');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_siso_mean,SNR,prm.bps_siso,'r',1.5,0);
load('DataBase/corM=1_2x2_RAYL_Wm=1_Ws=1_Mm=16_Ms=256_Exp=100.mat');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_mean,SNR,prm.bps,'--k' ,1.5,0);
load('DataBase/corM=1_2x2_RAYL_Wm=1_Ws=1_Mm=4_Ms=16_Exp=100');
SNR = SNR(1:size(ber_mean,2));
plot_ber(ber_siso_mean,SNR,prm.bps_siso,'--r',1.5,0);
xlim ([0 40]);
ylim([10^-5 10^0]);
title('QAM16')
legend('������������� QAM4 MIMO','MIMO','SISO','MIMO wavelet',...
    'SISO wavelet','Location','southwest');

% �� QAM 16 ��������
figure(8)
load('DataBase/corM=2_2x2_RAYL_Wm=1_Ws=1_Mm=16_Ms=16_Exp=100');
plot_ber(ber_mean,SNR,prm.bps,'k',1.5,0);
plot_ber(ber_siso_mean,SNR,prm.bps_siso,'-',1.5,0,[0.45 0.45 0.45]);
xlim ([0 50]);
ylim([10^-5 10^0]);
title('QAM16')
legend('MIMO 2x2 ���������','SISO');
% ���� QAM 16 ��������
figure(9)
load('DataBase/corM=2_2x2_RAYL_Wm=1_Ws=1_Mm=16_Ms=16_Exp=100');
plot_ber(ber_mean,SNR,prm.bps,'k',1.5,0);
plot_ber(ber_siso_mean,SNR,prm.bps_siso,'r',1.5,0);
xlim ([0 50]);
ylim([10^-5 10^0]);
title('QAM16')
legend('MIMO 2x2 ���������','SISO');