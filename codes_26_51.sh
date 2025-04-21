#!/bin/bash

# 26. Round Pi to n significant digits
round_pi() {
  echo -n "Enter the number of significant digits: "
  read n
  pi=$(echo "scale=$n; 4*a(1)" | bc -l | awk '{print substr($0, 1, n+1)}')
  echo "Pi rounded to $n significant digits: $pi"
}

# 27. Bullseye matrix (concentric circles of numbers)
bullseye_matrix() {
  echo -n "Enter matrix size (odd number): "
  read size
  for ((i=0; i<size; i++)); do
    for ((j=0; j<size; j++)); do
      distance=$(( (i<size/2) ? size/2-i : i-size/2 ))
      distance=$(( (distance<(size-j-1)) ? distance : size-j-1 ))
      distance=$(( (distance<(size-i-1)) ? distance : size-i-1 ))
      echo -n "$((distance+1)) "
    done
    echo
  done
}

# 28. Convert sentence to camel case
camel_case() {
  echo -n "Enter a sentence: "
  read sentence
  result=$(echo $sentence | sed -r 's/([a-zA-Z0-9]+)[[:space:]]*/\U\1/g' | sed 's/^[a-z]/\L&/')
  echo "Camel case: $result"
}

# 29. Generate a square wave
square_wave() {
  echo -n "Enter number of periods: "
  read periods
  echo -n "Enter amplitude: "
  read amplitude
  for ((i=0; i<periods; i++)); do
    for ((j=0; j<amplitude; j++)); do
      if ((i % 2 == 0)); then
        echo -n "+"
      else
        echo -n "-"
      fi
    done
    echo
  done
}

# 30. Find the two most distant points in a set of 2D points
most_distant_points() {
  echo -n "Enter number of points: "
  read n
  declare -a points
  for ((i=0; i<n; i++)); do
    echo -n "Enter x and y coordinates for point $((i+1)): "
    read x y
    points+=("$x $y")
  done

  max_dist=0
  for ((i=0; i<n-1; i++)); do
    for ((j=i+1; j<n; j++)); do
      x1=$(echo ${points[$i]} | awk '{print $1}')
      y1=$(echo ${points[$i]} | awk '{print $2}')
      x2=$(echo ${points[$j]} | awk '{print $1}')
      y2=$(echo ${points[$j]} | awk '{print $2}')
      dist=$(echo "scale=2; sqrt(($x2 - $x1)^2 + ($y2 - $y1)^2)" | bc)
      if (( $(echo "$dist > $max_dist" | bc -l) )); then
        max_dist=$dist
        p1="$x1,$y1"
        p2="$x2,$y2"
      fi
    done
  done
  echo "The two most distant points are: $p1 and $p2 with distance $max_dist"
}

# 31. Compute Discrete Wavelet Transform (DWT)
dwt_transform() {
  echo -n "Enter sequence of numbers (space-separated): "
  read -a sequence
  # DWT is not natively supported in bash, but here's a simple low-pass filter for illustration
  for ((i=0; i<${#sequence[@]}-1; i+=2)); do
    avg=$(( (${sequence[$i]} + ${sequence[$i+1]}) / 2 ))
    diff=$(( (${sequence[$i]} - ${sequence[$i+1]}) / 2 ))
    echo -n "($avg, $diff) "
  done
  echo
}


# 32. Convert a decimal number to binary
decimal_to_binary() {
  echo -n "Enter a decimal number: "
  read n
  binary=$(echo "obase=2;$n" | bc)
  echo "Binary: $binary"
}

# 33. Calculate factorial of a number
factorial() {
  echo -n "Enter a number: "
  read n
  fact=1
  for ((i=2; i<=n; i++)); do
    fact=$((fact * i))
  done
  echo "Factorial: $fact"
}

# 34. Check if a number is palindrome
check_palindrome() {
  echo -n "Enter a number: "
  read num
  rev=$(echo $num | rev)
  if [[ $num -eq $rev ]]; then
    echo "$num is a palindrome."
  else
    echo "$num is not a palindrome."
  fi
}

# 35. Sum of digits of a number
sum_of_digits() {
  echo -n "Enter a number: "
  read num
  sum=0
  while (( num > 0 )); do
    sum=$((sum + num % 10))
    num=$((num / 10))
  done
  echo "Sum of digits: $sum"
}

# 36. Count vowels and consonants in a string
count_vowels_consonants() {
  echo -n "Enter a string: "
  read str
  vowels=0
  consonants=0
  for ((i=0; i<${#str}; i++)); do
    char=${str:i:1}
    if [[ "$char" =~ [aeiouAEIOU] ]]; then
      vowels=$((vowels + 1))
    elif [[ "$char" =~ [a-zA-Z] ]]; then
      consonants=$((consonants + 1))
    fi
  done
  echo "Vowels: $vowels, Consonants: $consonants"
}

# 37. Reverse a string
reverse_string() {
  echo -n "Enter a string: "
  read str
  rev=$(echo $str | rev)
  echo "Reversed string: $rev"
}

# 38. Find the largest number in an array
find_largest_number() {
  echo -n "Enter numbers (space-separated): "
  read -a arr
  largest=${arr[0]}
  for num in "${arr[@]}"; do
    if ((num > largest)); then
      largest=$num
    fi
  done
  echo "Largest number: $largest"
}

# 39. Find the smallest number in an array
find_smallest_number() {
  echo -n "Enter numbers (space-separated): "
  read -a arr
  smallest=${arr[0]}
  for num in "${arr[@]}"; do
    if ((num < smallest)); then
      smallest=$num
    fi
  done
  echo "Smallest number: $smallest"
}
# 40. Network Ping Sweep to identify live hosts in a range
echo "40. Network Ping Sweep to identify live hosts in a range"
echo -n "Enter the subnet (e.g., 192.168.1): "
read subnet
for i in {1..254}
do
    ping -c 1 $subnet.$i &>/dev/null && echo "$subnet.$i is online"
done

# 41. Simple Nmap port scanner
echo "41. Simple Nmap port scanner"
echo -n "Enter target IP: "
read target
echo -n "Enter port range (e.g., 1-1000): "
read range
nmap -p $range $target

# 42. Display network interface details
echo "42. Display network interface details"
echo "Active Network Interfaces:"
ifconfig -a | grep -E "inet|eth|wlan"

# 43. Packet Sniffer using tcpdump
echo "43. Packet Sniffer using tcpdump"
echo -n "Enter network interface (e.g., eth0): "
read interface
echo -n "Enter capture duration in seconds: "
read duration
tcpdump -i $interface -G $duration -w capture.pcap
echo "Capture saved as capture.pcap"

# 44. Check open ports using Netcat
echo "44. Check open ports using Netcat"
echo -n "Enter target IP: "
read target
echo -n "Enter port range (e.g., 1-65535): "
read range
for port in $(seq 1 65535)
do
    nc -zv $target $port &>/dev/null && echo "Port $port is open"
done

# 45. IP Geolocation lookup
echo "45. IP Geolocation lookup"
echo -n "Enter IP address: "
read ip
curl -s "https://ipinfo.io/$ip/json" | jq

# 46. DNS Lookup
echo "46. DNS Lookup"
echo -n "Enter domain name: "
read domain
dig $domain

# 47. SSL Certificate Expiry Check
echo "47. SSL Certificate Expiry Check"
echo -n "Enter domain to check SSL expiry: "
read domain
echo | openssl s_client -connect $domain:443 -servername $domain 2>/dev/null | openssl x509 -noout -dates

# 48. Traceroute script
echo "48. Traceroute script"
echo -n "Enter target host: "
read host
traceroute $host

# 49. ARP Cache Dump
echo "49. ARP Cache Dump"
echo "ARP Cache Entries:"
arp -a

# 50. Check HTTP Response Code
echo "50. Check HTTP Response Code"
echo -n "Enter URL: "
read url
curl -o /dev/null -s -w "%{http_code}" $url

# 51. Wi-Fi Network Scanner
echo "51. Wi-Fi Network Scanner"
echo "Scanning for Wi-Fi networks..."
sudo iwlist wlan0 scan | grep "ESSID" | awk -F ':' '{print $2}' | sort

