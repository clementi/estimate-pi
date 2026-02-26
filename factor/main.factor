USING: io locals math math.functions math.parser random ;
IN: estimate-pi

: coprime? ( a b -- ? ) gcd 1 = ;

:: count-coprime ( pair-count limit -- n )
    0 :> count!
    pair-count [
        limit random-integer limit random-integer coprime?
        [ count 1 + count! ] when
    ] times
    count ;

:: main ( -- )
    1000000 :> pair-count
    100 :> estimate-count
    1000000000 :> limit
    0.0 :> estimate-sum!
    0 :> i!
    estimate-count [
        pair-count limit count-coprime pair-count /f :> probability
        6 probability /f sqrt :> estimate
        "Estimate " write i number>string write ": " write
        estimate number>string print
        estimate-sum estimate + estimate-sum!
        i 1 + i!
    ] times
    "Mean: " write
    estimate-sum estimate-count /f number>string print ;

main
