### Requirements
* [G1]:
	- [D1]
	- [D14]
	- [R1.1]: The system can acquire user information for the registration (name, surname, address, birth date, driving licence number, credit card number and CVV)
	- [R1.2]: The system validates the driving licence number using the external service mentioned in [D1]
	- [R1.3]: The system validates the payment information using the external service mentioned in [D2]
	- [R1.4]: The system is able to verify that no other registered user exists with the same username or driving licence number or payment information
	- [R1.5]: The system registers this new user only if given information are valid
* [G2]:
	- [D14]
	- [D17]
	- [R2.1]: The system can acquire user information for login (username and password)
	- [R2.2]: System is able to check whether a tuple (username, password) is correct, that is whether that tuple matches the information of a registered user or of an employee or not
	- [R2.3]: The user or the employee logs in if and only if username and password costitute a correct tuple
* [G3]:
	- [D5]
	- [D6]
	- [D7]
	- [D13]
	- [D14]
	- [R3.1]: The system only allows the logged in user who is not banned to insert the search radius
	- [R3.2]: The system is capable of finding all available cars within the inserted distance from the user's position
	- [R3.3]: The system is able to show to a user a list of cars with their position and battery level
* [G4]:
	- [D3]
	- [D5]
	- [D6]
	- [D7]
	- [D14]
	- [R3.1]
	- [R4.1]: The system only allows the logged in user who is not banned to insert the address on which the search area will be centered
	- [R4.2]: The system is capable of finding all available cars within a distance range from the geographical coordinate of the address
	- [R3.3]
* [G5]:
	- [D5]
	- [D6]
	- [D7]
	- [D14]
	- [D15]
	- [R5.1]: The system only allows the logged in user who is not banned to reserve an available car
	- [R5.2]: The system is able to get the geographical region from the car geographical coordinates
	- [R5.3]: The system only reserves a car if the logged in user that requests it has no other reservation for the same geographical area in which the car is located
* [G6]:
	- [R6.1]: The system keeps track of the time elapsed since a reservation is made
	- [R6.2]: If the elapsed time is greater than one hour, then the reservation expires
* [G7]:
	- [D5]
	- [D6]
	- [D11]
	- [D13]
	- [D14]
	- [R7.1]: The system unlocks a car only if distance between the car and the reservor user is less then 8 meters and the reservor user has requested the unlocking
* [G8]:
	- [D5]
	- [D10]
	- [R8.1]: The system can create an empty bill for the reservor user only when the engine is ignited
* [G9]:
	- [D5]
	- [D6]
	- [D8]
	- [D10]
	- [R9.1]: The system knows whether a car is in a safe area or not
	- [R9.2]: The system knows the time elapsed since the engine ignition
	- [R9.3]: The system updates the reservor user bill according to the elapsed time
* [G10]:
	- [D4]
	- [R10.1]: The system knows the reservor user bill
* [G11]:
	- [D2]
	- [D5]
	- [D6]
	- [D8]
	- [D10]
	- [D16]
	- [D18]
	- [R9.1]
	- [R12.1]: When a car is becoming available and this car is parked in a recharging station area there is a 5 minute window before the system charges the bill to the reservor user 
	- [R12.2]: When a car is becoming available and this car is parked in a safe parking area the system charges immediatly the reservor user with the bill
* [G12]:
	- [D5]
	- [D6]
	- [D7]
	- [D8]
	- [D9]
	- [D10]
	- [R16]
	- [D18]
	- [R11.1]: When a car is becoming available, if the system detects that this car has had at least two passengers (not including the driver) for all the time of the ride when the engine was ignited, then the system applies a discount of 10% on the bill of the reservor user  
	- [R11.2]: When a car is becoming available, if its battery level is greater or equal to the 50% of the total battery level, the system applies a discount of 20% on the bill of the reservor user
	- [R11.3]: When a car is becoming available, if it is parked in a recharging station area and it is plugged to the power grid, the system applies a discount of 30% on the bill of the reservor user and the 5 minute window terminates
	- [R11.4]: When a car is becoming available, if the battery level is less than 20% of the total battery level, the system applies a raise of 30% on the bill of the reservor user
	- [R11.5]: When a car is becoming available, if it is left more than 3Km away from the nearest recharging station, the system applies a raise of 30% on the bill of the reservor user
* [G13]:
	- [D2]
	- [D5]
	- [D12]
	- [R13.1]: The system knows whether a payment attempt was made for the current car
	- [R13.2]: The system locks the car and makes it available only if the payment attempt was processed, either if the payment is successful or not
* [G14]:
	- [D2]
	- [R14.1]: The system knows the result of the payment operation
	- [R14.2]: The user is banned only if there exists a pending bill bound to him
	- [R14.3]: The system marks a bill as paid if and only if a payment operation associated to this bill is successful
	- [R14.4]: A user can ask the system to try again to extinguish his pending bills
	- [R14.5]: Only pending bills can be required to be paid
* [G15]:
	- [D5]
	- [D6]
	- [D7]
	- [R15.1]: The system only allows a logged in user who is not banned to view his reservations
	- [R15.2]: The system is capable of finding all the reservation made by the user
	- [R15.3]: The system is able to show to a user a list of cars with their position, battery level and the expiration time
* [G16]:
	- [R16.1]: The system only allows a logged in employee to manage geographical regions
	- [R16.2]: The system is able to find all the geographical regions already defined
	- [R16.3]: The system is able to display the geographical regions to the employee
* [G17]:
	- [R16.1]
	- [R16.2]
	- [R16.3]
	- [R17.1]: The system allows the employee to select a geographical region
	- [R17.2]: The system allows the employee to draw a line inside the selected geographical region
	- [R17.3]: The system is able to compute the new geographical region and store them
* [G18]:
	- [R16.1]
	- [R16.2]
	- [R16.3]
	- [R18.1]: The system allows the employee to select two geographical regions
	- [R18.2]: The system merges the two region into one single region and store it, removing the two sources region
* [G19]:
	- [R19.1]: The system only allow a logged in employee to manage safe areas
	- [R19.2]: The system is able to find all the safe areas already defined
	- [R19.3]: The system is able to display the safe areas to the employee
* [G20]:
	- [R19.1]
	- [R19.2]
	- [R19.3]
	- [R20.1]: The system allows the employee to select a safe area
	- [R20.2]: The system remove the selected safe area
* [G21]:
	- [R19.1]
	- [R19.2]
	- [R19.3]
	- [R21.1]: The system can acquire from the employee the type of safe area, its shape as a sequence of coordinate, and eventually the number of plugs of the recharging station area
	- [R21.2]: The system is able to check if the defined safe area will overlap with the already defined safe areas
	- [R21.3]: The system insert the new safe area only if it is not overlapping
* [G22]:
	- [R19.1]
	- [R19.2]
	- [R19.3]
	- [R22.1]: The system allows the employee to select a safe area
	- [R21.1]: The system can acquire from the employee the type of safe area, its shape as a sequence of coordinate, and eventually the number of plugs of the recharging station area
	- [R22.2]: The system is able to check if the defined safe area will overlap with the already defined safe areas except for the selected one
	- [R22.3]: The system updates the selected safe area only if it is not overlapping
* [G23]:
	- [D5]
	- [D6]
	- [D7]
	- [R23.1]: The system only allows a logged in employee to view the list of in maintenance cars
	- [R23.2]: The system is capable of finding all the in maintenance cars
	- [R3.3]
* [G24]:
	- [R24.1]: The system only allows a logged in employee or logged in user to log out