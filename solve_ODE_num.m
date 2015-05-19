clear all
clc
close all

global A B

str = {'Spring w.o e.f', 'Spring w e.f', 'Pendulum down', 'Pendulum up'};
[s,v] = listdlg('PromptString','choose system',...
                'SelectionMode','single',...
                'ListString',str);

if s==1 % Spring without external force
	sigma = 0.25; % sigma = my/(m*sqrt(k/m));
	A =@(t) [0,		1;...
			-1,		-sigma];
	figure()
	hold on
	axis([0 20 -1 1])
	init = 1;
	B =@(t) [0;...
			0];
	 
	[t,theta] = ode45(@my_ODE, [0 1000], [init 0]);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif s==2 % Spring with external force
	sigma = 0; % sigma = my/(m*sqrt(k/m));
	F = 0.1;
	m = 1;
	k = 1;
	omega = 1;
    w_0 = sqrt(k/m);
    beta = -1/(0.5*pi); % F/(m*w_0^2*x0);
	A =@(t) [0,		1;...
			-1,		-sigma];
	figure()
	hold on
	axis([0 20 -1 1])
	init = -0.01;
	x0 = init;
	B =@(t) [0;...
		 beta*cos(omega*t)];
	 
	[t,theta] = ode45(@my_ODE, [0 100], [init 0]);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else % Pendulum	
	if s==3
		l		= 3;
		amp		= 0.05*l;
		g		= 9.82;
		omega	= sqrt(g/l);
		a		= g/(l*omega^2);
		epsi	= amp/l;
		gamma	= 0.1;
		kappa	= gamma/omega;
		init = 0.01;
	else % Up
		l		= 3;
		amp		= 0.05*l;
		g		= 9.82;
		omega	= 90;
		a		= g/(l*omega^2);
		epsi	= amp/l;
		gamma	= 0.1;
		kappa	= gamma/omega;
		init = -pi+0.01;
	end
	f =@(t,x) [x(2);...
				-(a-epsi*cos(t))*sin(x(1))-kappa*x(2)];
	t = 1:0.2:100;
	[t,theta] = ode45(f, t, [init 0]);
end
 
if(~isempty(s))
	
	clf
% 	subplot(2,1,1)
 	plot(t,theta(:,1))

	figure()
	u = gradient(theta(:,1));
	v = gradient(theta(:,2));
% 	subplot(2,1,2)
	n = 2;
	quiver(theta(1:n:end,1), theta(1:n:end,2), u(1:n:end), v(1:n:end))

% 	set(gca, ...
% 	  'Box'         , 'off'     , ...
% 	  'TickDir'     , 'out'     , ...
% 	  'TickLength'  , [.02 .02] , ...
% 	  'XMinorTick'  , 'on'      , ...
% 	  'YMinorTick'  , 'on'      , ...
% 	  'YGrid'       , 'on'      , ...
% 	  'XColor'      , [.3 .3 .3], ...
% 	  'YColor'      , [.3 .3 .3], ...
% 	  'LineWidth'   , 1         );
% 	set(gcf, 'PaperPositionMode', 'auto');
% 	print -depsc2 fig/wfric_gamma_05_omega_2.eps

	
end