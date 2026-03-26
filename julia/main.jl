function (@main)(args)
    pairCount = 1000000
    estimateCount = 100

    global coprimeCount = 0
    global estimateSum = 0

    for i in 1:estimateCount
        for j in 1:pairCount
            if gcd(rand(UInt32), rand(UInt32)) == 1
                global coprimeCount += 1
            end
        end

        probability = coprimeCount / pairCount
        estimate = sqrt(6 / probability)
        println("Estimate ", i, ": ", estimate)

        global estimateSum += estimate
        global coprimeCount = 0
    end

    println("Mean: ", estimateSum / estimateCount)
end
