clear all
clc	

x = [1, 0;...
	0,	1];
sol = zeros(2);
A =@(t,x)	[x(2);...
			-(1-1*cos(t))*x(1)];

T = 2*pi;

[~,theta] = ode45(A, [0 T], [1 0]);

theta(end,:)'

t = 0:T/2:T;

[~,theta] = ode45(A, t, [1 0])

theta(end,:)'