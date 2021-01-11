close all
clear
clc

epsilon = @(r,Psi) abs((1+1i*2*Psi*r) ./ (1-r.^2+1i*2*Psi*r));

r = linspace(0,4,100);

figure
plot(r,epsilon(r,0.12),'b','LineWidth',2)
hold on
plot(r,epsilon(r,0.23),'r','LineWidth',2)
plot(r,epsilon(r,0.37),'g','LineWidth',2)
plot(r,epsilon(r,0.87),'c','LineWidth',2)
plot(r,epsilon(r,1.3),'k','LineWidth',2)
plot(r,epsilon(r,2.4),'m','LineWidth',2)
xlim([0 4])
ylim([0 8])
grid on
set(gca,'xtick',[0:0.5:4])
legend('0.12','0.23','0.37','0.87','1.3','2.4')
xlabel('Frequency Ratio')
ylabel('Amp Transmisibility')