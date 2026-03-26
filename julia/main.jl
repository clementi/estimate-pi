function (@main)(args)
    let pairCount = 1000000,
        estimateCount = 100,
        coprimeCount = 0,
        estimateSum = 0

        for i in 1:estimateCount
            for j in 1:pairCount
                if gcd(rand(UInt32), rand(UInt32)) == 1
                    coprimeCount += 1
                end
            end

            let proportion = coprimeCount / pairCount,
                estimate = sqrt(6 / proportion)

                println("Estimate ", i, ": ", estimate)

                estimateSum += estimate
                coprimeCount = 0
            end
        end

        println("Mean: ", estimateSum / estimateCount)
    end
end
