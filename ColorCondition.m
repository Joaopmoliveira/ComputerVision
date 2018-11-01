function Boolean=ColorCondition(Act,Var,ColorVector,T)
% this function computes the euclidian norm between the two superpixels
% provided
%first we want to retrive the vector color from the ColorVector
Col1=ColorVector(1:3,Act);
Col2=ColorVector(1:3,Var);
%now we compute the euclidian norm squared
EuclidianNorm=(Col1-Col2)'*(Col1-Col2);
% Now we just need to compare the threshold T squared with the Euclidian
% Norm
Boolean=(le(EuclidianNorm,T*T));
end