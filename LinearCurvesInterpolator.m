function [outcurves] = LinearCurvesInterpolator(curves,samplesout)
% LinearCurvesInterpolator Interpolate linearly between 3D curves.
%   Returns the interpolated curves in a matrix of number of points of the
%   curves x 3 x samples dimension.
%   Needs a matrix of curves with number of points of the
%   curves x 3 x number of curves dimension 
%   And needs the number of samples to compute.
%   Example: LinearCurvesInterpolator(rand(5,3,2),5)
    
    s=size(curves);
    outcurves=zeros([s(1:2),samplesout]);
    
    for i=1:s(1)
        [yy,xx,zz]=linearpiecewise_interpolation3(reshape(curves(i,1,:),s(3),1),...
            reshape(curves(i,2,:),s(3),1),reshape(curves(i,3,:),s(3),1),samplesout);
        outcurves(i,1,:)=xx;
        outcurves(i,2,:)=yy;  
        outcurves(i,3,:)=zz;  
    end
    
    hold on
    for i=1:samplesout
        plot3(outcurves(:,1,i),outcurves(:,2,i),outcurves(:,3,i))
    end
    hold off
end

