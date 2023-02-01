using Plots
using Printf

ReVals = 10 .^range(3.4,8,400)
realativeRoughnessVals = 10 .^range(-6,-1.3,15)

#=
fric_Factor = [FixedPointIteration(Re, realativeRoughness, .05) for realativeRoughness in realativeRoughnessVals, Re in ReVals]

pltMoody = plot(ReVals, fric_Factor', xaxis = :log10, yaxis = :log10)
=#

for i in range(1,length(realativeRoughnessVals))
    global frictionFactorVals = Array{Float64}(undef, length(ReVals))
    for j in range(1,length(ReVals))
        frictionFactorVals[j] = FixedPointIteration(ReVals[j], realativeRoughnessVals[i], .1)

    end
    if i == 1
        global plt = plot(ReVals, frictionFactorVals, xaxis =:log10, yaxis = :log10,legendfont = 6, grid = true, xlabel = "Reynolds Number", ylabel = "Friction Factor", legend = :bottomleft, label = @sprintf("Real. Rough. = %e", realativeRoughnessVals[i]))
    else
        plot!(ReVals,frictionFactorVals, label = @sprintf("Real. Rough. = %e", realativeRoughnessVals[i]))
    end
end


function FixedPointIteration(Re, RealativeRoughness, firstGuess)
    
    tolerance = 0.0001
    stopFlag = false
    x = GofX(1 / sqrt(firstGuess), Re, RealativeRoughness)
    previous = 0.0
    while !stopFlag
        realativeChange = abs(1 / x^2 - 1 / x^2)

        if realativeChange < tolerance
            stopFlag = true
        end

        previous = x
        x = previous + GofX(previous, Re, RealativeRoughness) 

        #println("x is ", x, "  and the ff is ", 1 / sqrt(x))
    end

    return(1/x^2)

end

function GofX(x, Re, RealativeRoughness)
    return(-2*log10((RealativeRoughness/3.7)+((2.51/Re)*x)))
end


