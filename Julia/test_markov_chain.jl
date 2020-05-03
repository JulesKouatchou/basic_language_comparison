using BenchmarkTools
using Printf

# Get the number of iterations from the command line
n, = size(ARGS)
if (n < 1)
    println("Usage: test_markov_chain.jl N")
    println("       ---> Please specify the number of iterations.")
    exit()
end

N = parse(Int, ARGS[1])


"""
    function markov_optimized(x,N)

Operate the Markov chain on two identical inputs x a total of N times.
"""
function markov_optimized(x, N)
    x1, x2 = x
    f(x1, x2) = exp(sin(x1*5) - x1^2 - x2^2)
    p = f(x1, x2)
    for n = 1:N
        y1 = x1 + 0.01*randn(x1)
        y2 = x2 + 0.01*randn(x2)
        q = f(y1, y2)
        if p*rand() < q
            x1 = y1
            x2 = y2
            p = q
        end
    end
end


"""
    function markov(x, y, N)

Operate the Markov chain on two inputs x, y a total of N times.
"""
function markov(x, y, N)
    f(x, y) = exp(sin(x*5) - x^2 - y^2)    
    p = f(x, y)
    for n = 1:N
        x2 = x + 0.01*randn()
        y2 = y + 0.01*randn()
        p2 = f(x2, y2)
        if rand() < p2/p
            x = x2
            y = y2
            p = p2
        end
    end
    x, y
end

# trigger JIT
markov(0.0, 0.0, 10)

println("--------------------------")
println(@sprintf "Markov Chain calculations: %d" N)
println("--------------------------")

@btime markov(0.0, 0.0, N)

#println("--------------------------")
#println(@sprintf "Markov Chain calculations - Opt: %d" N)
#println("--------------------------")
#
@btime markov_optimized([0.0 0.0],N)
