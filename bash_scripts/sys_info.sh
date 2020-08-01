#!/bin/bash

#Check if run as root. Exit if true.
if [$UID -eq 0 ]
then
	echo "please do not run this script as root."
	exit
fi

#Define Variables
output=~/research/sys_info.txt
ip=$(ip addr | head -9 | tail -1)
suids=$(find / -type f -perm /4000)
cpu=$(lscpu | grep CPU)
disk=$(df -H | head -2)

#Define Lists to use Later
commands=(
'date'
'uname -a'
'hostname -s'
)

files=(
'/etc/passwd'
'/etc/shadow'
'/etc/hosts'
)

#Check for research directory. Create if needed.
if [ ! -d $HOME/research ]
then
	mkdir ~/research 2> /dev/null
fi

#Check for output file. Clear if needed.
if [ -f $output ]
then
	>> $output
fi

echo "A Quick System Audit Script" >> $output
echo "" >> $output

for x in {0..2} ;
do
	results=$(${commands[$x]})
	echo "Results of "${commands[$x]}" command:" >> $output
	echo $results >> $output
	echo "" >> $output
done

#Display Machine Type
echo "Machine Type Info:" >> $output
echo $MACHTYPE >> $output

echo -e "Uname info $(uname -a) \n" >> $output

#Display IP Address Info
echo -e "IP Info:" >> $output
echo -e "$ip \n" >> $output


#Display Hostname
echo "Hostname: $(hostname -s) " >> $output

#Display DNS Info
echo "DNS Servers: " >> $output
cat /etc/resolv.conf >> $output

#Display Memory Usage
echo -e "Memory Info:" >> $output
free >> $output

#Display CPU Usage
echo -e "\nCPU Info:" >> $output
lscpu | grep CPU >> $output

#Display Disk Usage
echo -e "\nDisk Usage:" >> $output
df -H | head -2 >> $output

#Display Who is Logged in
echo -e "\nWho is logged in: \n $(who -a) \n" >> $output

#List SUID Files
echo -e "\nSUID Files:" >> $output
for suid in $suids;
do
	echo $suids >> $output
done

#List top 10 Processes
echo -e "\nTop 10 Processes" >> $output
ps aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head >> $output

#Check the Permissions on Files
echo -e "\nThe permissions for sensitive /etc files: \n" >> $output
for file in ${files[@]};
do
	ls -l $file >> $output
done
