# DBMS & bill
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I1T1 |
| **Test items**           | |
| **Test description**     | This test ensures that a bill record will be created in the database.|
| **Input specification**  | The amount and the date of a valid bill.|
| **Output specification** | The database table must have a bill record.|
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I1T2 |
| **Test items**           | |
| **Test description**     | This test ensures that only valid bills will be stored into the database.|
| **Input specification**  | A non valid bill. |
| **Output specification** | It must return an error, no record must be stored in the database. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I1T3 |
| **Test items**           | |
| **Test description**     | This test ensures that bills can be retrived for a specific user. |
| **Input specification**  | A user. |
| **Output specification** | It must return all the bills for the user and no other bills. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I1T4 |
| **Test items**           | |
| **Test description**     | This test ensures that the bill controller communicates with the external payment processing system. |
| **Input specification**  | Non valid credit card data. |
| **Output specification** | An error must be returned. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I1T5 |
| **Test items**           | |
| **Test description**     | This test ensures that the bill controller communicates with the external payment processing system. |
| **Input specification**  | Valid credit card data. |
| **Output specification** | The test completes without errors. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I1T6 |
| **Test items**           | |
| **Test description**     | This test ensures that the bill controller communicates with the external payment processing system. |
| **Input specification**  | Valid credit card data, bill. |
| **Output specification** | The payment must be processed. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I1T7 |
| **Test items**           | |
| **Test description**     | This test ensures that the bill controller communicates with the external payment processing system. |
| **Input specification**  | Non valid credit card data, bill. |
| **Output specification** | The payment must be rejected, and an error must be returned. |
| **Environmental needs**  | |

#DBMS (& bill maybe a stub it's not required) & user
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I2T1 |
| **Test items**           | |
| **Test description**     | This test ensures that a user record is created for a user.|
| **Input specification**  | A user.|
| **Output specification** | The database table must have a user record.|
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I2T2 |
| **Test items**           | |
| **Test description**     | This test ensures that a user record is not created for a non valid user or for a valid user whose username is already in the database. |
| **Input specification**  | A non valid user.|
| **Output specification** | Must return an error, no modification to the database must be performed.|
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I2T3 |
| **Test items**           | |
| **Test description**     | This test ensures that a user or an employee can be autheniticated.|
| **Input specification**  | The username and the password for a valid account.|
| **Output specification** | It must return a valid authentication token.|
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I2T4 |
| **Test items**           | |
| **Test description**     | This test ensures that a user or an employee can be autheniticated.|
| **Input specification**  | The username and the password for a non valid account.|
| **Output specification** | It must return an error, the error must not contain information regarding which field is not valid.|
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I2T5 |
| **Test items**           | |
| **Test description**     | This test ensures that a user having a pending bill is banned. |
| **Input specification**  | A user, a bill for the user which is pending. |
| **Output specification** | The user must be banned. |
| **Environmental needs**  | |


#Geo area & User & DBMS

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I3T1 |
| **Test items**           | |
| **Test description**     | This test ensures that the merge operation behaves correctly. |
| **Input specification**  | Two regions. |
| **Output specification** | The two region must be merged, the database must reflect this change. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I3T2 |
| **Test items**           | |
| **Test description**     | This test ensures that the split operation behaves correctly. |
| **Input specification**  | A region and a path within the region. |
| **Output specification** | The region is split using the path and the database must reflect this change. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I3T3 |
| **Test items**           | |
| **Test description**     | This test ensures that the split operation behaves correctly. |
| **Input specification**  | A region and a path outside the region. |
| **Output specification** | No operation must be performed, an error must be returned. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I3T4 |
| **Test items**           | |
| **Test description**     | This test ensures that the search operation behaves correctly. |
| **Input specification**  | A position and a radius. |
| **Output specification** | It must return all the regions whose polygon intersect a circle centered in position with the given radius.|
| **Environmental needs**  | |

#safe area & user & dbms

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I4T1 |
| **Test items**           | |
| **Test description**     | This test ensures that the remove operation behaves correctly. |
| **Input specification**  | A safe area. |
| **Output specification** | The safe area must be removed from the database. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I4T2 |
| **Test items**           | |
| **Test description**     | This test ensures that the add operation behaves correctly. |
| **Input specification**  | Data to create a valid safe area. |
| **Output specification** | A new safe area must be inserted inside the database. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I4T3 |
| **Test items**           | |
| **Test description**     | This test ensures that the add operation behaves correctly. |
| **Input specification**  | Data to create a safe area with an overlapping. |
| **Output specification** | No operation must be performed, an error must be returned.|
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I4T4 |
| **Test items**           | |
| **Test description**     | This test ensures that the edit operation behaves correctly. |
| **Input specification**  | Valid data to update a safe area. |
| **Output specification** | The old safe area is updated and the changes are stored in the database. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I4T5 |
| **Test items**           | |
| **Test description**     | This test ensures that the eidt operation behaves correctly. |
| **Input specification**  | Non valid data to update a safe area. |
| **Output specification** | No operation must be performed, an error must be returned.|
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I4T6 |
| **Test items**           | |
| **Test description**     | This test ensures that the search operation behaves correctly. |
| **Input specification**  | A position and a radius. |
| **Output specification** | It must return all the safe areas whose polygon intersect a circle centered in position with the given radius.|
| **Environmental needs**  | |

#
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I5T1 |
| **Test items**           | |
| **Test description**     | This test ensures that the StatusMessage is received and the information of the car sending this message is updated. |
| **Input specification**  | The StatusMessage from the car. |
| **Output specification** | The updated information are stored into the database. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I5T2 |
| **Test items**           | |
| **Test description**     | This test ensures that the Unlock message is received by the car. |
| **Input specification**  | The car to which the message is to be delivered. |
| **Output specification** | The car must perform all the action necessary to unlock itself. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I5T3 |
| **Test items**           | |
| **Test description**     | This test ensures that the Lock message is received by the car. |
| **Input specification**  | The car to which the message is to be delivered. |
| **Output specification** | The car must perform all the action necessary to lock itself. |
| **Environmental needs**  | |

# maybe use a stub for car management?
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I6T1 |
| **Test items**           |  |
| **Test description**     | This test ensures that only available cars can be reserved. |
| **Input specification**  | Some cars to be reserved. |
| **Output specification** | Only available cars must be reserved. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I6T2 |
| **Test items**           | |
| **Test description**     | This test ensures that low battery cars are put in maintenance. |
| **Input specification**  | A StatusMessage reporting a low (< 20%) battery level. |
| **Output specification** | The car sending the message must be put into maintenence. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I6T3 |
| **Test items**           | |
| **Test description**     | This test ensures that when a maintanance car has a battery level above 20% is put into the available cars. |
| **Input specification**  | A StatusMessage reporting a battery  level above 20%. |
| **Output specification** | The car must be put into the available cars. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I6T4 |
| **Test items**           | |
| **Test description**     | This test ensures that only reserved car can be put in use. |
| **Input specification**  | Some MessageStatus reporting a InUse status and the cars sending them.  |
| **Output specification** | Only reserved cars must be put in use. |
| **Environmental needs**  | |


| | |
|--------------------------|--------------------------|
| **Test case identifier** | I6T5 |
| **Test items**           | |
| **Test description**     | This test ensures that only in use car can be put in available. |
| **Input specification**  | Some MessageStatus reporting a InUse status, with engine turned off and the cars sending them.  |
| **Output specification** | Only in use cars whose position is inside a safe area must be put in the available status. |
| **Environmental needs**  | |

# add a stub for the bill
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I7T1 |
| **Test items**           | |
| **Test description**     | This test ensures that the ride controller terminates the ride after a car is parked in a safe area. |
! **Input specification**  | A sequence of StatusMessage reporting: |
|                          | |
|                          | * a car in use. |
|                          | * the same car parked in a safe area. !
| **Output specification** | A bill must be processed and the ride removed. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I7T2 |
| **Test items**           | |
| **Test description**     | This test ensures that the ride controller computes a correct price for the ride. |
| **Input specification**  | Some sequences of StatusMessage reporting a car in use, some StatusMessages that triggers either a single discount or a single raise and the StatusMessage reporting the car parked (if not already present). |
| **Output specification** | The bill amount must be compatible with the raise or the discount applied. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I7T3 |
| **Test items**           | |
| **Test description**     | This test ensures that the ride controller computes a correct price for the ride. |
! **Input specification**  | A sequence of StatusMessage reporting: |
|                          | |
|                          | * a car in use by a single person. |
|                          | * the same car in use by 3 passengers. |
|                          | * the same car parked in a safe area. !
| **Output specification** | The bill amount must not include any discount based on the number of passengers. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I7T4 |
| **Test items**           | |
| **Test description**     | This test ensures that the ride controller computes a correct price for the ride. |
! **Input specification**  | A sequence of StatusMessage reporting: |
|                          | |
|                          | * a car in use by 2 passengers. |
|                          | * the same car parked in a safe recharging area. |
|                          | * the same car in recharge. !
| **Output specification** | The bill amount must be compatible with multiple discount applied. |
| **Environmental needs**  | |

#add some stubs for ride & bill?
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I8T1 |
| **Test items**           | |
| **Test description**     | This test ensures that a reservation is created in response to a request. |
| **Input specification**  | A valid car and a user who wants to serve the car. |
| **Output specification** | A new reservation record must be created, the car must be in reserved status. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I8T2 |
| **Test items**           | |
| **Test description**     | This test ensures that a reservation is not made if there is already a reservation in the same geographical area. |
| **Input specification**  | A car and a user who wants to reserve the car, the user has already a reservation in the same geographical area.  |
| **Output specification** | An error must be returned, no operation must be performed. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I8T3 |
| **Test items**           | |
| **Test description**     | This test ensures that only available cars can generate a reservation record. |
| **Input specification**  | A car which is not available, and a user who wants to reserve that car. |
| **Output specification** | An error must be returned, no operation must be performed. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I8T4 |
| **Test items**           | |
| **Test description**     | This test ensures that a reservation can trigger an expiration, for the purpose of this test the expiration may be set to a time interval different from the production one (1 hour) |
| **Input specification**  | A car and a user who wants to reserve the car. |
| **Output specification** | After the defined time interval, the reservation must be removed, a bill must be processed for a 1€ fee. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I9T1 |
| **Test items**           | |
| **Test description**     | This test ensures that requests are routed correctly. |
| **Input specification**  | Some request for different services. |
| **Output specification** | The corresponding controller is actived with the data received in the request. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I9T2 |
| **Test items**           | |
| **Test description**     | This test ensures that a request to a non existent controller method behaves gracefully. |
| **Input specification**  | A request for which no controller method is associated. |
| **Output specification** | An error must be returned. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I9T3 |
| **Test items**           | |
| **Test description**     | This test ensures that requests for employee services are granted only to employees. |
| **Input specification**  | A request issued by a user for an employee service. |
| **Output specification** | An error must be returned. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I9T4 |
| **Test items**           | |
| **Test description**     | This test ensures that requests for user services are granted only to users. |
| **Input specification**  | A request issued by an employee for a user service. |
| **Output specification** | An error must be returned. |
| **Environmental needs**  | |
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I9T5 |
| **Test items**           | |
| **Test description**     | This test ensures that requests can be processed fast enough to meet our performance requirements. |
| **Input specification**  | Multiple concurrent request. |
| **Output specification** | Request must be processed within the time specified in the performance requirements. |
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | SI1T1 |
| **Test items**           | |
| **Test description**     | This test ensures that web request are correctly processed. |
| **Input specification**  | Some HTTPS request issued by the web browser. |
| **Output specification** | The correct page is displayed. |
| **Environmental needs**  | |


| | |
|--------------------------|--------------------------|
| **Test case identifier** | SI1T2 |
| **Test items**           | |
| **Test description**     | This test ensures that web requests can be processed fast enough to meet our performance requirements. |
| **Input specification**  | Multiple concurrent HTTPS request. |
| **Output specification** | Request must be processed within the time specified in the performance requirements. |
| **Environmental needs**  | |
