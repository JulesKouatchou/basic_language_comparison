
################################################
# Sections of the code below were proposed by Simon Danisch:
#     https://gist.github.com/SimonDanisch/ae046f3a0c78b26242e78fa9b139aa11#file-benchmark-jl
################################################

using BenchmarkTools


"""
    regular_time_step(u::Matrix)

Find the Jacobi numerical approximation using un-optimized loops.
"""
function regular_time_step(u::Matrix)
    n, m = size(u)
    err = 0.0
    for i in 2:n-1
        for j in 2:m-1
            tmp = u[i,j]
            u[i,j] = ((u[i-1, j] + u[i+1, j] +
                       u[i, j-1] + u[i, j+1])*4.0 +
                       u[i-1,j-1] + u[i-1,j+1] +
                       u[i+1,j-1] + u[i+1,j+1])/20.0

            diff = u[i,j] - tmp
            err = err + diff*diff
        end
    end
    return sqrt(err)
end


"""
    optimized_time_step{T}(u::Matrix{T})

Find the Jacobi numerical approximation using optimized loops.
"""
function optimized_time_step{T}(u::Matrix{T})
    n, m = size(u)
    err = T(0.0) # not an optimization, but makes it work for all element types
    @inbounds for i = 2:n-1
        for j = 2:m-1
            tmp = u[j, i];
            u[j, i] = ( T(4) *(u[j-1, i] + u[j+1, i] +
                        u[j, i-1] + u[j, i+1]) +
                        u[j-1, i-1] + u[j+1, i+1] +
                        u[j+1, i-1] + u[j-1, i+1]) / T(20)
            diff = u[j, i] - tmp
            err += diff*diff;
        end
    end
    return sqrt(err)
end


"""
    optimized_time_step{T}(u::Matrix{T})

Find the Jacobi numerical approximation using optimized loops and SIMD.
"""
function optimized_time_step_simd{T}(u::Matrix{T})
    n, m = size(u)
    err = T(0.0) # not an optimization, but makes it work for all element types
    @inbounds for i = 2:n-1
        @simd for j = 2:m-1
            tmp = u[j, i];
            u[j, i] = ( T(4) *(u[j-1, i] + u[j+1, i] +
                        u[j, i-1] + u[j, i+1]) +
                        u[j-1, i-1] + u[j+1, i+1] +
                        u[j+1, i-1] + u[j-1, i+1]) / T(20)
            diff = u[j, i] - tmp
            err += diff*diff;
        end
    end
    return sqrt(err)
end


"""
    optimized_vectorized_time_step(u::Matrix)

Find the Jacobi numerical approximation using optimized vectorization.
"""
function optimized_vectorized_time_step(u::Matrix)
    (n, m) = size(u)
    u_old = copy(u)
    #@views u[2:n-1, 2:m-1] = ((u[1:n-2, 2:m-1] + u[3:n,   2:m-1] +
    u[2:n-1, 2:m-1] = ((u[1:n-2, 2:m-1] + u[3:n,   2:m-1] +
                        u[2:n-1, 1:m-2] + u[2:n-1, 3:m])*4.0 +
                        u[1:n-2, 1:m-2] + u[1:n-2, 3:m] +
                        u[3:n,   1:m-2] + u[3:n,   3:m])/20.0
    v = vec(u - u_old)
    return sqrt(dot(v, v))
end



# C version
const clib_name5 = tempname()
source = """
#include <math.h>
double c_time_step(int N, double *u[])
{
    double tmp, diff;
    int i, j;
    double err;
    err = 0.0;
    for (i = 1; i < N-1; i++) {
        for (j = 1; j < N-1; j++) {
            tmp = u[j][i];
            u[j][i] = ( 4.0 *(u[j-1][i] + u[j+1][i] +
                        u[j][i-1] + u[j][i+1]) +
                        u[j-1][i-1] + u[j+1][i+1] +
                        u[j+1][i-1] + u[j-1][i+1])/20.;
            diff = u[j][i] - tmp;
            err += diff*diff;
        }
    }
    return sqrt(err);
}
"""
run(`gcc --version`)
# gcc (Ubuntu 5.4.1-2ubuntu1~16.04) 5.4.1 20160904
open(`gcc -fPIC -Ofast -O3 -xc -shared -o $(clib_name5).so -`, "w") do pipe
    print(pipe, source)
end
function c_time_step(X::Vector{Vector{Float64}})
    ccall(("c_time_step", clib_name5), Float64, (Cint, Ptr{Ptr{Float64}}), length(X), X)
end


function solver(u, time_step)
    iter = 0
    err = 2.0
    while iter < 100000 && err > 1e-6
        err = time_step(u)
        iter += 1
    end
    u, err, iter
end

#########################################
# Get the number of points from the command line
#########################################
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


#function init_array(numPoints = 100)
function init_array(numPoints = num_points)
    pi_c = 4.0 * atan(1.0)
    v = zeros(Float64, numPoints, numPoints)
    x = [(i-1)*pi_c/(numPoints-1) for i in 1:numPoints]
    v[1,:] = [sin(a) for a in x]
    v[numPoints,:] = [sin(a)*exp(-pi_c) for a in x]
    v
end
init_c() = (v = init_array(); v_2 = [v[i, :] for i=1:size(v, 1)])

funcs = (regular_time_step, optimized_time_step, optimized_vectorized_time_step, optimized_time_step_simd) #
benchmarks = map(funcs) do time_step
    v = init_array()
    solver(v, time_step) # compile
    v = init_array()
    # should be enough iterations already to be okay with just a simple elapsed
    result = @elapsed begin
        u, err, it = solver(v, time_step)
    end
    Symbol(time_step) => (result, it)
end


v = init_c()
result = @elapsed begin
    u, err, it = solver(v, c_time_step)
end
benchmarks = (benchmarks..., :c_time_step => (result, it))
for (name, (t, sweeps)) in benchmarks
    println(name, ":")
    println("          Number of sweeps: ", sweeps)
    println("              Elapsed Time: $(t) Seconds")
end
