
#!/bin/bash

# Bash shell script example 
# Created on 20211204
# Original jibberish done by neel...modified by bob and jonny.  
# Remember the key to life is have fun and laugh

# Check if script has root privileges to run
if (( EUID != 0 )); then
    echo "Hey bonehead!  Please run this script with sudo (root) privileges."
    exit
fi

# Set some variables
formattedDate=$(date '+_%F_%T_%Z')
outputDir=$(hostname)$formattedDate

# Confirm what you are running is what you really want to do
echo -e "\nThis script will gather system info and produce a report in the present working directory."
echo -e "$(pwd)/$outputDir/\n"
read -n 1 -r -s -s -p $'Press any key to continue or ^C to abort'

# Create a directory structure to save config files
mkdir ./"$outputDir"
mkdir ./"$outputDir"/configs
mkdir ./"$outputDir"/configs/cron
mkdir ./"$outputDir"/configs/cron/var-spool-cron/
mkdir ./"$outputDir"/reports

# Copy config files and generate reports
echo -e "\n"
echo -e "Gathering hosts"
cp /etc/hosts ./"$outputDir"/configs/hosts
echo -e "Gathering Iptables"
iptables --list > ./"$outputDir"/reports/iptables.txt
echo -e "Gathering repo info"
cp /etc/dnf/dnf.conf ./"$outputDir"/configs/dnf.conf
cp -r /etc/yum.repos.d/ ./"$outputDir"/configs/yum.repos.d/
echo -e "Gathering packages"
dnf list installed > ./"$outputDir"/reports/installed_packages.txt
echo -e "Gathering services"
systemctl --full --type service -all --no-pager > ./"$outputDir"/reports/services.txt
echo -e "Gathering passwd"
cp /etc/passwd ./"$outputDir"/configs/passwd
echo -e "Gathering shadow"
cp /etc/shadow ./"$outputDir"/configs/shadow
echo -e "Gathering sudoers"
cp /etc/sudoers ./"$outputDir"/configs/sudoers
echo -e "Gathering netstat connections"
netstat > ./"$outputDir"/reports/netstat.txt
echo -e "Gathering cron configs"
cp -r /etc/cron* ./"$outputDir"/configs/cron/var-spool-cron/

# Redirect next set of output to logfile only.
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>./"$outputDir"/sysinfo.txt 2>&1

echo -e "\nJonny Rickard is old and broken"
ehco -e "\n"
echo -e "---------------------------------------System Information--------------------------------------------------"
echo -e "Inventory collected as:\t" "$(date)"
echo -e "Hostname:\t\t" "$(hostname)"
echo -e "Uptime:\t\t\t" "$(uptime | awk '{print$3,$4}' | sed 's/,//')"
echo -e "Operating System:\t" "$(hostnamectl | grep "Operating System" | cut -d ' ' -f3-)"
echo -e "Kernel:\t\t\t" "$(uname -r)"
echo -e "Architecture:\t\t" "$(arch)"
echo -e "System IPs:\t\t" "$(hostname -I)"
echo -e "SELinux Status:\t\t" "$(sestatus | grep "status" | head -1 | awk '{print$3}')"
echo -e "SELinux Mode:\t\t" "$(sestatus | grep "Current mode" | head -1 | awk '{print$3}')"
echo -e "Firewall Status:\t" "$(firewall-cmd --state)"
echo -e "Target Run Level:\t" "$(systemctl get-default)"
echo -e "\n"

echo -e "\nBob Lawless is older and more broken"
echo -e "--------------------------------------Hardware Information--------------------------------------------------"
echo -e "Manufacture:\t\t" "$(cat /sys/class/dmi/id/chassis_vendor)"
echo -e "Product Name:\t\t" "$(cat /sys/class/dmi/id/product_name)"
echo -e "Version:\t\t" "$(cat /sys/class/dmi/id/product_version)"
echo -e "Serial Number:\t\t" "$(cat /sys/class/dmi/id/product_serial)"
echo -e "\n"

echo -e "--------------------------------------Resource Utilization--------------------------------------------------"
echo -e "Processor Name:\t\t" "$(awk -F':' '/^model name/ {print $2}' /proc/cpuinfo | uniq | sed -e 's/^[ \t]*//')"
echo -e "Processor Count:\t" "$(lscpu | grep -e 'CPU(s)' | head -1 | awk '{print$2}')"
echo -e "CPU Current Load:\t" "$(cat /proc/stat | awk '/cpu/{printf("%.2f%\n"), ($2+$4)*100/($2+$4+$5)}' | awk '{print $0}' | head -1)"
echo -e "Memory Total:\t\t" "$(grep MemTotal /proc/meminfo | awk '{print$2}')"
echo -e "Memory Usage:\t\t" "$(free | awk '/Mem/{printf("%.2f%"), $3/$2*100}')"
echo -e "Swap Usage:\t\t" "$(free | awk '/Swap/{printf("%.2f%"), $3/$2*100}')"
echo -e "\n"

echo -e "--------------------------------------Disk Configuration--------------------------------------------------"
lsblk
echo -e "\n"

echo -e "--------------------------------------Mount Configuration-------------------------------------------------"
grep "^[^#;]" /etc/fstab
echo -e "\n"

echo -e "--------------------------------------Disk Space Utilization----------------------------------------------"
df -h
echo -e "\n" 

echo -e "--------------------------------------Repositories--------------------------------------------------------"
yum repolist all

# TAR the output dir
chmod -R 777 ./"$outputDir"
chmod 777 ./"$outputDir".tar.gz

# &3 redirects the output screen only since above echos all go to log file
echo -e "\n" >&3
echo -e "Finished gathering System Info.\n" >&3
echo -e "The System Info report is saved in your present working directory:" >&3
echo -e "$(pwd)/$outputDir/" >&3
echo -e "\n" >&3
echo -e "The results were also packaged and compressed for transfer convenience:" >&3
echo -e "$(pwd)/$outputDir.tar.gz\n" >&3
echo -e ".....and I'm spent!! (Austin Power reference)" >&3
echo -e "\n" >&3
echo -e "Can we all agree that Jonny and Bob are the greatest at EVERYTHING!" >&3
bash-example.sh
Displaying bash-example.sh.
