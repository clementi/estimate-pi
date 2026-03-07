Module Program
    Sub Main()
        Dim PairCount, EstimateCount As Integer
        Dim EstimateSum As Double
        EstimateSum = 0.0
        PairCount = 1000000
        EstimateCount = 100

        Dim Rand As System.Random
        Rand = New Random()

        Dim CoprimeCount As Integer
        CoprimeCount = 0

        For i As Integer = 1 To EstimateCount
            For j As Integer = 1 To PairCount
                If Coprime(Rand.Next(Integer.MaxValue), Rand.Next(Integer.MaxValue)) Then
                    CoprimeCount = CoprimeCount + 1
                End If
            Next
            Dim Proportion As Double
            Proportion = CDbl(CoprimeCount) / CDbl(PairCount)
            Dim Estimate As Double
            Estimate = Math.Sqrt(6.0 / Proportion)
            Console.WriteLine("Estimate {0}: {1}", i, Estimate)
            EstimateSum = EstimateSum + Estimate
            CoprimeCount = 0
        Next

        Console.WriteLine("Mean: {0}", CDbl(EstimateSum) / CDbl(EstimateCount))
    End Sub

    Function Coprime(ByVal a As Integer, ByVal b As Integer)
        Return Gcd(a, b) = 1
    End Function

    Function Gcd(ByVal a As Integer, ByVal b As Integer)
        if b = 0 Then
            Return a
        Else
            Return Gcd(b, a mod b)
        End If
    End Function
End Module
