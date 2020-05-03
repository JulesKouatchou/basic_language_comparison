using BenchmarkTools
using Printf
using LinearAlgebra

# Get the number of iterations from the command line
n, = size(ARGS)
if n < 1
    println("Usage: TestGaussLegendreQuadrature.jl N")
    println("       ---> Please specify the number of grid points.")
    exit()
end

N = parse(Int, ARGS[1])

"""
    gauss(a, b, N)

Finds the approximate integral over the region [a, b]
with N iterations.
"""
function gauss(a, b, N)
    F = eigen(SymTridiagonal(zeros(N), [n/sqrt(4n^2 - 1) for n = 1:N-1]))
    return [(F.values[i]+1)*(b-a)/2 + a for i = 1:N], [2*F.vectors[1, i]^2 for i = 1:N]*(b-a)/2
    #lambda, Q = eig(SymTridiagonal(zeros(N), [n/sqrt(4n^2 - 1) for n = 1:N-1]))
    #return (lambda+1)*(b-a)/2 + a, [2*Q[1, i]^2 for i = 1:N]*(b-a)/2
end


println("--------------------------")
println(@sprintf "Gauss-Legendre Quadrature %d" N)
println("--------------------------")

@btime begin
   x, w = gauss(-3, 3, $N)
   quad = sum(exp.(x) .* w)
end

#exact = exp(3) - exp(-3)
#println(quad)
#println(exact)
