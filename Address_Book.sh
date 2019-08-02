# This is Assignment No.1
# Lab - SL2 (33315)

#! /bin/sh
#Insert data in file
insert() {
	echo -e "\nEnter Details:"
	
	echo -e "\nEnter Name: \c"
	read name
	while [ true ]
	do
		if ! [[ $name =~ ^[a-zA-Z]+$ ]]
		then 
			echo -e "Enter valid name : \c"
			read name
		else 
			break
		fi
	done
	
	echo -e "\nEnter Address: \c"
	read address
	
	echo -e "\nEnter City: \c"
	read city
	while [ true ]
	do
		if ! [[ $city =~ ^[a-zA-Z]+$ ]]
		then 
			echo -e "Enter valid name : \c"
			read city
		else 
			break
		fi
	done
	
	echo -e "\nEnter State: \c"
	read state
	while [ true ]
	do
		if ! [[ $state =~ ^[a-zA-Z]+$ ]]
		then 
			echo -e "Enter valid name : \c"
			read state
		else 
			break
		fi
	done
	
	echo -e "\nEnter Pin Code: \c"
	read pin
	
	while [ true ]
	do
		if [ ${#pin} -ne 6 ]
		then
			echo -e "Pin code should be of 6 digits Enter again:\c "
			read pin
		elif ! [[ "$pin" =~ ^[0-9]+$ ]]
		then
			echo -e "Characters not allowed enter again:\c "
			read pin
		else
			break
		fi
	done
	
	
	echo -e "\nENter Phone Number: \c"
	read phone
	
	while [ true ]
	do
		if [ ${#phone} -ne 10 ]
		then
			echo -e "\nPlease enter 10 digit number: \c"
			read phone
		elif ! [[ "$phone" =~ ^[0-9]+$ ]]
		then
			echo -e "\nCharacters are not allowed please re-enter : \c"
			read phone
		else
			break
		fi
	done
	
	echo -e "$name \t $address \t $city \t $state    \t $pin \t $phone" >> address.dat
	echo -e "\nRecord Inserted Successfully!!"
}

#Display data from file	
display() {
	echo -e "\nName \tAddress   City State   Pin \t Phone"
	echo -e "-------------------------------------------------"
	if [ "$ch" -eq 1 ]
	then
		sort -k 1 address.dat | column -t
	elif [ "$ch" -eq 2 ]	
	then
		sort -k 3 address.dat | column -t
	elif [ "$ch" -eq 3 ]
	then
		sort -k 6 address.dat | column -t
	fi
		
}


search()
{
	echo -e "\nEnter name to be searched : \c"
	read n
	#w for word match i for ignore case h for display whole line q for not printing anything on console
	grep -w -i -h -q "$n" address.dat
	s=$?
	#grep returns 0 if something is found	
	if [ $s -eq 0 ]
	then
		echo -e "\nSearch success record found\nRecord is:\n"
		echo -e "\nName \tAddress  \tCity \t State \t Pin \t\t Phone"
	    echo -e "--------------------------------------------------------------------"
		grep -i -w -h "$n" address.dat
	else
		echo -e "\nNo records found\n"
	fi
}

delete()
{
	echo -e "\nEnter name to be deleted : \c"
	read name
	
	sed "/"$name"/d" address.dat > temp.dat
#	grep -v $name address.dat > temp.dat
	mv temp.dat address.dat
	echo $name "Deleted !!"
}

modify()
{
	echo -e "\nEnter name or phone number or pincode to modify record: \c"
	read src
	
	#w for word match i for ignore case h for display whole line q for not printing anything on console
	str=$(grep -w -i "$src" address.dat)
	stat=$?
	#if the record exists	
	if [ $stat -eq 0 ]
	then
		#accept new data by calling insert function
		sed  -i "/$str/d" address.dat
		insert
			
		echo -e "Record Modified!\n"
	else
		echo -e "\nRecord not found in database\n"
	fi
}

#MENU
while(true)
	do
		echo -e "\n-------------STUDENT DATABASE---------------"
		echo -e "\n1-> Insert Record"
		echo -e "\n2-> Display Records"
		echo -e "\n3-> Delete Record"
		echo -e "\n4-> Search Record"
		echo -e "\n5-> Modify Record"
		echo -e "\n6-> Exit"
		echo -e "\n--------------------------------------------"
		echo -e "\nEnter your choice : \c"
		read choice

		case "$choice" in
			1) insert  ;;
			
			2) 
				echo -e "\nHow do you want to display ?"
				echo -e "\n1-> By Name\n2-> City\n3-> Phone Number"
				echo -e "\nEnter your choice : \c"
				read ch
				while(true)
				do
					if [ "$ch" -le 0 ]
					then
						echo -e "\nSelect Proper choice : \c"
						read ch
					elif [ "$ch" -gt 3 ]
					then
						echo -e "\nSelect Proper choice : \c"
						read ch
					else
						break
					fi
				done
				display "$ch";;
				
			3) delete  ;;
			
			4) search  ;;
			
			5) modify  ;;
			
			6) exit    ;;
			
			*) echo -e "\nYou Entered wrong choice!!"
		esac
	done
