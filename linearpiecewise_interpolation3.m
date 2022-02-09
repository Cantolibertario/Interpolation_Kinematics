function [xx,yy,zz] = linearpiecewise_interpolation3(x,y,z,samples)
% linearpiecewise_interpolation3 Interpolate linearly between points in 3D.
%   Returns interpolated coordinates.
%   Needs the coordinates if the points in a vector for each coordinate and
%   the number of samples to interpolate.
%   Example: linearpiecewise_interpolation3(rand(10,1),rand(10,1),rand(10,1),12)

    l=length(x);
    yy=zeros(samples,1);
    xx=zeros(samples,1);
    zz=zeros(samples,1);
    ii=1;
    sl=ceil(samples/(l-1));
    
    for i=1:l-1
        V=[x(i) 1; x(i+1) 1];
        b=y(i:i+1);
        c=V\b;
        b2=z(i:i+1);
        c2=V\b2;
        xx(ii:ii+sl-1)=(linspace(x(i),x(i+1),sl))';
        yy(ii:ii+sl-1)=polyval(c,xx(ii:ii+sl-1));
        zz(ii:ii+sl-1)=polyval(c2,xx(ii:ii+sl-1));
        ii=ii+sl;
    end

end

