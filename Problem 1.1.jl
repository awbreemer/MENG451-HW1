function factorial1(input)
    i = 1
    for j in range(1,input)
        i = i*j
    end
    return i
end

function factorial2(input)
    if input > 1
        factorial2(input-1)*input
    else
        return input
    end
end

factorial1(10)
factorial2(10)