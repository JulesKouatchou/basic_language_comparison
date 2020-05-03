using Printf
using BenchmarkTools
using LegacyStrings

fullstrip(str::AbstractString, chars::AbstractString) = replace(str, Regex("[$chars]") => "")

punctuation_characters = r"~\`!@#$%^&*()_-+=[{]}\\|;:',<.>/?1234567890"
#punctuation_characters = String("~\`!@#$%^&*()_-+=[{]}\\|;:',<.>/?1234567890")
#punctuation_characters = ASCIIString("~\`!@#$%^&*()_-+=[{]}\\|;:',<.>/?1234567890")
#punctuation_characters = '!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~ \t\n\r\x0b\x0c'

"""
    countwords(filename::String)

Opens the given file and makes a collection of its unique words.
"""
function countwords(filename::String)
    openedfile = open(filename)
    wordlist = String[]
    for line in eachline(openedfile)
        println(line)
        words = split( fullstrip(line, punctuation_characters))
        map(word -> push!(wordlist, lowercase(word)), words)
    end
    close(openedfile)
    filter!(!isempty, wordlist)
    println("Number of unique words: ", length(wordlist))
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
@btime count_word(filename)

println(" ")
