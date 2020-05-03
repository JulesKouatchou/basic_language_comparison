
#=
Sections of the code below were proposed by Simon Danisch:
    https://gist.github.com/SimonDanisch/ae046f3a0c78b26242e78fa9b139aa11#file-benchmark-jl
=#

using BenchmarkTools
using Printf
using LinearAlgebra

"""
    regular_time_step(u::Matrix)

Take a time step in the Jacobi numerical approximation u using un-optimized loops.
"""
function regular_time_step(u::Matrix)
    n, m = size(u)
    error = 0.0
    for i in 2:n-1
        for j in 2:m-1
            temp = u[i, j]
            u[i, j] = ((u[i-1, j] + u[i+1, j] +
                       u[i, j-1] + u[i, j+1])*4.0 +
                       u[i-1, j-1] + u[i-1, j+1] +
                       u[i+1, j-1] + u[i+1, j+1])/20.0

            difference = u[i, j] - temp
            error = error + difference*difference
        end
    end
    return sqrt(error)
end

"""
    optimized_time_step{T}(u::Matrix{T})

Take a time step in the Jacobi numerical approximation u using optimized loops.
"""
#function optimized_time_step{T}(u::Matrix{T}) 
function optimized_time_step(u::Matrix{T})  where {T}
    n, m = size(u)
    error = T(0.0) # not an optimization, but makes it work for all element types
    @inbounds for i = 2:n-1
        for j = 2:m-1
            temp = u[j, i];
            u[j, i] = ( T(4) *(u[j-1, i] + u[j+1, i] +
                        u[j, i-1] + u[j, i+1]) +
                        u[j-1, i-1] + u[j+1, i+1] +
                        u[j+1, i-1] + u[j-1, i+1]) / T(20)
            difference = u[j, i] - temp
            error += difference*difference;
        end
    end
    return sqrt(error)
end

"""
    optimized_time_step_simd{T}(u::Matrix{T})

Take a time step in the Jacobi numerical approximation u using optimized loops and SIMD.
"""
#function optimized_time_step_simd{T}(u::Matrix{T})
function optimized_time_step_simd(u::Matrix{T}) where {T}
    n, m = size(u)
    error = T(0.0) # not an optimization, but makes it work for all element types
    @inbounds for i = 2:n-1
        @simd for j = 2:m-1
            temp = u[j, i];
            u[j, i] = (T(4)*(u[j-1, i] + u[j+1, i] +
                        u[j, i-1] + u[j, i+1]) +
                        u[j-1, i-1] + u[j+1, i+1] +
                        u[j+1, i-1] + u[j-1, i+1])/T(20)
            difference = u[j, i] - temp
            error += difference*difference;
        end
    end
    return sqrt(error)
end


"""
    optimized_vectorized_time_step(u::Matrix)

Take a time step in the Jacobi numerical approximation u using optimized vectorization.
"""
function optimized_vectorized_time_step(u::Matrix)
    (n, m) = size(u)
    u_old = copy(u)
    #@views u[2:n-1, 2:m-1] = ((u[1:n-2, 2:m-1] + u[3:n, 2:m-1] +
    u[2:n-1, 2:m-1] = ((u[1:n-2, 2:m-1] + u[3:n, 2:m-1] +
                        u[2:n-1, 1:m-2] + u[2:n-1, 3:m])*4.0 +
                        u[1:n-2, 1:m-2] + u[1:n-2, 3:m] +
                        u[3:n, 1:m-2] + u[3:n, 3:m])/20.0
    v = vec(u - u_old)
    return sqrt(dot(v, v))
end


# C version
const clib_name5 = tempname()
source = """
#include <math.h>
double c_time_step(int N, double *u[])
{
    double temp, difference;
    int i, j;
    double error;
    error = 0.0;
    for (i = 1; i < N-1; i++) {
        for (j = 1; j < N-1; j++) {
            temp = u[j][i];
            u[j][i] = ( 4.0 *(u[j-1][i] + u[j+1][i] +
                        u[j][i-1] + u[j][i+1]) +
                        u[j-1][i-1] + u[j+1][i+1] +
                        u[j+1][i-1] + u[j-1][i+1])/20.;
            difference = u[j][i] - temp;
            error += difference*difference;
        }
    }
    return sqrt(error);
}
"""
run(`gcc --version`)
# gcc (Ubuntu 5.4.1-2ubuntu1~16.04) 5.4.1 20160904
open(`gcc -fPIC -Ofast -O3 -xc -shared -o $(clib_name5).so -`, "w") do pipe
    print(pipe, source)
end


"""
    c_time_step(X::Vector{Vector{Float64}})

Take a time step in the Jacobi numerical approximation u for the C version.
"""
function c_time_step(X::Vector{Vector{Float64}})
    ccall(("c_time_step", clib_name5), Float64, (Cint, Ptr{Ptr{Float64}}), length(X), X)
end


"""
    solver(u, time_step)

Find the numerical approximation u by iterating the time steps.
"""
function solver(u, time_step)
    iteration = 0
    error = 2.0
    while iteration < 100000 && error > 1e-6
        error = time_step(u)
        iteration += 1
    end
    u, error, iteration
end



# Get the number of points from the command line
n, = size(ARGS)
if (n < 1)
    println("Usage: jacobiDriver4-benchmark.jl N")
    println("       --->  Please specify the number of points.")
    exit()
end

num_points = parse(Int, ARGS[1])

println("-------------------------------")
println(@sprintf "Jacobi Iterations: %d" num_points)
println("-------------------------------")


"""
    initialize_array(numPoints = num_points)

Create and populate a square array with side length num_points.
"""
#function initialize_array(numPoints = 100)
function initialize_array(numPoints = num_points)
    pi_c = 4.0 * atan(1.0)
    v = zeros(Float64, numPoints, numPoints)
    x = [(i-1)*pi_c/(numPoints-1) for i in 1:numPoints]
    v[1, :] = [sin(a) for a in x]
    v[numPoints, :] = [sin(a)*exp(-pi_c) for a in x]
    v
end


initialize_c() = (v = initialize_array(); v_2 = [v[i, :] for i=1:size(v, 1)])

functions = (regular_time_step, optimized_time_step, optimized_vectorized_time_step, optimized_time_step_simd) #
benchmarks = map(functions) do time_step
    v = initialize_array()
    solver(v, time_step) # compile
    v = initialize_array()
    # should be enough iterations already to be okay with just a simple elapsed
    result = @elapsed begin
        u, error, iteration = solver(v, time_step)
    end
    Symbol(time_step) => (result, iteration)
end

result = @elapsed begin
    v = initialize_c()
    u, error, iteration = solver(v, c_time_step)
end
benchmarks = (benchmarks..., :c_time_step => (result, iteration))
for (name, (t, sweeps)) in benchmarks
    println(name, ":")
    println("          Number of sweeps: ", sweeps)
    println("              Elapsed Time: $(t) Seconds")
end
