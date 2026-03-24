program EstimatePi;

uses Sysutils;

function gcd(const a, b : UInt32): UInt32;
begin
   if b = 0 then
      Result := a
   else
      Result := gcd(b, a mod b)
end;

function coprime(const a, b : UInt32): Boolean;
begin
   Result := gcd(a, b) = 1
end;

function randUInt32(): UInt32;
begin
   Result := (UInt32(Random(65536)) shl 16) or UInt32(Random(65536))
end;

var
   pairCount     : UInt32;
   estimateCount : UInt32;
   estimateSum   : Real;
   coprimeCount  : UInt32;
   proportion    : Real;
   estimate      : Real;
   i             : UInt32;
   j             : UInt32;
begin
   Randomize;
   pairCount := 1000000;
   estimateCount := 100;
   
   estimateSum := 0.0;

   for i := 1 to estimateCount do
   begin
      coprimeCount := 0;
      for j := 1 to pairCount do
      begin
         if coprime(randUInt32(), randUInt32()) then
            coprimeCount := coprimeCount + 1;
      end;
      proportion := Real(coprimeCount) / Real(pairCount);
      estimate := Sqrt(6.0 / Real(proportion));

      WriteLn(Format('Estimate %d: %.15f', [i, estimate]));

      estimateSum := estimateSum + estimate;
   end;

   WriteLn(Format('Mean: %.15f', [estimateSum / Real(estimateCount)]));
end.
