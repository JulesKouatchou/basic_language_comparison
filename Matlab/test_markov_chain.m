
function test_markov_chain(N)
    tic
    f = @(x) exp(sin(x(1)*5) - x(1)^2 - x(2)^2);
    x = zeros(2);
    p = f(x);
    for n=1:N
        x2 = x + .01*randn(size(x));
        p2 = f(x2);
        if rand < p2/p
            x = x2;
            p = p2;
        end
    end
    toc
end
