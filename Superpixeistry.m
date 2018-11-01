%%
%A = imread('DSC07713_geotag.JPG');

[L,N] = superpixels(A,150,'Method','slic','Compactness',10);
BW = boundarymask(L);
D=imoverlay(A,BW,'cyan');
% Set color of each pixel in output image to the mean RGB color of the
% superpixel region.

% % outputImage = zeros(size(A),'like',A);
% % idx = label2idx(L);
% % %Aqui guardamos os valores de cor num vetor para facilitar o processamento
% % %que é necessario a seguir
% % ColorVector=zeros(2,N);
% % for pixVal=1:N;
% %     media=mean(A(idx{pixVal}));
% %     outputImage(idx{pixVal}) = media;
% % end
% %  subplot(1,2,1)
% %  imshow(imoverlay(A,BW,'cyan'))
% %  title('Bounderies of the SP')
% %  subplot(1,2,2)
% %  imshow(outputImage)
% %  title('Resulting image averages')
% %  