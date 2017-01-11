# Integration strategy
## Entry criteria
This paragraph provides the criteria that have to be met in order to start the integration testing.

* Both the _Requirements Analysis and Specification Document_ and the _Design Document_ must be fully written and validated by the quality assurance team.

* The single components that go under integration testing must have been developed at least for the 90% of the functionalities they have to provide, and the developed part must be fully unit tested (a coverage of 95% is required)

* Drivers and stubs as of chapter 5.1 of this document have been fully developed

* Integration testing can start only when the estimated
percentage of completion of every component with respect to its functionalities is:
    * 50% for _User Application_ and _Employee Application_
    * 100% _Monitoring Controller_, _User Controller_ and _Bill Controller_
    * 50% for _Router_
    * 80% for all other components
  
  Note that some components are required to be fully developed before integration testing starts because they are very basic components and are used by the majority of the other components. This reflects also the integration order defined by the strategy (see later).

  The choice of requiring different completion percentages is taken in order to anticipate as much as possibile the begin of the integration testing, as to speed up the overall system development.

## Elements to be integrated
This paragraph provides a list of the components that need to be integrated together.

As specified in the _Design Document_, the system is made up of five main components, that are:

* Server
* User Application
* Employee Application
* DBMS
* Car monitoring system

These are the final, highest level components to be integrated together. 

Before carrying out the full system integration, we must focus on lower level components. In particular, we have to focus on _server_, _user application_ and _employee application_. The _DBMS_ component is available as a COTS component, and thus it is a very well-known and well-tested component. The _car monitoring system_ is provided by the manufacturer of the cars, and so the development and the testing of that component has not to be carried out by our company (we must test the integration at system level).

The most complex component is for sure the server component, which is made up of the integration of the following components:

* Router
* Monitoring controller
* Car controller
* Reservation controller
* Ride controller
* User controller
* Geographical areas controller
* Safe areas controller
* Bill controller

In the context of the _server_ component, we define 3 main subsystems:

* __Core Service Subsystem__
  * Monitoring controller
  * Car controller
  * Reservation controller
  * Ride controller
* __Service Tuning Subsystem__
  * Safe areas controller
  * Geographical areas controller
* __End user subsystem__
  * User controller
  * Bill controller

The _router_ cannot be included in any of those subsystem as it is unrelated with the functionalities those subsystems provide. It can only constitute a singleton subsystem.

The _User application_ and the _Employee application_ are not as complex as the server components as they represent only a user friendly interface that invokes the server APIs. In this context, integration testing is very limited because of the fact there is (almost) no interaction between subcomponents related to different APIs.


## Integration testing strategy
The approach used in integration testing is a bottom-up approach.

Bottom-up approach is chosen for these reasons:

* It reflects the development process and avoids developing stubs of very simple components as the effort spent in developing the stub would not be so minor than the effort spent in developing the actual component to get a real advantage. 
* Components like the _DBMS_ or the _Car monitoring system_, which are bought from external companies, are immediatly available in a bottom-up approach without any explicit dependency
* It exercises real components instead of stubs, allowing the development team to have more precise feedback also on non functional requirements already during the integration testing, and so to detect and correct issues earlier (if a non functional requirement is violated during the integration testing phase then it is extremely unlikely it won't be violated also during the system testing) 

## Sequence of components / software integration
This section provides detailed specification of the order in which components must be integrated.

### Software integration
This section describes the order of integration of subsystem to build a highest-level component. Because of already explained reasons we focus on the _server_ component testing.

Stilistic note: as we'll focus on one component at a time, that component will be highlighted in light grey.

#### End user subsystem
According to the bottom-up integration approach, the first subsystem to be integrated is the _end user subsystem_. It only depends on the DBMS as an external component.

First of all, we test the integration between the _DBMS_ and the _bill controller_.

![Alt IT1](http://localhost/powerenjoy/ITPD/images/IT1.svg)

Then we can add the _user controller_, which depends both on the _DBMS_ and the previosly added _bill controller_

![Alt IT4](http://localhost/powerenjoy/ITPD/images/IT4.svg)

This completes the customer subsystem, which, according to the DD, provides the basic functionalities for user authentication, user management and billing.

#### Service management subsystem
Now we can perform integration testing on _service management subsystem_, that depends both on _DBMS_ and _end user subsystem_ (for user authentication and authorization).

The components of this subsystem are indipendent one from the other, so we can test integration of the two components with their dependencies separately.

![Alt IT5](http://localhost/powerenjoy/ITPD/images/IT5.svg)

![Alt IT6](http://localhost/powerenjoy/ITPD/images/IT6.svg)

This subsystem provides functionalities related to the tuning of the service, such as geographical regions and safe areas management.

#### Core service subsystem
This is the most complex subsystem, and it is the last in the integration order as it depends on both the privious subsystems, plus the _DBMS_

First of all, we exercise the integration with the external system that monitors cars onboard.
We setup the message-driven architecture described in the DD integrating the broker

![Alt IT2](http://localhost/powerenjoy/ITPD/images/IT2.svg)

and then adding the _car controller_ which provides informations about cars to all other components, interacting on one side in the message-driven architecture and on the other side with the DMBS in order to persist collected information.

![Alt IT3](http://localhost/powerenjoy/ITPD/images/IT3.svg)

Now we can test integration of the two main business components. Due to the bottom-up approach and the dependency of reservations on rides, we must test first the integration of the _ride controller_

![Alt IT7](http://localhost/powerenjoy/ITPD/images/IT7.svg)

Then the last component of this subsystem is the _reservation controller_

![Alt IT8](http://localhost/powerenjoy/ITPD/images/IT8.svg)

#### Router
The very last component to integrate is the _router_, which works on top of all the other subsystems and so can only be added as the very last component of the _server_. Components from different subsystems have different colors.

![Alt IT9](http://localhost/powerenjoy/ITPD/images/IT9.svg)


#### Fully integrated _server_ component
Now we are ready to integrate all subcomponents to form the _server_ high-level component.

![Alt subsys](http://localhost/powerenjoy/ITPD/images/Server-subsys.svg)

### Components integration
This paragraph provides informations about high-level component integration testing.

Due to the bottom-up approach, the first components that we are going to integrate are _server_ and _DBMS_. The interaction between these two components has already been tested during the previous phase, when we verified all the interaction between the _DBMS_ and a subcomponent of the _server_

Then we add the _car monitoring system_, whose interaction with the server has already been verified, just like what happened with the _DBMS_.

We can now test in parallel the integration of _user application_ with _server_ and of _employee application_ with _server_, has this two components have no interaction one with the other. This can also save time, as we can carry out the analysis in parallel.

Here we have a picture of the fully integrated system.

![Alt full](http://localhost/powerenjoy/ITPD/images/global.svg)