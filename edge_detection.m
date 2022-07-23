clc, clear, close all;
im = imread('taiwan.png');
I = rgb2gray(im);
image(I);
[Gmag, Gdir] = imgradient(I,'prewitt');
imshowpair(Gmag, Gdir, 'montage');
title('Gradient Magnitude, Gmag (left), and Gradient Direction, Gdir (right), using Prewitt method')

[len, wid] = size(Gdir);

c = 1;
pos =[];
for l = 1:10:len
    w = 1;
    while Gdir(l,w) == 0 && (w ~= wid)
        w = w + 1;
        if ~Gdir(l,w) == 0
           pos(1, c) =  w;
           pos(2, c) =  300 - l;
           c = c + 1;
       end
    end
end

for l = len:-10:1
    w = wid;
    while Gdir(l,w) == 0 && (w ~= 1)
        w = w - 1;
        if ~Gdir(l,w) == 0
           pos(1, c) =  w;
           pos(2, c) =  300 - l;
           c = c + 1;
       end
    end
end


scatter(pos(1,:),pos(2,:))
xlim([0, 300]);
ylim([0, 300]);
axis equal;


save('taiwan.mat','pos');