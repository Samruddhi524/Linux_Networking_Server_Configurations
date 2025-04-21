#!/bin/bash

# Utility function to calculate factorial
factorial() {
    local n=$1
    local f=1
    for ((i=1; i<=n; i++)); do
        f=$((f * i))
    done
    echo $f
}

while true; do
    echo ""
    echo "Choose a program to run:"
    echo " 8. Strong Numbers between 1 to n"
    echo " 9. Twin Prime Numbers"
    echo "10. Duck Number"
    echo "11. Automorphic Number"
    echo "12. Happy Number"
    echo "13. Harshad Number"
    echo "14. Armstrong Number"
    echo "15. Abundant Number"
    echo "16. Reverse Digits"
    echo "17. Sum of Digits"
    echo "18. Prime or Not"
    echo "19. Magic Number"
    echo "20. Buzz Number"
    echo "21. Palindrome Number"
    echo "22. Neon Number"
    echo "23. Factorial of a Number"
    echo "24. Prime Factors of a Number"
    echo "25. Count of Composite Numbers between 1 and n"
    echo " 0. Exit"
    echo -n "Enter your choice: "
    read choice

    case $choice in
        8)
            echo -n "Enter n: "; read n
            echo "Strong numbers between 1 and $n:"
            for ((i=1; i<=n; i++)); do
                sum=0
                num=$i
                temp=$num
                while ((temp > 0)); do
                    digit=$((temp % 10))
                    fact=$(factorial $digit)
                    sum=$((sum + fact))
                    temp=$((temp / 10))
                done
                if ((sum == num)); then echo "$num"; fi
            done
            ;;
        9)
            is_prime() {
                local n=$1
                if ((n < 2)); then return 1; fi
                for ((i=2; i*i<=n; i++)); do
                    if ((n % i == 0)); then return 1; fi
                done
                return 0
            }
            echo -n "Enter range n: "; read n
            echo "Twin Primes up to $n:"
            for ((i=2; i<=n-2; i++)); do
                if is_prime $i && is_prime $((i+2)); then
                    echo "$i and $((i+2))"
                fi
            done
            ;;
        10)
            echo -n "Enter number: "; read num
            if [[ "$num" == *0* ]]; then echo "$num is a Duck Number"
            else echo "$num is not a Duck Number"; fi
            ;;
        11)
            echo -n "Enter number: "; read num
            square=$((num * num))
            if [[ $square == *$num ]]; then
                echo "$num is an Automorphic Number"
            else
                echo "$num is not an Automorphic Number"
            fi
            ;;
        12)
            is_happy() {
                local n=$1
                declare -A seen
                while ((n != 1 && seen[$n] != 1)); do
                    seen[$n]=1
                    sum=0
                    while ((n > 0)); do
                        digit=$((n % 10))
                        sum=$((sum + digit * digit))
                        n=$((n / 10))
                    done
                    n=$sum
                done
                [[ $n == 1 ]]
            }
            echo -n "Enter number: "; read num
            if is_happy $num; then
                echo "$num is a Happy Number"
            else
                echo "$num is not a Happy Number"
            fi
            ;;
        13)
            echo -n "Enter number: "; read num
            sum=0; temp=$num
            while ((temp > 0)); do
                sum=$((sum + temp % 10))
                temp=$((temp / 10))
            done
            if ((num % sum == 0)); then
                echo "$num is a Harshad Number"
            else
                echo "$num is not a Harshad Number"
            fi
            ;;
        14)
            echo -n "Enter number: "; read num
            sum=0; temp=$num
            digits=${#num}
            while ((temp > 0)); do
                digit=$((temp % 10))
                power=1
                for ((i=0; i<digits; i++)); do power=$((power * digit)); done
                sum=$((sum + power))
                temp=$((temp / 10))
            done
            if ((sum == num)); then
                echo "$num is an Armstrong Number"
            else
                echo "$num is not an Armstrong Number"
            fi
            ;;
        15)
            echo -n "Enter number: "; read num
            sum=0
            for ((i=1; i<num; i++)); do
                ((num % i == 0)) && sum=$((sum + i))
            done
            if ((sum > num)); then
                echo "$num is an Abundant Number"
            else
                echo "$num is not an Abundant Number"
            fi
            ;;
        16)
            echo -n "Enter number: "; read num
            rev=0
            while ((num > 0)); do
                rev=$((rev * 10 + num % 10))
                num=$((num / 10))
            done
            echo "Reversed: $rev"
            ;;
        17)
            echo -n "Enter number: "; read num
            sum=0
            while ((num > 0)); do
                sum=$((sum + num % 10))
                num=$((num / 10))
            done
            echo "Sum of digits: $sum"
            ;;
        18)
            echo -n "Enter number: "; read num
            is_prime() {
                ((num < 2)) && return 1
                for ((i=2; i*i<=num; i++)); do
                    ((num % i == 0)) && return 1
                done
                return 0
            }
            if is_prime $num; then echo "$num is Prime"
            else echo "$num is Not Prime"; fi
            ;;
        19)
            echo -n "Enter number: "; read num
            while ((num > 9)); do
                sum=0
                while ((num > 0)); do
                    sum=$((sum + num % 10))
                    num=$((num / 10))
                done
                num=$sum
            done
            if ((num == 1)); then echo "Magic Number"
            else echo "Not a Magic Number"; fi
            ;;
        20)
            echo -n "Enter number: "; read num
            if ((num % 7 == 0 || num % 10 == 7)); then
                echo "$num is a Buzz Number"
            else
                echo "$num is not a Buzz Number"
            fi
            ;;
        21)
            echo -n "Enter number: "; read num
            rev=$(echo "$num" | rev)
            if [[ "$num" == "$rev" ]]; then echo "Palindrome Number"
            else echo "Not a Palindrome"; fi
            ;;
        22)
            echo -n "Enter number: "; read num
            square=$((num * num))
            sum=0
            while ((square > 0)); do
                sum=$((sum + square % 10))
                square=$((square / 10))
            done
            if ((sum == num)); then echo "$num is a Neon Number"
            else echo "$num is not a Neon Number"; fi
            ;;
        23)
            echo -n "Enter number: "; read num
            echo "Factorial: $(factorial $num)"
            ;;
        24)
            echo -n "Enter number: "; read num
            echo -n "Prime factors: "
            for ((i=2; i<=num; i++)); do
                while ((num % i == 0)); do
                    echo -n "$i "
                    num=$((num / i))
                done
            done
            echo ""
            ;;
        25)
            echo -n "Enter value of n: "; read n
            count=0
            for ((i=4; i<=n; i++)); do
                flag=0
                for ((j=2; j<=i/2; j++)); do
                    if ((i % j == 0)); then flag=1; break; fi
                done
                ((flag == 1)) && count=$((count + 1))
            done
            echo "Number of Composite Numbers between 1 and $n: $count"
            ;;
        0)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid choice!"
            ;;
    esac
done
