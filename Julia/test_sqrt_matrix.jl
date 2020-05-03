using BenchmarkTools
using Printf

# Get the matrix dimensions N from the command line argument.
N = parse(Int, ARGS[1])

A = ones(N, N)
for i = 1:N
    A[i, i] = 6
end

println("--------------------------")
println(@sprintf "Matrix square root: %d" N)
println("--------------------------")

# Take the square root of matrix A.
@btime begin
    B = sqrt(A)
end 
