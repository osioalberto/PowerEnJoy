# TODOS
* Give a name to the SYSTEM
* Fix use case diagram to be coherent
---
### Use cases
#### Registration
##### Actors
* User
* Service provider ___(MISSING IN DIAGRAM)___
* External system for driving licence validation
* External system for credit card parameters validation
##### Entry condition
* User is not registered to SYSTEM
##### Flow of events
* The user activates the _sign up_ function on his terminal. SYSTEM responds by presenting him a form.
* The user fills the form, inserting his complete name, birth date, driving licence number, credit card number and CVV, along with a username and a password. Once the form is completed, the user submits it.
* SYSTEM validates the inserted data, and in particular queries external systems for driving licence number and credit card informations validation (___MISSING IN USE CASE DIAGRAM___). If all is correct, then SYSTEM stores the new user data
##### Exit conditions
* User is registered and can log in to the system
* User is not banned
##### Exceptions
* Information submitted to SYSTEM by the user is not complete or wrong. In this case, user is notified of the error(s) and registration procedure fails.
* External service for driving licence validation is unavailable. In this case user and service provider are notified of the unavailability of the external service.
* * External service for credit card information validation is unavailable. In this case user and service provider are notified of the unavailability of the external service.

#### Login
##### Actors
* User
##### Entry condition
* The user is registered to the system
##### Flow of events
* The user activates the _sign in_ function on his terminal. SYSTEM responds by presenting him a form.
* The user fills the form, inserting the username and password he had chosen at registration time, and then submits it.
* SYSTEM validates the credentials.
##### Exit condition
* User is logged in to the system and, if he's not banned, he can search for cars, else he can ask SYSTEM to try again to perform pending bill payment.
##### Exceptions
* Username or password are wrong. In this case, user is notified of the error and he is not logged in.

#### Car search ___maybe split in two use cases?___
##### Actors
* User
##### Entry conditions
* User is logged in to the system
* User is not banned
##### Flow of events
* The user activates the _search a car_ function on his terminal. SYSTEM responds by presenting him a form.
* User chooses whether to search for cars near his current position or near a target address, and fills the form entering the radius of the search and, if he has chosen to search by address, the target address, then he submits the form.
* If search by address was chosen, __address translation into geographical coordinates__ use case is called
* SYSTEM queries the list of cars searching for available cars that fit user parameters (search center expressed by its geographical coordinates and search radius)
##### Exit condition
* If any car is found, __view car list__ use case is initiated
##### Exceptions
* If no car is found, the user is notified of the unavailability of cars
* If address cannot be translated into geographical coordinates, user is notified of the impossibility to perform the search

#### Address translation into geographical coordinates
##### Actors
* External system for address translation
* Service provider
##### Entry condition
* SYSTEM is processing an address-based search
##### Flow of events
* SYSTEM queries the external service with the address to translate
* The external service responds with the geographical coordinates of the address
##### Exit condition
* Address is translated into geographical coordinates
##### Exceptions
* External service is not available. In this case the service provider is notified of the unavailability of the external service.

#### View car list ___SWAP ARROW include -> extend___
##### Actors
* User
##### Entry conditions
* User is logged in
* User is not banned
* User has started a car search
* Some cars were found by that search
##### Flow of events
* SYSTEM sends to the user's terminal a list of the available cars, each one charcterized by its unique identification number\, its position (expressed by its geographical coordinates) and its battery level
* The user terminal builds a map in which car positions are highlighted with a pin reporting the car identification number and a list of all cars reporting, for each car, identification number, position (expressed by its geographical coordinates) and battery level
##### Exit condition
* The user is allowed to select a car for reservation

#### Car reservation
##### Actors
* User
##### Entry conditions
* User is logged in
* User is not banned
* User has issued a car search and results have been presented on his terminal
##### Flow of events
* User activates the _reserve car_ function on his terminal. A request carring as its payload the unique identification number of the selected car is sent to SYSTEM.
* SYSTEM checks that the car is actually available
* SYSTEM checks that the user has no reservation for other cars belonging to the region to which the selected car belongs
* SYSTEM reserves the target car for the user
* User is notified of the result of the operation
##### Exit conditions
* Car requested by the user is reserved
* The reservor user of the selected car is the user who issued the request
##### Exceptions
* If car is not available, SYSTEM notifies the user of the error. The user can then select another car.
* If the user has already a reserved car in the same geographical region, SYSTEM notifies the user of the error. The user can select another car.
##### Special requirements
* SYSTEM checks and car reservation must be performed as a unique atomic sequence.




