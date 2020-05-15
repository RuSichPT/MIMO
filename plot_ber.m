function plot_ber(ber,snr,bps,str,N,flag)
% str - ���� �������, N - ������ �����
% 'k','r','g','b','c'
% flag = 1 ��������� ����� ������,flag = 0 �� ���������
if flag == 1
    figure()
end
semilogy(snr-(10*log10(bps)),ber,str,'LineWidth',N)
hold on
grid on
xlim([0 snr(end)-ceil(10*log10(bps))])
ylim([10^-6 10^0]);
xlabel('E_b / N_0 , dB')
ylabel('BER')
end

