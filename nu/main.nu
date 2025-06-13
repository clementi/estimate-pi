def gcd [x y] {
    mut t = 1
    mut a = $x
    mut b = $y
    while $b != 0 {
        $t = $b
        $b = $a mod $b
        $a = $t
    }
    $a
}

def coprime [a b] {
    (gcd $a $b) == 1
}

let pair_count = 1000000
let estimate_count = 100

let limit = 2 ** 31 - 1

mut coprime_count = 0

mut estimate_sum = 0.0

for i in 1..$estimate_count {

    for j in 1..$pair_count {

        let a = random int 1..$limit
        let b = random int 1..$limit

        if (coprime $a $b) {
            $coprime_count += 1
        }
    }

    let proportion = $coprime_count / $pair_count
    let estimate = (6.0 / $proportion) | math sqrt
    print $"Estimate ($i): ($estimate)"
    $estimate_sum += $estimate
    $coprime_count = 0
}

print $"Mean: ($estimate_sum / $estimate_count)"
