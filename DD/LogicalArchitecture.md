#Architectural design

## Overview

![Alt Global Component Diagram](http://localhost/powerenjoy/DD/images/compdiag.png "Global Component Diagram")

The picture shows a representation of the proposed logical architecture. The system is composed of five main components:

* A _DataBase Management System (DBMS)_ used to access data related to cars, reservations, payments, geographical regions and safe areas in a reliable and efficient way
* A _Server_ component that implements the application logic both for user-related and employee related features
* A _User Application_ component, that takes care of user-related functionalities, making them available to the same users
* A _Employee Application_ component, that takes care of employee-related functionalities, making them available to the employees
* A _Car Monitoring System_ which models the monitoring system actually installed on cars

We have different kinds of architectural styles used to interface the different components with the server

* _Server_ and _User Application_ interaction is implemented using a _client - server_ architecture, because the interaction of final users with the system can be seen as a sequence of requests and responses where the user invokes a service from the server, and the server actually carries out operations according to user's input.
* _Server_ and _Employee Application_ interaction is implemented again as a _client - server_ architecture, for the very same reasons of the interaction between _Server_ and _User Application_
* _Server_ and _Car Monitoring System_ interaction is implemented as a event - driven architecture, because of two main reasons:
  + Monitoring system collects data about the car status, and sends them to the server without waiting for a server response, it justs _"sends and forgets"_
  + Different objects of the server might want to react to events coming from cars (for example, a ride should be notified when a passenger enters or exits the car).
* _Server_ and _DBMS_ interaction is based on the standard interface provided by the SQL language

## Component view
![Alt Server Component Diagram](http://localhost/powerenjoy/DD/images/servcomp.png "Server component  diagram")

The picture shows the logical architecture for the _Server_ component. The architecture is made up of several different components, each one devoted to a specific task:

* __Router__ component dispatches all the requests coming from the _User Application_ and _Employee application_ to the business component that can handle it. It multiplexes the parts of the interfaces of the different business components in two "virtual" interfaces, the former dedicated to user interaction, the latter to employee interaction.
* __Monitoring controller__ represents the broker of the event-driven architectural style used to collect data from cars
* __Car controller__ controls the state of each car and to trigger transitions between car states according to the state chart defined in the Requirements Analysis and Specification Document.
* __Bill controller__ handles tasks related to the storage of pending bills and to the interaction with the external system for payments processing
* __User controller__ controls the state of each user according to the state chart defined in the RASD. In particular, it provides all the functionalities needed for authenticating users and employees.
* __Geographical areas controller__ provides an API that can be used to retrive and manipulate data related to geographical areas boundaries
* __Safe areas controller__ provides an API with methods used to retrive and manipulate data about safe areas (both safe parking areas and recharging stations)
* __Reservations controller__ provides the functionalites needed for creating and canceling a reservation and for "using" a reservation to actually take the reserved car
* __Ride controller__ controls each ride in progress in the given instant of time, monitors the state of the car during the ride (in particular, the number of passengers and the battery level) and computes the bill at the end of the ride, applying proper discounts or raises on the calculated fee.

##Deployment view
***TODO***

##Runtime view
This section describes several interesting dynamic behaviours of the system.

###Login
![Alt Login Sequence Diagram](http://localhost/powerenjoy/DD/images/seq_login.svg "Login Sequence Diagram")
This diagram describes the interaction between the components involved in user login. The "actor" lifeline models the human actor (both employee and final user) trying to login to the system.

###Car reservation
![Alt Reservation Sequence Diagram](http://localhost/powerenjoy/DD/images/seq_reserve.svg "Reservation Sequence Diagram")
This diagram describes the interaction between the components involved in the reservation of a car. The "user" lifeline models a human user trying to reserve a car. Error conditions are modeled as _break_ frames

###Car unlock
![Alt Unlock Sequence Diagram](http://localhost/powerenjoy/DD/images/seq_unlock.svg "Unlock Sequence Diagram")
This diagram describes the interaction between components involved in the procedure of unlocking a car. The "user" lifeline models the human user trying to unlock a car. The procedures searches for a reservation which maps to a car that is very near to the user (this is the meaning of the "getNearestReservation" message), and then sends to the car a *unlock car* event throw the event-driven monitoring system connection (invoked by the car controller). During the procedure a new ride entity is created to model the incipent ride. For details about the creation of this ride entity refer to the next sequence diagram.

###Ride entity creation and ride start
![Alt Init Ride Sequence Diagram](http://localhost/powerenjoy/DD/images/seq_rideinit.svg "Init Ride Sequence Diagram")
This diagram shows the interaction between components involved in the creation of a new ride entity and in the starting procedure of that same ride. No human actor appears here, just because this is an interaction that is fully carried out inside the *server* component. The first part of the diagram is aimed at specifying the steps involved in the entity creation and consequent subscription to events sent by the car. The second part specifies the interaction aimed at handling the event relative to the engine ignition (and, as of the RASD, to the ride start).

###Ride conclusion and bill computation
![Alt Ride End Sequence Diagram](http://localhost/powerenjoy/DD/images/seq_rideend.svg "Ride End Sequence Diagram")
This diagram shows the interaction between components involved in the conclusion of a ride. The interaction is triggered by an event sent from the car, that signals that all passengers have got off the car. The *ride* entity models the ride that is listening on that event, and that will end. At ride end, a new bill is created and charged to the user whom the ride is referred to, and then the ride unsubscribes from the events sent by the car, as they are of no interest anymore.

###Insertion of a new safe area
![Alt Employee Sequence Diagram](http://localhost/powerenjoy/DD/images/seq_employee.svg "Employee Sequence Diagram")
This diagram shows the interaction between components involved in the insertion of a new safe area. It can be seen as a general model for all the interaction involving an employee, as all of them follow the same message pattern (adapted to the operation being carried out).

##Component interfaces
*** RESTful APIs ***

##Selected architectural styles and patterns
*** TODO ***

##Other design decisions
*** TODO J2EE ***