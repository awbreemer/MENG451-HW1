using Plots

function FixedPointIteration(Re, RealativeRoughness, firstGuess)
    
    tolerance = 0.0001
    stopFlag = false
    x = GofX(1 / (firstGuess^2), Re, RealativeRoughness)
    previous = 0.0
    while !stopFlag
        realativeChange = abs(1 / sqrt(x) - 1 / sqrt(previous))

        if realativeChange < tolerance
            stopFlag = true
        end

        previous = x
        x = previous + GofX(previous, Re, RealativeRoughness) 

        println("x is ", x, "  and the ff is ", 1 / sqrt(x))
    end

    return(1/sqrt(x))

end

function GofX(x, Re, RealativeRoughness)
    return(-2*log10((RealativeRoughness/3.7)+((2.51/Re)*x)))
end


