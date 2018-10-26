function [outIm,adj,ColorVector,connectivity] = propertiesSP(A,L,idx)
% PROPERTIESSP computes various properties of the superpixels of an image A
%              segmented according to a label matrix L and index cell idx
%              given by idx=label2idx(L).
%              [outIm,adj,ColorVector,connectivity] = propertiesSP(A,L,idx) 
%              adj and connectivity are a Nx1 cell and an NxN array, 
%              respectively, with information on the adjacents superpixels. 
%              N is the number of superpixel and adj{i} gives the adjecent 
%              superpixels of the superpixel i, where i is value between 
%              1 and N. ColorVector is an array with the mean colour of 
%              each superpixel. outIm is an image matrix segmented with A
%              superpixels where each superpixel has its mean color for 
%              all pixels contained in it.
%               


N=length(idx);
connectivity=eye(N);
outIm = zeros(size(A),'like',A);
adj = cell(N,1);
ColorVector=zeros(N,1);

for pixVal=1:N
    % Here the adjacents superpixel of pixVal are computed and stored
    prevMask = (L == pixVal);
    currMask = imdilate(prevMask, ones(3));
    adj{pixVal} = unique(L(currMask & ~prevMask));
    connectivity(pixVal,adj{pixVal})=1;
    
    % Here the average color of each superpixel is computed
    media=mean(A(idx{pixVal}));
    outIm(idx{pixVal}) = media;
    ColorVector(pixVal)=media;
end
end