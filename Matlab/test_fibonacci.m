
function test_fibonacci(n)

  fprintf('--------------------------\n')
  fprintf('Iterative Fibonacci:  %5g \n', n)
  fprintf('--------------------------\n')

  tic
    f=test_fibonacci_iter(n);
  toc

  fprintf('--------------------------\n')
  fprintf('Recursive Fibonacci:  %5g \n', n)
  fprintf('--------------------------\n')

  tic
    f=test_fibonacci_recur(n);
  toc
exit;
