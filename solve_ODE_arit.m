clear all
clc

Ts = 1e-2;
T = 2*pi;
Tend = 2*T;

gamma = 0;

A =  [0		1;
	  -1	-gamma];
  
[V, D] = eig(A);

FM =@(t) [exp(D(1,1)*t)*V(:,1), exp(D(2,2)*t)*V(:,2)];
PM =@(t) FM(t)*inv(FM(0))*[1;0];

expA =@(t) exp(A*t)*[1;0];

t = 0:Ts:Tend;
store = zeros(length(t),2);
for i=1:length(t)
	store(i,:) = exp(t(i))';
end
plot(t,real(store(:,1)),'r','linewidth',1.5)
hold on
plot(t,real(store(:,2)),'k','linewidth',1.5)
legend('real','imag')
D = [D(1,1); D(2,2)]