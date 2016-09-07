#!/bin/bash

# w will list all the users that are logged in
echo "List of logged in users"
w
echo
# The following cat command will list all users that have credentials to log in
echo "List of all Users"
cat /etc/passwd|grep '/home'|cut -d: -f1
#Printing list of all users to a txt file called users, located on the desktop
cat /etc/passwd|grep '/home'|cut -d: -f1 > users.txt

#Reading from the list users.txt and assigning the users random passwords of length 8
echo
# The for loop will read the txt file that has the list of users 
# Then it will assign each user a randomized passowrd and write it to a txt file
for i in `more users.txt`
do
randompw=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
# You can also change passwords using the line below...-s=secured and the number= length of pw
#randompw=$(pwgen -s 2)
echo $i:$randompw | sudo chpasswd
echo "User:" $i "now has the password:" $randompw
echo "User:" $i "now has the password:" $randompw  >> passwords.txt
done

# The following will generate an encrypted file to store the passwords
echo "Generating an encrypted file for passwords.txt..."
gpg -c passwords.txt
echo "passwords.txt.gpg now holds an encrypted file with all the users passwords."
