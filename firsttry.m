%% Algoritmo para encontrar caminhos mais claros
A = imread('DSC07832_geotag.JPG');
Ahsv = rgb2hsv(A);
As=Ahsv(:,:,2);
subplot(2,2,1),
imshow(A);
subplot(2,2,2),
BWs =~im2bw(As,0.23);
imshow(BWs)
se=strel('disk',30);
BWs=imopen(BWs,se);
subplot(2,2,3)
imshow(BWs);
subplot(2,2,4),imshow(A);hold on;spy(BWs,'r');