#Requirements traceability
All the decisions written in this document have been taken following functional and non-functional requirements presented in the RASD. Here is a mapping between requirements and design decisions.

## Functional requirements
Functional requirements have been mapped on different components in the overall architecture. Here is a mapping table.

Requirement (RASD)            | Component (DD)                
------------------------------|--------------------------------------
[R1.1]: The system can acquire user information for the registration (name, surname, address, birth date, driving licence number, credit card number and CVV) | User Controller
[R1.2]: The system validates the driving licence number using the external service for driving licence validation | User Controller
[R1.3]: The system validates the payment information using the external service for payment information validation | User Controller
[R1.4]: The system is able to verify that no other registered user exists with the same username or driving licence number or payment information | User Controller
[R1.5]: The system registers this new user only if given information are valid | User Controller
[R2.1]: The system can acquire user information for login (username and password) | User Controller
[R2.2]: System is able to check whether a tuple (username, password) is correct, that is whether that tuple matches the information of a registered user or of an employee or not | User Controller
[R2.3]: The user or the employee logs in if and only if username and password costitute a correct tuple | User Controller
[R3.1]: The system only allows the logged in user who is not banned to insert the search radius | User Application
[R3.2]: The system is capable of finding all available cars within the inserted distance from the user’s position | Car Controller
[R3.3]: The system is able to show to a user a list of cars with their position and battery level | User Application
[R4.1]: The system only allows the logged in user who is not banned to insert the address on which the search area will be centered | User Application
[R4.2]: The system is capable of finding all available cars within a distance range from the geographical coordinate of the address | Car Controller
[R5.1]: The system only allows the logged in user who is not banned to reserve an available car | Reservation Controller
[R5.2]: The system is able to get the geographical region from the car geographical coordinates | Geographical Areas Controller
[R5.3]: The system only reserves a car if the logged in user that requests it has no other reservation for the same geographical area in which the car is located | Reservation Controller
[R6.1]: The system keeps track of the time elapsed since a reservation is made | Reservation Controller
[R6.2]: If the elapsed time is greater than one hour, then the reservation expires | Reservation Controller
[R7.1] The system unlocks a car only if distance between the car and the reservor user is less then 8 meters and the reservor user has requested the unlocking | Reservation Controller
[R8.1] The system can create an empty bill for the reservor user only when the engine is ignited | Ride Controller
[R9.1]: The system knows whether a car is in a safe area or not | Safe Areas Controller
[R9.2]: The system knows the time elapsed since the engine ignition | Ride Controller
[R9.3]: The system updates the reservor user bill according to the elapsed time | Ride Controller
[R10.1] The system knows the reservor user bill | Ride controller
[R12.1]: When a car is becoming available and this car is parked in a recharging station area there is a 5 minute window before the system charges the bill to the reservor user | Ride Controller
[R12.2]: When a car is becoming available and this car is parked in a safe parking area the system charges immediatly the reservor user with the bill | Ride Controller
[R11.1]: When a car is becoming available, if the system detects that this car has had at least two passengers (not including the driver) for all the time of the ride when the engine was ignited, then the system applies a discount of 10% on the bill of the reservor user | Ride Controller
[R11.2]: When a car is becoming available, if its battery level is greater or equal to the 50% of the total battery level, the system applies a discount of 20% on the bill of the reservor user | Ride Controller
[R11.3]: When a car is becoming available, if it is parked in a recharging station area and it is plugged to the power grid, the system applies a discount of 30% on the bill of the reservor user and the 5 minute window terminates | Ride Controller
[R11.4]: When a car is becoming available, if the battery level is less than 20% of the total battery level, the system applies a raise of 30% on the bill of the reservor user | Ride Controller
[R11.5]: When a car is becoming available, if it is left more than 3Km away from the nearest recharging station, the system applies a raise of 30% on the bill of the reservor user | Ride Controller
[R13.1]: The system knows whether a payment attempt was made for the current car | Bill Controller
[R13.2]: The system locks the car and makes it available only if the payment attempt was processed, either if the payment is successful or not | Ride Controller
[R14.1]: The system knows the result of the payment operation | Bill Controller 
[R14.2]: The user is banned only if there exists a pending bill bound to him | User Controller
[R14.3]: The system marks a bill as paid if and only if a payment operation associated to this bill is successful | Bill controller
[R14.4]: A user can ask the system to try again to extinguish his pending bills | User Application
[R14.5]: Only pending bills can be required to be paid | Bill Controller
[R15.1]: The system only allows a logged in user who is not banned to view his reservations | Reservation Controller
[R15.2]: The system is capable of finding all the reservation made by the user | Reservation Controller
[R15.3]: The system is able to show to a user a list of cars with their position, battery level and the expiration time | User Application
[R16.1]: The system only allows a logged in employee to manage geographical regions | Geographical Areas Controller
[R16.2]: The system is able to find all the geographical regions already defined | Geographical Areas Controller
[R16.3]: The system is able to display the geographical regions to the employee | Employee Application
[R17.1]: The system allows the employee to select a geographical region | Employee Application
[R17.2]: The system allows the employee to draw a line inside the selected geographical region | Employee application
[R17.3]: The system is able to compute the new geographical region and store them | Geographical Areas Controller
[R18.1]: The system allows the employee to select two geographical regions | Employee Application
[R18.2]: The system merges the two region into one single region and store it, removing the two sources region | Geographical Areas Controller
[R19.1]: The system only allow a logged in employee to manage safe areas | Safe Areas Controller
[R19.2]: The system is able to find all the safe areas already defined | Safe Areas Controller
[R19.3]: The system is able to display the safe areas to the employee | Employee Application
[R20.1]: The system allows the employee to select a safe area | Employee application
[R20.2]: The system removes a selected safe area | Safe Areas Controller
[R22.1]: The system allows the employee to select a safe area | Employee application
[R21.1]: The system can acquire from the employee the type of safe area, its shape as a sequence of coordinate, and eventually the number of plugs of the recharging station area | Employee application
[R22.2]: The system is able to check if the defined safe area will overlap with the already defined safe areas except for the selected one | Safe Areas Controller
[R22.3]: The system updates the selected safe area only if it is not overlapping | Safe Areas Controller
[R23.1]: The system only allows a logged in employee to view the list of in maintenance cars | Car Controller
[R23.2]: The system is capable of finding all the in maintenance cars | Car Controller

## Non functional requirements
Requirement (RASD) | Design decision (DD)
-------------------|---------------------
Reliability | Presence of a backup server
Availability | Presence of a backup server
Security | Strong cryptographic functions
Portability | Web Standards and J2EE framework

