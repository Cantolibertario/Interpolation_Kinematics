function [outpts,len] = BezierCurves(inpts,samples)
%BEZIERCURVES Calculate the Bezier curve of 4 points in any dimension
%   Returns the interpolated curve and, opcionally, an approximation of its
%   length.
%   Needs the points in a matrix of 4xX, with X as the dimension, and the
%   number of samples.
%   Example BezierCurves(rand(4,3),100)

    outpts=zeros(samples,3);
    Bcoeff=[
        -1 3 -3 1;
        3 -6 3 0;
        -3 3 0 0;
        1 0 0 0
        ];
    
    xx=(linspace(0,1,samples))';
    
    for i=1:4
    outpts=outpts+polyval(Bcoeff(i,:),xx)*inpts(i,:);
    end
    
    plot3(outpts(:,1),outpts(:,2),outpts(:,3))
    
    if nargout==2
        len=Bezierlength(outpts,xx);
    end
end

function len=Bezierlength(outpts,xx)
       
    len=zeros(length(xx)-1,1);
    l=length(xx);
    s=diff(outpts,1,1);
    
    for i=1:l-1
       len(i)=norm(s(i,:),2);
    end
    
end
