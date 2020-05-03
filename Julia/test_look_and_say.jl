using Printf
using BenchmarkTools


"""
    lookandsay(n::String)

Perform the look and say algorithm once on the given string.
"""
function lookandsay(n::String)
    sequence = IOBuffer()
    i, c = 1, 1
    while i ≤ length(n)
        if i != length(n) && n[i] == n[i+1]
            c += 1
        else
            print(sequence, c, n[i])
            c = 1
        end
        i += 1
    end
    return newstring(take!(sequence))
end


"""
    lookandsayseq(n::Integer, startsequence::String)

Iteratively construct the nth look and say sequence.
"""
function lookandsayseq(n::Integer, startsequence::String)
    sequence = Array{String}(n)
    sequence[1] = startsequence
    if n > 1
        for i in 2:n
            sequence[i] = lookandsay(sequence[i-1])
        end
    end
    return sequence
end


N = parse(Int, ARGS[1])


println("--------------------------")
println(@sprintf "Look and say sequence: %d" N)
println("--------------------------")

@btime begin
    r = lookandsayseq(N, "1223334444")
end
    #println(r[N])
