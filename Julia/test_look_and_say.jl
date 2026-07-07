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
function look_and_say_sequence(starting_sequence::String, n::Int)
    """
      Construct the look and say sequence of order n and starting
      sequence starting_sequence (string)
    """
    current_sequence = starting_sequence

    # Run transformations n-1 times
    for i in 2:n
        count = 1
        # IOBuffer is much faster for building strings than concatenation
        temp_sequence = IOBuffer()

        for j in 2:length(current_sequence)
            if current_sequence[j] == current_sequence[j-1]
                count += 1
            else
                # Print directly to the buffer
                print(temp_sequence, count, current_sequence[j-1])
                count = 1
            end
        end

        # Append the final block
        print(temp_sequence, count, current_sequence[end])

        # Convert the buffer back into a String
        current_sequence = String(take!(temp_sequence))
    end

    return current_sequence
end

# Example usage:
# println(look_and_say_sequence("1223334444", 10))


N = parse(Int, ARGS[1])


println("--------------------------")
println(@sprintf "Look and say sequence: %d" N)
println("--------------------------")

@btime begin
    #r = lookandsayseq(N, "1223334444")
    r = look_and_say_sequence("1223334444", N)
end
    #println(r[N])
