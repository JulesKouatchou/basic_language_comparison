using BenchmarkTools
using Printf
using FFTW


# Get the number of data points N from the command line.
N = parse(Int, ARGS[1])

println("-----------------------------------------")
println("Compute FFTs: ", N)
println("-----------------------------------------")
println(" ")

#Take the FFT of the N random data points.
@btime begin
    mat = complex.(rand(N, N), randn(N, N))
    result = fft(mat)
    result = abs.(result)
end
