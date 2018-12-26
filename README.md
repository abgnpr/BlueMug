# BlueMug BFPE
## Beginner Friendly Programming Environment for C, C++, Python and JavaScript programmers 

**What's BlueMug?**

Blue Mug is a programming environment for C / C++ / Python / JS built using batch scripts and uses notepad++, MingGW, nodeJS and Python.

It comprises a set of batch scripts containing commands which automate 
the various tasks that a coder (the learner/beginner in this case) 
needs to get done, right from the point of creating a source file 
to its successful compilation and execution (including all intermediate and 
iterated steps and requirements).

**Who is it aimed at?**

Beginners like secondary/senior secondary school students OR students in various 
courses/colleges who are learning or going to learn C / C++ / Python / JavaScript 

**Features**

* **Saves your time**
* Makes you zoom past that programming exercise in your book at full speed.
* Has an embedded timer
* Easy to install (Setup includes everything to start programming in C, C++, Python and JS. Select what you want to install at setup time)
* Menu driven approach
* **Efficient workspace and program source-file management**
* Has a run-program selector
* **Any one can alter the batch scripts in order to make it suitable for his/her own needs**

**PS**

* Those using Batch files downloaded directly from GitHub can place them anywhere in their windows systems
and run. Required folder hierarchy for editor and compiler are "%systemdrive%\BlueMug\nppbin\(notepad++ executable)"  AND "%systemdrive%\MinGW" respectively.
* whoever is interested in writing header(.h) files can just trace assignments made to the 'ext' variable in the script 
and make necessary changes. (.cpp --> .h)

**Why BlueMug?**

Somebody told me that the C family of programming languages is awesome. So I decided to 
start with C. I bought a book on it. After going through a couple of programs in the book, 
there was the obvious urge of writing real programs on a machine. Next step was setting up the environment.
This caused a dilemma...there were some 'bests' among the IDEs but 
they did not fulfill my needs as a beginner...and there were some 'simple ones' that were no longer supported 
on modern Windows operating systems. Plus, different components like IDE and Compiler collection have to be fetched from different places.

Another problem: After figuring out how to write and compile codes using MinGW compiler collection, the next problem 
I faced was that a lot of mundane manual work was required to be done (since I was not using 
any of the IDEs) - routine work for each program included opening static 'cmd' windows for compiling and then for running programs, organising my programming workspace, 
writing files, changing extensions etc. 

So I decided to automate the whole process and found writing a batch script in cmd extremely feasible for the purpose. 

Owing to the above mentioned difficulties and dilemma and the realization of the problems faced by a beginners in setting up the environment, 
I created the BlueMug automation script and the complete package installer.

Hope You'll Enjoy using it
-Abhigyan Prakash 




