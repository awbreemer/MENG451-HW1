using Pkg
#Pkg.activate(".")
using Plots



function FixedPointIteration(Re, realativeRoughness)
    global previousIteration = 1/sqrt(100);
    global currentIteration = -2 * log10((realativeRoughness / 3.7) * (2.51 / Re) * previousIteration)
    print("x1 = " , currentIteration)
    global realativeChange = 10 
    global i = 0

    while (realativeChange > 0.000001) && (i < 100)
        global realativeChange = abs(1 / sqrt(currentIteration) - 1 / sqrt(previousIteration))
        global previousIteration = currentIteration
        global currentIteration = -2 * log10((realativeRoughness / 3.7) + (2.51 / Re) * previousIteration)
        global i += 1
        #println("The realativeChange is ", realativeChange, "  |  The currentIteration is ", 1 / sqrt(currentIteration))
    end

    return(1 / sqrt(currentIteration))
#println("The current iteration for Moody ", currentIteration)
#println("The friction factor is ", 1 / sqrt(currentIteration))
end

roughness = [0.05, 0.04, 0.03, 0.02, 0.015, 0.01, 0.005, 0.002, 0.001]
friction = zeros(Float64, length(Re))

global Re = 10 .^ range(3.5, stop=8, length=400)
plt = plot()
for k in range(1,length(roughness))
    for j in range(1,length(Re))
        friction[j] = FixedPointIteration(Re[j],roughness[k])
    end
    plot!(Re,friction, xaxis =:log10, xlims = [1000,1e8], ylims = [0,.5])
end

#print(roughness)




#FixedPointIteration(400000, 5e-4)

