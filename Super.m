%%
A = imread('DSC07713_geotag.JPG');
[L,N] = superpixels(A,500,'Method','slic','Compactness',10);
figure
BW = boundarymask(L);
imshow(imoverlay(A,BW,'cyan'))

% Set color of each pixel in output image to the mean RGB color of the
% superpixel region.
outputImage = zeros(size(A),'like',A);
idx = label2idx(L);
numRows = size(A,1);
numCols = size(A,2);
for labelVal = 1:N
    redIdx = idx{labelVal};
    greenIdx = idx{labelVal}+numRows*numCols;
    blueIdx = idx{labelVal}+2*numRows*numCols;
    outputImage(redIdx) = mean(A(redIdx));
    outputImage(greenIdx) = mean(A(greenIdx));
    outputImage(blueIdx) = mean(A(blueIdx));
end

figure
h1=fspecial('gaussian',[30 30],5);
Agray=rgb2gray(A);
Ags=imfilter(Agray,h1);
bw=edge(Ags,'canny');
%%
A = imread('DSC07713_geotag.JPG');
h1=fspecial('gaussian',[70 70],12);
Agray=rgb2gray(A);
Id=im2double(Agray);
Aout=4*(((1+0.8).^(Id))-1);
Ags=imfilter(Agray,h1);
bw=edge(Ags,'canny',[],9);
subplot(2,2,1),imshow(A);
subplot(2,2,2),imshow(Agray);
subplot(2,2,3),imshow(Ags);
subplot(2,2,4),imshow(bw);
figure
subplot(1,2,1),imshow(bw);
subplot(1,2,2),imshow(Aout);
%%
A = imread('DSC07742_geotag.JPG');
Ahsv = rgb2hsv(A);
% Ah=Ahsv(:,:,1);
As=Ahsv(:,:,2);
% Av=Ahsv(:,:,3);
% % Aout=4*(((1+0.8).^(Ah))-1);
% subplot(2,2,1),imshow(A);
% subplot(2,2,2),imshow(Ah);
% subplot(2,2,3),imshow(As);
% subplot(2,2,4),imshow(Av);
% figure
% subplot(1,2,1),imshow(Ah);
% subplot(1,2,2),imshow(Aout);
% figure
subplot(2,2,1),
imshow(A);
subplot(2,2,2),
BW =im2bw(As,0.23);
imshow(BW)
se=strel('disk',40);
BW=imclose(BW,se);
subplot(2,2,3)
imshow(BW);
subplot(2,2,4),imshow(A);hold on;spy(~BW,'r');



