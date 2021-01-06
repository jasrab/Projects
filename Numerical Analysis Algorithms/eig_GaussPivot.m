function x = GaussEigen(A,b)
% GaussEigen: Gauss elimination pivoting
% x = GaussPivot(A,b): Gauss elimination with pivoting.
% input:
% A = coefficient matrix
% b = right hand side vector
% output:
% x = solution vector
[m,n]=size(A);
if m~=n, error('Matrix A must be square'); end
nb=n+1;
Aug=[A b];
% forward elimination
for kk = 1:n-1 %row
     Aug(kk,:)= Aug(kk,:)*(1/Aug(kk,kk));
     factor = Aug(kk+1,kk);
     Aug(kk+1,kk:nb)=Aug(kk+1,kk:nb)-factor*Aug(kk,kk:nb);
end
ii=1;
factor = Aug(ii,ii+1);
Aug(1,1:nb)=Aug(1,1:nb)-factor*Aug(2,1:nb); 
% eigenvector
x=zeros(1,n);
x(n)=1;
for jj=1:n-1
    x(jj)= -Aug(jj,n);
end
end