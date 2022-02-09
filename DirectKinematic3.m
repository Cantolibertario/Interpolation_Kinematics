function x = DirectKinematic3(distances,angles,x0)
% DirectKinematic3 Calculate the position of a n-kinematic chain with 3DOF in 3D
%   Returns x, a vector with the position of each joints (in each column).
%   Needs distances, a matrix of the inicial orientation and length. The
%   format is each column is a vector whose norm2 is the legth of the arm
%   and its angle is its initial orientation, size 3x#joints.
%   angles, a matrix of angles to compute, each column is a DOF and each
%   row is asociated to a joint, size #jointsx3.
%   x0 is the position of the base position.
%   Example: DirectKinematic3(rand(3),rand(3),[0;0;0])
    
    s=size(distances);
    x=zeros(s(1),s(2)-1);
    x(:,1)=x0;
    scatter3(x(1,1),x(2,1),x(3,1),450,'o','filled','r'),hold on
    sumangles=zeros(1,3);
    for i=1:s(2)
        sumangles=angles(i,:)+sumangles;
        R1=[cos(sumangles(1)) sin(sumangles(1)) 0; 
            -sin(sumangles(1)) cos(sumangles(1)) 0;
            0 0 1];
        R2=[1 0 0;
            0 cos(sumangles(2)) sin(sumangles(2)); 
            0 -sin(sumangles(2)) cos(sumangles(2))];
        R3=[cos(sumangles(3)) sin(sumangles(3)) 0;
            0 1 0;
            0 -sin(sumangles(3)) cos(sumangles(3))];
        x(:,i+1)=R3*(R2*(R1*distances(:,i)))+x(:,i);
        line([x(1,i+1),x(1,i)],[x(2,i+1),x(2,i)],[x(3,i+1),x(3,i)], 'LineWidth', 5); 
        scatter3(x(1,i+1),x(2,i+1),x(3,i+1),250,'o','filled','MarkerFaceColor',[.50 .8 .1])
    end
    hold off
end