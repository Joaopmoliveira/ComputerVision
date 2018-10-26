% clear
% clc
% load newtry
tic
[L,N] = superpixels(A,10,'Method','slic','Compactness',10);
adj = cell(N,1);
BW = boundarymask(L);
%Esta parte do algoritm determina qual o valor da intensidade de cada
%superpixel
outputImage = zeros(size(A),'like',A);
idx = label2idx(L);
%Aqui guardamos os valores de cor num vetor para facilitar o processamento
%que é necessario a seguir
ColorVector=zeros(2,N);
for pixVal=1:N;
    media=mean(A(idx{pixVal}));
    outputImage(idx{pixVal}) = media;
    ColorVector(1,pixVal)=media;
    ColorVector(2,pixVal)=length(idx{pixVal});
end
%Esta parte do algoritmo determina qual a matrix de adjacencia entre os
%superpixeis
for pixVal=1:N %i representa o superpixel i indentificados pela matrix L
    prevMask = L == pixVal;
    currMask = imdilate(prevMask, ones(3));
    adj{pixVal} = unique(L(currMask & ~prevMask));
end
%Esta parte do codigo usa a cell adj que contem os nós adjacentes e
%verifica se esses nós devem ser fundidos ou não
MergeMatrix=zeros(N);
for pixVal=1:N
    for j=length(adj{pixVal}):-1:1
        if le(abs(ColorVector(1,pixVal)-ColorVector(1,adj{pixVal}(j))),20) %Esta é a condição de inclusão se um grupo de 
            %pixeis do no i deve ou não ser fundido com o grupo de pixeis do no j
            MergeMatrix(pixVal,adj{pixVal}(j))=1;
        end
    end
end
%Com a matrix definida anteriormente podemos agora criar um grafo com a
%informação de quais superpixeis estão conectados com quais
 G = graph(MergeMatrix);
 %Podemos agora extrair a informação em relação aos grupos de pixeis que
 %estão conectados
 BINS=conncomp(G,'OutputForm','cell');
 %Estamos em condições de contruir a imagem final usando o grafo anterior
 %mas primeiro é necessario reconstruir o novo index que organiza os
 %superpixeis 
 idxfinal=cell(1,length(BINS));
 outputImageF= zeros(size(A),'like',A);
 Lf=zeros(size(L));
 for Run=1:length(BINS)
     for Conc=1:length(BINS{Run})
         idxfinal{Run}=cat(1,idxfinal{Run},idx{BINS{Run}(Conc)});
     end
     outputImageF(idxfinal{Run})=(ColorVector(1,BINS{Run})*ColorVector(2,BINS{Run})')/(sum(ColorVector(2,BINS{Run})));
     Lf(idxfinal{Run})=Run;
 end
BWf= boundarymask(Lf);
subplot(1,3,1),imshow(A),title('Initial image');
subplot(1,3,2),imshow(imoverlay(outputImage,BW,'cyan')), title('Image after SLIC method');
subplot(1,3,3),imshow(imoverlay(outputImageF,BWf,'cyan')),title('Final result');
figure
plot(G), title('Graph of nodes that will be merged')
tf=toc;
