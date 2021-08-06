
% -----------------------------------
% Determine the Nth pernicious number
% -----------------------------------

function test_pernicious_numbers(N)
    tic

    i = 1;
    num_pernicious = 0;

    while num_pernicious < N
        binStr = dec2bin(i);
        y = length(find(binStr=='1'));
        if (isprime(y) == 1)
        %if (is_prime_number(y) == 1)
           num_pernicious = num_pernicious + 1;
           %fprintf('Pernicious number:  %8g %10g %10g \n', N, i, y)
        end
        i = i + 1;
    end

    toc

    fprintf('Pernicious number:  %8g %10g \n', N, i-1)

exit;

