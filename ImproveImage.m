function Iout=ImproveImage(I,m,lambda)
I1=double(I(:,:,1));
I2=double(I(:,:,2));
I3=double(I(:,:,3));
I1=m*(I1.^lambda);
I2=m*(I2.^lambda);
I3=m*(I3.^lambda);
Iout(:,:,3)=I3;
Iout(:,:,2)=I2;
Iout(:,:,1)=I1;

end