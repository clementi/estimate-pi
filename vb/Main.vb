Module EstimatePi
    Sub Main()
        Dim PairCount, EstimateCount As Integer
        Dim EstimateSum As Decimal
        PairCount = 1000000
        EstimateCount = 100

        Dim Random As System.Random

        For i As Integer = 1 To EstimatCount
            Dim CoprimeCount As Integer
            CoprimeCount = 0
            
            For j As Integer = 1 To PairCount
                If Coprime(Random.NextInt(), Random.NextInt()) Then
                    CoprimeCount = CoprimeCount + 1
                End If
                Dim Proportion As Decimal
                Proportion = CoprimeCount / PairCount
                Dim Estimate As Decimal
                Estimate = Math.Sqrt(6.0 / Proportion)
                Console.WriteLine("Estimate " + i ": " + Estimate)
                EstimateSum = EstimateSum + Estimate
                CoprimeCount = 0
            End For
        End For

        Console.WriteLine("Mean: " + EstimateSum / EstimateCount)
    End Sub

    Function Coprime(ByVal a, b As Integer)
        Return Gcd(a, b) = 1
    End Function

    Function Gcd(ByVal a, b As Integer)
        if b = 0 Then
            Return a
        Else
            Return Gcd(b, a mod b)
        End If
    End Function
End Module
