
% Matlab: Recursive fibonacci
function f=test_fibonacci_recur(n)
    if n <= 2
        f = 1.0;
    else
        f = test_fibonacci_recur(n-1) + test_fibonacci_recur(n-2);
    end
end
