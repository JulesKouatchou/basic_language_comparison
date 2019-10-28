% **********************************************************
% Given a nxnx3 matrix A, we want to perform the operations:
%
%       A[i][j][0] = A[i][j][1]
%       A[i][j][2] = A[i][j][0]
%       A[i][j][1] = A[i][j][2]
% **********************************************************
 
function test_copy_matrix(nx)
    %nx = 5000;


    disp(nx);

    fprintf('--------------------------\n')
    fprintf('ji Loop Copy:  %5g \n', nx)
    fprintf('--------------------------\n')

    A = rand (nx, nx, 3);
    tic

    for j = 1:nx
        for i = 1:nx
            A(i, j, 1) = A(i, j, 2);
            A(i, j, 3) = A(i, j, 1);
            A(i, j, 2) = A(i, j, 3);
        end
    end

    toc


    fprintf('--------------------------\n')
    fprintf('Vectorization Copy:  %5g \n', nx)
    fprintf('--------------------------\n')

    A = rand (nx, nx, 3);
    tic

    A(:, :, 1) = A(:, :, 2);
    A(:, :, 3) = A(:, :, 1);
    A(:, :, 2) = A(:, :, 3);

    toc

exit;
