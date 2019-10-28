% **********************************************************
% Given two nxn matrices A and B, we perform:
%       C = A x B
% ********************************************************** 
 
function test_matrix_multiplication(nx)
    A = rand (nx);
    B = rand (nx);

    disp(nx);

    tic

    AB = A * B;

    toc

exit;

