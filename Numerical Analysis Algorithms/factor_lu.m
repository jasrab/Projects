function [L,U]= factor_lu(A)
 % LU Factorization without partial pivot
 % [L,U] = Jasmin_Rabosto_lu(A)
 % input:
 % A= symmetric coefficient matrix
 % output:
 % L= lower triangular factor such that L*U == A 
 % U = upper triangular factor such that L*U == A
[n, m]=size(A);
if n~=m
    error('Matrix A must be symmetric');
end
U=A;
for ii=1:1:n %rows
        if ii>1 
            factor= A(ii,1)/A(1,1);
            U(ii,:)= A(ii,:)- A(1,:)*factor;
        end
end
for jj=2:1:m %columns
    if U(jj,jj-1)~=0
        factor= U(jj,jj-1)/U(jj-1,jj-1);
        U(jj,jj-1:m)=U(jj,jj-1:m)-U(jj-1,jj-1:m)*factor;
    end
end
L=zeros(n,m);
for kk=1:1:n %rows
    for qq=1:1:m %columns
        if kk==qq
            L(kk,qq)=1;
        end
        if kk>qq
            L(kk,qq)= A(kk,qq)/A(qq,qq);
        end
    end
end
end