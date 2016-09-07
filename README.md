# Change-user-passwords-via-Bash-Script
This is a bash script that will first off list all the users that are currently logged into a box. 
Then it will list all users on the box, followed by writting the name of those users to a txt file then reading in the txt file and changing the password for each user.
All passwords are different an randomly generated.
Lastly the script changes the passwords for the users and writes those passwords to a txt file, followed by encrypting the file using OpenGPG.


Break down of each command.

     Command: w
 Description: Show's a list of logged on users and their processes. 

     Command: cat /etc/passwd|grep '/home'|cut -d: -f1
 Description: This will output everything in the passwd directory, and |grep '/home' will print out all users who have a /home directory.              Following that, |cut -d: -f1 will remove all sections of each row except the first instance in this case its the username.

     Command: echo cat /etc/passwd|grep '/home'|cut -d: -f1 > users.txt
 Description: This is the same as the previous command, however we are printing the list of users to a file called users.txt
 
     Command: for loop
 Description: A quick break down of the for loop. The parameters it holds, is basically saying, for i (each name) in the text file we              created (users.txt) 'do' we then generate a random password (on line 19 randompw=...). /dev/urandom is a directory                   that generates random characters or numbers. | seperating commands. tr (translate) -dc (delete all characters except for              the specified ones) 'a-zA-Z0-9' (specified set). | fold -w 8 is specifying that each password will be 8 charaters long.              The number can be whatever you want your password length to be. head -n 1 this will output the first part of the file,               but since we are using the -n option we are telling it to only print the first line. Then the first echo statement                   basically takes a username from the file users.txt and generates a random password which then changes its previous                   password to that new password. Then prompts the user saying the user "x" now has the password "x". Following that we                 print the password to a txt file called passwords.txt
 
     Command: gpg -c passwords.txt
 Description: OpenPGP is an encryption and signing tool. The -c option allows us to encrypt with a symmetric cipher using a                        passphrase. After -c we specify which file we want to encrypt. Once executing the above command the user will be                     prompted with a "Enter passphrase:" this is where the user enters the key/password they wish to encrypt the file with.
              As a result we will now have a new file called passwords.txt.gpg which is now the encrypted passwords.txt file.
 
 Decrypting gpg: In order to decrypt we have to run the following command.
    Command/Syntax: gpg -d "passwords.txt.gpg" 
Cont Decription: After executing the following command you will be prompted with "Enter passphrase:" which you will then enter your                    passphrase. Successfully entering the correct passphrase you should be able to see the content of the encrypted file.
 
 
