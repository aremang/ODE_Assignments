clear all
clc

N = 1e2;

epsi = linspace(-5,5,N);
a = linspace(-2,5,N);

sol = zeros(2);

T = 2*pi;
t = 0:T/2:T;

figure()
axis([-2 5 -5 5])
hold on
counter = 0;

for i=1:N
	for ii=1:N
		A =@(t,x)	[x(2);...
			-(a(i)-epsi(ii)*cos(t))*x(1)];
		
		[~,theta] = ode113(A, t, [1 0]);
		sol(:,1) = theta(end,:)';
		[~,theta] = ode113(A, t, [0 1]);
		sol(:,2) = theta(end,:)';
		
		if abs(trace(sol)) < 2
			plot(a(i),epsi(ii),'b.')
			counter = counter+1;
		end
	end
end