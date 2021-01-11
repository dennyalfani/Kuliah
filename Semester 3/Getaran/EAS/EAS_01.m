close all
clear
clc

k1 = 120;
k2 = 120;
k3 = 120;
k4 = 120;
m1 = 12;
m2 = 12;
m3 = 12;


A = [0 0 0 1 0 0;
     0 0 0 0 1 0;
     0 0 0 0 0 1;
     -(k1+k2)/m1 k2/m1 0 0 0 0;
     -k2/m2 -(k2+k3)/m2 k3/m3 0 0 0;
     0 k3/m3 -(k3+k4)/m3 0 0 0];
B = [0 0 0;0 0 0;1/m1 0 1/m3;0 1/m2 0; 0 0 0; 0 0 0];
C = [1 0 0 0 0 0;0 1 0 0 0 0;0 0 1 0 0 0;0 0 0 1 0 0; 0 0 0 0 1 0;0 0 0 0 0 1];
D = [0 0 0;0 0 0;0 0 0;0 0 0;0 0 0;0 0 0];


sys = ss(A,B,C,D);
Fs = 100;
t = (0:1/Fs:10)';
F1 = zeros(size(t));
F2 = zeros(size(t));
F3 = zeros(size(t));
x0 = [0.2;0.2;0.2;0;0;0];

x = lsim(sys,[F1 F2 F3],t,x0);
x1 = x(:,1);
x2 = x(:,2);
x3 = x(:,3);


massa1 = [2.8 0;3.8 0;3.8 1;2.8 1;2.8 0];
massa2 = [6.1 0;7.1 0;7.1 1;6.1 1;6.1 0];
massa3 = [10.1 0;11.1 0;11.1 1;10.1 1;10.1 0];

X1 = fft(x1);
Freq = linspace(0,Fs,length(X1));
X2 = fft(x2);
Freq = linspace(0,Fs,length(X2));
X3 = fft(x3);
Freq = linspace(0,Fs,length(X3));


%FFt
X1 = fft(x1);
Freq = linspace(0,Fs,length(X1));
figure
plot(Freq,abs(X1)/length(X1))
xlim([0 Fs/2])
xlabel('xxx')
ylabel('yyy')


figure (1)
for tt = linspace(min(t),max(t),90)
    idx = t <= tt;
    subplot(4,1,1)
    plot(t(idx),x1(idx),'linewidth',1.3)
    xlim([min(t) max(t)])
    ylim([-15 15])
    xlabel('time X1')
    ylabel('dispacement X1')
    
    subplot(4,1,2)
    plot(t(idx),x2(idx),'linewidth',1.3)  
    xlim([min(t) max(t)])
    ylim([-7 7])
    xlabel('time X2')
    ylabel('dispacement X2')
    
    subplot(4,1,3)
    plot(t(idx),x3(idx),'linewidth',1.3)
    xlim([min(t) max(t)])
    ylim([-5 5])
    xlabel('time x3')
    ylabel('dispacement x3')
    pause(0.001)
    
    subplot(4,1,4)
    idx = t<= tt;
    mdx1 = x1(idx);
    mdx1 = mdx1(end);
    mdx2 = x2(idx);
    mdx2 = mdx2(end);
    mdx3 = x3(idx);
    mdx3 = mdx3(end);
    
    plot([0.5 0.5],[0 1],'r','LineWidth',2)
    hold on
    plot([14.5 14.5],[0 1],'r','LineWidth',2)
    plot([0.5 14.5],[0 0],'g','LineWidth',2)
    plot(massa1(:,1)+mdx1,massa1(:,2),'b')
    plot(massa2(:,1)+mdx2,massa2(:,2),'b')
    plot(massa3(:,1)+mdx3,massa2(:,2),'b')
    
    pegas1 = linspace(0.5,2.7+mdx1,10);
    pegas2 = linspace(3.8+mdx1,6.1+mdx2,10);
    pegas3 = linspace(7.1+mdx2,10.1+mdx3,10);
    pegas4 = linspace(11.1+mdx3,14.5,10);
    
    plot(pegas1,0.5,'k+','LineWidth',2,'MarkerSize',8)
    plot(pegas2,0.5,'k+','LineWidth',2,'MarkerSize',8)
    plot(pegas3,0.5,'k+','LineWidth',2,'MarkerSize',8)
    plot(pegas4,0.5,'k+','LineWidth',2,'MarkerSize',8)
    plot([3.3 3.3],[0 1],'k--')
    plot([6.6 6.6],[0 1],'k--')
    plot([10.6 10.6],[0 1],'k--')
    xlim([0 15]); ylim([-0.2 2])

    xlabel('Gerakan 3 DOF')
    hold off
    pause (0.001)

 frame = getframe(figure(1));
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
      if tt == 0
          imwrite(imind,cm,'3dof.gif','gif', 'Loopcount',inf);
      else
          imwrite(imind,cm,'3dof.gif','gif','WriteMode','append');
      end

end

figure(2)
subplot(3,2,1)
plot(Freq,abs(X1)/length(X1))
xlim([0 Fs/2])
xlabel('Frequency (Hz)')
ylabel('Abs(X1)')

subplot(3,2,2)
plot(Freq,abs(X2)/length(X2))
xlim([0 Fs/2])
xlabel('Frequency (Hz)')
ylabel('Abs(X2)')

subplot(3,2,[3,4])
plot(Freq,abs(X3)/length(X3))
xlim([0 Fs/2])
xlabel('Frequency (Hz)')
ylabel('Abs(X3)')
