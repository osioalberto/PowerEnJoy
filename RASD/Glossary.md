### Glossary
* **System**: the system to be developed for PowerEnJoy
* **User**: a generic person interacting with the system
* **Car**: an electric vehicle the company owns
* **Bill**: an amount of money a user has to pay it is related to only a single car
* **Area**: a space delimited by a sequence of geographical coordinates
* **Geographical coordinates**: a tuple of latitute and longitude describing a location on Earth
* **Geographical region**: an area where a user can only reserve at most one car, they do not overlap
* **Safe area**: an area where it is possible to park a car and optionally to recharge it, to make it available to another user
* **Safe parking area**: a special safe area where it is not possible to recharge the car
* **Recharging station area**: a special safe area where plugging the car for recharging is possible
* **Registered user**: a user who has completed the sign up process
* **Logged user**: a user who has completed the log in process and has not yet started the log out process
* **Banned user**: a registered user who cannot reserve a car untill all his bills are estinguished
* **Reservor user**: the user who has made a reservation for the specific car
* **Available car**: a locked car for which no reservation exists
* **Reserved car**: a locked car for which it exists a user who has reserved it
* **Becoming available car**: an unlocked car is said to be "becoming available" as soon as all the passengers and the driver of this car exits the car and it is parked in a safe area
* **In use car**: an unlocked car which is not becoming available
* **QR-code**: a special code that can be easly identified and interpreted by software once acquired by an image sensor
* **SMS**: Short Message Service, it is a notification sent from the management system using a SMS Gateway to the registered user
* **SMS gateway**: A service capable of sending an SMS via a well known interface
* **GSM network**: A way for mobile device to access Internet
* **GPS**: A system capable of providing the location of a receiver device with a good precision (5 meters)
* **Overlapping areas**: Two areas are said to be overlapping if there exists at least one geographical coordinates which is contained inside the two areas
* **Expiration of a car reservation**: when a reservation expires, the car becomes available again, the reservor user loses his reservation and he is charged a fee of 1€
* **Applying a raise** or ** a discount**: Thoose operation are delayed untill immediately before the system charges the user for a bill, in exactly this moment these operation are evaluated on the bill and then algebraically added to the bill