functor
import
   Application
   System
   OS
define
   Limit = 1000000000
   PairCount = 1000000
   EstimateCount = 100

   fun {GCD A B}
      if B == 0 then A
      else {GCD B (A mod B)}
      end
   end

   fun {Coprime A B}
      {GCD A B} == 1
   end

   fun {RandomInt Max}
      ({OS.rand} mod Max) + 1
   end

   fun {CountCoprimes PairCount Limit}
      fun {Loop I Acc}
         if I >= PairCount then Acc
         else
            A = {RandomInt Limit}
            B = {RandomInt Limit}
         in
            if {Coprime A B} then {Loop I + 1 Acc + 1}
            else {Loop I + 1 Acc}
            end
         end
      end
   in
      {Loop 0 0}
   end

   fun {EstimatePi Limit PairCount}
      CoprimeCount = {CountCoprimes PairCount Limit}
      Probability = {Int.toFloat CoprimeCount} / {Int.toFloat PairCount}
   in
      {Float.sqrt 6.0 / Probability}
   end

   fun {Average EstimateCount Limit PairCount}
      fun {Loop I Sum}
         if I >= EstimateCount then Sum / {Int.toFloat EstimateCount}
         else
            Estimate = {EstimatePi Limit PairCount}
         in
            {System.showInfo "Estimate " # I # ": " # Estimate}
            {Loop I + 1 Sum + Estimate}
         end
      end
   in
      {Loop 0 0.0}
   end

   Mean = {Average EstimateCount Limit PairCount}
in
   {System.showInfo "Mean: " # Mean}
   {Application.exit 0}
end
