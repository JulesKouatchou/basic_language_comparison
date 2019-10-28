
% Determine the FTT of a complex matrix

function test_compute_FFT(n)
    fprintf('--------------------------\n')
    fprintf('FFT of complex matrix:  %5g \n', n)
    fprintf('--------------------------\n')

    tic

    complex_mat = rand(n, n) + 1j * randn(n, n);
    result = fft2(complex_mat);
    result = abs(result);

    toc

exit;
