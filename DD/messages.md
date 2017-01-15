## Messages ##
#StatusReport#
This message is sent by the car system, to communicate variations of the car status.
It is sent immediatly after the status or the number of passengers change or the batteryLevel drops more than 5% or the batteryLevel reaches its minimum or maximum value,
or every 15 minutes if the batteryLevel changes by less than 5% and nothing else happens in the meantime.
|Field|Type|Description|
|-----|----|-----------|
|batteryLevel|float|The normalized percentage of the battery charge level|
|status|CarStatus|The status of the car|
|passengers|integer|The number of persons that the car has detected inside|
|position|Position|The current position of the car|

#Unlock#
This message is sent by management system to the car system in order to unlock the car.
This message has no parameters

#Lock#
This message is sent by management system to the car system in order to lock the car.
This message has no parameters