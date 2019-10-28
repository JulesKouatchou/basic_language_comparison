function test_evaluate_functions(nx)

    fprintf('--------------------------\n')
    fprintf('Compute values:  %5g \n', nx)
    fprintf('--------------------------\n')

    tic

    x = linspace(-1500.0, 1500.0, nx);
    M = 10000;

    for i = 1:M
        y =  sin(x);
        x = asin(y);
        y =  cos(x);
        x = acos(y);
        y =  tan(x);
        x = atan(y);
    end

    toc

exit;
