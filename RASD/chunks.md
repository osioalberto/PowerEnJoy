####TODO Front Page####
###Chapter 1###
###Introduction###
##1.1 Purpose##
This document is the Requirement Analysis and Specification Document for
the PowerEnjoy system. Its aim is to completely describe the system,
its components, functional and non-functional requirements, constraints, and
relationships with the external world, and to provide typical use cases and
scenarios for all the users involved.

##1.2 Scope##
The system is an electrical car sharing management system.
Its main goal is ###TODO???###
The system consists in a server application (back-end) and a web application (front-end).
The system has two types of users:
	PowerEnjoy employee (Employee)
	Generic persons (User)
The system should allow the users to sign up and login with their credentials.
The system must know the location of each car and logged in user.
The system allows a user to reserve a car in each geographical region for at most an hour.
When a user is near his reserved car and asks for an unlock, then the ride will start,
after parking in a safe area the bill is processed.
The system allows the employee to manage safe areas and geographical regions to improve the overall offered service.
The system allows the employee also to monitor the status of the car, so that when a car has a
low battery charge an employee can move the car is a recharging station and plug the car.

##1.3 Goals##
###TODO###

##1.4 Glossary##
###TODO###

##1.5 References##
This document refers to the rules of the Software Engineering 2 prokect and to the RASD assignment.

##1.6 Overview##
This document is structured in three parts:
* **Chapter 1: Introduction.** It provides an overall description of the system scope and purpose, with some information on this document
* **Chapter 2: Overall description.** Provides a general perspective over the principal system features, constraints and assumptions about the users and the environment
* **Chapter 3: Specific requirements.** It focuses in the functional and nonfunctional requirements.

###Chapter 2###
###Overall description###
##2.1 Product perspective##
#2.1.1 User interfaces#
The system will present itself as a web application, the interface will be intuitive and responsive.
#2.1.2 Hardware interfaces#
####TODO####
#2.1.3 Software interfaces#
The web application works on any web server that supports Java.
The back-end stores its data in a RDBMS and can run on every platform that supports Java.
##2.2 Product functions##
TODO
##2.3 User characteristics##
The two types of users are employee and clients (users), both of them have access to Internet, and both can use a browser.
##2.4 Constraints##
#2.4.1 Regulatory policies#
The users are responsable of the information inserted and for any unlawful behaviour.
The system must ask the user permission for processing and storing personal data.
#2.4.2 Hardware limitations#
The system has to run under the following worst-case conditions:
* 1 Mb/s Internet connection
* Viewport size of 320x480 pixels
#2.4.3 Reliability requirements#
The system must have a minimum availability of 99%.
#2.4.4 Criticality of the application#
The system is not used in life-critical applications.
#Safety and security considerations#
The user payment information, the driving licence number and their location must be kept private.
The location of in use car must be visible only to the employee.
##2.5 Assumptions and dependencies##
###TODO###
##2.6 Future extensions##
###TODO###
###Chapter 3###
###Specific requirements###
##3.1 External interface requirements##
#3.1.1 User interfaces#
The user interfaces must satisfy the following constraints:
* Web pages must adhere to the W3C and Ecma International standards. In particular to the HTML5, CSS and ECMA-262 specification.
* The first screen must ask the user to login or to sign up in order to begin operations.
* There must be a menu which lists any functionality allowed for the user so that the user is more efficient
* The menu must be visible in any view
* The compilation of input fields must be done with suitable controls to simplify user's interactions
* Web pages must be responsive
#3.1.2 Hardware interfaces#
###TODO###
#3.1.3 Software interfaces#
The system requires:
* MySQL 5.7
* Java EE7
#3.1.4 Communications interfaces#
The users communicate with the system via HTTPS.
##3.2 System features##
###Scenario, use cases, etc... as sublist###
##3.3 Performance requirements##
###Da inventare###
##3.4 Software system attributes##
#3.4.1 Reliability#
#3.4.2 Availability#
#3.4.3 Security#
#3.4.4 Maintainability#
#3.4.5 Portability#
##3.5 Alloy##