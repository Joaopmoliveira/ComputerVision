tic
A=imread('DSC07713_geotag.JPG');
A=uint8(ImproveImage(A,1.5,1.05));
B=imresize(A,1/4);
[L,N] = superpixels(B,600,'Method','slic','Compactness',5);
adj = cell(N,1);
BW = boundarymask(L);
%Esta parte do algoritm determina qual o valor da intensidade de cada
%superpixel
idx = label2idx(L);
numRows = size(B,1);
numCols = size(B,2);
%Aqui guardamos os valores de cor num vetor para facilitar o processamento
%que � necessario a seguir
ColorVector=zeros(4,N);
for pixVal=1:N;
    redIdx               = idx{pixVal};
    greenIdx             = idx{pixVal}+numRows*numCols;
    blueIdx              = idx{pixVal}+2*numRows*numCols;
    ColorVector(1,pixVal)= mean(B(redIdx));
    ColorVector(2,pixVal)= mean(B(greenIdx));
    ColorVector(3,pixVal)= mean(B(blueIdx));
    ColorVector(4,pixVal)= length(idx{pixVal});
    prevMask             = (L == pixVal);
    currMask             = imdilate(prevMask, ones(3));
    adj{pixVal}          = unique(L(currMask & ~prevMask));
end
%Esta parte do codigo usa a cell adj que contem os n�s adjacentes e
%verifica se esses n�s devem ser fundidos ou n�o
MergeMatrix=zeros(N);
for pixVal=1:N
    for j=1:length(adj{pixVal})
        if  ColorConditionNorm(pixVal,adj{pixVal}(j),ColorVector,15) %&& statisticsOfImage() %Esta � a condi��o de inclus�o se um grupo de 
            %pixeis do no i deve ou n�o ser fundido com o grupo de pixeis do no j
            MergeMatrix(pixVal,adj{pixVal}(j))=1;
        end
    end
end
%Com a matrix definida anteriormente podemos agora criar um grafo com a
%informa��o de quais superpixeis est�o conectados com quais
 G = graph(MergeMatrix);
 %Podemos agora extrair a informa��o em rela��o aos grupos de pixeis que
 %est�o conectados
 BINS=conncomp(G,'OutputForm','cell');
 %Estamos em condi��es de contruir a imagem final usando o grafo anterior
 %mas primeiro � necessario reconstruir o novo index que organiza os
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
figure,imshow(B),title('Initial image');
figure,
multi=cat(4,imoverlay(B,BW,'cyan'),imoverlay(B,BWf,'cyan'));
hIm = imdisp(multi,'Border',[0.005 0.005]);
figure
plot(G), title('Graph of nodes that will be merged')
figure
imshow(imoverlay(B,BW,'cyan'))
figure
imshow(imoverlay(B,BWf,'cyan'))
tf=toc;
