function [data,x,y,z]=MomentsStatistics(B,L,BW,idx,data,param)
% Para correr um estrutura com os campos:
% ºarvore
% ºestrada terra batida
% ºestrada alcatrão
% ºmar
% corre o codigo data = struct('arvore',[],'mar',[],'estrada_batida',[],'estrada_alcatrao',[])
if verifica_entrada(param)
    error('The param value introduced does not existe in the struct data')
end
Igray=rgb2gray(B);
n=input(['Insert the number of ' param '\n']);
mean=zeros(1,n);
var=zeros(1,n);
skew=zeros(1,n);
Kurt=zeros(1,n);
SupPixTar=zeros(1,n);
imshow(imoverlay(B,BW,'cyan'))
[xposi,yposi]=ginput(n);
for i=1:n
    SupPixTar(i)=L(round(yposi(i)),round(xposi(i)));
    [count,X]=imhist(Igray(idx{SupPixTar(i)}));
    prob=(count)/(sum(count));
    mean(i)=X'*prob;
    var(i)=((X-mean(i)).^2)'*prob;
    skew(i)=(((X-mean(i)).^3)'*prob)/(var(i)^3);
    Kurt(i)=(((X-mean(i)).^4)'*prob)/(var(i)^4);
end
resultmatrix=zeros(5,n);
resultmatrix(1,:)=mean;
resultmatrix(2,:)=var;
resultmatrix(3,:)=skew;
resultmatrix(4,:)=Kurt;
resultmatrix(5,:)=SupPixTar;
data.(param)=resultmatrix;
x=var;
y=skew;
z=Kurt;
end
