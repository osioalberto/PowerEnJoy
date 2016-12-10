# Introduction
## Purpose
This is the Design Document for the PowerEnJoy system. Its aim is to completely describe the logical and physical architecture of the system, along with some guidelines for most critical algorithms and some dynamic views of the system. This document will present content using mainly UML standards, along with textual descriptions.This document does not include mock ups of the application, as they were already included in the Requirements Analysis and Specification Document.
This document is written for project managers, developers, testers, and Quality Assurance people.

## Scope
The system is an electrical car sharing management system. Its main goal is to provide easy access to the service for the end user and to incetivize virtuous behaviours of the same users.

The system addresses to two types of users:

* PowerEnjoy employee (Employee)
* Generic people (User)

Users must be allowed to reserve and use cars, employees must be allowed to manage the parameters of the service (geographical regions and safe areas).

This document is written in the context defined in the RASD, and aims at mapping requirements defined in the same RASD on software components which are to be deployed on real machines. Components must be designed as to have the highest possible cohesion and the lowest possible coupling, so they must encapsulate a single functionality. This also leads to high reusability of the same modules.

Design patterns and architectural styles will be used for solving architectural problems in order to achieve good performances of the system and to build a highly maintanable and modular system.

## Definitions, acronyms and abbreviations
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

## Reference Documents
1. Project rules of the Software Engineering 2 project
2. Template for the Design Document
3. Requirement Analysis and Specification Document (previous deliverable)

## Document structure
The document is organized in six sections:

1. **Introduction**: describes the overall structure of the whole document
2. **Architectural design**: describes both the logical architecture and the deployment of the system, along with some dynamical views of the presented components
3. **Algorithm design**: describes some guidelines for the implementation of the most critical algorithms
4. **User interface design**: describes a UX model for the user interface (both for users and employees)
5. **Requirements traceability**: presents a mapping of functional and non functional requirements on described components and architectural decisions
6. **Appendix**: contains informations about the effort spent in writing this document and about the references from which further documentation can be obtained.