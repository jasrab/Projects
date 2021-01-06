function [U]= factor_chol(A)
 % Cholesky Factorization: Cholesky Factorization without pivot
 % [U] = Jasmin_Rabosto_chol(A)
 % input
 % A= symmetric coefficient matrix
 % output:
 % U = upper triangular factor such that U * U'== A

[n, m]=size(A);
if n~=m
    error('Matrix A must be symmetric');
end
U=zeros(n,m);
factor1=0;
factor2=0;
for ii=1:1:n %rows
    for jj=1:1:m %columns
        if (ii==jj && ii>1)
            array1= U(ii:-1:1,jj);
            square1= array1.^2;
            factor1=sum(square1);
        end
        if ii==jj
            U(ii,jj)= sqrt(A(ii,jj)-factor1);
        end
        if (ii<jj && ii>1)
            array2= U(ii-1,ii:1:m);
            factor2= prod(array2);
        end
        if ii<jj
            U(ii,jj)= (A(ii,jj) - factor2)/U(ii,ii);
        end     
end
end
