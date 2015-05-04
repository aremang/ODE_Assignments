function [  ] = my_sim(t,theta,l)
figure()
for i=1:length(t)
	x = cos(theta(i)-pi/2)*l;
	y = sin(theta(i)-pi/2)*l;
	plot([0 x],[0 y])
	axis([-4 4 -1 4])
	pause(0.1)
end

