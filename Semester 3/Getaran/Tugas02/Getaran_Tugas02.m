% Denny Alfani 
% 02311940005012

close all
clear
clc

k1 = 120;
k2 = 144;
m1 = 4;
m2 = 12;


A = [0 0 1 0;
     0 0 0 1;
     -k1/m1 k1/m1 0 0;
     k1/m2 -(k2+k1)/m2 0 0];
B = [0 0;0 0;1/m1 0;0 1/m2];
C = [1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
D = [0 0;0 0;0 0;0 0];

sys = ss(A,B,C,D);
Fs = 100;
t = (0:1/Fs:9)';
F1 = zeros(size(t));
F2 = zeros(size(t));
x0 = [0;2*0.5;0;0];

x = lsim(sys,[F1 F2],t,x0);
x1 = x(:,1);
x2 = x(:,2);

lantai= [-1 0;1 0];
massa1 = [-0.5 5;0.5 5;0.5 6;-0.5 6;-0.5 5];
pegas1 = [0 0;0 1.25];
pegas3 = [0 4;0 5];
pegas2 = linspace(1.25,4,6);

massa2 = [-0.5 11;0.5 11;0.5 12;-0.5 12;-0.5 11]; 
pegas4 = [0 6;0 7.25];
pegas6 = [0 10;0 11];
pegas5 = linspace(7.25,10,6);


for tt = 0:0.05:max(t)
    ind = t<= tt;

figure(1)
    subplot(2,2,1)
    plot(t(ind),x1(ind),'linewidth',1.5)  
    xlim([min(t) max(t)])
    ylim([-3 3])
    xlabel('time X1')
    ylabel('dispacement X1')
    
    subplot(2,2,2)
    plot(t(ind),x2(ind),'linewidth',1.5)  
    xlim([min(t) max(t)])
    ylim([-3 3])
    xlabel('time X2')
    ylabel('dispacement X2')

    subplot(2,2,[3,4]);
    ind = t<= tt;
    mdx1 = x1(ind);
    mdx1 = mdx1(end);
    mdx2 = x2(ind);
    mdx2 = mdx2(end);
     
    pegas2 = linspace(1.25,4+mdx1,3);
    pegas5 = linspace(7.25+mdx1, 10+mdx2,6);
    
    plot(lantai(:,1), lantai (:,2), 'k-','linewidth', 4)
    hold on
    plot(massa1(:,1), massa1(:,2)+mdx1, 'r','linewidth', 2)
    plot(pegas1(:,1), pegas1(:,2), 'b','linewidth', 2)
    plot(pegas3(:,1), pegas3(:,2)+mdx1, 'b','linewidth', 2)
    plot(0, pegas2, 'b+','MarkerSize', 13, 'linewidth', 2)
    
    plot(massa2(:,1), massa2(:,2)+mdx2, 'r','linewidth', 2)
    plot(pegas4(:,1), pegas4(:,2)+mdx1, 'b','linewidth', 2)
    plot(pegas6(:,1), pegas6(:,2)+mdx2, 'b','linewidth', 2)
    plot(0, pegas5, 'b+','MarkerSize', 13, 'linewidth', 2)

    xlim([-2 4])
    ylim([0 20])
    xlabel('gerakan 2 DOF')
    hold off
    
    frame = getframe(figure(1));
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
      if tt == 0
          imwrite(imind,cm,'2dof.gif','gif', 'Loopcount',inf);
      else
          imwrite(imind,cm,'2dof.gif','gif','WriteMode','append');
      end

end

% FFT
X1 = fft(x1);
Freq1 = linspace(0,Fs,length(X1));
X2 = fft(x2);
Freq2 = linspace(0,Fs,length(X2));
    
figure(2)
    subplot(2,1,1)
    plot(Freq1,abs(X1)/length(X1))
    xlim([0 Fs/2])
    xlabel('Frequency (Hz)')
    ylabel('Abs(X1)')
    subplot(2,1,2)
    plot(Freq2,abs(X2)/length(X2))
    xlim([0 Fs/2])
    xlabel('Frequency (Hz)')
    ylabel('Abs(X2)')
%     saveas(gcf,'FFT.png')