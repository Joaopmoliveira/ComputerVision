function [numMask,mxy]=numberSP(I,idx,varargin)
% NUMBERSP creates mask with numbered Superpixels of image I given by idx
% This function compute the superpixels centroids of image based on the index given
% and gives a mask with superpixels numbered at their centroid for a visual aid.
%          [numMask,mxy]=numberSP(I,idx) creates numMask which is image I 
%          overlayed with the numbers of the Superpixels given by idx.
%          idx is an 1xN cell given by the function superpixels with the 
%          pixels belonging to the N superpixels of image I.
%           
%          [numMask,mxy]=numberSP(I,idx,mask) gives a grayscale image mask
%          with the numbered superpixels to place on top of image I if 
%          mask = 1. If mask = 0 the output is the same as calling 
%          [numMask,mxy]=numberSP(I,idx) 
%                 

if nargin==3
    mask=varargin{1};
else
    mask=0;
end
if mask
    numMask=zeros(size(I),'like',I);
else
    numMask=I;
end

N=length(idx);
nR=size(I,1);
mxy=zeros(2,N);
fonsize=zeros(1,N);

for i=1:N
    l=length(idx{i});
    xy=zeros(2,l);
    fonsize(i)=min(max(round(l*0.006),10),50);
    for j = 1:size(xy,2)
        xy(1,j)=mod(idx{i}(j),nR);
        xy(2,j)=(idx{i}(j)-xy(1,j))/nR;
    end
    mxy(:,i)=mean(xy,2);
    
    numMask=insertText(numMask,[mxy(2,i),mxy(1,i)],num2str(i),...
        'FontSize',fonsize(i),'TextColor','Red','AnchorPoint','Center','BoxOpacity',0);
end


if mask
    numMask=rgb2gray(numMask);
end


end