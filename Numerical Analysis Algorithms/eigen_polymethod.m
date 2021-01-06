clc; clear;

%roots of det(A) cubic polynomial
coeffs= [-1 350 -25000 250000];
lambda= sort(roots(coeffs));

%plug lambdas back into system
A= [150 -100 0; -100 150 -50; 0 -50 50];
I= eye(3);
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

%table of eigenvalues
eval1= num2str(lambda(1));
eval2= num2str(lambda(2));
eval3= num2str(lambda(3));
fprintf('\nThe eigenvalues and their corresponding eigenvectors are:\n\n');
eigenvecs= array2table(eigenvec, 'VariableNames', {eval1, eval2, eval3}); 
disp(eigenvecs);

