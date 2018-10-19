%% Algoritmo para encontrar caminhos mais claros
A = imread('DSC07832_geotag.JPG');
%usamos a transformação para HSV para ser mais natural qual dos canais
%usara para selecionar certas estruturas
Ahsv = rgb2hsv(A);
%O canal de saturação permite a seleção do caminho claro
As=Ahsv(:,:,2);
subplot(2,2,1),
imshow(A);
subplot(2,2,2),
%O threshold com o valor de 0.23 pode ter de ser alterado dependendo do
%exemplo que estamos a resolver. Parametro que é necessario optimizar
BWs =~im2bw(As,0.23);
imshow(BWs)
%Necessario eliminar o ruido de forma a selecionar apenas o caminho
se=strel('disk',30);
BWs=imopen(BWs,se);
subplot(2,2,3)
imshow(BWs);
%o comando spy permite fazer o plot de uma matrix com zeros e uns e fazer o
%seu plot em cima da figura que queremos trabalhar
subplot(2,2,4),imshow(A);hold on;spy(BWs,'r');