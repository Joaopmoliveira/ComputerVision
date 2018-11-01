clear
clc
I = imread('ima2cor01.jpg'); %meter a imagem aqui
Igray=rgb2gray(I);
Ithresh=~im2bw(Igray,160/256);
SE = strel('sphere',1);
Ieroded = im
corners = detectHarrisFeatures(Ieroded);
subplot(2,2,1),imshow(I);
subplot(2,2,2),imshow(Igray);
subplot(2,2,3),imshow(Igray),hold on;
plot(corners.selectStrongest(15));
subplot(2,2,4),imshow(Ieroded);
figure
hist(double(Igray))


