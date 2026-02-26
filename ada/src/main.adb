with Ada.Text_IO;
with Ada.Long_Float_Text_IO;
with Ada.Numerics.Long_Elementary_Functions;
with Ada.Numerics.Discrete_Random;

procedure Main is
   package IO     renames Ada.Text_IO;
   package Int_IO is new Ada.Text_IO.Integer_IO (Integer);
   package Flt_IO renames Ada.Long_Float_Text_IO;
   package Math   renames Ada.Numerics.Long_Elementary_Functions;

   subtype Large_Integer is Positive range 1 .. 2_147_483_647;
   package Random_Large is new Ada.Numerics.Discrete_Random (Large_Integer);

   Generator : Random_Large.Generator;

   function GCD (A, B : Natural) return Natural is
   begin
      if B = 0 then
         return A;
      else
         return GCD (B, A mod B);
      end if;
   end GCD;

   function Coprime (A, B : Positive) return Boolean is
   begin
      return GCD (A, B) = 1;
   end Coprime;

   Pair_Count     : constant := 1_000_000;
   Estimate_Count : constant := 100;

   Coprime_Count : Natural    := 0;
   Estimate_Sum  : Long_Float := 0.0;
   Probability   : Long_Float;
   Estimate      : Long_Float;

begin
   Random_Large.Reset (Generator);

   for I in 0 .. Estimate_Count - 1 loop
      Coprime_Count := 0;

      for J in 1 .. Pair_Count loop
         if Coprime (Random_Large.Random (Generator), Random_Large.Random (Generator)) then
            Coprime_Count := Coprime_Count + 1;
         end if;
      end loop;

      Probability := Long_Float (Coprime_Count) / Long_Float (Pair_Count);
      Estimate    := Math.Sqrt (6.0 / Probability);

      IO.Put ("Estimate ");
      Int_IO.Put (Item => I, Width => 0);
      IO.Put (": ");
      Flt_IO.Put (Item => Estimate, Fore => 1, Aft => 15, Exp => 0);
      IO.New_Line;

      Estimate_Sum := Estimate_Sum + Estimate;
   end loop;

   IO.Put ("Mean: ");
   Flt_IO.Put (Item => Estimate_Sum / Long_Float (Estimate_Count), Fore => 1, Aft => 15, Exp => 0);
   IO.New_Line;

end Main;
