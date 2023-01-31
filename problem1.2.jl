using Pkg
#Pkg.activate(".")
using Plots

Re = LinRange(4000, 1e8, 300)




function FixedPointIteration(Re, realativeRoughness)
    global previousIteration = 0.0001;
    global currentIteration = -2 * log10((realativeRoughness / 3.7) * (2.51 / Re) * previousIteration)
    print("x1 = " , currentIteration)
    global realativeChange = 10 
    print("the realativeChange is " , realativeChange)
    global i = 0

    while (realativeChange > 0.0001) && (i < 100)
        global realativeChange = abs(currentIteration - previousIteration)
        global previousIteration = currentIteration
        global currentIteration = -2 * log10((realativeRoughness / 3.7) + (2.51 / Re) * previousIteration)
        global i += 1
        println("The realativeChange is ", realativeChange, "  |  The currentIteration is ", 1 / sqrt(currentIteration))
    end



println("The current iteration for Moody", currentIteration)

println("The friction factor is ", 1 / sqrt(currentIteration))
end


FixedPointIteration(4000,.001)

