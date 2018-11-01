function [numMask,mxy]=numberSP(I,idx)
% This function compute the superpixels centroids of image based on the index given
% and gives a mask with superpixels numbered at their centroid for a visual aid.
% Inputs: 

%numMask=zeros(size(I),'like',I);
numMask=I;

N=length(idx);
nR=size(I,1);
mxy=zeros(2,N);
fonsize=zeros(1,N);

for i=1:N
    l=length(idx{i});
    xy=zeros(2,l);
    if i==12
        fonsize(i)=20;
    else
    fonsize(i)=min(max(round(l*0.006),10),50);
    end
    for j = 1:size(xy,2)
        xy(1,j)=mod(idx{i}(j),nR);
        xy(2,j)=(idx{i}(j)-xy(1,j))/nR;
    end
    mxy(:,i)=mean(xy,2);
    if i==12
        numMask=insertText(numMask,[mxy(2,i),mxy(1,i)+30],num2str(i),...
        'FontSize',fonsize(i),'TextColor','Red','AnchorPoint','Center','BoxOpacity',0);
    else
    numMask=insertText(numMask,[mxy(2,i),mxy(1,i)],num2str(i),...
        'FontSize',fonsize(i),'TextColor','Red','AnchorPoint','Center','BoxOpacity',0);
    end
    
end

% figure
% imshow(I);
% hold on
% h=imshow(numMask);
%numMask=rgb2gray(numMask);
%set(h,'AlphaData',numMask)
end