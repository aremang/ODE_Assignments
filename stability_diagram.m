clear all
clc

N = 100;

epsi = linspace(-6,6,N);
a = linspace(-2,3,N);
kappa = 0.5;

sol = zeros(2);
dot = zeros(N*N,2);


T = 2*pi;
t = 0:T/2:T;

num_sol = 1;
h = waitbar(0,'Initializing waitbar...');

for i=1:N
	for ii=1:N
		A =@(t,x)	[x(2);...
			-kappa*x(2)-(a(i)-epsi(ii)*cos(t))*x(1)];
		
		[~,theta] = ode113(A, t, [1 0]);
		sol(:,1) = theta(end,:)';
		[~,theta] = ode113(A, t, [0 1]);
		sol(:,2) = theta(end,:)';
		
		if abs(trace(sol)) < 2
			dot(num_sol,:) = [a(i),epsi(ii)];
			num_sol = num_sol+1;
		end
	end
	waitbar((i/N),h,'working...')
end
save('stab_fric')
%%
plot(dot(1:num_sol-1,1),dot(1:num_sol-1,2),'.')
% set(gca, ...
%   'Box'         , 'off'     , ...
%   'TickDir'     , 'out'     , ...
%   'TickLength'  , [.02 .02] , ...
%   'XMinorTick'  , 'on'      , ...
%   'YMinorTick'  , 'on'      , ...
%   'XGrid'       , 'on'      , ...
%   'YGrid'       , 'on'      , ...
%   'XColor'      , [.3 .3 .3], ...
%   'YColor'      , [.3 .3 .3], ...
%   'LineWidth'   , 0.5         );
% set(gcf, 'PaperPositionMode', 'auto');
% print -depsc2 fig/stab_3.eps