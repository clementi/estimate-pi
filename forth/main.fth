variable rng-limit
variable coprime-count
fvariable estimate-sum

: gcd ( a b -- gcd )
    begin dup while tuck mod repeat drop ;

: coprime? ( a b -- flag )
    gcd 1 = ;

: count-coprime ( pair-count limit -- )
    rng-limit !
    0 coprime-count !
    0 do
        rng-limit @ random rng-limit @ random coprime?
        if 1 coprime-count +! then
    loop ;

: main ( -- )
    randomize
    0e0 estimate-sum f!
    100 0 do
        1000000 1000000000 count-coprime
        coprime-count @ s>f 1.0e6 f/
        6.0e0 fswap f/
        fsqrt
        fdup
        ." Estimate " i . ." : " f. cr
        estimate-sum f@ f+ estimate-sum f!
    loop
    ." Mean: " estimate-sum f@ 1.0e2 f/ f. cr ;

main
