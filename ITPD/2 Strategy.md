# Integration strategy
## Entry criteria
This paragraph provides the criteria that have to be met in order to start the integration testing.

* Both the _Requirements Analysis and Specification Document_ and the _Design Document_ must be fully written and validated by the quality assurance team.

* The single components that go under integration testing must have been developed at least for the 90% of the functionalities they have to provide, and the developed part must be fully unit tested (a coverage of 95% is required)

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

The _User application_ and the _Employee application_ are not as complex as the server components as they represent only a user friendly interface that invokes the server APIs. In this context, integration testing is very limited because of the fact there is (almost) no interaction between subcomponents related to different APIs (they are not even specified in the design document).

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

### Components integration