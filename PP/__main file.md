## Software Engineering 2: PowerEnJoy {.book-no-toc}
# Project Planning Document {.book-no-toc}
###Nardo Loris, Osio Alberto {.book-no-toc}
####Politecnico di Milano {.book-no-toc}

@TOC@

@INCLUDE PP ref.md@

# Project size, cost and effort estimation
@INCLUDE PP - FP.md@

##Effort estimation: COCOMO II
COCOMO II is an algorithmical methodology aimed at estimating the effort (in person-hours) requried by a project, given its size (expressed in kilo lines of code). It is based on the evaluation of scale factors, which account for how much complexity scales for a unary change in size, and of cost drivers, which account for all the factors related both to project and process that can increase or decrease time required by the development.

In the following paragraphs, we are going to evaluate both scale factors and cost drivers. At the end of the evaluation, the last paragraph will contain the effort estimation.

@INCLUDE PP - cocomo_sf.md@

@INCLUDE PP - cocomo_cd_1.md@

###Effort estimation
From scale factor evaluation we get a coefficient
~~~
E = 1.0772
~~~

From cost driver evaluation we get a overall multiplier of
~~~
M = 0.6393
~~~

Hence the overall extimation yields a value of
~~~
Effort = A x (size^E) x M ~ 27.5 Person / Months
size = 11.926
A = 2.94
~~~

@INCLUDE PP - schedule.md@

@INCLUDE PP - resource allocation.md@

@INCLUDE PP - risks.md@

@INCLUDE PPappendix.md@