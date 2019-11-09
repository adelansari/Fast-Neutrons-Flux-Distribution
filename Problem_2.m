%%   Nuclear Reactor Theory   %%
%*   Project                  *%
%*   Adel Ali Ansari          *%
%*   U00038673                *%
%*   Problem 2                *%
%******************************%
clear all
clc

%%  Numerical solution  of the one speed diffusion equation to find the flux distribution


disp('****Nuclear Reactor Theory');
disp(sprintf('****Project- Problem 2\n'));
disp(sprintf('\t\t\t\tAdel Ali Ansari           -- U00036658\n'));
disp(sprintf('\n\t\t\t\tInstructor:\tDr.Iyad Al Qasir\n'));

Diffusion_coefficient= 0.562;
SigmaA=0.00551;
delta=0.25;

a_material= (-Diffusion_coefficient)/(delta^2);
b_material= SigmaA + ((2*Diffusion_coefficient)/(delta^2));


D=0.562
sigma_absorbtion = 0.00551

Delta = 0.25
b= (4*D/(Delta^2))+sigma_absorbtion
a= -(D/(Delta^2))

coff=zeros(1600);
%%
%entering flux coafficient
for i=1:1600
    for j=1:1600
        
        if i==j
            coff (i,j) = b;
        end
        
    end
end
for i=1:1600-1
    coff(i, i+1)=a;
    coff(i+1, i)=a;
end
for i=1:1600-41
    coff(i,i+40)=a;
    coff(i+40, i)=a;
end
for i=1:40-1
    coff((i*40),(i*40)+1)=0;
    coff((i*40+1),(i*40))=0;
end
%%
%entering source matrix
z=1;

for i=linspace(-5,5,40)
    for j=linspace(-5,5,40)
        
        s(z)= (10^12)*cos(pi*(i/10))*exp(-((i^2)+(j^2)));
        z=z+1;
    end
end

%%
% Finding the flux
loop=1;
I=s*inv(coff);
for i=1:40
    for j=1:40
        flux(i,j)=I(loop) ;
        
        loop=loop+1 ;
    end
end

%%
%Results and plots
FigHandle = figure('Position', [20, 50, 650, 550]);

subplot(2,2,1)
contour3(flux,1000)
xlabel('x')
ylabel('y')
zlabel('z')
title('1-Three dimensional plot of flux(x,y)')

subplot(2,2,2)
contour(flux)
xlabel('x')
ylabel('y')
title('2-Two dimensional contour of flux(x,y)')
colorbar

subplot(2,2,3)
plot(flux(40,:))
xlabel('X')
ylabel('flux')
title('3- flux(x,0)')

subplot(2,2,4)
plot(flux(:,40))
xlabel('y')
ylabel('flux')
title('4- flux(0,y)')
