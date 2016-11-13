####TODO Front Page####
#Chapter 1#
#Introduction#
##1.1 Purpose##
This document is the Requirement Analysis and Specification Document for
the PowerEnjoy system. Its aim is to completely describe the system,
its components, functional and non-functional requirements, constraints, and
relationships with the external world, and to provide typical use cases and
scenarios for all the users involved.

##1.2 Scope##
The system is an electrical car sharing management system.
Its main goal is ##Da inventare##
The system consists in a web application.
The system has two types of users:
* PowerEnjoy employee (Employee)
* Generic persons (User)
The system should allow the users to sign up and login with their credentials.
The system must know the location of each car and logged in user.
The system allows a user to reserve a car in each geographical region for at most an hour.
When a user is near his reserved car and asks for an unlock, then the ride will start,
after parking in a safe area the bill is processed.
The system allows the employee to manage safe areas and geographical regions to improve the overall offered service.
The system allows the employee also to monitor the status of the car, so that when a car has a
low battery charge an employee can move the car is a recharging station and plug the car.

##1.3 Goals##
###Goals.md###

##1.4 Glossary##
###Glossary.md###

##1.5 References##
This document refers to the rules of the Software Engineering 2 project and to the RASD Assignment.

##1.6 Overview##
This document is structured in three parts:
* **Chapter 1: Introduction.** It provides an overall description of the system scope and purpose, with some information on this document
* **Chapter 2: Overall description.** Provides a general perspective over the principal system features, constraints and assumptions about the users and the environment
* **Chapter 3: Specific requirements.** It focuses in the functional and non-functional requirements.

#Chapter 2#
#Overall description#
##2.1 Product perspective##
###2.1.1 User interfaces###
The system will present itself as a web application, the interface will be intuitive and responsive.
###2.1.2 Hardware interfaces###
The system should use the following hardware interfaces:
* GPS interface to obtain the position of car and logged users
* Car system to obtain the charge level of the battery, whether the engine is ignited, the number of passengers, whether all the doors are closed
###2.1.3 Software interfaces###
* The system will run on any web server that supports Java and stores its data in a RDBMS.
##2.2 Product functions##
The system allows:
* The users to:
	* Sign up
	* Login
	* View near available cars
	* View all the non expired reservation
	* Make a reservation
	* Unlock a car previously reserved
* The employee to:
	* Login
	* View the status of all the cars
	* Manage geographical regions
	* Manage safe areas
##2.3 User characteristics##
The two types of people that will use the system are employee and users, both of them have access to Internet, and both can use a browser.
##2.4 Constraints##
###2.4.1 Regulatory policies###
The users are responsable of the information inserted and for any unlawful behaviour.
The system must ask the user permission for processing and storing personal data.
###2.4.2 Hardware limitations###
The system has to run under the following worst-case conditions:
* 1 Mb/s Internet connection
* Viewport size of 320x480 pixels
###2.4.3 Reliability requirements###
The system must have a minimum availability of 99%.
###2.4.4 Criticality of the application###
The system is not used in life-critical applications.
###2.4.5 Safety and security considerations###
The user payment information, the driving licence number and their location must be kept private.
The location of in use car must be visible only to the employee.
##2.5 Assumptions and dependencies##
###Domain assumptions.md###
##2.6 Future extensions##
The system will be implemented foreseeing the possibility of further extensions. An incomplete and facultive list is below:
* Allow a user to modify the data sent during sign up
* Allow a user to unregister from the system
* Programmatically assign an in maintenance car to an employee
#Chapter 3#
#Specific requirements#
##3.1 External interface requirements##
###3.1.1 User interfaces###
The user interfaces must satisfy the following constraints:
* Web pages must comply with the W3C and Ecma International standards. In particular to the HTML5, CSS and ECMA-262 specification.
* The first screen must ask the user to login or to sign up in order to begin operations.
* There must be a menu which lists any functionality allowed for the user so that the user is more efficient
* The menu must be visible in any view
* There must be a breadcrumb to improve user navigation throughout the web application
* The compilation of input fields must be done with suitable controls to simplify user's interactions
* Web pages must be responsive
###3.1.2 Hardware interfaces###
The system should use the following hardware interfaces:
* GPS interface to obtain the position of car and logged users
* Car system to obtain the charge level of the battery, whether the engine is ignited, the number of passengers, whether all the doors are closed
###3.1.3 Software interfaces###
The system requires:
* MySQL 5.7
* Java EE7
###3.1.4 Communications interfaces###
Users and employees communicate with the system via HTTPS channel.
##3.2 System features##
###Requirements,Scenario, use cases, etc... as sublist###
##3.3 Performance requirements##
###Da inventare###
##3.4 Software system attributes##
###3.4.1 Reliability###
###Da inventare###
###3.4.2 Availability###
The system must guarantee an availability of 99%.
###3.4.3 Security###
* All the communications between server and clients must be protected by using TLS protocol.
* All attempts of establishing an unsecure communication with the server must be refused.
* Users' passwords must be stored using a one way function
###3.4.4 Maintainability###
All the code must be documented using JavaDoc so that other developers can easily understand the code and edit it.
The system must provide a logging functionality for debug purpose.
###3.4.5 Portability###
The web application being written in Java, will be portable to any OS able to run the JVM and java class files with major version 51.
The interface with the employees and the users must be compatible with the last two years version of the major browsers that are Android Browser, Chrome, Chrome for Android, Edge, Firefox, Firefox for Android, IE Mobile, Internet Explorer, Safari, iOS Safari.
##3.5 Alloy##
##alloy.als##