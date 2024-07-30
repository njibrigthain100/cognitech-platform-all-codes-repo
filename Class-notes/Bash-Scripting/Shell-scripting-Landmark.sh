Computer has 2 components:
Bare Metal or Hard Ware:
	- RAM: Memory
	- CPU:
	- ROM: hard disk
	- MOUSE
	- Keyboard: 
Software components:
	- Operating system: OS like windows, Linux, MacOS etc
Other software's:
	- Shell
	- Sublime
	- Microsoft word/Excel: 
	- These are other software's that you can install. 
	- If you want to run tasks on your computer you have to either use the GUI (graphical user interface) or the CLI (Command line interface) using a shell. 
	- A server is a super computer that does multiple things

WHAT IS A SHELL SCRIPT
	- A shell script is a collection of commands in a file
	- A shell is an interpreter
	- A shell is a program that takes command from the keyboard and gives them to the operating system to perform
	- On most Linux systems a program called bash ( which stands for Bourne Again Shell, an enhanced version of the original Unix shell program, sh) acts as the shell program. Besides bourne shell, there are other shell programs that can be installed in a Linux system. These include Korn Shell, Boune shell (bash) and C shell. 
	- To see the shells that you have in your system you run cat /etc/shells
	ec2-user@ip-172-31-77-155 ~]$ cat /etc/shells
	/bin/sh
	/bin/bash
	/usr/bin/sh
	/usr/bin/bash
	- The above output tells me that I have sh which is the bourne shell and bash which is the bourne again shell. 
	- The command echo $SHELL tells you which shell will be interpreting your commands 
Naming convention:
	- The shell script is recommended to end in .sh or .sc example will be deploy.sh
	- The shell script ALWAYS start with #!/bin/sh or #!/bin/bash
	- You can also do the above with usr/bin

How to run a shell script
	- ./script name
	- Example is ./deploy.sh
	- If you run the shell script without giving the script any permissions you get a permission deny. So the above command will give a permission denied because the file does not have executable permissions. 
	- To assign permissions to a file we use the chmod command. Which is chmod +x scriptname
	- +x means add executable permissions. +r means add read permissions and +w means add write permissions. 
	- After running the executable permissions the color of the file changes color.
	- To get the date in a shell script the date has to be inputted as `date`. This provides you with the date of that particular day
	- For a command to run as a command in shell scripting the command has to be run in back tic as seen above with the date command.``
	- To remove the executable permissions in a file you run the command chmod -x filename
	- We can also run a file without executable permissions
	- You can also run a script without the #! Option. However, it is best practice to run it with that option
	- To run a script without executable permissions simply run as sh filename or bash filename
	- This is because these are the interpreters
	- You can install other interpreters such as c shell and k shell by running sudo yum install csh or sudo yum install ksh
	- Then to see what shells are running you run cat /etc/shells

What are comments:
	- Metadata is data about data
	- Explains what the script is achieving and used to explain the script file
	- Single line comment vs multi line comment
	- The comments have to start with #
	- Multi line comments in shell starts with <<mlc and ends with mlc wher mlc is a variable that can be changed based on the user
	- Sudo yum list installed to find the packages installed and sudo yum search packagename to find package names you are trying to install. For example sudo yum search awscl* to find packages for the awscli to install
	- The multi-line comment prevents you from inputting the # sign multiple times.
	- You are able to run scripts providing the absolute path as well if the script is being run from a different location

What are variables in Linux:
	- Company = LandmarkTechnology
	- Echo $Company
	- The dollar sign in front of company tells me that company is a variable
	- We will create a variable file called var.sh which is a variable file
	- When it comes to variables we have system defined variables and user defined variables
	- In the above example PWD is a system defined variable and the other variables like name and company are user defined variables
	- Env helps list all your environmental variables
	- All system variables are in caps so it is not recommended for user variables to be in caps as well. This is to avoid a conflict with any system variables available with the same name
	- To refresh a variable file you run source plus variable file
	- This updates the file after any changes are made
	- The read pin command in Linux allows the user to dynamically enter a pin
	- The read command in this case allows the user to be able to enter a value for the system
	- The pin in this case is a dynamic variable
    
Bash scripting class 3
	- Helping clients to transition from manual operations to automation
	- Rather than running individual commands we will put them in a file to automate the process
	- The echo can be run with or without the quotes
	- To run a dynamic variable we are going to use the read command
	- Scripting is very important for automation
	- The read command helps to obtain dynamic variables
	- Writing variables like the one in whatsapp.sh is called hard coding which is not recommended in software development
	[ec2-user@ip-172-31-77-155 ~]$ cat whatsapp.sh
	#!/bin/bash
	firstname=brigthain
	lastname=kargong
	echo "Thanks $firstname $lastname for installing whatsapp"
	echo "Please enter your phone number to receive your pin"
	read number
	echo "confirm if this $number is correct"
	read
	- First and last name above have been hard coded
	- We had a meeting with the team to avoid hard coding
	- Always try to make use of comments when writing scripts in your environment
	- The script below helps create a user account in your environment
	!/bin/bash
	#You need to be root or have sudo access to execute this script
	#This script will create a new user's account in a linux server
	echo "Please enter the userName for the account you want to create!"
	read userName
	echo "The name you entered is: $userName"
	sudo useradd $userName
	echo "$userName user account created successfully"
	echo "Set the password for $userName"
	sudo passwd $userName
	- The | command acts as a temporary storage and grep will only extract the word you provide
	- Read -s allows you to provide any information as a secret
	[ec2-user@ip-172-31-77-155 ~]$ cat read-user2.sh
	
	#!/bin/sh
	#You need to be root or have sudo access to execute this script
	echo -n "Enter the username: "
	read username
	echo -n "Enter the password:"
	read -s password
	sudo adduser "$username"
	echo "$password" | sudo passwd "$username" --stdin
	tail -7 /etc/passwd
	<<ST
	    stdin: This option is used to indicate that the passwd should read the new password from standard input, which can be a pipe.
	you can cat /etc/passwd to verify
	ST
	- https://www.howtogeek.com/435903/what-are-stdin-stdout-and-stderr-on-linux/
	- View link above to lear about stdin, stdout,stderror
	- Python scripts end in .py
	- Echo is to bash shell scripting as print is to python
	- Multi line code for python looks like '' and ''
	- To run a command in python type print('Input phrase here')
	#!/bin/sh
	#You need to be root or have sudo access to execute this script
	#This script also adds the user to the sudoers file for root privilges
	echo -n "Enter the username: "
	read username
	echo -n "Enter the password:"
	read -s password
	sudo adduser "$username"
	echo "$password" | sudo passwd "$username" --stdin
	echo "$username  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$username
	tail -7 /etc/passwd
	<<ST
	    stdin: This option is used to indicate that the passwd should read the new password from standard input, which can be a pipe.
	you can cat /etc/passwd to verify
	ST
	
	Number and String variables
	- An example of a string variable is str1="My name is Brigthain kargong and I work for gainwelltechnologies"
	- Most string variables should either be in single or double quotes
	- Number variable is num=5
	- The expression command in Linux lets you output values on your CLI
	- For instance expr 4+5 gives you 9
	- Or we can also use variables in bash shell scripting to create your own calculator
		#!/bin/bash
	echo "Please enter the first number"
	read num1
	echo "Please enter the second number"
	read num2
	echo "The sum is"
	expr $num1 + num2
	echo "The difference is `expr $num1 - $num2`
	echo "The product is `expr $num1 \* $num2`
	- The backtick is used here so that that portion will be run as a command

Command line arguments:
	- These are very important in bash shell scripting. These tell you what is happening when you run a script
	- The command line arguments to make note of are
	- Echo '$#:' -> number of arguments
	- , echo '$$:',-> a process ID
	-  echo '$0:',-> ScriptName
	-  echo '$*:', : Display all arguments
	- echo '$@:',: Display all the arguments
	-  echo '$?:': Status of the last run command
	- Any command you run in Linux created a process ID. 
	- Arg1 is the first argument. If you run the command cla.sh arg1 db app lb. The arg1 db app and lb in this case are all the arguments and app is the 3rd argument
	- Echo $?: has value either 0 or 1-127
	- Echo $?: 0 means you are good to go. If its nor zero it means there's a problem
	- For echo $? You get an error of 127 when there's a command not found error and value of 1 when there's a no such file or directory
	- This basically gives us the status of the last run command. If the comma d was fine the value will be a zero and if it was an error it will have a value ranging from 1-127
#!/bin/bash
#if (( $# >=3 ))
#if [ $# -gt 3 ]
#if [ $# -lt 3 ]
if (( $# == 3 ))
then
#Number of arguments on the command line
echo '$#:' $#
#Process number of the current process
echo '$$:' $$
#Display the 3rd argument on the command line
echo '$3:' $3
#Display the 10th argument on the command line
echo '${10}:' ${10}
#Display the name of the current shell
echo '$0:' $0
#Display all the arguments on the command line
echo '$*:' $*
#Display all the arguments on the command line
echo '$@:' $@
date
echo '$?:' $?
else
echo "Please pass the 3 command line arguments along with the script. Thanks"

Class 5
	#!/bin/bash
	sum=`expr $1 + $2`
	echo $sum
	echo "$1+$2=`expr $1 + $2`"
	#Run the above script as follows
	- To run multiplication you run expr 3 \*2
	- The above script expects you to pass 2 arguments for the number variables cause the variables were not specified at run time
	- $1 is the first argument while $2 is the second argument
	- The debugging mode in bash shell script helps you find out if there are any issues in the script. It breaks each part of the command letting you if there are any errors in the script
	- You can use either -v or -x to run the script in debugging mode
	
	Input output redirection
	- For standard output redirect an example is getting the output from the command tail -5 /etc/passwd > new-users.
	- Here the output from the passwd file will be outputted in the new-users file
	- 2> redirect standard error
	- 1> redirect standard output
	- 2>&1 redirect standard error to standard output
	- So using > is redirecting the output in your file to another specified file (Here the content in the redirected file is completed replaced with the output content from the first file
	- To append a file you use >>  so it adds content to the already existing file
	- Example is tail -5 /etc/passwd >> new-users
	- Interview question? What's the difference between redirect and append? Redirect replaces the content in the file while append adds content to the file.
	- To get the standard error you can run the command as sh error.sh > log.txt 2> error.txt
	- In the above command no information will be shown on the cli and all the output will be outputted to the log.txt and all errors will be outputted to the error.txt
	- Standard practice is that the content will be redirected into 1 file
	- To have both the errors and the standard output in one file you run the command as such sh error.sh > logging 2>&1 and both the errors and output will all be in one file
	- The tee command pushes the output to another file

Class 6
Conditions:
	- -eq Equals to ==  ex to say equals to b then you write a -eq b or a ==b
	- -ne is not equals to or != so a!=b or a -ne b
	- -gt is greater than so a>b or 3>2
	- -lt <  is less than 2<3 or a -lt b
	- -ge >= greater or equals to 4>=3
	- -le <= less than or equals to 3<=2
	- The conditions script always ends with fi. Always remember that
	!/bin/bash
	mypin=1986
	echo "Please enter your pin number"
	read pin
	if [ $pin == $mypin ]
	then
	echo "The pin you entered is correct please select your account number"
	else
	echo "You entered the wrong pin. You have 3 more tries before your account is locked. Thank you"
	fi
	- The above condition script asks the client to enter their password and if the wrong password is entered then the else statement is displayed
	- The if condition can either be written like if [ $var1 == $var2 ] or if (( $var1 == $var2 ))
	- Conditions3.sh
	firstname=brigthain
	lastname=kargong
	mypet=bingo
	echo "Please enter your petname"
	read petname
	if [ $mypet == $petname ]
	then
	echo "You entered the correct response. please proceed to the next question"
	else
	echo "That was the wrong answer.Please try again"
	fi
	echo "Please enter your first name"
	read Firstname
	if [ $Firstname == $firstname ]
	then
	echo "You entered the correct response. Please proceed to the next question"
	else
	echo "That was the wrong answer. Please try again"
	fi
	echo "Please enter your last name"
	read Lastname
	if [ $Lastname == $lastname ]
	then
	echo "You entered the correct response. Please proceed to the next question"
	else
	echo "That was the wrong response. Please try again"
	fi
	echo "Thank you for choosing Myworld.com for your services. We appreciate your support"
	- For each condition you have to close it with an fi. So if you have 3 ifs you must have 3 fi. 
	- Elif is another type of condition that is used to counter an earlier condition. For instance if the condition states. If the variable is greater than 10 then echo "" elif if the  variable is equal to 10 then echo ""
	- Elif is used to add additional conditions in a script
		#!/bin/bash
	echo -n "Enter the first number"
	read var1
	echo "Enter the second number"
	read var2
	echo "Enter the third number"
	read var3
	if [ $var1 -ge $var2 ] && [ $var1 -ge $var3 ]
	then
	echo "$var1 is the largest number"
	elif [ $var2 -ge $var1 ] && [ $var2 -ge $var3 ]
	then
	echo "$var2 is the largest number"
	elif [ $var2 -eq $var1 ] && [ $var2 -eq $var3 ]
	then
	echo "The variables are equal"
	else
	echo "$var3 is the largest number"
	fi
	
LOOPS:
	- This is used for repetition or repetitive tasks
For loops:
	- The syntax for for loops starts with the word for
	- So it looks like for expression, do and done
	- So to pass an expression with 5 variables such as 1,2,3,4,5
	- You run for I in 1 2 3 4 5
	- Do
	- Echo $i
	- So the above command gets the script to go back in the loop and keep looking for the value of I until there is no more value
	- So it will do for I in 1 2 3 4 etc until it gets to the last value
	- The key words for forloop is for, in , do and done
	- To define a range that has a high number or letter count you cant input all the values do you can run it in the following way
	- For I in {1..20} where the range is from 1 to 20
	- To execute the variables in steps of say 5 you can run the loop like this for I in {1..20..5}. In this case you are telling the script to run in ranges of 5
	!/bin/bash
	echo "For loops start.."
	#for i in 1 2 3 4 5
	#i=90
	for (( i=90; i<=100; i++ ))
	do
	echo $i
	done
	echo "loop is done"

	#!/bin/bash
	for i in {0..20..5}
	do
	echo $i
	done
	- For the above script the loop says for i=90, the loop needs to run until I is less than 100. 
	- i++ means that the value of I will keep increase by 1
	- So for i=1 it will be according to the formular i+1=1+1=2
	- Next value will be 2+1=3 and so on
While-loops
	- In this case the key words are while do and done
	#!/bin/bash
	echo "While demo loop
	i=1
	while [ $i -le 5 ]
	do
	echo $i
	i=`expr $i + 1`
	done
	echo "While loop is over"
	- In the above script the value of i=1 and we are saying that while i=1 and less than 5 run the math equation $i+1
	
Switch cases:
	- What is a switch case in batch shell scripting? 
	- Most commands you see in Linux are switch cases
	- A command is a program is a script or an executable file
	- Commands are generally found in the bin and sbin directory
	- Switch cases start with application state. i.e. start, stop, restart, state, enable
	#!/bin/bash
	case $i in
	start)
	echo 'myapp starting'
	echo 'myapp started';;
	stop)
	echo 'myapp stopping'
	echo 'myapp stopped';;
	restart)
	echo 'myapp restaring'
	echo 'myapp restarted';;
	*)
	echo 'sorry unknown option'
	echo 'please enter start|stop|restart';;
	esac
	#systemctl start httpd
	#service sshd start
	#we use openssh to connect to our linux
	#server = ssh port+22, ssh client, hostname/IP username
	#ssh privatekey or password
	- The systemctl start https is an example of a switch case that starts the software
	- Always remember to put the ;; after the second variable before the choice. Choices in the above script are star, stop or restart
	- The *) in this case states that the script should deny any other option that is not one of the above
	- The switch cases always start with case $variable in and end with esac
	- Esac is the opposite of esac.
	- Key word for switch cases are case in and esac
Functions:
	- What are functions in bash scripting?
	- Greet function
	- They are used to reduce lines of codes by calling them
	- To  create a function the key word is the user name
	- For instance the create user function can help us create a user
	- In this case the function will look like this
Create-user() 
{
	#This function will create a user when called
	Echo "Please enter the user"
	Read user
	Sudo useradd $username
}
	- How do you call a function in Linux? You do so by calling the function name
	- You can only call a function out of that function
	ec2-user@ip-172-31-77-155 ~]$ cat function1.sh
	#!/bin/bash
	createuser()
	{
	        echo "Please enter the user"
	        read username
	        sudo useradd $username
	        echo "$username has succesfully been created"        id $user
	}
	createuser
	- Functions start with the function name() and ends with the function name as well as seen on the above script
	- You also need the curl braces between your input
	ec2-user@ip-172-31-77-155 ~]$ cat function2.sh
	#!/bin/bash
	start()
	{
	        variable=boy
	        echo "This server will start after you pass the correct variable"
	        read variable1
	        if [ $variable == $variable1 ]
	        then
	        echo "You have entered the correct variable"
	        else
	        echo " YOu have entered the wrong variable"
	        fi
	        echo "end of file"
	}
	start
	- Functions are used to avoid repetitions in our code as we can just call them during the code
	#!/bin/bashcheckuser()
	{
	if [ -e /etc/passwd ]
	then
	echo "it exist. Please proceed ..."
	grep ec2-user /etc/passwd
	#tail -5 /etc/passwd
	touch test24.java /home/ec2-user/
	touch testb.py . #
	ls testb.py .
	else
	echo "It doesn't exist"
	fi
	}
	echo "Before function"
	checkuser
	- See above code
	
								CRONTAB CLASS
	- Explain your experience in bash shell scripting? I have written a script for server monitoring
	- The script continuously monitors our server and ensure that it does not run above a defined threshold. 85% in this case
	#!/bin/bash
	THRESHOLD=85
	df -h | grep -vE 'Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
	do
	  echo $output  usep=$(echo $output | awk '{ print $1 }' | cut -d'%' -f1 )
	  partition=$(echo $output | awk '{ print $2 }' )
	  if [ $usep -ge $THRESHOLD ]; then
	     echo "Running out of memory space \"$partition ($usep%)\" on $(hostname) as on date $(date)" |
	     mail -s "Alert: Almost out disk space $usep% kbrigthain@gmail.com"
	  fi
	done
	- The above script monitors CPU utilization in your servers
	- Developers write code in the build server
	- I have written a shell script for data base backup
	- To copy from one server to another you use SCP command
		- I have written a shell script for package management, Patch optimization, data backup and user and file manager
	- Now how do I automate my task as a DevOps engineer
	- To automate a task you use a cron job
	- Cron jobs run at specific intervals
	- Cron -e lets you edit the cron table
	- Cron -l lets you list the cron table
	- To install crontab run sudo yum install crontabs.noarch
	- This helps install the crontab
	- Now to edit it run crontab -e
	- To generate a cron table go to crontab generator
	- To generate a cron job copy the file path you want to create the job for a go to https://crontab-generator.org/ and paste it in the "command to execute" space and it gives you what to paste in the cron file.
	- Who should have access to crontab?
	- The uptime command tells you how long that server has been running
	- To limit access to the cron table you create a file called cron.allow and cron.deny
	- To find the number of users in an account run ls /home. This will list all the users in that server
	- Now create a file called cron.deny by running touch /etc/cron.deny
	- Once the cron.allow is created no user is allowed to have access to the crontab UNLESS they are added to the file but for cron.deny the user has to be added to the file to be denied access to it
	- That’s how you control access to cron jobs
	- The reason why we do this is to avoid the wrong people from gaining access to certain automations
	- Landmark recommends to use the cron.allow instead of the cron.deny
	

	


	


