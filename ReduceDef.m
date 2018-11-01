function ImOut=ReduceDef(Im,factor)
  
ImSize=size(Im);
ImSize=ImSize(1:2);
n=factor^2;
%we have to find if the inserted factor can devide both the height and the
%length
    if ~(~(mod(ImSize(1),factor)) && ~(mod(ImSize(2),factor)))
        error('ReduceDef: The factor insert was not divisor of the size of the image')
    end
    ImOut=zeros(ImSize*(1/factor));
    idex=(ImSize(1)*ImSize(2))/n;
    mask=(ones(factor))/n;
    for pixel=1:idex
        ImOut(pixel)=mask*Im( );
        
    end
 
end