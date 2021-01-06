%description: find eignenvalues and eigenvectors for homogenous linear system where A = 3x3 matrix

%created by Jasmin Rabosto for the sole purpose of exercising numerical methods application.   
% date: July 2020

clc; clear;
%roots of det(A) cubic polynomial
A = input('Input 3x3 matrix A using brackets[] ex.[1 2 3; 4 5 6; 7 8 9]:\n');
A_sym = sym(A);
m = size(A);
syms x
I_sym = sym(eye(m)*x);
H_sym = A_sym-I_sym;
func_sym = det(H_sym);
coeffs = sym2poly(func_sym);
lambda= roots(coeffs);
%plug lambdas back into system
%A= [2.5 -1.666 0; -1.42857 2.14285 -0.71428; 0 -0.625 0.625];
I= eye(m);
n=length(lambda);
b=[0;0;0]; 
eigenvec= zeros(n);
for ii=1:n
    Ilam= lambda(ii).*I;
    newA= A - Ilam;
    %use Gauss Elimination to find {x} for lamda(ii)
    xs= GaussEigen(newA, b);
    eigenvec(:, ii)=xs;
end
eval1= num2str(lambda(1));
eval2= num2str(lambda(2));
eval3= num2str(lambda(3));
fprintf('\nThe eigenvalues and their corresponding eigenvectors are:\n\n');
eigenvecs= array2table(eigenvec, 'VariableNames', {eval1, eval2, eval3}); 
disp(eigenvecs);

