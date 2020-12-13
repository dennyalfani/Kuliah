clear
clc
close all

m=4;
c=2^10;
k=2^10; 

A= [0 1;-k/m -c/m];
B= [0;1/m];
C= [1 0];
D= 0;

x0= [1.25;0];

sys= ss(A,B,C,D);

t= 0:0.01:5;
u= zeros(size(t));

x=lsim(sys,u,t,x0);

lantai= [0 0;4 0];
massa = [0 5;4 5;4 6;0 6;0 5];
pegas1= [1 0;1 1.25];
pegas3= [1 4;1 5];
pegas2 = linspace(1.25,4,6);
damper1 = [3 0;3 1.25];
damper2 = [2.7 4; 2.7 1.25; 3.3 1.25; 3.3 4];
damper3 = [2.7 2.5; 3.3 2.5; 3 2.5; 3 5];

figure(1)
filename = 'criticaldamping m=4,k=c=2^10.gif';

for tt = 0:0.05:max(t)
    
    subplot(2,1,1)
    ind = t<= tt;
    plot(t(ind),x(ind),'linewidth',1.5)
    xlim([min(t) max(t)])
    ylim([-1.5 1.5])
    
    dx = x(ind);
    dx = dx(end);
    pegas2 = linspace(1.25,4+dx,6);
    subplot(2,1,2)
    plot(lantai(:,1), lantai (:,2), 'k-','linewidth', 4)
    hold on
    plot(massa(:,1), massa(:,2)+dx, 'r','linewidth', 2)
    plot(pegas1(:,1), pegas1(:,2), 'b','linewidth', 2)
    plot(pegas3(:,1), pegas3(:,2)+dx, 'b','linewidth', 2)
    plot(1, pegas2, 'b+','MarkerSize', 13, 'linewidth', 2)
    plot(damper1(:,1), damper1(:,2), 'g','linewidth', 2)
    plot(damper2(:,1), damper2(:,2), 'g','linewidth', 2)
    plot(damper3(:,1), damper3(:,2)+dx, 'g','linewidth', 2)
    plot([-2 6],[5.5 5.5], 'k--')
    xlim([-8 12])
    ylim([0 9])
    hold off
    pause (0.01)
    
    % capture the plot as an image
%      frame = getframe(figure(1));
%       im = frame2im(frame);
%       [imind,cm] = rgb2ind(im,256);
%       if tt == 0
%           imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
%       else
%           imwrite(imind,cm,filename,'gif','WriteMode','append');
%       end
end