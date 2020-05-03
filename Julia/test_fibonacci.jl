using Printf
using BenchmarkTools


# Get the number of iterations from the command line.
n, = size(ARGS)
if n < 1
    println("Usage: fibonnaci.jl N")
    println("       ---> Please specify the number of iterations.")
    exit()
end

N = parse(Int, ARGS[1])

"""
    recursive_fibonacci(n)

Finds the nth Fibonacci number using recursion.
"""
function recursive_fibonacci(n)
    if n <= 2
        1.0
    else
        recursive_fibonacci(n-1) + recursive_fibonacci(n-2);
    end
end


"""
    iterative_fibonacci(n)

Finds the nth Fibonacci number using iteration.
"""
function iterative_fibonacci(n)
    x, y = (0, 1)
    for i = 1:n x, y = (y, x + y) end
    x
end


println("--------------------------")
println(@sprintf "Iterative - Fibonnaci %d" N)
println("--------------------------")

@btime iterative_fibonacci(N)

println("--------------------------")
println(@sprintf "Recursive - Fibonnaci %d" N)
println("--------------------------")

@btime recursive_fibonacci(N)
