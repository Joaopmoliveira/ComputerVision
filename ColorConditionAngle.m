function Boolean=ColorConditionAngle(Act,Var,ColorVector,thresholdAngle)
% this function computes the angle between the two vectors in the RGB
% color space
%first we want to retrive the vector color from the ColorVector
Col1=ColorVector(1:3,Act);
Col2=ColorVector(1:3,Var);
%now we compute the cross product between the vector in order to determine
%the angle between them 
NormCol1=norm(Col1);
NormCol2=norm(Col2);
Angle=acos((Col1'*Col2)/(NormCol1*NormCol2));
% Now we just need to compare the threshold T squared with the Euclidian
% Norm
Boolean=(le(Angle,thresholdAngle));
end