%% input by mouse
% clc, clear, close all;
% N_Max = 50;
% L_Max = 100;
% figure(1);
% axis equal; % for circle
% axis([0, L_Max, 0, L_Max]);
% title('plot of complex Fourier seris $c_n = \int^1_0 e^{-2\pi i nt}f(tdt)$','Interpreter','latex','LineWidth',20);
% xlabel('imaginary part','LineWidth',15);
% ylabel('real part','LineWidth',15);
% ax = axis;
% hold on;
% N = 0;
% Q = [];
% while N < N_Max
%     q = ginput(1); % input from graphics
%     plot(q(1),q(2),'ko');
%     Q = [Q, q'];
%     N = N + 1;
% end

%% input by given position
clc, clear, close all;
% L_Max = 300;
% L_Max = 120;
L_Max = 300;
axis equal; % for circle
axis([0, L_Max, 0, L_Max]);
ax = axis;
hold on;

% load('taiwan.mat');
% load('heart.mat');
load('linux_icon.mat');
Q = pos;
N = length(pos);

%% covert to complex
C = hsv(N); % color mapping
x = Q(1,:);
y = Q(2,:);
P = x + y*1i;
Z = fft(P);
Z = Z/N; % scaling

%% interpolation
% M = 4;
% p0 = ifft([Z(1), Z(2:N/2+1), zeros(1, M*N, 1), Z((N/2+2):end)]);
% p0 = [p0, p0(1)];
% x = [x, x(1)];
% y = [y, y(1)];
% plot(x,y);

%% sorting by radius
r = abs(Z(2:end)); % radius
k = [1:N/2, -N/2+1:-1];
% k = 1:N-1;
q = 2:N;
[r, id] = sort(r,'descend');
k = k(id);
q = q(id);

%% plot
t = 0:2*pi/(5*N):2*pi;
trace = [];
for n = 1:length(t)
    z0 = Z(1);
    for j = 1:length(k) - 5 % sum of all wave number k
        plot(x, y, '.');
        hold on;
        plot(real(trace), imag(trace));
        plot(real(z0), imag(z0),'o','color',C(j,:)); % center of circle
        plot(real(z0) + r(j)*cos(t), imag(z0) + r(j)*sin(t),'color',C(j,:)); % circle 1
        axis equal
        title('plot of complex Fourier seris $y_n = \frac{1}{N}\sum^{N - 1}_{k = 0} z_k e^{jk\cdot \frac{n \cdot 2\pi}{N}},\; z_k = \sum^{N - 1}_{k = 0} y_n e^{-jk\cdot \frac{n \cdot 2\pi}{N}}$','Interpreter','latex','LineWidth',20);
        xlabel('real part','LineWidth',15);
        ylabel('imaginary part','LineWidth',15);
        axis(ax);
        z1 = z0 + Z(q(j))*exp(1i*k(j)*t(n));
        plot([real(z0), real(z1)], [imag(z0), imag(z1)],'b-'); % line from circle 1 to circle 2
        z0 = z1;
    end
    plot(real(z0), imag(z0), 'o');
    plot(real(z0), imag(z0), 'k.-');
    trace(n) = z0;
    hold off;
%     filename = ['fourier_plot_taiwan',num2str(n), '.png'];
%     filename = ['fourier_plot_heart',num2str(n), '.png'];
    filename = ['fourier_plot_linux_icon',num2str(n), '.png'];
    print(gcf,filename,'-dpng','-r600'); 
%     pause(0.01);
end