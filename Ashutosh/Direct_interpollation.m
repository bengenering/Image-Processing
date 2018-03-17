tic
clc
clear all
disp('Enter all the values in the form of Column matrix');
x(:,2)=input('Enter first column of Details:');
x(:,3)=input('Enter second column of Details:');
t=input('Enter point where you want to find the value:');
n=size(x);
n=n(2);
x(:,1)=abs(t-x(:,2));
x=sortrows(x);
A=[x(1,2)^3 x(1,2)^2 x(1,2) 1;x(2,2)^3 x(2,2)^2 x(2,2) 1;x(3,2)^3 x(3,2)^2 x(3,2) 1;x(4,2)^3 x(4,2)^2 x(4,2) 1];
B=[x(1,3);x(2,3);x(3,3);x(4,3)];
T=inv(A)*B;
f=@(m) (T(1)*m^3)+(T(2)*m^2)+(T(3)*m)+T(4);
f(t)
toc 