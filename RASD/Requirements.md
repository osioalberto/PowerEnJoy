### Requirements
**Not yet completed**
* [G1]:
	- [D1]
	- [R1]: The system shows a registration form to the user
	- [R2]: The system validates the data using also the [D1] system and ensures that no other registered user exists with the same username
	- [R3]: The system registers this new user only if the data is valid
* [G2]:
	- [R4]: The system shows a login form to the user
	- [R5]: Only if the username and the password are correct then the user logs in
* [G3]:
	- [D2]
	- [D3]
	- [D7]
	- [D8]
	- [R6]: The system only allows the logged in user who is not banned to insert the distance
	- [R7]: The system is capable of finding all available cars within a distance range from the user position and showing them
* [G4]:
	- [D2]
	- [D4]
	- [D7]
	- [D8]
	- [R6]
	- [R8]: The system is capable of finding all available cars within a distance range from the geographical coordinate of the address and showing them
* [G5]:
	- [D2]
	- [D7]
	- [R9]: The system only allows the logged in user who is not banned to reserve the car
	- [R10]: The system is able to get the geographical region from the car geographical coordinates
	- [R11]: The system only reserve the car if the logged in user has no other reservation for the same geographical area
* [G6]: [[TO IMPROVE]]
	- [D11]
	- [R12]: The system keeps track of the time elapsed since a reservation is made
	- [R13]: If the elapsed time is greather than one hour, then the reservation expires
* [G7]:
	- [D2]
	- [D7]
	- [D3]
	- [R14]: The system shows the unlock form only to a reservor user
	- [R15]: The system unlocks the car only if the reservor user is near the car and he has requested the unlock
* [G8]:
	- [D7]
	- [D8]
	- [R15]: The system can create a bill for the reservor user, initially empty
* [G9]:
	- [D7]
	- [D8]
	- [R16]: The system can update the reservor user bill
* [G10]:
	- [D12]
	- [R17]: The system can find the reservor user bill
* [G11]:
	- [D2]
	- [D7]
	- [D8]
	- [R18]: When a car is becoming available and if for all the time of the ride the system detects that this car has had at least two passengers (not including the driver), the system applies a discount of 10% on the bill of the reservor user  
	- [R19]: When a car is becoming available and if the battery level is at least 50% of the total battery level, the system applies a discount of 20% on the bill of the reservor user
	- [R20]: When a car is becoming available and this car is parked in a recharging station area and this car is plugged to the power grid, the system applies a discount of 30% on the bill of the reservor user and the 5 minute window will terminate
	- [R21]: When a car is becoming available and if the battery level is less than 20% of the total battery level, the system applies a raise of 30% on the bill of the reservor user
	- [R22]: When a car is becoming available and this car is left more than 3Km from the nearest power station, the system applies a raise of 30% on the bill of the reservor user
* [G12]:
	- [D2]
	- [D7]
	- [D11]
	- [R23]: When a car is becoming available and this car is parked in a recharging station area there is a 5 minute window before the bill of the reservor user will be charged to him otherwise the bill is immediatly charged
* [G13]:
	- [R24]: The system knows whether a payment attempt was made for the current car
	- [R25]: The system locks the car and makes it available only if the payment attempt was done
* [G14]:
	- [D11]
	- [R26]: The system knows the result of the payment operation
	- [R27]: The user is banned only if the payment operation fails