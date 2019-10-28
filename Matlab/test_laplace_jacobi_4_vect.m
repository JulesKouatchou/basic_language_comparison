%###############################################
% Numerical solution of the Laplace's equation.
%
%  u   + u   = 0
%   xx    yy
%
% Fourth-order compact Scheme
% Jacobi's iteration
%###############################################

function test_laplace_jacobi_4_vect(nx)
    x_min = 0;
    x_max = 1;
    y_min = 0;
    y_max = 1;

    %nx = 100;
    ny = nx;

    dx = (x_max - x_min) / (nx - 1);
    dy = (y_max - y_min) / (ny - 1);

    x = x_min:dx:x_max;
    y = y_min:dy:y_max;

    n_iter = 10000;
    eps = 1e-6;

    u = zeros(nx,ny);
    u(:,1)   = sin(x.*pi);
    u(:,end) = sin(x.*pi)*exp(-pi);
    err = Inf;
    count = 0;

    tic

    while err > eps && count < n_iter
        count = count + 1;
        u_old = u;
        u(2:end-1, 2:end-1) = ((u(1:end-2, 2:end-1) + u(3:end, 2:end-1) + u(2:end-1, 1:end-2) + u(2:end-1, 3:end))*4.0 + u(1:end-2, 1:end-2) + u(1:end-2, 3:end) + u(3:end, 1:end-2) + u(3:end, 3:end))/20.0;
        v = (u - u_old);
        err = sqrt(v(:).'*v(:));
    end

    fprintf('Jacobi with Matlab - Vectorization \n');
    fprintf('     Number of iterations: %5g \n', count);
    fprintf('     Error: %12.10f \n', err);

    toc
exit;
