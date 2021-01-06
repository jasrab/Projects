% description: Factorization of 3x3 matrix A and/or solution of 3x3 linear system using either: 
% 1)LU Factorization or 2)Cholesky Factorization without pivot
% created by Jasmin Rabosto

% determine if just a matrix factorization or if a linear system problem
%determine what type of factorization user wants
ans_type = input('Select number 1 or 2:\nDo you need to solve 1) a matrix factorization or 2) a linear system problem?: '); 
if ans_type == 1
 A = input('\nInput 3x3 matrix A using brackets[] ex.[1 2 3; 4 5 6; 7 8 9]:\n');
 factor_type = input('\nSelect number 1 or 2:\nWhich factorization method do you want to perform 1) LU or 2) Cholesky?: ');
elseif ans_type == 2
    A = input('\nInput 3x3 matrix A using brackets[] ex.[1 2 3; 4 5 6; 7 8 9]:\n');
    B = input('\nInput 1x3 matrix B using brackets[] ex.[1; 2; 3]:\n');
    factor_type = input('\nSelect number 1 or 2:\nWhich factorization method do you want to perform to find the solution 1) LU or 2) Cholesky?: ');
%else
%    error('Error: must select 1 or 2');
end

%if factor_type ~= 1 || factor_type ~= 2
%    error('Error: must select 1 or 2');
%end
if ans_type == 1 & factor_type == 1
    [L,U] = factor_lu(A);
    LU = [L,U];
    disp(LU);
elseif ans_type == 1 & factor_type == 2
    U = factor_chol(A);
    disp(U);
elseif ans_type == 2 & factor_type == 1
    [L,U]= factor_lu(A);
    D= B/L;
    X = D/U;
    disp(X); 
elseif ans_type == 2 & factor_type == 1
    U = factor_chol(A);
    D = U'/B;
    X = D/U;
    disp(X);
end
