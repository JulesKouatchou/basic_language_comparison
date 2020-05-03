using BenchmarkTools
using Printf


"""
    evaluatefunctions(N)

Evaluates trigonometric functions on N values spaced
evenly between -1500.0 and 1500.0.
"""
function evaluatefunctions(N)
    #x = linspace(-1500.0, 1500.0, N)
    x = range(-1500.0, stop=1500.0, length=N)
    M = 10000
    for i in 1:M
        y = sin.(x)
        x = asin.(y)
        y = cos.(x)
        x = acos.(y)
        y = tan.(x)
        x = atan.(y)
    end
end


# Get the number of values from the command line.
N = parse(Int, ARGS[1])

println("-----------------------------------------")
println("Evaluate functions: ", N)
println("-----------------------------------------")
println(" ")

@btime evaluatefunctions(N)
