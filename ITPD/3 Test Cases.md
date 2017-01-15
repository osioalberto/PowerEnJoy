## Integration test case I1
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I1T1 |
| **Test items**           | Bill Controller &rarr; DBMS |
| **Test description**     | This test ensures that a bill record will be created in the database.|
| **Input specification**  | The amount and the date of a valid bill.|
| **Output specification** | The database table must have a bill record.|

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I1T2 |
| **Test items**           | Bill Controller &rarr; DBMS |
| **Test description**     | This test ensures that only valid bills will be stored into the database.|
| **Input specification**  | A non valid bill (past date, negative amount&hellip;). |
| **Output specification** | It must return an error, no record must be stored in the database. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I1T3 |
| **Test items**           | Bill Controller &rarr; DBMS |
| **Test description**     | This test ensures that bills can be retrived for a specific user. |
| **Input specification**  | A user. |
| **Output specification** | It must return all the bills for the user and no other bills. |

## Integration test case I2
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I2T1 |
| **Test items**           | External payment processing system &rarr; Bill Controller, DBMS  |
| **Test description**     | This test ensures that the bill controller communicates with the external payment processing system. |
| **Input specification**  | Non valid credit card data. |
| **Output specification** | An error must be returned. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I2T2 |
| **Test items**           | External payment processing system &rarr; Bill Controller, DBMS |
| **Test description**     | This test ensures that the bill controller communicates with the external payment processing system. |
| **Input specification**  | Valid credit card data. |
| **Output specification** | The test completes without errors. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I2T3 |
| **Test items**           | External payment processing system &rarr; Bill Controller, DBMS |
| **Test description**     | This test ensures that the bill controller communicates with the external payment processing system. |
| **Input specification**  | Valid credit card data, bill. |
| **Output specification** | The payment must be processed. |
| **Test dependencies**  | I2T1 |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I2T4 |
| **Test items**           | External payment processing system &rarr; Bill Controller, DBMS |
| **Test description**     | This test ensures that the bill controller communicates with the external payment processing system. |
| **Input specification**  | Non valid credit card data (CVV non correct, non existing credit card number), valid bill. |
| **Output specification** | The payment must be rejected, and an error must be returned. |
| **Test dependencies**  | I2T1 |

## Integration test case I3
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I3T1 |
| **Test items**           | User Controller &rarr; DBMS, Bill Controller |
| **Test description**     | This test ensures that a user record is created for a user.|
| **Input specification**  | A user.|
| **Output specification** | The database table must have a user record.|

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I3T2 |
| **Test items**           | User Controller &rarr; DBMS, Bill Controller |
| **Test description**     | This test ensures that a user record is not created for a non valid user or for a valid user whose username is already in the database. |
| **Input specification**  | A non valid user.|
| **Output specification** | Must return an error, no modification to the database must be performed.|

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I3T3 |
| **Test items**           | User Controller &rarr; DBMS, Bill Controller |
| **Test description**     | This test ensures that a user or an employee can be authenticated.|
| **Input specification**  | The username and the password for a valid account.|
| **Output specification** | It must return a valid authentication token.|

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I3T4 |
| **Test items**           | User Controller &rarr; DBMS, Bill Controller |
| **Test description**     | This test ensures that a user or an employee can be authenticated.|
| **Input specification**  | The username and the password for a non valid account.|
| **Output specification** | It must return an error, the error must not contain information regarding which field is not valid.|
| **Environmental needs**  | |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I3T5 |
| **Test items**           | User Controller &rarr; DBMS, Bill Controller |
| **Test description**     | This test ensures that a user having a pending bill is banned. |
| **Input specification**  | A user, a bill for the user which is pending. |
| **Output specification** | The user must be banned. |

##Integration test case I4
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I4T1 |
| **Test items**           | External driving licence validation service &rarr; User Controller,  DBMS, Bill Controller |
| **Test description**     | This test ensures that ensures that this component is able to communicate with the external driving licence validation service. |
| **Input specification**  | Some user data with valid and driving licence. |
| **Output specification** | User is inserted in the database |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I4T2 |
| **Test items**           | External driving licence validation service &rarr; User Controller,  DBMS, Bill Controller |
| **Test description**     | This test ensures that ensures that this component is able to communicate with the external driving licence validation service. |
| **Input specification**  | Some user data with non valid driving licence (non existing driving licence number, outdated driving licence number). |
| **Output specification** | No operation is performed on the database |

## Integration test case I5
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I5T1 |
| **Test items**           | Geographical areas controller &rarr; DBMS |
| **Test description**     | This test ensures that the merge operation behaves correctly. |
| **Input specification**  | Two regions. |
| **Output specification** | The two region must be merged, the database must reflect this change, hence it must not contain the input region and must contain a new region which is the union of the two. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I5T2 |
| **Test items**           | Geographical areas controller &rarr; DBMS |
| **Test description**     | This test ensures that the split operation behaves correctly. |
| **Input specification**  | A region and a path within the region. |
| **Output specification** | The region is split using the path and the database must reflect this change, hence it must not contain the input region and must contain two regions whose union corresponds to the input region, and that have as a part of their boundary the given path |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I5T3 |
| **Test items**           | Geographical areas controller &rarr; DBMS |
| **Test description**     | This test ensures that the split operation behaves correctly. |
| **Input specification**  | A region and a path outside the region. |
| **Output specification** | No operation must be performed, an error must be returned. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I5T4 |
| **Test items**           | Geographical areas controller &rarr; DBMS |
| **Test description**     | This test ensures that the search operation behaves correctly. |
| **Input specification**  | A position and a radius. |
| **Output specification** | It must return all and only the regions whose polygon intersects a circle centered in the given position with the given radius.|

## Integration test case I6
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I6T1 |
| **Test items**           | Safe areas controller &rarr; DBMS |
| **Test description**     | This test ensures that the remove operation behaves correctly. |
| **Input specification**  | A safe area. |
| **Output specification** | The safe area must be removed from the database. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I6T2 |
| **Test items**           | Safe areas controller &rarr; DBMS |
| **Test description**     | This test ensures that the add operation behaves correctly. |
| **Input specification**  | Data to create a valid safe area. |
| **Output specification** | A new safe area must be inserted in the database. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I6T3 |
| **Test items**           | Safe areas controller &rarr; DBMS |
| **Test description**     | This test ensures that the add operation behaves correctly. |
| **Input specification**  | Data to create a safe area that overlaps with another, already existing, safe area. |
| **Output specification** | No operation must be performed, an error must be returned.|

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I6T4 |
| **Test items**           | Safe areas controller &rarr; DBMS |
| **Test description**     | This test ensures that the edit operation behaves correctly. |
| **Input specification**  | Valid data to update a safe area. |
| **Output specification** | The old safe area is updated and the changes are stored in the database. |
| **Test dependencies**  | I6T2 |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I6T5 |
| **Test items**           | Safe areas controller &rarr; DBMS |
| **Test description**     | This test ensures that the edit operation behaves correctly. |
| **Input specification**  | Non valid data to update a safe area (open boundary, negative number of plugs for recharging stations, &hellip;). |
| **Output specification** | No operation must be performed, an error must be returned.|
| **Test dependencies**  | I6T3 |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I6T6 |
| **Test items**           | Safe areas controller &rarr; DBMS |
| **Test description**     | This test ensures that the search operation behaves correctly. |
| **Input specification**  | A position and a radius. |
| **Output specification** | It must return all the safe areas whose polygon intersects a circle centered in the given position with the given radius.|



## Integration test case I7
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I7T1 |
| **Test items**           | Car monitoring system &rarr; Monitoring controller |
| **Test description**     | This test ensures that the StatusMessage is received. |
| **Input specification**  | The StatusMessage from the car. |
| **Output specification** | The StatusMessage is received and dispatched. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I7T2 |
| **Test items**           | Car monitoring system &rarr; Monitoring controller |
| **Test description**     | This test ensures that the Unlock message is received by the car. |
| **Input specification**  | The car to which the message is to be delivered. |
| **Output specification** | The car must perform all the action necessary to unlock itself. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I7T3 |
| **Test items**           | Car monitoring system &rarr; Monitoring controller |
| **Test description**     | This test ensures that the Lock message is received by the car. |
| **Input specification**  | The car to which the message is to be delivered. |
| **Output specification** | The car must perform all the action necessary to lock itself. |

## Integration test case I8
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I8T1 |
| **Test items**           | Car controller &rarr; Monitoring controller, DBMS, Safe areas controller, Geographical areas controller |
| **Test description**     | This test ensures that only available cars can be reserved. |
| **Input specification**  | Some cars to be reserved (this test must be run several times, sometimes use an available car, some other times use a non available one). |
| **Output specification** | Only available cars must be reserved. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I8T2 |
| **Test items**           | Car controller &rarr; Monitoring controller, DBMS, Safe areas controller, Geographical areas controller |
| **Test description**     | This test ensures that low battery cars are put in maintenance. |
| **Input specification**  | A StatusMessage reporting a low (< 20%) battery level and the car parked somewhere. |
| **Output specification** | The car sending the message must be put in maintenence. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I8T3 |
| **Test items**           | Car controller &rarr; Monitoring controller, DBMS, Safe areas controller, Geographical areas controller |
| **Test description**     | This test ensures that when a maintanance car has a battery level above 20% is put into the available cars. |
| **Input specification**  | A StatusMessage reporting a battery  level above 20%. |
| **Output specification** | The car must be put into the available cars. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I8T4 |
| **Test items**           | Car controller &rarr; Monitoring controller, DBMS, Safe areas controller, Geographical areas controller |
| **Test description**     | This test ensures that only reserved car can be put in use. |
| **Input specification**  | Some MessageStatus reporting a InUse status and the cars sending them.  |
| **Output specification** | Only reserved cars must be put in use. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I8T5 |
| **Test items**           | Car controller &rarr; Monitoring controller, DBMS, Safe areas controller, Geographical areas controller |
| **Test description**     | This test ensures that only in use car can be put in available status. |
| **Input specification**  | Some MessageStatus reporting a InUse status, with engine turned off and the cars sending them.  |
| **Output specification** | Only in use cars whose position is inside a safe area must be put in the available status, its geographical area must be updated accordingly. |

## Integration test case I9
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I9T1 |
| **Test items**           | Ride Controller &rarr; Monitoring controller, DBMS, Safe areas controller, Car controller |
| **Test description**     | This test ensures that the ride controller terminates the ride after a car is parked in a safe area. |
! **Input specification**  | A sequence of StatusMessage reporting: |
|                          | |
|                          | * a car in use. |
|                          | * the same car parked in a safe area. !
| **Output specification** | A bill must be processed and the ride removed. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I9T2 |
| **Test items**           | Ride Controller &rarr; Monitoring controller, DBMS, Safe areas controller, Car controller |
| **Test description**     | This test ensures that the ride controller computes a correct price for the ride. |
| **Input specification**  | Some sequences of StatusMessage reporting a car in use, some StatusMessages that triggers either a single discount or a single raise and the StatusMessage reporting the car parked (if not already present). |
| **Output specification** | The bill amount must be compatible with the raise or the discount applied. |
| **Test dependencies**  | I9T1 |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I9T3 |
| **Test items**           | Ride Controller &rarr; Monitoring controller, DBMS, Safe areas controller, Car controller |
| **Test description**     | This test ensures that the ride controller computes a correct price for the ride. |
! **Input specification**  | A sequence of StatusMessage reporting: |
|                          | |
|                          | * a car in use by a single person. |
|                          | * the same car in use by 3 passengers. |
|                          | * the same car parked in a safe area. !
| **Output specification** | The bill amount must not include any discount based on the number of passengers. |
| **Test dependencies**  | I9T2 |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I9T4 |
| **Test items**           | Ride Controller &rarr; Monitoring controller, DBMS, Safe areas controller, Car controller |
| **Test description**     | This test ensures that the ride controller computes a correct price for the ride. |
! **Input specification**  | A sequence of StatusMessage reporting: |
|                          | |
|                          | * a car in use by 2 passengers. |
|                          | * the same car parked in a safe recharging area. |
|                          | * the same car in recharge. !
| **Output specification** | The bill amount must be compatible with multiple discount applied. |
| **Test dependencies**  | I9T2 |

## Integration test case I10
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I10T1 |
| **Test items**           | Reservations controller &rarr; DBMS, Car controller, Geographical areas controller |
| **Test description**     | This test ensures that a reservation is created in response to a request. |
| **Input specification**  | A valid car and a user who wants to serve the car. |
| **Output specification** | A new reservation record must be created, the car must be in reserved status. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I10T2 |
| **Test items**           | Reservations controller &rarr; DBMS, Car controller, Geographical areas controller |
| **Test description**     | This test ensures that a reservation is not made if there is already a reservation in the same geographical area. |
| **Input specification**  | A car and a user who wants to reserve the car, the user has already a reservation in the same geographical area.  |
| **Output specification** | An error must be returned, no operation must be performed. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I10T3 |
| **Test items**           | Reservations controller &rarr; DBMS, Car controller, Geographical areas controller |
| **Test description**     | This test ensures that only available cars can generate a reservation record. |
| **Input specification**  | A car which is not available, and a user who wants to reserve that car. |
| **Output specification** | An error must be returned, no operation must be performed. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I10T4 |
| **Test items**           | Reservations controller &rarr; DBMS, Car controller, Geographical areas controller |
| **Test description**     | This test ensures that a reservation can trigger an expiration, for the purpose of this test the expiration may be set to a time interval different from the production one (1 hour) |
| **Input specification**  | A car and a user who wants to reserve the car. |
| **Output specification** | After the defined time interval, the reservation must be removed, a bill must be processed for a 1€ fee. |
| **Test dependencies**  | I10T1 |


| | |
|--------------------------|--------------------------|
| **Test case identifier** | I10T5 |
| **Test items**           | Reservations controller &rarr; DBMS, Car controller, Geographical areas controller |
| **Test description**     | This test ensures that the controller is able to get all the cars near a position. |
| **Input specification**  | Some position, radius and the status of the car to search for. |
| **Output specification** | It must return all the cars with the given status at most radius meter distant from the given position. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I10T6 |
| **Test items**           | Car controller &rarr; Monitoring controller, DBMS, Safe areas controller, Geographical areas controller |
| **Test description**     | This test ensures that the geocoding of an address is done correctly. |
| **Input specification**  | Some location, radius and the status of the car to search for. |
| **Output specification** | It must return all the cars with the given status at most radius meter distant from the given location. |
| **Test dependencies**  | I10T5 |

## Integration test case I11
| | |
|--------------------------|--------------------------|
| **Test case identifier** | I11T1 |
| **Test items**           | Router &rarr; all the components of the server |
| **Test description**     | This test ensures that requests are routed correctly. |
| **Input specification**  | Some request for different services. |
| **Output specification** | The corresponding controller is actived with the data received in the request. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I11T2 |
| **Test items**           | Router &rarr; all the components of the server |
| **Test description**     | This test ensures that a request to a non existent controller method fails gracefully. |
| **Input specification**  | A request for which no controller method is associated. |
| **Output specification** | An error must be returned. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I11T3 |
| **Test items**           | Router &rarr; all the components of the server |
| **Test description**     | This test ensures that requests for employee services are granted only to employees. |
| **Input specification**  | A request issued by a user for an employee service. |
| **Output specification** | An error must be returned. |
| **Test dependencies**  | I11T1 |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | I11T4 |
| **Test items**           | Router &rarr; all the components of the server |
| **Test description**     | This test ensures that requests for user services are granted only to users. |
| **Input specification**  | A request issued by an employee for a user service. |
| **Output specification** | An error must be returned. |
| **Test dependencies**  | I11T1 |

##  Integration test case SI1
| | |
|--------------------------|--------------------------|
| **Test case identifier** | SI1T1 |
| **Test items**           | Router &rarr; all the components of the server |
| **Test description**     | This test ensures that requests can be processed fast enough to meet our performance requirements. |
| **Input specification**  | Multiple concurrent request. |
| **Output specification** | Request must be processed within the time specified in the performance requirements. |

## Integration test case SI2
| | |
|--------------------------|--------------------------|
| **Test case identifier** | SI2T1 |
| **Test items**           | Web browser &rarr; Web server |
| **Test description**     | This test ensures that web request are correctly processed. |
| **Input specification**  | Some HTTPS request issued by the web browser. |
| **Output specification** | The correct page is displayed. |

| | |
|--------------------------|--------------------------|
| **Test case identifier** | SI2T2 |
| **Test items**           | Web browser &rarr; Web server |
| **Test description**     | This test ensures that web requests can be processed fast enough to meet our performance requirements. |
| **Input specification**  | Multiple concurrent HTTPS request. |
| **Output specification** | Request must be processed within the time specified in the performance requirements. |
| **Test dependencies**  | SI2T1 |