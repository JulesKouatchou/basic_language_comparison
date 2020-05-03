using BenchmarkTools
using Printf
using Random
using LinearAlgebra

# Get the number of iterations from the command line.
n, = size(ARGS)
if n < 1
    println("Usage: belief.jl N")
    println("       ---> Please specify the number of iterations.")
    exit()
end

N = parse(Int, ARGS[1])

"""
    beliefpropagation(N)

Runs the belief propagation algorithm N times.
"""
function beliefpropagation(N)
    dim = 5000
    x = ones(dim)
    A = (randn(dim,dim) .+ 1.0)/2.0

    for i = 1:N
        x = log.(A*exp.(x));
        x .-= log.(sum(exp.(x)));
    end
    x
end

println("--------------------------")
println(@sprintf "Belief calculations: %d" N)
println("--------------------------")

@btime beliefpropagation(N)
