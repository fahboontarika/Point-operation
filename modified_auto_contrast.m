clc;clear all
I = imread('tree.jpg');
u = size(I,1);
v = size(I,2);
I = rgb2gray(I);
I_mac = I;
sat = 2;
q = sat/100;
I_min = 0; %map to new range [20,255]
I_max = 255;
%% Find I_high and I_low
f = zeros(1,256); 
for p = 1:256
    for i = 1:u
        for j = 1:v
            if I(i,j)==p-1
                f(1,p)=f(1,p)+1;  % p-1 =intensity of pixel 0:255 map to f 1:256
            end
        end
    end
end
cdf = zeros(1,256);
for p = 1:256
    for k = 1:p
    cdf(1,p) = cdf(1,p)+f(1,k);
    end
end
%bar(cdf)
low=zeros(1,256);
high=zeros(1,256);
for i = 1:256
    if cdf(1,i) >= u*v*q 
        low(1,i) = i;
    end    
    if cdf(1,i) <= u*v*(1-q)
        high(1,i) = i;
    end
end
for i = 1:256
    if low(1,i) ~= 0 
        I_low = (low(:));
        break;
    end
end
I_high = max(high(:));
%% modified auto contrast function 
I_low = I_low - 1;
I_high = I_high -1;
for i=1:u
    for j=1:v
        if I_mac(i,j) <= I_low
            I_mac(i,j) = I_low;
        end
        if (I_low < I_mac(i,j)) & (I_mac(i,j) < I_high)
            I_mac(i,j) = I_min + ((I(i,j)-I_low) * ((I_max-I_min)/(I_high-I_low)));
        end
        if  I_mac(i,j) >= I_high
            I_mac(i,j) = I_high;
        end
    end
end
subplot(221);
imshow(I);
title('Original image')
subplot(223)
histogram(I);

subplot(222);
imshow(I_mac);
title('Modified Auto-contrast')
subplot(224)
histogram(I_mac);
