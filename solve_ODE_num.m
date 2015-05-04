clear all
clc
close all

global A B

str = {'Spring w.o e.f', 'Spring w e.f', 'Pendulum down', 'Pendulum up'};
[s,v] = listdlg('PromptString','choose system',...
                'SelectionMode','single',...
                'ListString',str);

if s==1 % Spring without external force
	sigma = 50; % sigma = my/(m*sqrt(k/m));
	A = [0,		1;...
		 -1,	-sigma];
	figure()
	hold on
	axis([0 20 -1 1])
	[~,init] = ginput(1);
	B = [0;...
		 0];
	 
	 
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif s==2 % Spring with external force
	sigma = 0; % sigma = my/(m*sqrt(k/m));
	F = 0.1;
	m = 1;
	k = 1;
	omega = 3;
	F = 0.1;
	A =@(t) [0,		1;...
			1,		-sigma];
	figure()
	hold on
	axis([0 20 -1 1])
	init = -0.01;
	x0 = init;
	B =@(t) [0;...
		 F/m*1/(sqrt(k/m)*x0)*cos(omega*t)];
	 
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else % Pendulum
	omega	= 1;
	l		= 3;
	amp		= 0.08*l;
	g		= 9.82;
	a		= g/(l*omega^2);
	epsi	= amp/(2*l);
	gamma	= 0.1;
	kappa	= gamma/omega;
	
	if s==3 % Down
		A =@(t) [0,							1;...
				-(a-2*epsi*cos(t*omega)),	-kappa];
		init = 0.1;
		B = [0;...
		 0];
	else % Up
		A =@(t) [0,							1;...
				(a-2*epsi*cos(t*omega)),	-kappa];
		init = pi+0.1;
		B =@(t) [0;...
				-(a-2*epsi*cos(t*omega))*pi];
	end
end
 
if(~isempty(s))
	
	[t,theta] = ode45(@my_ODE, [0 100], [init 0]);
	
	clf
	subplot(2,1,1)
	plot(t,theta(:,1))
	
	u = gradient(theta(:,1));
	v = gradient(theta(:,2));
	subplot(2,1,2)
	quiver(theta(:,1), theta(:,2), u, v)

% 	if(s==4)
% 		my_sim(t,theta(:,1),l)
% 	end
end