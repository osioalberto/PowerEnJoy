## Software Engineering 2: PowerEnJoy {.book-no-toc}
# Requirements Analysis and Specification Document {.book-no-toc}
###Nardo Loris, Osio Alberto {.book-no-toc}
####Politecnico di Milano {.book-no-toc}

@TOC@

# Introduction
## Purpose
This document is the Requirement Analysis and Specification Document for
the PowerEnjoy system. Its aim is to completely describe the system,
its components, functional and non-functional requirements, constraints, and
relationships with the external world, and to provide typical use cases and
scenarios for all the users involved.

## Scope
The system is an electrical car sharing management system.
Its main goal is to provide easy access to the service for the end user and to incetivize virtuous behaviours of the same users.
The system consists in a web application addressed to two types of users:

* PowerEnjoy employee (Employee)
* Generic people (User)

The system allows non registered users to sign up and registered users to login with their credentials.
The system must know the location of each car and logged in user.
Registered users are allowed to reserve a single car in each geographic area at most one hour before picking it up. When a user is near a car he has reserved, if reservation has not expired, he asks for unlocking it, gets in and ignites the engine, starting a ride. A ride ends when the car is parked in a safe area and all the people inside it have got off. If reservation expires, user will no longer be able to pick the reserved car. Moreover, user will be charged with a fee.

The system allows the employee to manage safe areas and geographical regions to improve the overall offered service. Employees are also allowed to monitor the status of the car, so that when a car has a low battery charge an employee can move the car to a recharging station and plug the car or go and recharge the car on site.

@INCLUDE RASD - Glossary.md@

@INCLUDE RASD - Goals.md@

## References
This document refers to the rules of the Software Engineering 2 project and to the RASD Assignment.

## Overview
This document is structured in three parts:

* **Chapter 1: Introduction** It provides an overall description of the system scope and purpose, with some information about this document
* **Chapter 2: Overall description** It provides a general perspective over the main system features, constraints and assumptions about the users and the environment
* **Chapter 3: Specific requirements** It focuses in the functional and non-functional requirements.

# Overall description
## Product perspective
### User interfaces
The system will present itself as a web application, the interface will be intuitive and responsive.
### Hardware interfaces
The system should use the following hardware interfaces:

* GPS interface to obtain the position of car and logged users
* Car monitoring system to obtain the charge level of the battery, whether the engine is ignited, the number of passengers, whether all the doors are closed.

### Software interfaces
* The system will run on any web server that supports Java Enterprise Edition and stores its data in a RDBMS.

## Product functions
The system allows:

* The users to:
	* Sign up
	* Login
	* Logout
	* Search nearby available cars
	* Search available cars nearby a specific address
	* View all the non-expired reservations
	* Make a reservation
	* Unlock a car previously reserved
* The employee to:
	* Login
	* Logout
	* View the status of all the cars
	* Manage geographical regions
	* Manage safe areas

## User characteristics
The system has two classes of users: PowerEnJoy employees and end user of shared cars. All of them have access to the Internet, and can use a browser.
## Constraints
### Regulatory policies
The users are responsable of the information provided and for any unlawful behaviour.
The system must ask the user permission for acquiring, processing and storing personal data.
### Hardware limitations
The system has to run under the following worst-case conditions:

* 1 Mb/s Internet connection
* Viewport size of 320x480 pixels

### Interfaces to other applications
* External system for driving licence validation
   The interaction with external system for driving licence validation is carried out over HTTPS requests
   
* External system for address translation
   The interaction with external system for address translation is carried out over HTTPS protocol
   
* External system for payments processing
   The interaction with external system for payments processing is carried out over a SOAP API offered by the same service

### Reliability requirements
The system must have a minimum availability of 99%.
### Criticality of the application
The system is not used in life-critical applications.
### Safety and security considerations
* The user's payment information and driving licence number and their location must be kept private.
* The position of in use cars must be visible only to the employee.

## Assumptions and dependencies

@INCLUDE RASD - Domain Assumptions.md@

## Future extensions
The system will be implemented foreseeing the possibility of further extensions. An incomplete list of possible extensions is below:

* Allow a user to modify the data sent during sign up
* Allow a user to unregister from the system
* Programmatically assign in maintenance cars to employees
* Provide the users with a money saving option, letting them input their destination and providing informations about where to leave the car, as to provide a better distribution of cars.
* Keep track of virtuous behaviours of the users, in order to provide the most virtuous users with further discounts.

# Specific requirements
## External interface requirements
### User interfaces ###
The user interfaces must satisfy the following constraints:

* Web pages must comply with the W3C and ECMA International standards. In particular to the HTML5, CSS and ECMA-262 specification.
* The first screen must ask the user to login or to sign up in order to begin operations.
* There must be a menu which lists any functionality available for the user, in order to make the usage of the application simpler
* The menu must be visible in any page
* The user interface must provide breadcrumbs navigation
* The compilation of input fields must be done with suitable controls to simplify user's interactions
* Web pages must be responsive

### Hardware interfaces
The system should use the following hardware interfaces:

* GPS interface to obtain the position of car and logged users
* Car monitoring system to obtain the charge level of the battery, whether the engine is ignited, the number of passengers, whether all the doors are closed

### Software interfaces
The system requires:

* MySQL 5.7
* Java EE7

### Communications interfaces
Users and employees communicate with the system via HTTPS connection.
## System features ##

@INCLUDE RASD - Scenarios.md@

### Detailed use case description
<img src="diagrams/UseCase.svg" alt="" />

@INCLUDE RASD - Use Case Description.md@

@INCLUDE RASD - Diagrams.md@

@INCLUDE RASD - Mockups.md@

@INCLUDE RASD - Requirements.md@

## Performance requirements
1. There is no limit to the number of registered users
2. All of the requests must be processed 10 seconds. The majority of them (>90%) must be processed in less than 5 seconds.
3. The system must be able to manage more than 100 simultaneos connections from users
4. The system must be able to handle all the connections with the cars in the same time. Signals coming from cars must be processed in less than 1 second, in order to grant a fluid interaction experience to the users when interacting with the cars.

## Software system attributes
### Reliability
System is designed to run on a single server. A backup server is also present, in order to take place of main server in case of failure. This is done to prevent service unavailability and to ensure that reserved cars can be effectively picked up by users.
### Availability
The system must guarantee an availability of 99%.
### Security
* All the communications between server and clients must be protected by using TLS protocol.
* All attempts of establishing an unsecure communication with the server must be refused.
* Users' passwords must be stored using a one way function
* Users' payment informations and driving licence number must be stored in a private location

### Maintainability
All the code must be documented using JavaDoc so that other developers can easily understand and edit it.
The system must provide a logging functionality for debug purpose.
### Portability
The web application being written in Java, will be portable to any OS able to run the JVM and Java class files with major version 51.
The interface with the employees and the users must be compatible with the last two years version of the major browsers that are Android Browser, Chrome, Chrome for Android, Edge, Firefox, Firefox for Android, IE Mobile, Internet Explorer, Safari, iOS Safari.

@INCLUDE RASD - Alloy.md@

# Appendix
## Effort spent

* Nardo Loris: 42 hours
* Osio Alberto: 38 hours

## Software and tools used
* Github (https://github.com) for version control
* Alloy (http://http://alloy.mit.edu/alloy/) for model verification
* StarUML (http://staruml.io/) for UML diagrams (except use case diagram)
* Signavio (http://www.signavio.com/) for use case diagrams
* Sublime Text Editor (https://www.sublimetext.com/) for alloy syntax highlighting



# Version history
| Version | Description                                      |
|---------|--------------------------------------------------|
| 1.0     | Initial release                                  |
! 1.1     | * Revised pagination style                       |
|         | * Fixed small error in Alloy model               |
|         | * Fixed some typos in the document               |
|         | * Added brief descriptions on mockups            |
|         | * Added time as an actor on the use case diagram !
