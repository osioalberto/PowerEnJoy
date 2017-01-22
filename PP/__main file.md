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
PM = A x (sizeᴱ) x M ≈ 27.5 Person / Months
where A = 2.94, size = 11.926
~~~

###Duration
COCOMO provides a simple schedule estimation capability. This estimation is based on the following equation
<div style="font-family:monospace">
TDEV = [C x PM<sup> D+0.2x(E-B)</sup>] x 
<span style="display:inline-table;vertical-align:middle;text-align:center;">
<span style="display:table-row;"><span style="display:table-cell;border-bottom:1px solid;">SCED%</span></span>
<span style="display:table-row;><span style="display:table-cell;">100</span></span>
</span> ≈ 10.5 Months
<br>where C = 3.67, D = 0.28, B = 0.91, PM and E are the values calculated in the previous paragraph
</div>
This estimation is anyway too pessimistic and provides an upper bound of the time needed, it uses the pessimistic code size and it does not take into consideration that some part of the code needed can be found in already available libraries and some part of the development is carried out in parallel so our final estimation is 6 month.

@INCLUDE PP - schedule.md@

@INCLUDE PP - resource allocation.md@

@INCLUDE PP - risks.md@

@INCLUDE PPappendix.md@