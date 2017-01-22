#Resource allocation
In order to better highlight parallel work on same tasks or on different tasks, resource allocation is presented in a tabular format, with each activity represented by a rectangle and identified by a label. Moreover, in order to increase readability, we have split the allocation table in four tables, one for each development phase. The numbering of the weeks reflects that of the Gantt, with week1 starting at Oct. 17th.

Not all the tasks described in the Gantt diagram are reflected in the resource allocation map. Here is a list of the exceptions:

* Code inspection  
  As described in the previous chapter, code inspection is not really a task we have to carry out, as there will be held several code inspections sessions during the development period. So far, we have not included those session in the chart because we considered it as a part of the development tasks.
* System testing  
  System testing is not included in the chart because it is carried out by an external company, and thus it not requires one of ou developers to be allocated to it.

For each development phase, we provide a map between activities and their identifier and the resource allocation table

##Requirements analysis and specification

| Identifier | Activity                              |
|:----------:|:--------------------------------------|
| #1         | Talk to customers                     |
| #2         | Domain definition                     |
| #3         | Stakeholder identification            |
| #4         | Scenario collection                   |
| #5         | Use case definition                   |
| #6         | Goal identification                   |
| #7         | Requirements identification           |
| M1         | Internal checkup meeting (31/10/2016) |
| #8         | Customer review                       |
| #9         | Domain definition refinement          |
| #10        | Goal refinement                       |
| #11        | Requirements refinement               |
| M2         | Internal checkup meeting (07/11/2016) |
| #12        | Model verification                    |
| #13        | UI mockups                            |
| QA         | Quality Assurance Review (10/11/2016) |
| #14        | Final refinements                     |

![alt "resrasd"](http://localhost/powerenjoy/PP/images/resources/RASD.png)

##Design

| Identifier | Activity                               |
|:----------:|:---------------------------------------|
| #15        | High level architecture draft          |
| #16        | Main components identification         |
| #17        | Data schema design                     |
| #18        | Dynamic system modeling                |
| M3         | Internal review (30/11/2016)           |
| #19        | Algorithm design                       |
| #20        | Deployment design                      |
| #21        | User interface design                  |
| M4         | Internal review (06/12/2016)           |
| #22        | Meeting with stakeholders (07/12/2016) |
| QA         | Quality Assurance Review (08/12/2016)  |
| #23        | Final refinements                      |

![alt "resdd"](http://localhost/powerenjoy/PP/images/resources/DD.png)

##Development
| Identifier | Activity                                    |
|:----------:|:--------------------------------------------|
| #24        | External system acquisition and study       |
| #25        | Integration testing design                  |
| QA         | Quality assurance review (16/12/2016)       |
| #26        | Integration testing refinement              |
| #27        | Integration testing environment development |
| #28        | Subcomponents development                   |
| #29        | End user applications development           |
| #30        | Integration testing                         |
| #31        | Stakeholder demostration 1                  |
| M5         | Internal review (20/01/2017)                |
| #32        | Customer demostration 2                     |
| #33        | User manual                                 |
| #34        | Refinements and bugfixes                    |
| M6         | Final internal review                       |
| #35        | Final refinements                           |

![alt "resdev"](http://localhost/powerenjoy/PP/images/resources/DEV.png)

##Deployment
| Identifier | Activity                                    |
|:----------:|:--------------------------------------------|
| #36        | Hardware acquisition and verification       |
| #37        | System deployment                           |
| #38        | Teaching sessions with employees            |
| #39        | Real life simulation                        |
| #40        | Updates and checks                          |

![alt "resdepl"](http://localhost/powerenjoy/PP/images/resources/DEPL.png)