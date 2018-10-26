function [M,nidx]=mergeSP(adj,ColorVector,idx)
% MERGECELL creates a cell with the new superpixels of an image, where the
% the new SP is composed of the previous superpixel segmentation according
% to a certain merging criteria.
%           [M,nidx]=mergeCell(adj,ColorVector) outputs a cell array where
%           each cell contains the separate agglomerates of the previous
%           superpixels to be merged. nidx is the new superpixels pixel
%           index. adj is an Nx1 cell giving the information of each
%           adjacent superpixel. ColorVector is an array containg the
%           average color of each previous superpixel. ColorVector and adj
%           are given by the propertiesSP function. idx is the previous
%           superpixel index.

% Variables initialization
N=length(adj);
M=cell(floor(N/2),1);
nmerge=0;

% Checking for each previous superpixel which of the adjacents superpixel 
% are to merge according to the criteria chosen
for pixVal=1:N
    amerged=0;
    M{nmerge+1}=zeros(length(adj{pixVal}),1);
    
    
    for j=1:length(adj{pixVal}) % j corre todos os spixeis adjacentes
        evalPix=adj{pixVal}(j);
        
        if le(abs(ColorVector(pixVal)-ColorVector(evalPix)),20) %condição de merge
            M{nmerge+1}(j)=evalPix;
        end
    end
    
    M{nmerge+1}=[pixVal; M{nmerge+1}];
    M{nmerge+1}(~M{nmerge+1})=[];
    
    if length(M{nmerge+1})>1
        for j=1:nmerge
            if any(M{j}==M{nmerge+1}(1))
                amerged=1;
                M{j}=unique(cat(1,M{j},M{nmerge+1}));
                break
            end
        end
    end
    if amerged
        M{nmerge+1}=zeros(length(adj{pixVal}),1);
    else
        nmerge=nmerge+1;
    end
    
end
M(nmerge+1:end)=[];

nidx=cell(nmerge,1);
for i=1:nmerge
    nidx{i}=cat(1,idx{M{i}});
end

end