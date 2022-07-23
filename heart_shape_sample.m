clc, clear, close all;
t = linspace(-pi,pi, 50); % take 50 sampling points
x = 16 * (sin(t)).^3; % parametric heart equation
y = 13 * cos(t) - 5 * cos(2*t) - 2 * cos(3*t) - cos(4*t); % parametric heart equation
x = 3*(x + 20); % scaling
y = 3*(y + 20); % scaling

plot(x,y,'.r');

pos(1, :) = x;
pos(2, :) = y;
save('heart.mat','pos');
axis equal;