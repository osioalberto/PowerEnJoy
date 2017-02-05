## Software Engineering 2: PowerEnJoy {.book-no-toc}
# Code Inspection Document {.book-no-toc}
###Nardo Loris, Osio Alberto {.book-no-toc}
####Politecnico di Milano {.book-no-toc}

@TOC@

# Description of the code
## Assigned classes
The classes assigned to our group are:

- <span style="font-family:Consolas;color:#34A7BD;">HtmlTreeRenderer</span> located in the package <span style="font-family:Consolas;">org.apache.ofbiz.widget.renderer.html</span> of Apache OFBiz.

## Functional role of classes
The class to review is part of the OFBiz project.
<blockquote>
Apache OFBiz is an open source product for the automation of enterprise processes that includes
framework components and business applications for ERP (Enterprise Resource Planning),
CRM (Customer Relationship Management), E-Business / E-Commerce, SCM (Supply Chain Management),
MRP (Manufacturing Resource Planning), MMS/EAM (Maintenance Management System/Enterprise Asset Management)
</blockquote>

The role of the package is to render widgets referenced in XML files representing the User Interface of the system into HTML.
In particular <span style="font-family:Consolas;color:#34A7BD;">HtmlTreeRenderer</span> renders a widget named tree into a classical expandeable tree structure.

# Issues
## Naming conventions
### Condition 7
Constants are declared using all uppercase with words separated by
an underscore. Examples: **MIN_WIDTH**; **MAX_HEIGHT**.  
The following lines are not compliant:

- 52: module is static final so it is a constant

## Braces
### Condition 10
Consistent bracing style is used, either the preferred "Allman" style
(first brace goes underneath the opening block) or the "Kernighan and
Ritchie" style (first brace is on the same line of the instruction that
opens the new block).  
The following lines are not compliant:

- 54: The right curly brace must be on a new line

## File Organization
### Condition 12
Blank lines and optional comments are used to separate sections (beginning comments, package/import statements,
class/interface declarations which include class variable/attributes declarations,
constructors, and methods).  
The following lines are not compliant:

- 183-184: Left two lines instead of one as a separator, this is non consistent with the whole file.

### Condition 13
Where practical, line length does not exceed 80 characters.  
The following lines exceed 80 characters:

|       |       |       |       |
|-------|-------|-------|-------|
! - 18  | - 49  | - 56  | - 58  |
| - 61  | - 62  | - 72  | - 81  |
| - 88  | - 93  | - 94  | - 95  |
| - 101 | - 102 | - 107 | - 112 |
| - 119 | - 120 | - 129 | - 134 |
| - 146 | - 150 | - 158 | - 185 |
| - 223 | - 224 | - 227 | - 228 |
| - 240 | - 268 | - 308 | - 309 |
| - 312 | - 313 | - 314 | - 319 |
| - 335 | - 342 | - 343 |       !

This could have been avoided breaking lines on method declaration, using less nested code and shorter variable names.

### Condition 14
When line length must exceed 80 characters, it does **not** exceed 120 characters.  
The following lines exceed 120 characters:

|       |       |
|-------|-------|
! - 56  | - 134 |
| - 150 | - 158 |
| - 185 | - 227 |
| - 268 | - 342 !

## Wrapping Lines
### Condition 17
A new statement is aligned with the beginning of the expression at the same level as the previous line.  
The following lines are not compliant:

- 227-228: Line 228 has less indentation than expected.
- 342-343: Line 343 has less indentation than excepted.

## Comments
### Condition 18
Comments are used to adequately explain what the class, interface,
methods, and blocks of code are doing.

Apart from copyright and a minimal class description there is no helpful comment in the whole file, nor in the interface it implements.  
The following comments are useless:

| Line         | Comment   | Reason |
|--------------|-----------|--------|
|159, 186, 269 | open tag  | It states something obvious|
|257           | the text  | It states something wrong, probabily this is due to a copy paste from renderLabel|
|178, 264      | close tag | It states something obvious|
|85            | FIXME     | Since the solution is simple, instead of writing the comment, one should have written the fix  |

### Condition 19
Commented out code contains a reason for being commented out and a date it can be removed from the source file if determined it is no longer needed.  
The following lines have been commented out, but no date is present:

- 92
- 106

## Java Source Files
### Condition 22
Check that the external program interfaces are implemented consistently with what is described in the javadoc.

No javadoc is present in the implemented interface.

### Condition 23
Check that the javadoc is complete (i.e., it covers all classes and files part of the set of classes assigned to you).

No javadoc is present in the class assigned.

## Class and Interface Declarations
### Condition 25
The class or interface declarations shall be in a standard order.  
The following lines are not compliant:

- 52: public static variable must be before line 51

### Condition 27
Check that the code is free of duplicates, long methods, big classes, breaking encapsulation, as well as if coupling and cohesion are adequate.

The assigned class contains lot of duplicated code, in particular the following pattern
<div style="font-family:Consolas;page-break-inside:avoid;">
<div><span style="color:#C70040;">if</span> (<span style="color:#34A7BD;">UtilValidate</span><span style="color:#C70040;">.</span>isNotEmpty({attributeValue})) {</div>
<div style="white-space:pre;">  writer<span style="color:#C70040;">.</span>append(<span style="color:#8F8634;">" {attributeName}=\""</span>);</div>
<div style="white-space:pre;">  writer<span style="color:#C70040;">.</span>append({attributeValue});</div>
<div style="white-space:pre;">  writer<span style="color:#C70040;">.</span>append(<span style="color:#8F8634;">"\""</span>);</div>
<div>}</div>
</div>
is repeated several times, in the following methods:

- <span style="font-family:Consolas;">renderLabel</span>: 2 times
- <span style="font-family:Consolas;">renderLink</span>:  5 times immediate + 1 time where a long computation is embedded
- <span style="font-family:Consolas;">renderImage</span>: 5 times immediate + 1 time where a long computation is embedded

The following methods are overly complex and long, they should have used private or utility methods

- <span style="font-family:Consolas;">renderNodeBegin</span>
- <span style="font-family:Consolas;">renderLink</span>
- <span style="font-family:Consolas;">renderImage</span>

## Initialization and Declarations
### Condition 28
Check that variables and class members are of the correct type. Check that they have the right visibility (public / private / protected).  
The following lines are not compliant:

- 51 : The declared field must be private, since a getter is defined and no other class references this field directly.

### Condition 29
Check that variables are declared in the proper scope.  
The following lines are not compliant:

- 57: The declared variable is used only inside some blocks, so it is pointless to declare it outside those blocks.
- 305: Since the variable is never modified and only accessed, the constant value should have been propagated and the variable removed.
- 306: Since the variable is never modified and only accessed, the constant value should have been propagated and the variable removed.
- 307: Since the variable is never modified and only accessed, the constant value should have been propagated and the variable removed.

### Condition 33
Declarations appear at the beginning of blocks (A block is any code surrounded by curly braces '{' and '}'). The exception is a variable can be declared in a for loop.  
The following lines are not compliant:

|       |       |       |       |
|-------|-------|-------|-------|
! - 68  | - 69  | - 70  | - 76  |
| - 86  | - 87  | - 94  | - 95  |
| - 107 | - 112 | - 113 | - 129 |
| - 161 | - 167 | - 188 | - 194 |
| - 200 | - 206 | - 212 | - 218 |
| - 221 | - 222 | - 223 | - 224 |
| - 258 | - 271 | - 277 | - 283 |
| - 289 | - 295 | - 301 | - 304 |
| - 305 | - 306 | - 307 | - 308 !

## Other found problems and considerations
### Legacy Java code
In several places the java standard used seems to be pre Java 5, and this makes the code more verbose than what should be.
Since Java 5 there is a concept called autoboxing and unboxing, which moves to the compiler some typical conversion from object to primitive values and vice-versa.
The source code instead uses explicit boxing and unboxing in the following lines:

- 105: It is used <span style="font-family:Consolas;"><span style="color:#34A7BD;">Boolean</span><span style="color:#C70040">.</span>TRUE</span> instead of <span style="font-family:Consolas;color:#7C4FCD;">true</span>
- 128: It is used <span style="font-family:Consolas;"><span style="color:#34A7BD;">Boolean</span><span style="color:#C70040">.</span>FALSE</span> instead of <span style="font-family:Consolas;color:#7C4FCD;">false</span>
- 136,152: It is used <span style="font-family:Consolas;">{variable}<span style="color:#C70040">.</span>booleanValue()</span> instead of <span style="font-family:Consolas;">{variable}</span>.

Since Java 6 <span style="font-family:Consolas;color:#34A7BD;">@Override</span> annotations could also be put on implemented interface methods, and this is also a good practice. None of the implemented methods have an <span style="font-family:Consolas;color:#34A7BD;">@Override</span> annotation.

### Desugaring of String concatenation operator
The desugaring of String concatenation operator is made whenever one uses the <span style="font-family:Consolas;color:#34A7BD;">StringBuilder</span> instead of the <span style="font-family:Consolas;color:#C70040;">+</span> operator with no particular performance reasons.
The Java compiler already translates the <span style="font-family:Consolas;color:#C70040;">+</span> operator to a <span style="font-family:Consolas;color:#34A7BD;">StringBuilder</span> pattern, for example the above two example are equals also on the bytecode produced by the compiler:
<figure>
  <div style="font-family:Consolas;">
    <div><span style="color:#34A7BD;">String</span> string <span style="color:#C70040;">=</span> <span style="color:#8F8634;">"b";</span></div>
    <div><span style="color:#34A7BD;">String</span> result <span style="color:#C70040;">=</span> <span style="color:#8F8634;">"a "</span> <span style="color:#C70040;">+</span> string <span style="color:#C70040;">+</span> <span style="color:#8F8634;">" c"</span>;</div>
  </div>
  <figcaption>This code use the standard concatenation operator.</figcaption>
</figure>
<figure>
  <div style="font-family:Consolas;page-break-inside:avoid;">
    <div><span style="color:#34A7BD;">String</span> string <span style="color:#C70040;">=</span> <span style="color:#8F8634;">"b"</span>;</div>
    <div><span style="color:#34A7BD;">String</span> result <span style="color:#C70040;">=</span> (<span style="color:#C70040;">new</span> <span style="color:#34A7BD;">StringBuilder</span>()<span style="color:#C70040">.</span>append(<span style="color:#8F8634;">" a"</span>)<span style="color:#C70040">.</span>append(string)<span style="color:#C70040">.</span>append(<span style="color:#8F8634;">" c"</span>))<span style="color:#C70040">.</span>toString();</div>
  </div>
  <figcaption>This code use the <span style="font-family:Consolas;color:#34A7BD;">StringBuilder</span> class.</figcaption>
</figure>

The following lines uses such desugaring for no reason:

- 94
- 112
- 235: Even if the <span style="font-family:Consolas;color:#34A7BD;">StringBuilder</span> is passed to a method, there is an alternative methods that gets the same result as a <span style="font-family:Consolas;color:#34A7BD;">String</span> object.
- 321: Even if the <span style="font-family:Consolas;color:#34A7BD;">StringBuilder</span> is passed to a method, there is an alternative methods that gets the same result as a <span style="font-family:Consolas;color:#34A7BD;">String</span> object.

### Mixed responsibilities
Mixed responsibilities happens when a task logically belonging to a unit is made by another unit. This can lead to errors, in fact in the class assigned to us the mixed resposibility for the encoding of
the text lead to some errors in particular:

- When the code need to get an attribute from a <span style="font-family:Consolas;color:#34A7BD;">ModelNode</span> subclass it calls a method belonging to the subclass which is resposable to encode the text according to the renderer used and then returns this text,
this task should have been done by the renderer itself and in fact not all attribute values are properly encoded for example the <span style="font-family:Consolas;">getStyle</span>, <span style="font-family:Consolas;">getId</span>, <span style="font-family:Consolas;">getName</span>, <span style="font-family:Consolas;">getTitle</span> and others do not encode the text.
- When building the target destination of a link, the <span style="font-family:Consolas;">externalLoginKey</span> is not encoded.

This can lead to possible vectors to XSS or to unexpected behaviours.

# Appendix
## Effort spent
- Nardo Loris: 14 hours of work
- Osio Alberto: 10 hours of work