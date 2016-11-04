# TODOS
* Give a name to the SYSTEM
* In use case "registration", there is a incoherence with requirements - need fixup
---
### Use cases
#### Registration
##### Actors
* User
* External system for driving licence validation
* External system for credit card parameters validation
##### Entry condition
* User is not registered to SYSTEM
##### Flow of events
* The user activates the _sign up_ function on his terminal. SYSTEM responds by presenting him a form.
* The user fills the form, inserting his complete name, birth date, driving licence number, credit card number and CVV, along with a username and a password. Once the form is completed, the user submits it.
* SYSTEM validates the inserted data, and in particular queries external systems for driving licence number and credit card informations validation (___MISSING IN REQUIREMENTS___). If all is correct, then SYSTEM stores the new user data
##### Exit conditions
* User is registered and can log in to the system
* User is not banned
##### Exceptions
* Information submitted to SYSTEM by the user is not complete or wrong. In this case, user is notified of the error(s) and registration procedure fails.
* External service for driving licence validation or external service for credit card information validation are unavailable. In this case user is notified of the unavailability of the registration service.

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

#### Car search
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
* * SYSTEM responds to the user's terminal with a list of the available cars, each one charcterized by its unique identification number, its position (expressed by its geographical coordinates) and its battery level
* The user terminal builds a map in which car positions are highlighted with a pin reporting the car identification number and a list of all cars reporting, for each car, identification number, position (expressed by its geographical coordinates) and battery level
##### Exit condition
* The user has received a list of all cars that fit its search parameters
##### Exceptions
* If no car is found, the user is notified of the unavailability of cars
* If address cannot be translated into geographical coordinates, user is notified of the impossibility to perform the search

#### Address translation into geographical coordinates
##### Actors
* External system for address translation
##### Entry condition
* SYSTEM is processing an address-based search
##### Flow of events
* SYSTEM queries the external service with the address to translate
* The external service responds with the geographical coordinates of the address
##### Exit condition
* Address is translated into geographical coordinates
##### Exceptions
* External service is not available. In this case the caller is notified of the unavailability of the service.


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


#### Reservation expiration
##### Actors
* User
* External system for payment processing
##### Entry condition
* User has reserved a car
* Since reservation time, a time of one hour has elapsed
##### Flow of events
* SYSTEM cancels the reservation of the car for the user (the car is marked as available)
* SYSTEM charges the user with a fee of 1€
* SYSTEM invokes the ___payment___ use case in order to actually perform the payment
* External system for payments processing answers whether the payment attemp was successful or not
##### Exit condition
* User is able to reserve other cars
##### Exceptions
* If payment is not successful, user is marked as "banned" and he is notified of the error
* If external system is not available, user is marked as "banned" and he is notified of the error


#### Ride
##### Actors
* User
* Other people not necessarly registered to SYSTEM (referred to as passengers)
##### Initial condition
* User is logged in
* User is the reservor user for a car
##### Flow of events
* User reaches the reserved car and activates the _unlock car_ function on his terminal
* SYSTEM checks the position of the user, and, if the user is near the car, SYSTEM unlocks it.
* User enters the car. If there are some passengers, they enter the car too.
* User ignites the engine. The car signals to SYSTEM that the engine was ignited.
* SYSTEM creates an empty bill for the user.
##### Exit conditions
* The user can actually drive the car he had reserved.
* SYSTEM charges him with a per minute fee.
* Car communicates with SYSTEM in order to signal passengers entering or exiting the car, or that the ride is ended

#### Ride conclusion
##### Actors
* User
##### Entry condition
* The car reserved by the user has been parked in a safe area
##### Flow of events
* The car signals to SYSTEM that all passengers have got off
* SYSTEM locks the car
* SYSTEM closes the bill associated to the ride
* SYSTEM detects whether the car is parked in a safe parking area or in a recharging station. It the car is parked in a recharging station, SYSTEM waits for 5 minutes
* SYSTEM invokes the ___additional fees/discounts computation___ use case
* SYSTEM marks the car as "available"
* SYSTEM charges the bill to the user
* SYSTEM invokes the ___payment___ use case
##### Exit condition
* User is able to reserve other cars
* The car is available for another reservation
##### Exceptions
* If the payment is not successful (that is, it is rejected, for example because user has no money on the credit card), user is marked as "banned" and he is notified of the error
* If the payment could not be performed (for example, because the external system is not available), user is marked as "banned" and he is notified of the error

#### Additional fees/discounts computation
##### Actors
_No other actor than SYSTEM is involved_
##### Entry condition
* SYSTEM is processing the bill associated to a ride
##### Flow of events
* SYSTEM asks the car to send information about its battery level, its actual position and whether or not it is plugged to a power source
* The car sends required information to SYSTEM
* SYSTEM computes percentage fees or discounts on the final amount of the bill, accorring to these rules
    - -10% if for all the duration of the ride, SYSTEM detected that 3 or more people (including the driver) were con the car
    - -20% if residual battery level is greater or equal to 50% of full charge level
    - -30% if the car is actually plugged to a power source
    - +30% if battery level is less then 20% of full charge level
    - +30% if the car is parked more than 3km far from the nearest recharging station
* SYSTEM algebraically adds the computed amounts to the amount of the bill associated to the ride under consideration
##### Exit condition
* The user bill includes additional fees and discounts contribution


#### Payment
##### Actors
* External system for payments processing
* _(User is not directly involved, SYSTEM eventually changes his status, but he actually does nothing)_
##### Entry condition
* There is a pending bill in SYSTEM
##### Flow of events
* SYSTEM requests the external system to actually carry out the payment, sending in the request the amount of the bill and the credit card information of the user whom this bill belongs to
* The external system acknowledges the payment
* If the user bound to this bill was banned and now he has no more pending bills, the user is not anymore considered "banned"
##### Exit condition
* The bill is paid
##### Exceptions
* The payment cannot be carried out. In this case, the external system signals to SYSTEM the error.
* The external system is not available. In this case, SYSTEM stops the procedure and the bill is still marked as "pending"

#### Require payment trial
##### Actors
* User
##### Entry conditions
* User is logged is
* User is banned
* There exists at least one pending payment associated to the user
##### Flow of events
* User activates the _pay pending bills_ function on his terminal. A request is sent to SYSTEM.
* SYSTEM searches all pending payments associated to the user
* For each found payment, SYSTEM activates the ___payment___ use case
* SYSTEM responds to the request acknowledging the completion of the payments
##### Exit conditions
* User is not anymore "banned" and can reserve cars
##### Exceptions
* If a payment fails, SYSTEM notifies the user of the error
* If a payment could not be performed, SYSTEM notifies the user of the error