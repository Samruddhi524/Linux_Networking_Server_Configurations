#!/bin/bash

# Utility function to catch errors and continue
run_script() {
  echo -e "\n=============================="
  echo "Running: $1"
  echo "=============================="
  {
    eval "$1"
  } || {
    echo "Error encountered in: $1. Skipping to next script..."
  }
}

# 1. Most non-zero elements in a row
run_script "
if [[ -f input_matrix.txt ]]; then
  max_count=0
  row_number=0
  max_row=0
  while read -r line; do
    ((row_number++))
    count=0
    for val in \$line; do [[ \$val -ne 0 ]] && ((count++)); done
    if (( count > max_count )); then
      max_count=\$count
      max_row=\$row_number
    fi
  done < input_matrix.txt
  echo \"Row \$max_row has the most non-zero elements (\$max_count)\"
else
  echo \"input_matrix.txt not found.\"
fi"

# 2. Simple polynomial evaluation
run_script "
read -p 'Enter the degree of the polynomial: ' degree
echo \"Enter \$((degree + 1)) coefficients: \"
read -a coeffs
read -p 'Enter the value of x: ' x
result=0
for ((i=0; i<=degree; i++)); do
  power=\$((degree - i))
  result=\$((result + coeffs[i] * (x ** power)))
done
echo \"Polynomial evaluated to: \$result\""

# 3. Binary representation of an unsigned integer
run_script "
read -p 'Enter an unsigned integer: ' num
if [[ \$num =~ ^[0-9]+$ ]]; then
  binary=\"\"
  while (( num > 0 )); do
    binary=\$((num % 2))\$binary
    ((num /= 2))
  done
  echo \"Binary: \$binary\"
else
  echo \"Invalid input. Not an unsigned integer.\"
fi"

# 4. Fibonacci series
run_script "
read -p 'Enter the number of terms: ' terms
a=0; b=1
echo -n \"Fibonacci Series: \$a \$b \"
for ((i=2; i<terms; i++)); do
  next=\$((a + b))
  echo -n \"\$next \"
  a=\$b
  b=\$next
done
echo"

# 5. Tribonacci series
run_script "
read -p 'Enter number of terms: ' n
a=0; b=1; c=1
echo -n \"Tribonacci: \$a \$b \$c \"
for ((i=3; i<n; i++)); do
  next=\$((a + b + c))
  echo -n \"\$next \"
  a=\$b
  b=\$c
  c=\$next
done
echo"

# 6. Digit extraction and ascending order display
run_script "
read -p 'Enter a number: ' num
if [[ \$num =~ ^[0-9]+$ ]]; then
  digits=(\$(echo \$num | grep -o . | sort))
  echo -n \"Sorted Digits: \"
  for d in \"\${digits[@]}\"; do echo -n \"\$d \"; done
  echo
else
  echo \"Invalid number.\"
fi"

# 7. Betrothed number
run_script "
sum_divisors() {
  local n=\$1 sum=0
  for ((i=1; i<n; i++)); do ((n % i == 0)) && sum=\$((sum + i)); done
  echo \$sum
}
read -p 'Enter first number: ' a
read -p 'Enter second number: ' b
sa=\$(sum_divisors \$a)
sb=\$(sum_divisors \$b)
if [[ \$sa -eq \$((b + 1)) && \$sb -eq \$((a + 1)) ]]; then
  echo \"\$a and \$b are betrothed numbers\"
else
  echo \"They are not betrothed numbers\"
fi"

# 8. Buzz number
run_script "
read -p 'Enter a number: ' num
if (( num % 7 == 0 || num % 10 == 7 )); then
  echo \"\$num is a Buzz number\"
else
  echo \"\$num is not a Buzz number\"
fi"

# 9. Kaprekar routine steps
run_script "
read -p 'Enter a 4-digit number with at least 2 distinct digits: ' num
steps=0
kaprekar() {
  local n=\$1
  while [[ \$n -ne 6174 ]]; do
    n1=\$(echo \$n | grep -o . | sort -r | tr -d '\n')
    n2=\$(echo \$n | grep -o . | sort | tr -d '\n')
    n=\$((10#\$n1 - 10#\$n2))
    ((steps++))
    n=\$(printf '%04d' \$n)
  done
  echo \"Kaprekar steps: \$steps\"
}
kaprekar \$num"

# 10. Trim spaces from a string
run_script "
read -p 'Enter a string: ' str
trimmed=\$(echo \$str | sed 's/^ *//;s/ *\$//')
echo \"Trimmed string: '\$trimmed'\""

# 11. Find initials
run_script "
read -p 'Enter full name: ' name
initials=\"\"
for word in \$name; do
  initials+=\"\${word:0:1}.\"
done
echo \"Initials: \$initials\""

# 12. Collatz sequence
run_script "
read -p 'Enter a number: ' n
echo -n \"Collatz sequence: \$n \"
while (( n != 1 )); do
  if (( n % 2 == 0 )); then
    n=\$((n / 2))
  else
    n=\$((3 * n + 1))
  fi
  echo -n \"\$n \"
done
echo"
