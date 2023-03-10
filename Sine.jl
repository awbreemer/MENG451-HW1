#Andrew Breemer
#Sine HW

using Pkg
using BenchmarkTools


function Sine(x, realativeChange)
    # shift x to a value between 0 and 2*pi
    x = TwoPiShift(x)
    #loop to compute the series
    stopFlag = false
    currentVal = 1.0
    currentSign = 1
    thisVal = 0
    previousVal = 0.0

    while !stopFlag
        previousVal = thisVal
        thisVal += currentSign*myExponential(x,currentVal)/myFactorial(currentVal)
        currentVal += 2
        currentSign *= -1

        if(abs(thisVal-previousVal) < realativeChange)
            stopFlag = true
        end

    end

    return(thisVal)

end


## accounts for negative inputs as well
function TwoPiShift(x)
    if 2*pi < x 
        
        while x > 2*pi
            x -= 2*pi
        end

    elseif x < 0

        while x < 0 
            x += 2*pi
        end

    end

        return(x)
end

function myFactorial(n)
    nextMultiplier = n-1

    while nextMultiplier >= 2
        n *= nextMultiplier
        nextMultiplier -= 1
    end

    return(n)
end

function myExponential(body, power)
    newBody = 1

    for i in 1:power
        newBody *= body
    end

    return(newBody)
end

@benchmark Sine(22, .001)
@benchmark sin(22)
