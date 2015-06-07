% ODE Assignment 2

clear all
close all
clc
clf
%% Logistic equation

% global a b
% 
% a = 1;          % Scalar constant
% b = 2;          % Right hand side
% T = 100;
% tau = [0 T];    % Time vector
% x_init = [0:5];         % Begynnelsevärde
% ri = 0.1;
% K = 10;
% 
% f = @(t,x)ri.*x.*(1-x./K);
% 
% hold on;
% 
% for i=1:length(x_init)
%     [t,X] = ode45(f,tau,x_init(i));
%     plot(t,X);
% end

%% Lotka-Volterra two species competition model

r1 = 0.1;   %Gamma1
r2 = 0.2;   %Gamma2

alpha = 4;  %alpha1
beta = 1;   %alpha2

% Ask for which case
str = { 'r2/beta>K1 & r1/alpha<K2','r2/beta<K1 & r1/alpha>K2', 'r1/alpha>K2 & r2/beta>K1', 'r2/beta<K1 & r1/alpha<K2'};
[s,v] = listdlg('PromptString','choose system',...
                'SelectionMode','single',...
                'ListString',str);

if s==1 
    K1 = 0.1;
    K2 = 1;
elseif s ==2 
    K1 = 0.3;
    K2 = 0.01;
elseif s==3
    K1 = 0.1;
    K2= 0.01;
else
    K1 = 0.4;
    K2 = 0.1;
end
x_init = [.5 .5];
T = 1e2;
tspan = [0 T];

f = @(t,x)[r1.*x(1).*(1-x(1)./K1)-alpha.*x(1).*x(2); r2.*x(2).*(1-x(2)./K2)-beta.*x(2).*x(1)];

[t,X] = ode45(f,tspan,x_init);

figure(1)
hold on
plot(t,X(:,1),t,X(:,2),t,ones(length(t)).*K1,'--',t,ones(length(t)).*K2,'--');        % Integral curves of the 
legend('x1','x2')

% hLegend = legend('$x_1$', '$x_2$', '$K_1$', '$K_2$', 'location', 'NorthEast');
% set(hLegend, 'Interpreter', 'latex');
% set([hLegend, gca], 'FontSize', 8);
title('Lotka-Volterra')
xlabel('Time [s]')
ylabel('Population')
set(gca, ...
	  'Box'         , 'off'     , ...
	  'TickDir'     , 'out'     , ...
	  'TickLength'  , [.02 .02] , ...
	  'XMinorTick'  , 'on'      , ...
	  'YMinorTick'  , 'on'      , ...
	  'YGrid'       , 'on'      , ...
	  'XColor'      , [.3 .3 .3], ...
	  'YColor'      , [.3 .3 .3], ...
	  'LineWidth'   , 1.5);
set(gcf, 'PaperPositionMode', 'auto');
input = inputdlg('Write the name for the file:',...
             'Save the plot as an eps');
if isempty(input)
    warndlg('The file was not saved','!! Warning !!')
else
    str = strcat('fig/', input, '.eps');
    print(str{1},'-depsc2')
end

figure(2)
quiver(X(:,1),X(:,2),gradient(X(:,1)),gradient(X(:,2)))


