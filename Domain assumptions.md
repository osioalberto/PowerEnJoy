# PowerEnJoy
### Domain assumptions
* At registrations users provide their phone number, in order to receive a password via SMS, and credit card credentials, in order to allow automatic payments
* Generated passwords are safe, users not registered cannot access the system (guessing the password, for instance)
* Car position is detected using GPS
* If a user wants to search for cars available nearby his position, then the user position is detected using GPS
* If a user wants to search for cars available nearby a certain address, then this address is converted in geographical coordinates via an external service (Google Maps)
* Each car is tagged with a unique QR-code. 
* Each car can communicate with the management system via at least GSM network
* The control system of each car can detect the level of charge of the battery, the number of people in the car, whether a car has been plugged for re-charge or not
* When a car is locked, no user is able to get in it or turn it on
* When a car gets unlocked because of a user taking it up, doors unlock and the user must enter
* A user can always pay for the service (either the reservation expiration fee or the cost of the last ride)
* There are no intermediate stop to pick up or drop passengers
* The payment for the last ride is done at the end of the ride, to avoid the overhead of credit card fees
* Safe areas and geographical regions are defined by means of polygons whoose vertices are expressed in geographical coordinates
* Safe areas don't overlap
* Geographical regions don't overlap
