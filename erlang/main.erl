-module(main).
-export([start/0]).

start() ->
    Limit = 1000000000,
    PairCount = 1000000,
    EstimateCount = 100,
    Estimate = average(EstimateCount, Limit, PairCount),
    io:format("Mean: ~w~n", [Estimate]).

average(EstimateCount, Limit, PairCount) ->
    Estimates = lists:map(fun(I) ->
                            Estimate = estimatePi(Limit, PairCount),
                            io:format("Estimate ~w: ~w~n", [I, Estimate]),
                            Estimate
                          end, lists:seq(1, EstimateCount)),
    lists:sum(Estimates) / EstimateCount.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

coprime({A, B}) ->
    gcd(A, B) == 1.

estimatePi(Limit, PairCount) ->
    CoprimeCount = length(lists:filter(fun(Pair) -> coprime(Pair) end, createPairs(PairCount, Limit))),
    Probability = CoprimeCount / PairCount,
    math:sqrt(6 / Probability).

createPairs(0, _) -> [];
createPairs(Count, Limit) ->
    [ createRandomPair(Limit) | createPairs(Count - 1, Limit) ].

createRandomPair(Limit) ->
    { rand:uniform(Limit), rand:uniform(Limit) }.
    
