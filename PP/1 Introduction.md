#Introduction
##Purpose and Scope
This is the Project Planning Document for the PowerEnJoy car sharing system. This document has to be read after the Requirements Analysis and Specification Document and the Design Document. It's aim is to provide a (retrospective) analysis of the project complexity, size and effort, and an overview of the steps leading to the realization of the system. This document is intended to be read by the stakeholders, that can find here information about complexity and time required by the project and about risks, and by core development and design team, that can find informations about the activity assigned to them and their schedule.

##Definitions, acronyms and abbreviations
* **System**: the system to be developed for PowerEnJoy
* **User**: a generic person interacting with the system
* **Employee**: a person who works for PowerEnJoy
* **Actor**: can refer to both users and employees
* **Car**: an electric vehicle owned by the company
* **Bill**: an amount of money a user has to pay. It is related to only a single ride
* **Pending bill**: a bill that the user has not paid yet
* **Paid bill**: a bill that the user has already paid for
* **Area**: a space delimited by a polygonal line whose vertices are a set of geographical coordinates
* **Geographical coordinates**: a tuple of latitute and longitude describing a location on Earth
* **Geographical region**: an area where a user can reserve at most one car. They do not overlap
* **Safe area**: an area where it is possible to park a car and optionally to recharge it, in order to make it available for another user
* **Safe parking area**: a special safe area where it is not possible to recharge the car
* **Recharging station area**: a special safe area where it is possible to plug the car for recharging its battery
* **Registered user**: a user who has completed the sign up process
* **Logged user**: a user who has completed the log in process and has not yet started the log out process
* **Banned user**: a registered user who cannot reserve a car until all his pending bills are estinguished
* **Reservor user**: the user who has made a reservation for the specific car. A user is considered the reservor user of a car until the reservation expires or the user is charged with the bill
* **Available car**: a locked car for which no reservation exists
* **Reserved car**: a locked car for which it exists a user who has reserved it
* **Becoming available car**: an unlocked car is said to be "becoming available" as soon as all the passengers and the driver of this car exits the car, the doors of the car are closed and it is parked in a safe area
* **In maintenance car**: a locked car is said to be "in maintenance" as soon as its battery level is below 20%, the car cannot be reserved
* **In use car**: an unlocked car which is not becoming available
* **GPS**: A system capable of providing the location of a receiver device with a good precision (5 meters)
* **Overlapping areas**: Two areas are said to be overlapping if there exists at least one geographical coordinates which is contained inside the two areas
* **Expiration of a car reservation**: when a reservation expires, the car becomes available again, the reservor user loses his reservation and he is charged a fee of 1€
* **Percentage delta**: a discount or a raise based on percentage
* **Applying a raise** or **a discount**: The operation of increasing or reducing the amount of a bill for a specific reason. The amount is computed just before the system charges the user of a bill, and then all those amounts (each one related to a specific reason) are algebraically added to the same bill.
* **RASD**: Requirements Analysis and Specification Document
* **DD**: Design Document
* **ITPD**: Integration Test Plan Document
* **DBMS**: DataBase Management System
* **COTS**: Commercial Off The Shelf
* **OWASP**: Open Web Application Security Project [https://www.owasp.org/](https://www.owasp.org/)
* **XSS**: Cross-site Scripting
* **CSRF**: Cross-site Request Forgery
* **FPs**: Function Points

##Reference documents
* Project rules of the Software Engineering 2 project
* Template for the Design Document
* Requirement Analysis and Specification Document (previous deliverable)
* Design Document (previous deliverable)
* Function Point definition and calculation [http://www.functionpointmodeler.com/](http://www.functionpointmodeler.com/)
* Function Point constants for estimating SLOC [http://www.qsm.com/resources/function-point-languages-table](http://www.qsm.com/resources/function-point-languages-table)
* COCOMO II specification [http://csse.usc.edu/csse/research/COCOMOII/cocomo2000.0/CII_modelman2000.0.pdf](http://csse.usc.edu/csse/research/COCOMOII/cocomo2000.0/CII_modelman2000.0.pdf)

##Document structure
In the first section of this document we are going to provide first an estimation of the size of the project using Function Points, and right after an estimation of the required effort calculated applying COCOMO II.  
In the second and third sections we are going to provided a detailed schedule of the project and to allocate all the defined activities to out team members.  
In the last section we are goign to carry out a risk analysis for the project and to elaborate a mitigation strategy for each of the risks presented.