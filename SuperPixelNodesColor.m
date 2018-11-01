tic
A=imread('DSC07718_geotag.JPG');
B=imresize(A,1/4);
[L,N] = superpixels(B,600,'Method','slic','Compactness',8);
adj = cell(N,1);
BW = boundarymask(L);
%Esta parte do algoritm determina qual o valor da intensidade de cada
%superpixel
idx = label2idx(L);
numRows = size(B,1);
numCols = size(B,2);
%Aqui guardamos os valores de cor num vetor para facilitar o processamento
%que é necessario a seguir
ColorVector=zeros(4,N);
for pixVal=1:N;
    redIdx = idx{pixVal};
    greenIdx = idx{pixVal}+numRows*numCols;
    blueIdx = idx{pixVal}+2*numRows*numCols;
    ColorVector(1,pixVal)=mean(B(redIdx));
    ColorVector(2,pixVal)=mean(B(greenIdx));
    ColorVector(3,pixVal)=mean(B(blueIdx));
    ColorVector(4,pixVal)=length(idx{pixVal});
    prevMask = L == pixVal;
    currMask = imdilate(prevMask, ones(3));
    adj{pixVal} = unique(L(currMask & ~prevMask));
end
%Esta parte do codigo usa a cell adj que contem os nós adjacentes e
%verifica se esses nós devem ser fundidos ou não
MergeMatrix=zeros(N);
for pixVal=1:N
    for j=1:length(adj{pixVal})
        if  ColorCondition(pixVal,adj{pixVal}(j),ColorVector,30)%Esta é a condição de inclusão se um grupo de 
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
 Lf=zeros(size(L));
 for Run=1:length(BINS)
     for Conc=1:length(BINS{Run})
         idxfinal{Run}=cat(1,idxfinal{Run},idx{BINS{Run}(Conc)});
     end
%      outputImageF(idxfinal{Run})=(ColorVector(1,BINS{Run})*ColorVector(2,BINS{Run})')/(sum(ColorVector(2,BINS{Run})));
     Lf(idxfinal{Run})=Run;
 end
BWf= boundarymask(Lf);
subplot(1,3,1),imshow(B),title('Initial image');
subplot(1,3,2),imshow(imoverlay(B,BW,'cyan')), title('Image after SLIC method');
subplot(1,3,3),imshow(imoverlay(B,BWf,'cyan')),title('Final result');
figure
plot(G), title('Graph of nodes that will be merged')
figure
imshow(imoverlay(B,BW,'cyan'))
figure
imshow(imoverlay(B,BWf,'cyan'))
tf=toc;
