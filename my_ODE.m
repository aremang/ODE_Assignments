function dx = my_ODE(t,x)
global A B 

dx		= A(t)*x + B(t);
end

