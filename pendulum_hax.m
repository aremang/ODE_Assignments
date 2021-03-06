% ODE Assignment 1 - Pendulum case

%% Constants & parameters

g = 9.82;
l = 3.0;            %length of the swing
A = 0;          %Amplitude of the oscillations
gamma = 0;          %Friction coefficient
omega = 2*sqrt(g/l);      %Exitation frequency
% Pendeln blir stabil f�r ca w >= 52


tau = 0;            %Begynnelsev�rde
T = 20;             %End time
x0 = [0.1 0]';        %Randvillkor

f = @(t,x)[x(2);-gamma/omega*x(2)-(g-A*omega^2*cos(t))*sin(x(1))/(l*omega^2)];

t = tau:0.1:T;

[T,X] = ode45(f,t,x0);


%% Time and phase plotting
figure(1)
plot(T,X(:,1));


figure(2)
quiver(X(:,1),X(:,2),gradient(X(:,1)),gradient(X(:,2)))
% plot(X(:,1),X(:,2))
title('Phase portrait')
xlabel('Angle')
ylabel('Angular velocity')
% 
set(gca, ...
	  'Box'         , 'off'     , ...
	  'TickDir'     , 'out'     , ...
	  'TickLength'  , [.02 .02] , ...
	  'XMinorTick'  , 'on'      , ...
	  'YMinorTick'  , 'on'      , ...
	  'YGrid'       , 'on'      , ...
	  'XColor'      , [.3 .3 .3], ...
	  'YColor'      , [.3 .3 .3], ...
	  'LineWidth'   , 1         );
	set(gcf, 'PaperPositionMode', 'auto');
	print -depsc2 fig/pp_down_2w_eps_0.eps




