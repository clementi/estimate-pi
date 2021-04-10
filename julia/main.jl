pairCount = 1000000
estimateCount = 100

coprimeCount = 0
estimateSum = 0

limit = 1000000000

for i in 1:estimateCount
    for j in 1:pairCount
        if gcd(rand(Int), rand(Int)) == 1
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
