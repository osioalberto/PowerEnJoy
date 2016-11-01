### Requirements (need renumbering)
* [G1]:
	- [D1]
	- [D15]
	- [R1]: The system can acquire user information for the registration (name, surname, address, birth date, driving licence number, credit card number and CVV)
	- [R2]: The system validates the driving licence number using the external service mentioned in [D1] and ensures that no other registered user exists with the same username ___[split in two parts?]___
	- [R3]: The system registers this new user only if given information is valid
* [G2 and G2bis]:
	- [D15]
	- [R4]: The system can acquire user information for login (username and password)
	- ___[R30 ?]___: System is able to check whether a tuple (username, password) is correct, that is whether that tuple matches the information of a registered user or not ___[I added it, is this needed?]___
	- [R5]: The user logs in if and only if username and password costitute a correct tuple
* [G3]:
	- [D6]
	- [D7]
	- [D8]
	- [D14]
	- [D15]
	- [R6]: The system only allows the logged in user who is not banned to insert the search radius
	- [R7]: The system is capable of finding all available cars within the inserted distance from the user's position
	- ___[R31?]___: The system is able to show to a user a list of cars with their position and battery level
* [G4]:
	- [D3]
	- [D6]
	- [D7]
	- [D8]
	- [D15]
	- [R6]
	- [R8]: The system is capable of finding all available cars within a distance range from the geographical coordinate of the address
	- ___[R31?] as of G3___
	- ___[R32?]___: The system only allows the logged in user who is not banned to insert the address on which the search area will be centered 
* [G5]:
	- [D6]
	- [D7]
	- [D15]
	- [D16]
	- [R9]: The system only allows the logged in user who is not banned to reserve an available car
	- [R10]: The system is able to get the geographical region from the car geographical coordinates
	- [R11]: The system only reserves a car if the logged in user that requests it has no other reservation for the same geographical area in which the car is located
	- ___Missing: we have never stated how the system knows the list and the boundaries of the geographic areas___
* [G6]:
	- [D7] ___why is needed??___
	- [R12]: The system keeps track of the time elapsed since a reservation is made
	- [R13]: If the elapsed time is greater than one hour, then the reservation expires
* [G7 and G7bis]:
	- [D6]
	- [D7]
	- [D12]
	- [D14]
	- [D15]
	- [R14]: The system unlocks a car only if distance between the car and the reservor user is less then 8 meters and the reservor user has requested the unlocking
* [G8]:
	- [D6]
	- [D11]
	- [R15]: The system can create an empty bill for the reservor user only when the engine is ignited
* [G9]:
	- [D6]
	- [D7] ___is this needed??___
	- [D9]
	- [D11]
	- [R16]: The system knows whether a car is in a safe area or not
	- [R17]: The system knows the time elapsed since the engine ignition
	- [R18]: The system updates the reservor user bill according to the elapsed time
* [G10]:
	- [D4]
	- ___maybe D6 is needed here?___
	- [R19]: The system knows the reservor user bill
* [G11]:
	- [D6]
	- [D7]
	- [D8]
	- [D9]
	- [D10]
	- [D11]
	- [R16]
	- [R20]: When a car is becoming available, if the system detects that this car has had at least two passengers (not including the driver) for all the time of the ride, then the system applies a discount of 10% on the bill of the reservor user  
	- [R21]: When a car is becoming available, if its battery level is greater or equal to the 50% of the total battery level, the system applies a discount of 20% on the bill of the reservor user
	- [R22]: When a car is becoming available, if it is parked in a recharging station area and it is plugged to the power grid, the system applies a discount of 30% on the bill of the reservor user and the 5 minute window terminates ___which window are you talking about? Maybe consider swapping the two goals, or define such window before___
	- [R23]: When a car is becoming available, if the battery level is less than 20% of the total battery level, the system applies a raise of 30% on the bill of the reservor user
	- [R24]: When a car is becoming available, if it is left more than 3Km away from the nearest recharging station, the system applies a raise of 30% on the bill of the reservor user
* [G12]:
	- [D2]
	- [D6]
	- [D7]
	- [D9]
	- [D17]
	- [D11]
	- [R16]
	- [R25]: When a car is becoming available and this car is parked in a recharging station area there is a 5 minute window before the system charges the bill to the reservor user 
	- ___[R25bis]:___ When a car is becoming available and this car is parked in a safe parking area the system charges immediatly the reservor user with the bill
* [G13]:
	- [D2]
	- [D6] ___is this needed?___
	- [D13]
	- [R26]: The system knows whether a payment attempt was made for the current car
	- [R27]: The system locks the car and makes it available only if the payment attempt was processed, either if the payment is successful or not.
* [G14]:
	- [D2]
	- [R28]: The system knows the result of the payment operation
	- [R29]: The user is banned only if there exists a pending bill bound to him
	- [R32]: The system marks a bill as paid if and only if a payment operation associated to this bill is successful
	- [R33]: A user can ask the system to try again to extinguish his pending bills
	- [R34]: Only pending bills can be required to be paid