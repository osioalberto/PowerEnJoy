#Tools and Test equipment required
##Tools

One of the main desirabe characteristic of a set of test cases is that it can be run automatically. This is also helpful after system deploying in order to verify that maintanance operations and modifications do not break interaction between components.
In order to achieve this goal, two main tools are going to be uses: __JUnit framework__ and __Arquillian testing framework__.

* __JUnit__  
  Even if JUnit has been historically designed in order to automate Unit Testing, it can come very handy also during integration testing, as it can automate the execution of methods as of the developed drivers (that are to be integrated with JUnit), verify responses against a oracle and check that appropriate exceptions are raised in the expected cases (according to the specification). This tool provides a common base upon which drivers are built, so as to fully automate test lifecycle (except for test definition, which is stated in this document).

* __Arquillian testing framework__  
  This framework comes very handy in executing container-level tasks in Java EE. In particular, these kind of test concerns mainly the interaction with the _DBMS_ (because many low-level interactions with the DBMS are actually performed by the Java EE containers, and so we need to check they interact properly with business components) and the testing of dependency injection (which is widely used between components that need instances of other components). Moreover, this framework also helps in creating partial builds of the system, which is used in bottom up integration, when different components are included one at a time. This is accomplished by the _micro-deployment_ created in a programmable way with Arquillian.

Not all tests can however be automated, for example GUI related components cannot be completely tested in a automatic way. Another tool is then required, and it is __manual testing__. This tool has the great disadvantage of not being automatically reproducible, but it is the only viable tool to test some features of the application. Moreover, the intire activity of designing the test suit and implement the proper drivers and oracles has to be carried out manually.

During the integration of the system it may happen that some interactions are tested and then used during other tests. When this interactions involve external services, they must be tested against the real service in the dedicated tests, but then external services should be mocked in order to avoid to query them uselessly. A tool that grants this possibility is __mock server__.

In order to test _user application_ and _employee application_ interaction with the server component, the __Chrome developer tools__ may come very useful, as they provide functions to inspect both web requests and responses and interal components' state (other web browsers provide similar tools, but this is the most complete and flexible tool, according to developer's experience). Because of the fact that this needs to be a cross-browser application, it should be tested on all the major modern browsers, which include:

* Google Chrome
* Mozilla Firefox
* Safari
* Opera browser
* Micorsoft Edge
* Google Chrome for Android
* Mobile Safari
* Android Browser
* Android WebView
* IE Phone
* Opera Mobile
* Firefox Mobile

Mobile versions of major desktop browsers can also be tested through the emulator provided by the desktop version.

##Test equipment
A complete test equiment is composed of devices on which the different components can be deloyed.

In order to deploy the _server_ component, a complete J2EE server infrastructure is needed. A draft for this infrastructure is composed of:
* __GlassFish Java Application server__
* __Java Enterprise Edition__ runtime
* __GlassFish Message Broker__ (in order to setup the message-driven part of the overall architecture)

The _DBMS_, in order to mimic the real deployment scenario, should be constituted by an instance of __MySQL__ deployed on a dedicated machine.

The _monitoring system_ is deployed on board of the cars, thus at least one car of the PowerEnJoy company is needed (unless the car manufacturer provides a reliable stub of the real system for testing purposes)

The _user application_ and the _employee application_ are web application, and so they run in the context of a browser. The only hardware needed to test them is a normal notebook, plus a set of mobile devices or emulators in order to test system agaist mobile browsers. No particular screen resolution is required, and more different screen resolutions should be tested, in order to check the reactivity of the design, in particular with respect to very large or very small devices. Clearly, an instance of each of the browsers listed in the previous paragraph is needed.