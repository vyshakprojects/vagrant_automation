#!/bin/bash
clear

WORKING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [[ ! -d VirtualboxVMs ]]; then
    # Making a directory for all the vagrant files
    mkdir VirtualboxVMs
fi
echo "enter 1 to create VM"
echo "enter 2 to edit current vm"
echo "enter 3 to delete a vm"

while [[ $VM_MODE -lt 1 || $VM_MODE -gt 4 ]]; do
  echo "#   Enter a valid number"
  read -p "#   :" VM_MODE
done
  if [[ "$VM_MODE" == 1 ]]; then
      read -p "enter the VM name: " VM_NAME
      read -p "enter the server IP: " VM_IP
      read -p "enter the number of CPU: " CPU_NUM
      read -p "enter the ram required :" RAM
      read -p "enter the disk size:" DISK
      mkdir VirtualboxVMs/$VM_NAME
      cp Vagrant.txt VirtualboxVMs/$VM_NAME/Vagrantfile
      cd VirtualboxVMs/$VM_NAME

      echo "VM_NAME=$VM_NAME" >> properties.txt
      echo "VM_IP=$VM_IP" >> properties.txt
      echo "CPU_NUM=$CPU_NUM" >> properties.txt
      echo "RAM=$RAM" >> properties.txt
      echo "DISK=$DISK" >> properties.txt

      python3.7 ${WORKING_DIR}/change_config.py properties.txt Vagrantfile

      vagrant up
      cd ../..

   elif [[ "$VM_MODE" == 2 ]]; then
     cd VirtualboxVMs
     echo "The following are the available VMs"
     arr=(*)
      # iterate through array using a counter
      for ((i=0; i<${#arr[@]}; i++)); do
          #do something to each element of array
          echo "> $i.${arr[$i]}"
      done
     echo "Enter the number of the VM: "
     read VM_NUM
     while [[ $VM_NUM -ge ${#arr[@]} ]]; do
       echo "#   Enter a valid number"
       read -p "#   :" VM_NUM
     done
     VM_NAME="${arr[VM_NUM]}"
     echo "You are selected VM : $VM_NAME"
     echo "Enter the variable to change"
     cd $VM_NAME
     x="1";

        while [ $x -ne 5 ];
        do
          echo "1. IP"
          echo "2. CPU Number"
          echo "3. RAM"
          echo "4. Disk size"
          echo "5. Save and exit"
          read x
          case $x in
        	1)
        		read -p "Please enter the new IP: " VM_IP
            echo "$VM_IP"
            echo "changing the variable in properties file"
            sed -i "" "/VM_IP/d" properties.txt && echo "VM_IP=$VM_IP" >> properties.txt
        		;;
        	2)
        		read -p "Please enter the number of CPU: " CPU_NUM
            echo "$CPU_NUM"
            echo "changing the variable in properties file"
            sed -i "" "/CPU_NUM/d" properties.txt && echo "CPU_NUM=$CPU_NUM" >> properties.txt
            ;;
          3)
            read -p "Please enter the amount of RAM riquired: " RAM
            echo "$RAM"
            echo "changing the variable in properties file"
            sed -i "" "/RAM/d" properties.txt && echo "RAM=$RAM" >> properties.txt
            ;;
          4)
            read -p "Please enter the Disk size: " DISK
            echo "$DISK"
            echo "changing the variable in properties file"
            sed -i "" "/DISK/d" properties.txt && echo "DISK=$DISK" >> properties.txt
            ;;
          5)
            echo "Current settings saved...Quiting"
            break
            ;;
        	*)
        		echo "Sorry, I don't understand"
            echo "Please try again"
            ;;
        esac
        done
# removing current vagrant file
     mv Vagrantfile Vagrantfile.back
# copying new vagrant file
     cp $WORKING_DIR/Vagrant.txt Vagrantfile
# changing the properties to the vagrant file
     python3.7 ${WORKING_DIR}/change_config.py properties.txt Vagrantfile
     pwd
     vagrant reload
   else
     #statements
     cd VirtualboxVMs
     echo "The following are the available VMs"
     arr=(*)
      # iterate through array using a counter
      for ((i=0; i<${#arr[@]}; i++)); do
          #do something to each element of array
          echo "> $i.${arr[$i]}"
      done
     echo "Enter the number of the VM: "
     read VM_NUM
     while [[ $VM_NUM -ge ${#arr[@]} ]]; do
       echo "#   Enter a valid number"
       read -p "#   :" VM_NUM
     done
     VM_NAME="${arr[VM_NUM]}"
     echo "You are selected VM : $VM_NAME"
     cd $VM_NAME
     vagrant destroy
     cd ..
     rm -rf $VM_NAME
   fi
