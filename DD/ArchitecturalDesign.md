#Architectural design

## Overview

![Alt Global Component Diagram](http://localhost/powerenjoy/DD/images/compdiag.png "Global Component Diagram")

The picture shows a representation of the proposed logical architecture. The system is composed of five main components:

* A _DataBase Management System (DBMS)_ used to access data related to cars, reservations, payments, geographical regions and safe areas in a reliable and efficient way
* A _Server_ component that implements the application logic both for user-related and employee related features
* A _User Application_ component, that takes care of user-related functionalities, making them available to the same users
* A _Employee Application_ component, that takes care of employee-related functionalities, making them available to the employees
* A _Car Monitoring System_ which models the monitoring system actually installed on cars

Each component is connected only to the _server_ component. In this way it is possibile to keep clearly distinguished three logical levels:

1. The _DBMS_, which represents the _data layer_ of the system
2. The _server_, which represents the _application logic layer_ of the system. It is the only component to interact with the _DBMS_, as to grant data security and privacy.
3. The _user application_ and the _employee application_, which represent the _presentation layer_ of the system. They carry out all the tasks related with interaction with end users (both users of the service and employees). They are connected only with the _server_ as to preserve data security. Moreover, they are modeled as thin clients, as no application logic function is delegated to them. This was chosen for security reasons, as it is very easy to attack functions delegated to a client living in a browser.

The _monitoring system_ actually is part neither of the _presentation layer_ nor of the _application logic layer_, as it represents only a kind of _sensor layer_. By the way, it only interacts with the _server_ component in a event-driven architectural style. 

## DataBase structure
![Alt ER](http://localhost/powerenjoy/DD/images/ER.svg "ER diagram")

## Component view
![Alt Server Component Diagram](http://localhost/powerenjoy/DD/images/servcomp.svg "Server component  diagram")

The picture shows the logical architecture for the _Server_ component. The architecture is made up of several different components, each one devoted to a specific task:

* __Router__ component dispatches all the requests coming from the _User Application_ and _Employee application_ to the business component that can handle it. It multiplexes the parts of the interfaces of the different business components in two "virtual" interfaces, the former dedicated to user interaction, the latter to employee interaction.
* __Monitoring controller__ represents the broker of the event-driven architectural style used to collect data from cars
* __Car controller__ controls the state of each car and triggers transitions between car states according to the state chart defined in the Requirements Analysis and Specification Document.
* __Bill controller__ handles tasks related to the storage of pending bills and to the interaction with the external system for payments processing
* __User controller__ controls the state of each user according to the state chart defined in the RASD. In particular, it provides all the functionalities needed for authenticating users and employees.
* __Geographical areas controller__ provides an API that can be used to retrive and manipulate data related to geographical areas boundaries
* __Safe areas controller__ provides an API with methods used to retrive and manipulate data about safe areas (both safe parking areas and recharging stations)
* __Reservations controller__ provides the functionalites needed for creating and canceling a reservation and for "using" a reservation to actually take the reserved car
* __Ride controller__ controls each ride in progress in the given instant of time, monitors the state of the car during the ride (in particular, the number of passengers and the battery level) and computes the bill at the end of the ride, applying proper discounts or raises on the calculated fee.

##Deployment view
![Alt Deployment Diagram](http://localhost/powerenjoy/DD/images/deploy.svg "Deployment Diagram")
This picture shows how the system should be deployed.
The database server and the application server are deployed on two different physical machines, in order to have more security for data and to achieve a decoupled architecture that can be replicated for reliability reasons. This way we can have a main application server, and a backup application server, that are almost identical as of deployed components. The HTTPS protocol, and the routing IP protocol beside it, are configured so as to send all the request to the main application server, and if that server is not available, to the backup application server. This also gives the possibility to carry out maintenance tasks on the system without bringing it completely down, just working on a server at a time. Finally, the DBMS server is not replicated for the money saving reasons. It is not so likely that an attacker can gain access to the DBMS server, and so there is no need of invest money in a distributed DBMS.

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
This diagram describes the interaction between components involved in the procedure of unlocking a car. The "user" lifeline models the human user trying to unlock a car. The procedures searches for a reservation which maps to the car requested by the user (this is the meaning of the "getReservationForRequestedCar" message), and then sends to the car a *Unlock* event throw the event-driven monitoring system connection (invoked by the car controller). During the procedure a new ride entity is created to model the incipent ride. For details about the creation of this ride entity refer to the next sequence diagram.

###Ride entity creation and ride start
![Alt Init Ride Sequence Diagram](http://localhost/powerenjoy/DD/images/seq_rideinit.svg "Init Ride Sequence Diagram")
This diagram shows the interaction between components involved in the creation of a new ride entity and in the starting procedure of that same ride. No human actor appears here, just because this is an interaction that is fully carried out inside the *server* component. The first part of the diagram is aimed at specifying the steps involved in the entity creation and consequent subscription to events sent by the car. The second part specifies the interaction aimed at handling the event relative to the engine ignition (and, as of the RASD, to the ride start).

###Ride conclusion and bill computation
![Alt Ride End Sequence Diagram](http://localhost/powerenjoy/DD/images/seq_rideend.svg "Ride End Sequence Diagram")
This diagram refers to the situation in which the car is parked in a safe area and not in a recharching station (otherwise, a timeout of 5 minutes should be added before locking the car). This diagram shows the interaction between components involved in the conclusion of a ride. The interaction is triggered by an event sent from the car, that signals that all passengers have got off the car. The *ride* entity models the ride that is listening on that event, and that will end. At ride end, a new bill is created and charged to the user whom the ride is referred to, and then the ride unsubscribes from the events sent by the car, as they are of no interest anymore.

###Insertion of a new safe area
![Alt Employee Sequence Diagram](http://localhost/powerenjoy/DD/images/seq_employee.svg "Employee Sequence Diagram")
This diagram shows the interaction between components involved in the insertion of a new safe area. It can be seen as a general model for all the interaction involving an employee, as all of them follow the same message pattern (adapted to the operation being carried out).

##Component interfaces
There are two different kinds of interfaces: RESTful APIs are used with client-server architectural style, and Messages are used in event-driven interactions

###RESTful APIs
The token mentioned in the /users/{id}/login must be have the following features:

* It must provide an expiration time
* It must univocally identify a user without quering the database
* It must provide the user type (employee, user) without quering the database
* It must be secure and thus it cannot be easily changed or guessed

***INCLUDE***

###Messages
Messages are exchanged using a protocol based on TCP TLS.

####StatusReport####
This message is sent by the car system, to communicate variations of the car status.
It is sent immediatly after the status or the number of passengers change or the batteryLevel drops more than 5% or the batteryLevel reaches its minimum or maximum value,
or every 15 minutes if the batteryLevel changes by less than 5% and nothing else happens in the meantime.
|Field|Type|Description|
|-----|----|-----------|
|batteryLevel|float|The normalized percentage of the battery charge level|
|status|CarStatus|The status of the car|
|passengers|integer|The number of persons that the car has detected inside|
|position|Position|The current position of the car|

####Unlock####
This message is sent by management system to the car system in order to unlock the car.
This message has no parameters

####Lock####
This message is sent by management system to the car system in order to lock the car.
This message has no parameters

##Selected architectural styles and patterns
There are two different architectural styles used to build the architucture of the system:

* __Client - Server__ style is used in the interaction between _user application_ and _employee application_ and the _server_ component. This architectural style supports the request - response pattern, that is the one that mostly fits the way actors interact with the system: they make a request invoking some services provided by the _server_, and the _server_ itself provides a response according to the received request. 
* __Event - driven__ style is used in the interaction between _monitoring system_ built on the cars and the _server_ component. This architectural style was selected due to two main reasons: 

  + _Monitoring system_ collects data about the car status on board, and sends them to the server without waiting for a server response, it justs _"sends and forgets"_
  + Different objects living in the server might want to react to events coming from cars

  Both these can be reliably achieved with a event-driven architectural style

* __RESTful APIs__ 
  
  + RESTful API are implemented using JAX-RS.
  + RESTful APIs are implemented over the HTTPS protocol used in client-server interaction. This was chosen in order to have a clean and neat API, that is easier to understand, extend and mantain.
  + The content could have been formatted using XML or JSON; for this application the two standards provide the same capability but we opted for JSON since it is easier to be used on client side
  + To allow future changes of the API that will be incompatible with the one defined, all the url of the RESTful API are relative to a version qualifier path "v1/"

##Other design decisions
A possible implementation of the shape of an Area was to use a table with the following columns (_areaid_,_order_,latitude,longitude),
but then all the query requesting in which area was a point would have required the scan of the whole table and this was not acceptable, so we opted to use
a column named **polygons** in the entity **Area** of type MULTIPOLYGON (http://dev.mysql.com/doc/refman/5.7/en/gis-class-multipolygon.html) as such it can store any geometrical shape composed of segments, and can also be indexed.
### Framework selection

  Java Enterprise Edition was selected for the implementation of the server components, because we can easily build reliable and scalable application modeling the components as Enterprise Java Beans, and using Java Server Pages for building dynamical user interfaces. Moreover, Java Persistence APIs can be used for the interaction with the DBMS.

### DBMS selection

  MySQL DBMS was selected because it grants good performance along with no licence cost, in order to reduce system total cost.

### Security
  
  * Passwords are not stored in plain text, but are hashed and salted with strong cryptographic functions. 
  * Payments security is granted by the external system for payments processing.
  * Remote communications are carried out using TLS.

### Service providers

#### Maps generation and address translation
The system uses _Google Maps (https://maps.google.com)_ to carry out map rendering and address translation (into geographical coordinates) in a reliable, well-known and well-tested way. Moreover, this can save the huge cost of the implementation of a new system and of the collection of data.

#### Driving licence validation
The system uses _Il portale dell'automobilista (www.ilportaledellautomobilista.it)_ for validating the driving licence numbers. This was the only feasible solution to have access to a updated data source.

#### Payment information validation and payment processing
The system uses _Paypal (www.paypal.com)_ to carry out tasks related to payment processing. _Paypal_ was chosen because it is a very well-known and well-tested platform, which provides a lot of guarantees about payments and that is very used, so the majority of users of the PowerEnJoy system already has a Paypal account. Moreover, it provides a well-defined set of APIs to carry out all the required tasks.