#!/bin/bash
architecture=$(uname -a)
phys_cpu=$(lscpu | grep Processeur | awk '{print $2}')
virt_cpu=$(nproc)
ram_usage=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)",$3,$2,$3*100/$2}')
disk_usage=$(df -h | awk '$1 == "/dev/sda1" {printf "%d/%sb (%d%%)",$3,$2,$3*100/$2}')
cpu_usage=$(top -bn1 | grep load | awk '{printf("%.2f", $(NF-2))}')
last_boot=$(who -b | awk '{print $3 " " $4}')
lvm=$(if [ $(lsblk | grep "lvm" | wc -l) -eq 0 ]; then echo no; else echo yes; fi)
tcp_co=$(ss -neopt state established | wc -l)
users_log=$(who | wc -l)
ip=$(hostname -I)
mac=$(ip a | grep link/ether | awk '{print $2}')
sudo_log=$(grep "sudo " /var/log/auth.log | wc -l)
wall "		#Architedture: $architecture
		#CPU physical: $phys_cpu
		#vCPU: $virt_cpu
		#Memory Usage: $ram_usage
		#Disk Usage: $disk_usage
		#CPU load: $cpu_usage%
		#Last_boot: $last_boot
		#LVM use: $lvm
		#Connexion tcp: $tcp_co ESTABLISHED
		#User log: $users_log
		#Network: IP $ip ($mac)
		#Sudo: $sudo_log cmd"
