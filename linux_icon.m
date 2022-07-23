clc, clear, close all;
data = readmatrix("linux_icon.txt");
figure(1);
axis equal; % for circle
data(:,2) = 300 - data(:,2); % invert y axis

scatter(data(:,1),data(:,2),'.');
xlim([0 300]);
ylim([0 300]);

pos_de = [data(1:3:49,:)', data(51:2:252,:)', data(253:341,:)',data(341:2:375,:)', data(376:3:end,:)']';
scatter(pos_de(:,1),pos_de(:,2),'.');
xlim([0 300]);
ylim([0 300]);

pos = pos_de';
save('linux_icon.mat','pos');