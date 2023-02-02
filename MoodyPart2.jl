#Andrew Breemer
#Moody Diagram

using Plots
using Printf


function FixedPointIteration(Re, RealativeRoughness, firstGuess)
    
    tolerance = 0.0001 #here is how close the iteration has to the previous iteration
    stopFlag = false
    x = GofX(1 / sqrt(firstGuess), Re, RealativeRoughness) #the first value 
    previous = 0.0
    while !stopFlag #complete fixed point iteration untill within tolerance
        realativeChange = abs(1 / x^2 - 1 / x^2)

        if realativeChange < tolerance
            stopFlag = true
        end

        previous = x
        x = previous + GofX(previous, Re, RealativeRoughness) 

    end

    return(1/x^2)

end

#Seperate function for simplicity for GofX for the Colbrook equation
function GofX(x, Re, RealativeRoughness)
    return(-2*log10((RealativeRoughness/3.7)+((2.51/Re)*x)))
end

#Set vals for the Re and for the Realative Roughness
ReVals = 10 .^range(3.4,8,400)
realativeRoughnessVals = 10 .^range(-6,-1.3,15)
#=
Nested for loop. One loop for running through the different roughness values and one for each of the points for Re. Utilizes the 
fixed point iteration for each loop. After all the friction factor values have been calculated for a given roughness a line on the 
plot is created. 
=#
for i in range(1,length(realativeRoughnessVals)) #For the roughness values
    global frictionFactorVals = Array{Float64}(undef, length(ReVals)) #re-initialize empty array for storing friction factor vals
    for j in range(1,length(ReVals)) #For each friction factor value
        frictionFactorVals[j] = FixedPointIteration(ReVals[j], realativeRoughnessVals[i], .1)

    end
    if i == 1 #there is most likely a more elegent meathod for plotting, but this worked
        global plt = plot(ReVals, frictionFactorVals, xaxis =:log10, yaxis = :log10,legendfont = 6, grid = true, xlabel = "Reynolds Number", ylabel = "Friction Factor", legend = :bottomleft, label = @sprintf("Real. Rough. = %e", realativeRoughnessVals[i]))
    else
        plot!(ReVals,frictionFactorVals, label = @sprintf("Real. Rough. = %e", realativeRoughnessVals[i]))
    end
end
savefig(plt, "myfig.png")

