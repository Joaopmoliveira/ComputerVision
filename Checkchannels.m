% A = imread('DSC07742_geotag.JPG');
Ahsv = rgb2hsv(A);
Ah=Ahsv(:,:,1);
As=Ahsv(:,:,2);
Av=Ahsv(:,:,3);
subplot(2,2,1),imshow(Ahsv);
subplot(2,2,2),imshow(Ah);
subplot(2,2,3),imshow(As);
subplot(2,2,4),imshow(Av);
