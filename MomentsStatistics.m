function [data1,x,y,z]=MomentsStatistics(B,L,BW,idx,param)
% Para correr um estrutura com os campos:
% ºarvore
% ºestrada terra batida
% ºestrada alcatrão
% ºmar
% corre o codigo data = struct('arvore',[],'mar',[],'estrada_batida',[],'estrada_alcatrao',[])
load('data1.mat','data1');
if verifica_entrada(param)
    error('The param value introduced does not existe in the struct data')
end
Igray=rgb2gray(B);
B=ImproveImage(B);
imshow(imoverlay(B,BW,'cyan'));
n=input(['Insert the number of ' param '\n']);
SupPixTar=zeros(1,n);
xposi=zeros(1,n);
yposi=zeros(1,n);
for i=1:n
    imshow(imoverlay(B,BW,'cyan'));
    [xposi(i),yposi(i)]=ginput(1);
    SupPixTar(i)=L(round(yposi(i)),round(xposi(i)));
    BW(idx{SupPixTar(i)})=1;
end
mean=zeros(1,n);
var=zeros(1,n);
skew=zeros(1,n);
Kurt=zeros(1,n);
for i=1:n
    [count,X]      =imhist(Igray(idx{SupPixTar(i)}));
    occurenceVector=createOcurrenceVector(X,count);
    var(i)         =std(occurenceVector);
    skew(i)        =skewness(occurenceVector);
    Kurt(i)        =kurtosis(occurenceVector);
end
resultmatrix=zeros(5,n);
resultmatrix(1,:)=mean;
resultmatrix(2,:)=var;
resultmatrix(3,:)=skew;
resultmatrix(4,:)=Kurt;
resultmatrix(5,:)=SupPixTar;
data1.(param)=[data1.(param) resultmatrix];
x=var;
y=skew;
z=Kurt;
save('data1.mat','data1');

end

function occurenceVector=createOcurrenceVector(x,count)
    n=sum(count);
    occurenceVector=zeros(1,n);
    j=1;
    for i=1:length(x)
        temporaryVector=ones(1,count(i))*x(i);
        occurenceVector(j:j-1+length(temporaryVector))=temporaryVector;
        j=j+length(temporaryVector);
    end
end
