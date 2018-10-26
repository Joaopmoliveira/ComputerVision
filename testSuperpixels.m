clearvars
clc
%% Load image into workspace 
% load A
I=imread('autumn.tif');
A=rgb2gray(I);

%% Superpixel parametrization 
[L,N] = superpixels(A,200,'Method','slic','Compactness',10);
idx = label2idx(L);
[outIm,adj,ColorVector,connectivity] = propertiesSP(A,L,idx);

%% Image shown
boundMask=boundarymask(L);
boundIm=imoverlay(outIm,boundMask,'cyan');
[boundIm,mxy]=numberSP(boundIm,idx,0);
%[numMask,mxy]=numberSP(I,idx,1);
%boundIm=imoverlay(boundIm,numMask,'red');
figure;
imshow(boundIm,'InitialMagnification','fit');
%% Merging

[M,nidx]=mergeSP(adj,ColorVector,idx);
    
CC=struct('Connectivity',8,'ImageSize',size(A),...
    'NumObjects',length(nidx),'PixelIdxList',{nidx});

nL=labelmatrix(CC);
bMt=boundarymask(nL);
[noutIm,nadj,nColorVector,nconnectivity] = propertiesSP(A,nL,nidx);
bImt=imoverlay(noutIm,bMt,'cyan');
[bImt,~]=numberSP(bImt,nidx,0);

imshowpair(boundIm,bImt,'montage');
figure
imshowpair(imoverlay(I,boundMask,'cyan'),imoverlay(I,bMt,'cyan'),'montage');