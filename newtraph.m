function [root, ea, iter] = newtraph(func, dfunc, x_initial, es, maxiter, varargin);
% newtraph.m : uses Newton-Raphson method to find the root of func
% func = function
% dfunc = derivative of function
% x_initial = initial guess
% es = set tolerance (default = 0.0001%)
% maxiter = maximum allowable iterations (default = 50)
% 
% root = real root
% ea = approximate error (%)
% iter = number of iterations
if nargin<3
    error('at least 3 input arguments required')
end
if nargin<4 || isempty(es)
    es=0.0001;
end
if nargin<5 || isempty(maxiter)
    maxiter=50;
end
%initialize iteration
iter = 0;
while (1)
xrold = x_initial;
%Newton-Raphson method
x_initial = x_initial - func(x_initial,varargin{:})/dfunc(x_initial,varargin{:});
iter = iter + 1;
xreturn(iter) = x_initial;
if x_initial ~= 0
ea(iter) = abs((x_initial - xrold)/x_initial) * 100; % approximate relative error
end
if ea(iter) <= es || iter >= maxiter
break
end
end
root = x_initial;