% Description: script that determines root of function closest to given initial guess 
% using Newton-Raphson
%
% created by Jasmin Rabosto for the sole purpose of exercising numerical methods application.   
% date: July 2020

clc; clear;

coeffs = input('List the function coefficients using enclosed brackets[] ex.[1 2 3]: ');
x_initial = input('Input an initial guess: '); 
n = length(coeffs);
elements = strings(n*2, 1);
elements(1) = '@(x)';

for ii = 2:2:length(elements)
    elements(ii) = sprintf('%g*x^%g', coeffs(ii/2), n-(ii/2));
    if n-(ii/2) == 0
        elements(ii) = sprintf('%g', coeffs(ii/2));
        break
    end
    elements(ii+1) = '+';
end

func_string = join(elements);
func = str2func(func_string);
func_sym = str2sym(func_string);
df_sym= diff(func_sym);
dfunc= matlabFunction(df_sym);
es = 0.01; %set tolerance
%Newton-Raphson
[root, ea, iter] = roots_newtraph(func, dfunc, x_initial, es);
fprintf('\nroot = %g\nnumber of iterations = %g\n', root, iter);
