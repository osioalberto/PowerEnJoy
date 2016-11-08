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

#### Manage safe parking areas
##### Actors
* PowerEnJoy employee
##### Entry conditions
* The employee is logged in with his company credentials
##### Flow of events
* The employee activates the _manage safe parking areas_ function on his terminal. SYSTEM responds with a list of safe parking areas currently known
* If the employee chooses to add a new safe parking area activating the _add safe parking area_ function on his terminal, then the use case __add safe parking area__ is activated
* If the employee chooses to remove a new safe parking area activating the _remove safe parking area_ function on his terminal, then the use case __remove safe parking area__ is activated
##### Exit conditions
* The list of safe parking areas is updated

#### Add safe parking area
##### Actors
* PowerEnJoy employee
##### Entry conditions
* The employee is logged in with his company credentials
* The employee has chosen to add a new safe parking area
##### Flow of events
* SYSTEM shows the employee a form
* The employee fills the form with the parameters of the new safe parking area (including the boundaries of the area), then submits the form
* SYSTEM adds the new safe parking area to the list of known parking areas
##### Exit conditions
* The new safe parking area is added to the list of safe parking areas
##### Exceptions
* If the new parking area overlaps with another parking area, than the request of adding it is rejected

#### Remove safe parking area
##### Actors
* PowerEnJoy employee
##### Entry conditions
* The employee is logged in with his company credentials
* The employee has chosen to remove a safe parking area
##### Flow of events
* The employee chooses which safe parking area has to be deleted
* SYSTEM deletes the safe parking area from the list of known parking areas
##### Exit conditions
* The safe parking area is removed from the list

#### Manage recharging stations
##### Actors
* PowerEnJoy employee
##### Entry conditions
* The employee is logged in with his company credentials
##### Flow of events
* The employee activates the _manage recharging stations_ function on his terminal. SYSTEM responds with a list of recharging stations currently stored in the known
* If the employee chooses to add a new recharging station activating the _add recharging station_ function on his terminal, then the use case __add recharging station__ is activated
* If the employee chooses to remove a recharging station activating the _remove recharging station_ function on his terminal, then the use case __remove recharging station__ is activated
* If the employee chooses to update a recharging station activating the _update recharging station_ function on his terminal, then the use case __update recharging station__ is activated
##### Exit conditions
* The list of recharging stations is updated

#### Add recharging station
##### Actors
* PowerEnJoy employee
##### Entry conditions
* The employee is logged in with his company credentials
* The employee has chosen to add a new recharging station
##### Flow of events
* SYSTEM shows the employee a form
* The employee fills the form with the parameters of the new recharging station (including the boundaries of the area and the number of available plugs), then submits the form
* SYSTEM adds the new recharging station to the list of known recharging stations
##### Exit conditions
* The new recharging station is added to the list
##### Exceptions
* If the new recharging station boundaries overlap with another parking area, than the request of adding it is rejected

#### Remove recharging station
##### Actors
* PowerEnJoy employee
##### Entry conditions
* The employee is logged in with his company credentials
* The employee has chosen to remove a recharging station
##### Flow of events
* The employee chooses which recharging station has to be deleted
* SYSTEM deletes the recharging station from the list of known recharging stations
##### Exit conditions
* The recharging station is removed from the list

#### Update recharging station
##### Actors
* PowerEnJoy employee
##### Entry conditions
* The employee is logged in with his company credentials
* The employee has chosen to remove a recharging station
##### Flow of events
* The employee chooses which recharging station has to be updated
* SYSTEM shows a form in which user can update recharging station parameters (including its boundaries and/or number of plugs), then submits the form
* SYSTEM updates the parameters of the selected recharging station
##### Exit conditions
* The recharging station parameters are updated
##### Exceptions
* If the recharging station boundaries overlap with another parking area, than the request of updating it is rejected

#### Manage geographical regions
##### Actors
* PowerEnJoy employee
##### Entry conditions
* The employee is logged in with his company credentials
##### Flow of events
* The employee activates the _manage geographical regions_ function on his terminal
* SYSTEM sends to the employee's terminal a map showing all the geographical regions
* If the employee chooses to add one more region, than the __add geographical region__ use case is activated
* If the employee selects one region, he can decide to divide it into two regions or to merge it with another region. In the former case __split geographical region__ use case is activated, in the latter __merge geographical regions__ use case is activated
##### Exit conditions
* Geographical regions are updated
* New reservations will be affected by the update
* Reservations that are already inserted are not affected by the update 

#### Add geographical region
##### Actors
* PowerEnJoy employee
##### Entry conditions
* The employee is logged in with his company credentials
* The employee has chosen to add a new geographical region
##### Flow of events
* SYSTEM presents on the employee's terminal a map where actual geographical regions are highlighted
* The employee selects on the map the boundaries of the new geographical area
* The employee confirms his choice
* SYSTEM adds the new region to the list of the geographical regions
##### Exit conditions
* The new region is inserted into the set of geographical regions
##### Exceptions
* If the selected region overlaps with some other geographical region already inserted, then the insertion is rejected

#### Split geographical region
##### Actors
* PowerEnJoy employee
##### Entry conditions
* The employee is logged in with his company credentials
* The employee has selected a region from the ones inserted in the system
* The employee has chosen to split that region
##### Flow of events
* SYSTEM presents on the employee's terminal a map where selected geographical region is highlighted
* The employee draws a line across the region so that the geographical region is divided in two subregions
* The employee confirms his choice
* SYSTEM updates the set of geographical regions removing the old geographical region and adding the two subregions
##### Exit conditions
* The geographical region selected by the employee is now split into two subregions

####  Merge geographical regions
##### Actors
* PowerEnJoy employee
##### Entry conditions
* The employee is logged in with his company credentials
* The employee has selected a region from the ones inserted in the system
* The employee has chosen to merge that region with another region
##### Flow of events
* SYSTEM presents on the employee's terminal a map where geographical regions adjoining the selected one are highlighted
* The employee selects one of the highlighted geographical regions
* The employee confirms his choice
* SYSTEM updates the set of geographical regions removing the two selected geographical regions and adding one geographical region which is the result of the union of the two deleted geographical regions
##### Exit conditions
* The geographical regionsselected by the employee are now merged into a single region