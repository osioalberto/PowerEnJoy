#Introduction
##Revision history

Version | Author                     | Description
--------| -------------------------- | -----------------------------
1.0     | Nardo Loris - Osio Alberto | Initial release

##Purpose and scope
This document describes the integration test plan for the PowerEnJoy car sharing management system. It aims at providing a detailed and exhaustive description of the steps involved in integration testing, along with entry condition and a description of test data.

Integration test is a very important activity as it aims at checking the communication between components, and in particular with components not actually developed by our company, as to verify that all the services implemented inside the various components actually fulfill the functional and non functional requirements.

This document is intended to be read mainly by developers and quality assurance team. In general, this document is to be read in the context described by the _Requirements Analysis and Specification Document_ and by the _Design Document_ written for this project.

##Document structure
The content of this document is mainly organized in four sections:

* __Integration strategy__ chapter provides detailed informations about the starting conditions required to begin integration testing, the approach chosen for integration, the components to be integrated and the integration sequence
* __Individual steps and test description__ chapter provides informations about the tests to be performed in the different integration steps
* __Tools and test equipment__ chapter deals with the tools that is planned to use in order to implement and run tests over the (partially) built system
* __Program stubs and test data required__ chapter deals with the structure of the scaffolding to be developed in order to build a meaningful test environment

##Acronyms, abbreviations and definitions
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
* **DBMS**: DataBase Management System
* **COTS**: Commercial Off The Shelf

##Reference documents
* The project description document
* Requirement Analysis and Specification Document for PowerEnJoy car sharing system
* Design Document for PowerEnJoy car sharing system
* The Integration Test Plan Example document
* Testing tools  
  * Mock server: [http://www.mock-server.com](http://www.mock-server.com)
  * JUnit: [http://junit.org/junit4](http://junit.org/junit4)
  * Arquillian: [http://arquillian.org](http://arquillian.org)
