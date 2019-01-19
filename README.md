# BlueMug BFPE
## Beginner Friendly Programming Environment for C, C++, Python and JavaScript programmers 

![alt text](https://github.com/mountAP/BlueMug/blob/V-1.2.x/Screenshot.png)

Download the stable release here: 
https://sites.google.com/view/bluemug/home

Download V 1.2.0 Evaluation patch here:
https://sites.google.com/view/bluemug/developers

**What's BlueMug?**

A somewhat beautiful batch interface that makes writing, compiling and running C, C++ programs on Windows systems super easy. 

It comprises a set of batch and python scripts containing commands which automate 
the various tasks that a coder (the learner/beginner in this case) 
needs to get done, right from the point of creating a source file 
to its successful compile and execution (including all intermediate and 
iterated steps and requirements).

Uses (for compiling and runtime support)

 - MinGW GCC Toolchain 8.1.0
 - Python 3.7.2
 - Node.js 10.15.0

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

**Note**

* Those who want to checkout the project can download the sources directly from GitHub and place them anywhere in their windows system
  and run. 
  
  Required folder hierarchy for other components
   
   - C/C++  -  %systemdrive%\MinGW
   - python -  %systemdrive%\python (necessary for the functioning of BlueMug)
   - nodejs -  %systemdrive%\nodejs
   
* Though BlueMug automation makes use of notepad++ as the default editor but it will soon be editor independent.
    
* option for writing C/C++ headers will soon be added.

**Why BlueMug?**

Somebody told me that the C family of programming languages is awesome. So I decided to 
start with C. I bought a book on it. After going through a couple of programs in the book, 
there was the obvious urge of writing real programs on a machine. Next step was setting up the environment.
This caused a dilemma...there were some 'bests' among the IDEs but 
they did not fulfill my needs as a beginner...and there were some 'simple ones' that were no longer supported 
on modern Windows operating systems. Plus, different components like IDE and Compiler collection have to be fetched from different places.

Another problem: After figuring out how to write and compile codes using MinGW compiler collection, the next problem I faced was that a lot of mundane routine work had be done manually (since I was not using any of the IDEs) - routine work for writing each program included opening static 'cmd' windows for compiling and then for running programs, organising my programming workspace, writing files, changing extensions etc. 

So I decided to automate the whole process and found writing a batch script in cmd extremely feasible for the purpose.

Owing to the above mentioned difficulties and dilemma and the realization of the problems faced by a beginners in setting up the environment, I created the BlueMug automation scripts and the complete package installer.

*P.S*
Though BlueMug was initially made for C/C++ programming, it can now be used by Python and JS learners as well!

Hope You'll Enjoy using it
-Abhigyan Prakash 
