using Printf
using BenchmarkTools


println("-------------------------------")
println(@sprintf "Compute the first four Munchausen numbers")
println("-------------------------------")

"""
    raisedto(x)


Raise x to the power of itself.
"""
function raisedto(x)
    if x == 0
       return 0
    else
       return x^x
    end
end

function find_munchausen_numbers()

   power_of_digits = [raisedto(i) for i in 0:9]

   num = 0
   i = 0
   while num < 4
         thisnumber = i
         # find the sum of the digits raised to themselves
         sumofpowers = 0
         while thisnumber > 0
               digit = thisnumber % 10
               sumofpowers += power_of_digits[digit+1]
               thisnumber ÷= 10
         end
         if i == sumofpowers
            num += 1
            println("Munchausen number: ", num, " ", i)
         end
         i += 1
   end
end 


@btime find_munchausen_numbers()

println(" ")
