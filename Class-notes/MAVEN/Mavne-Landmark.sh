	- What do we as DevOps engineer do when the developers are done with their job?
	- This is an important build tool
	- Apache maven is a software project management and comprehension tool. It is based on the concept of a project object model(POM). Maven can manage a projects build, reporting and documentation. 
	- The most powerful feature is its ability to download the project dependency libraries automatically from maven central repo, maven remote repo or local repo. 
	- When developers write codes they commit and push the code to Git/GitHub. 
	- The developers are writing the source code or the raw code. They are also writing the build script and the test cases. The code in this case are in the form app.java. 
	- Once the code is written it should never be sent directly to the customer application. There should be some testing before its deployed. 
	- The code has to go through a process that gets it ready for the application. So the code needs to be built. 
	- The code needs to go through Testing and Code build. This is where the DevOps engineer come in. 
	- The code build is done with Maven. Maven processes this code and once the build is complete the application server will be able to read the code. The codes will be packaged in either jar, war or ear packages.
	- So the codes will be app.jar, app.war or app.ear. 
	- Example of an application server is Tomcat or JBoss. 

What is Maven really?
	- It is a build tool. It is a software used to create packages for deployment. 
	- Build tools create deployable packages. 
	- The code goes from coding to testing to build and then eventually deployed. 
	- Raw code + build = packages that the deployment servers can interpret. 
	- We support JAVA based projects and a few .NET and NodeJS projects as well. This means that we support apps that are written in java, .NET, NodeJS by developers. 
	- It is an open source java based tool/software
	- The vendor of maven is called Apache
	- It was originally developed for java based codes
	- All software are available in 3 options:
		○ Free: Software is given for free without source code. How the software is developed is not shared
		○ Licensed: The software is paid for
		○ Open source: both the software and the source code are available for free. You can download the source code and develop on existing features. 
	- Linux is another open source tool like Maven. 
	- You need a license for windows unlike with linux
	- Projects are developed using programming languages like:
		○ Java
		○ Python
		○ nodeJS
		○ .NET
		○ JAVASCRIPT
		○ Etc
Build Tools for different programming languages:
Java:
	- Maven
	- ANT
	- Gradle
.NET:
	- NaNt
	- MSBuild
Python:
	- PyBuilder
Ruby:
	- Rake
NodeJS
	- Npm

Pre requisites:
	- Java
	- XML
What is expected of developers:
	- They are expected to write the source code
	- Unit test cases
	- Build scripts 
	- If developers write 30000 lines of code they are expected to write 30000 unit test cases. This is because we are expected to test each line of code written. This is referred to as unit testing
	- This entails testing individual component or unit or each line of the code
	- Who writes the unit test cases: Developers
	- Who performs/run the unit testing: Developer
What does build means:
	- It means compiling and creating deployable packages from raw codes. Example hello.java or hello.py
	- We have human readable and machine readable language. 
	- Print('hello world') is understood by humans and machine readable languages are binary files that are understood by machines.
	- A build can never be succesfully without a compilation
	- Ls -h give you human readable forms of the files and ls -I gives you the inode numbers which are machine readable.
	-  the inode are numbers that the machine assigns to a file so it can read them
Maven installation:
	- See software installation for maven
	- The maven home directory is where the maven software is extracted
	- Our maven home directory is /opt/maven
	- The home directory is represented as M2_HOME
	- The maven home directory is made up of bin  boot  conf  lib  LICENSE  NOTICE  README.txt
	- These are all the folders in the maven home directory
	- The bin directory is made up of binary files
	- The conf directory contains configuration files
	- The lib directory contains jar files and library files
	- We use maven to Test, Build and manage applications
	- Maven creates jar, war and /OR ear
	Jar: Standalone applications
	Ebay.jar
	Paypal.jar
	Tesla.jar
	
	War: Web applications
	Boa.war
	Tesla.war
	Td.war
	
	Ear: Enterprise applications
	Aa.ear
	Tesla.ear
	Td.ear
	
What are standalone applications: .jar
	- They create jar archives
	- They contain java codes only and java classes
Web Application: .war
	- They contain java codes plus web content such as CSS, HTML, JS images
	- They are good for frontend and backend codes
	- Tesla.war
Enterprise application .ear
	- They contain java codes plus web content and multiple modules
	- Ear = war(s) + jar(s)
	- Banking applications
	- Maven-web-application.war
What kind of application are we building:
	1. Source code (raw code)
	2. Unit test cases
		a. JAVA --> Junit test cases
		b. .Net --> Nunit test cases
		c. C++ --> CPPUnit test cases
	3. Buildscripts  --> pom.xml
	The buildscript is called pom.xml
	The build scripts contains:
		- Dependencies
		- Plugins
		- Tag [v1, v2, v3, 1.0.0, 2.0.0]
		- Package name [*.war, *.ear, app,jar]
		- Xml is extensible mark-up language
		- Html is hypertext markup language
		- Xml tags are custom and does not come wit predefined tags
		- Html have predefined tags that you have to used
		- Example of html tags are <h1>Hello World</h1>
		- In xml you can have <buea>Hello World</buea>
		- The project dependencies are found in the pom.xml file
	
Explain the Maven Lifecycle:
It has 3 lifecycles: Clean, site and default
Each of the above lifecycles have a goal:
	- Clean: Helps delete old builds. This is ran a lot as it cleans old builds. 
	- Site/swagger: it creates java classes (byte code) and JVM
	- Default: it has different goals:
		- Mvn validate: It will validate the project structure and resource files
		- Mvn compile: It will compile all java classes and test cases
		- Mvn test: it will run the unit test cases JUnit
		- Mvn package: it will create packages in the target directory (*.jar/*.war/*ear)
		- Mvn install: it will store the build artifacts in MAVEN LOCAL REPO
                      Default location: .m2/repository
		- Mvn deploy: NEXUS
		It will upload the build artifacts into maven-remote-repo NEXUS
	- Mvn package does the following:  VCTP
	1. Validate
	2. Compile
	3. RunUnitTesting
	4. Create the packages
	- Mvn install does the following:
	1- Validate 
	2- Compile
	3- RunUnitTesting
	4- Create packages in the target directory
	5- Create package in the maven local repository

Maven uses plugins/dependencies in the build process
Where will maven get the plugins and dependencies in the build process? 
It gets that from:
	- Maven local repository
		- ~/.m2/repository = default
		- Ls ~/.m2/repository
	- Maven remote repository
	- Maven central repository
	- The pom.xml determines what kind of package will be created. When developers are writing the project file they know if the project will only use java or java plus web applications
	
