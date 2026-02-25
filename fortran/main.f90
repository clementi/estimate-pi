program estimate
    implicit none

    integer :: pair_count
    integer :: estimate_count
    integer :: coprime_count
    real :: estimate_sum
    integer :: i
    integer :: j
    integer :: a, b, rand_int
    logical :: coprime
    real :: proportion, est

    pair_count = 1000000
    estimate_count = 100
    coprime_count = 0
    estimate_sum = 0.0

    do i = 1, estimate_count
        do j = 1, pair_count
            a = rand_int()
            b = rand_int()
            if (coprime(a, b)) then
                coprime_count = coprime_count + 1
            end if
        end do
        proportion = real(coprime_count) / pair_count
        est = sqrt(6 / proportion)
        print *, i, est
        estimate_sum = estimate_sum + est
        coprime_count = 0
    end do

    print *, 'Mean: ', real(estimate_sum) / estimate_count
end program estimate

function rand_int() result(n)
    use, intrinsic :: iso_fortran_env, only: int32
    implicit none

    real :: r
    integer :: n

    call random_number(r)
    n = 1 + floor((2 ** 20 - 1) * r)
end function

function coprime(a, b) result(is_coprime)
    implicit none
    
    integer, intent(in) :: a, b
    integer :: gcd
    logical :: is_coprime

    is_coprime = gcd(a, b) == 1
end function coprime

recursive function gcd(a, b) result(d)
    implicit none

    integer, intent(in) :: a, b
    integer :: d

    if (b == 0) then
        d = a
    else 
        d = gcd(b, mod(a, b))
    end if
end function gcd
