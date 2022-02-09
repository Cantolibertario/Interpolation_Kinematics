function [x,angles,it] = InverseKinematic3(distances,endpoint,x0,tol)
%InverseKinematic3 Calculate the inverse kinematic of a n-kinematic chain with 3DOF in 3D
%   Returns x, the position of the joints, a matrix whose column i is the position of joint i.
%   Returns angles, a matrix whose row i is the R^3 vector with the final
%   angles in each axis of the joint i.
%   And return the number of iterations, it.
%   Needs distances, a matrix of the inicial orientation and length. The
%   format is each column is a vector whose norm2 is the legth of the arm
%   and its angle is its initial orientation, size 3x#joints.
%   An end point and a inicial point, R^3 vectors.
%   And a tolerance, a number.
%   Example: InverseKinematic3(rand(3),rand(3,1),zeros(3,1),0.01)

    epn=norm(endpoint);
    range=sum(vecnorm(distances));
    if(epn>range)
       error('End point out of range');
    end
    pause('on')
    
    s=size(distances);
    angles=zeros(s(2),3);
    x=DirectKinematic3(distances,angles,x0);
    J=zeros(s(1),3*s(2));
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
    R3=[cos(h) sin(h) 0;
        0 1 0;
        0 -sin(h) cos(h)];
    R3=R3-R3';
    
    while e>tol
        for i=1:s(2)
            pos=x(:,end)-x(:,i);
            J(:,i)=R1*pos;
            J(:,i+s(2))=R2*pos;
            J(:,i+2*s(2))=R3*pos;
        end
        pJ=pinv(J);
        obj=endpoint-x(:,end);
        e=norm(obj);
        if e<0.5
             k=1.5;
        else
             k=0.7;
        end
        deltangles=pJ*obj*h*k;
        angles=angles+[deltangles(1:end/3) deltangles(end/3+1:end*2/3) deltangles(end*2/3+1:end)];
        scatter3(endpoint(1),endpoint(2),endpoint(3),250,'o','filled','MarkerFaceColor','k'),
        hold on
        x=DirectKinematic3(distances,angles,x0);
        axis([-range range -range range -range range])
        it=it+1;
        pause(0.25)
    end
end

