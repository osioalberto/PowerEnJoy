# PowerEnJoy
### Domain assumptions
* At registrations users privide their phone number, in order to receive a password via SMS, and credit card credentials, in order to allow automatic payments)
* Generated passwords are safe, users who have not paid cannot access the system (guessing the password, for instance)
* Car position is detected using GPS
* When searching for a available car, user position is detected using GPS
* If a user wants to look for car available nearby a certain address, then that address is converted in geographical coordinates (latitute and longitude) via an external service (Google Maps)
* Each car is tagged with a unique QR-code. 
* Each car can communicate with the management system via GSM network
* The control system of each car can detect the level of charge of the battery, the number of people in the car, whether a car has been plugged for re-charge or not
* When a car is locked, no user is able to get in it or turn it on
* When a car gets unlocked because of a user taking it up, doors unlock for 30 seconds in order to allow the user get in. If no user enters the car in those 30 seconds, doors get locked again and car is marked free for new user requests.