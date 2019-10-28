%------------------------------------------------------------
% Given a matrix A, we are looking for the matrix B such that
%
%          A = B*B
%
% The matrix A has 6s on the diagonal and 1s else where.
%------------------------------------------------------------

function test_sqrt_matrix.m(n)
    fprintf('--------------------------\n')
    fprintf('Square root of a matrix:  %5g \n', n)
    fprintf('--------------------------\n')

    A = ones(n, n);
    for i = 1:n
        A(i, i) = 6;
    end

   tic
   B = sqrtm(A);
   toc
exit;

