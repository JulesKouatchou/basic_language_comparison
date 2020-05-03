
using BenchmarkTools


"""
    read_reverse_file(filename::String)

       Read an entire file and write its content in
       a new file in reverse order.
"""
function read_reverse_file(filename::String)
    open(filename) do file_id 
        lines = readlines(file_id)
    end

    rev_filename = "rev_"+basename(filename)
    open(rev_filename, "w") do rev_file_id 
        println(rev_file_id, [reverse(line) for line in reverse(lines)])
    end
end


# Get the text file name from the command line.
n, = size(ARGS)
if n < 1
    println("Usage: ")
    println("    julia " + ARG[0] + " filename")
    println("       --->      Please specify the filename.")
    exit()
end

filename = ARGS[1]
@btime read_reverse_file(filename)

println(" ")
