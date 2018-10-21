clear all
clc
load A
[L,N] = superpixels(A,10,'Method','slic','Compactness',5);
adj = cell(N,1);
connectivity=eye(N);
%Esta parte do algoritm determina qual o valor da intensidade de cada
%superpixel
outputImage = zeros(size(A),'like',A);
idx = label2idx(L);
%Aqui guardamos os valores de cor num vetor para facilitar o processamento
%que é necessario a seguir
ColorVector=zeros(1,N);
for pixVal=1:N;
    media=mean(A(idx{pixVal}));
    outputImage(idx{pixVal}) = media;
    ColorVector(pixVal)=media;
end
%Esta parte do algoritmo determina qual a matrix de adjacencia entre os
%superpixeis
for pixVal=1:N %i representa o superpixel i indentificados pela matrix L
    prevMask = L == pixVal;
    currMask = imdilate(prevMask, ones(3));
    adj{pixVal} = unique(L(currMask & ~prevMask));
    connectivity(pixVal,adj{pixVal})=1;
end
MergeMatrix=adj;
for pixVal=1:N
    for evalPix=length(adj{pixVal}):-1:1
        if ge(abs(ColorVector(pixVal)-ColorVector(evalPix)),20)
            MergeMatrix{pixVal}(evalPix)=[];
        end
    end
end
BW = boundarymask(L);
imshow(imoverlay(outputImage,BW,'cyan'))

