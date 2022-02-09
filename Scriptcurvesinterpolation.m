clear all
puntos1=rand(4,3);
puntos2=rand(4,3);
samples=1000;
curves=zeros(samples,3,3);
figure(1),
curves(:,:,1)=BezierCurves(puntos1,samples);
figure(2),
curves(:,:,2)=BezierCurves(puntos2,samples);
figure(3)
outcurves=LinearCurvesInterpolator(curves,10);