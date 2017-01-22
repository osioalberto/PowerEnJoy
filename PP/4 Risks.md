#Risks
Risks must be taken into consideration in a project planning.  
Even if it is not possible to forsee any possible risks, a good risk management for the most probable risks must be taken into consideration. Three main risk categories are described in the following part of this section of the document.

- **Project risks**: this risks involve the project plan itself, leading to raise in cost or to deadline missing.
- **Technical risks**: these risks involve the implementation of the project and they affect the overall quality of the software we have to develop.
- **Business risks**: these risks involve the company developing the software itself.

##Project risks
- **Too optimistic schedules**: The project may require additional time. If this is the case, we can release an incomplete but working version (e.g. without the ability for employee to define the geographical areas, or with a simplier user interface)
- **Too pessimistic schedules**: The project may require much less time. If this is the case, we can propose our client some additional services for free (e.g. extended support).
- **Requirements change**: This risk can be mitigated writing the RASD in a conscius way.
- **Team collaboration issues**: Misunderstanding or things left as intended may lead to an incorrect repartition of tasks. A possible solution are meetings and a precise task assignament.
- **Gold plating**: A software product is never perfect, but this does not mean it cannot be released. Successive releases may refine some aspects. This risk is avoided if deadlines for task assignment are defined and inforced.

##Technical risks

- **Lack of experience in programming with Java EE**: This must be taken into consideration in the early stages of planning (e.g. adding a timespan devoted to learning of this technology or expanding the time related to the actual coding of the software project)
- **Server downtime**:Downtimes are often indicators that the software is not scalable or that the hardware running the server part is not powerful enough, to prevent this, one must design the software with scalability in mind from the early stages of the DD, and choose the appropriate hardware.
- **Security flaws**:The application may be susceptible to security issues and to data leaks if not well designed. All the raccomandation from OWASP must be followed, thus the user input must be correctly handled; tests must be done to ensure that most common flaws are handled (e.g. XSS, CSRF, SQL Injection, &hellip;)
- **Data loss**: Data lost can occure because of hardware fault or software errors. This problem can be mitigated enforcing periodic backups.
- **Unstructured code**: With the growth of the project and the incombing deadline the code may become badly structured, with repetitions. Tihs problem can be mitigated performing a periodical code inspection.
- **Component integration fails**: After having implemented some components, a test may fail and this can require to rewrite large portion of the components. This risk is mitigated by specifying the contracts and interfaces of each component and by doing integration tests early using drivers or stubs.

##Business risks

- **Competitors**: Other companies can develop a software capable of the same functionality and release this software before us. A possible solution for this problem is to continuosly enhance the software product and to highlight peculiarities.
- **Bankruptcy**: While the income for this project is known, its cost is not, a good feasibility study helps to avoid this situation.
- **PowerEnjoy may violete some future laws**: local and State regulators can change some rules and this can lead to unpredictable impact. This risk cannot be avoided, but the problematic portion of the product can be disabled temporarily and the team must work to adapt to the new regulations as soon as possible.
