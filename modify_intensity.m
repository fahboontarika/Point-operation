clc;clear all
I = imread('tree.jpg');
u = size(I,1);
v = size(I,2);
%% contrast
c1 = 0.5; %factor of adjusting contrast
c2 = 1.5;
I = rgb2gray(I);
for i=1:u
    for j=1:v
        I_con1(i,j) = I(i,j)*c1;
        I_con2(i,j) = I(i,j)*c2;
    end
end
subplot(231);
imshow(I);
title('Original image')
subplot(234)
histogram(I);

subplot(232);
imshow(I_con1);
title('Decreasing contrast by 50%')
subplot(235)
histogram(I_con1);

subplot(233);
imshow(I_con2);
title('Increasing contrast by 50%')
subplot(236)
histogram(I_con2);
figure;
%% Brightness
b1 = 50;
for i=1:u
    for j=1:v
        I_b1(i,j) = I(i,j)+b1;
    end
end
subplot(221);
imshow(I);
title('Original image')
subplot(223)
histogram(I);

subplot(222);
imshow(I_b1);
title('Increasing brightness 50 unit')
subplot(224)
histogram(I_b1);
figure;
%% Clamping
for i=1:u
    for j=1:v
        if I(i,j) >= 200
            I_cl(i,j) = 200;
        elseif I(i,j)<= 50
            I_cl(i,j) = 50; 
        else
            I_cl(i,j) = I(i,j);
        end
    end
end
subplot(221);
imshow(I);
title('Original image')
subplot(223)
histogram(I);

subplot(222);
imshow(I_cl);
title('Clamping intensity in range [50,200]')
subplot(224)
histogram(I_cl);
figure;
%% Inverting image
Imax= max(I,[],'all'); 
for i=1:u
    for j=1:v
        I_iv(i,j) = Imax - I(i,j);
    end
end
subplot(221);
imshow(I);
title('Original image')
subplot(223)
histogram(I);

subplot(222);
imshow(I_iv);
title('Inverting intensity image')
subplot(224)
histogram(I_iv);
figure;
%% Threshold
a_th = 150;
a0 = 50;
a1 = 200;
I_th = I;
for i=1:u
    for j=1:v
        if I_th(i,j) < a_th
            I_th(i,j) = a0;
        elseif I_th(i,j) >= a_th
            I_th(i,j) = a1;
        end
    end
end
subplot(221);
imshow(I);
title('Original image')
subplot(223)
histogram(I);

subplot(222);
imshow(I_th);
title('After thresholding with a_t_h=150, seperate to a_0=50 and a_1=200')
subplot(224)
histogram(I_th);