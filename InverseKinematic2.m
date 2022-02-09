function [x,angles,it] = InverseKinematic2(distances,endpoint,x0,tol)
% InverseKinematic2 Calculate the inverse kinematic of a n-kinematic chain with 2DOF in 3D
%   Returns x, the position of the joints, a matrix whose column i is the position of joint i.
%   Returns angles, a matrix whose row i is the R^2 vector with the final
%   angles in each axis of the joint i.
%   And return the number of iterations, it.
%   Needs distances, a matrix of the inicial orientation and length. The
%   format is each column is a vector whose norm2 is the legth of the arm
%   and its angle is its initial orientation, size 3x#joints.
%   An end point and a inicial point, R^3 vectors.
%   And a tolerance, a number.
%   Example: InverseKinematic2(rand(3),rand(3,1),zeros(3,1),0.01)

    if(norm(endpoint)>sum(vecnorm(distances)))
       error('End out of range');
    end
    pause('on')
    
    s=size(distances);
    angles=zeros(s(2),2);
    x=DirectKinematic2(distances,angles,x0);
    J=zeros(s(1),2*s(2));
    h=0.001;
    e=inf;
    it=0;
    R1=[cos(h) sin(h) 0; 
        -sin(h) cos(h) 0;
        0 0 1];
    R1=R1-R1';
    R2=[1 0 0;
        0 cos(h) sin(h); 
        0 -sin(h) cos(h)];
    R2=R2-R2';
    
    while e>tol
        for i=1:s(2)
            pos=x(:,end)-x(:,i);
            J(:,i)=R1*pos;
            J(:,i+s(2))=R2*pos;
        end
        pJ=pinv(J);
        obj=endpoint-x(:,end);
        e=norm(obj);
         if e<0.7
             k=1.5;
         else
             k=0.7;
         end
        deltangles=pJ*obj*h*k;
        angles=angles+[deltangles(1:end/2) deltangles(end/2+1:end)];
        scatter3(endpoint(1),endpoint(2),endpoint(3),250,'o','filled','MarkerFaceColor','k'),
        hold on
        x=DirectKinematic2(distances,angles,x0);
        it=it+1;
        pause(0.25)
    end
end

