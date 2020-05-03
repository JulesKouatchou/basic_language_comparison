using Printf
using BenchmarkTools


# Get the matrix dimensions from the command line argument.
n, = size(ARGS)
if (n < 1)
    println("Usage: matrixMult.jl N")
    println("       ---> Please specify the dimensions.")
    exit()
end

N = parse(Int, ARGS[1])


println("----------------------------")
println(@sprintf "Matrix dimensions: %d" N)
println("----------------------------")
println(" ")

# Multiply matrices A and B.
A = randn(N, N)
B = randn(N, N)

@btime C = A*B
