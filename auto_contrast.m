clc;clear all
I = imread('jpg3.jpg');
u = size(I,1);
v = size(I,2);
I = rgb2gray(I);
I_ac = I;
I_high = max(I,[],'all');
I_low = min(I,[],'all');
I_min = 20; %map to new range [20,255]
I_max = 255;
for i=1:u
    for j=1:v
        I_ac(i,j) = I_min + ((I(i,j)-I_low) * ((I_max-I_min)/(I_high-I_low)));
    end
end
subplot(221);
imshow(I);
title('Original image')
subplot(223)
histogram(I);

subplot(222);
imshow(I_ac);
title('Automatic contrast')
subplot(224)
histogram(I_ac);
figure;
