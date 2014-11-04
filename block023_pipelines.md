---
title: "Automating Data-analysis Pipelines"
author: "Shaun Jackman"
date: "2014-11-03"
output:
  html_document:
    toc: true
    toc_depth: 2
---

Automating Data-analysis Pipelines
================================================================================

The goal of this activity is to create a pipeline that will

+ calculate a histogram of English word lengths
+ determine the most common word length
+ generate a figure of this histogram
+ render a RMarkdown report in HTML and PDF

You will automate this pipeline using `make`!

Getting Started
================================================================================

Install `make` on Microsoft Windows
------------------------------------------------------------

These instructions are courtesy of [Dean Attali](https://github.com/daattali).

Mac OS and Linux machines come with `make` installed. You do not need to follow these instructions.

### Install Make for Windows

+ Go to the [Make for Windows](http://gnuwin32.sourceforge.net/packages/make.htm) web site
+ Download the [Setup program](http://gnuwin32.sourceforge.net/downlinks/make.php)
+ Install the file you just downloaded and copy to your clipboard the directory in which it is being installed
+ The default directory is `C:\Program Files (x86)\GnuWin32\`
+ You now have `make` installed, but you need to tell Windows where to find the program. This is called [updating your `PATH`](https://www.google.ca/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=windows%20update%20path%20variable). You will want to update the `PATH` to include the `bin` directory of the newly installed program. These are the steps on Windows 7 (for Windows 8 you'd have to Google it):

### Update your `PATH`

+ Click on the Windows logo
+ Right click on *Computer*
+ Select *Properties*
+ Select *Advanced System Settings*
+ Select *Environment variables*
+ Select the line that has the `PATH` variable. You may have to scroll down to find it
+ Select *Edit*
+ Go to the end of the line and add a semicolon `;`, followed by the path where the program was installed, followed by `\bin`. For example, I added the following to the end of the line: `;C:\Program Files (x86)\GnuWin32\bin`
+ Click Okay and close all the windows that you opened
+ Close RStudio and open it again.
+ RStudio and your command line will now know where to find `make`

Configure RStudio
------------------------------------------------------------

+ `make` is rather picky and requires that lines be indented with tabs and not spaces
+ Select *Tools -> Global Options -> Code Editing* and make sure that *Insert spaces for tabs* is *not* checked
+ If *Tools -> Project Options* is not greyed out, select *Tools -> Project Options -> Code Editing* and make sure that *Insert spaces for tabs* is *not* checked

Dependency graph of the pipeline
================================================================================

[![block023_pipelines/images/activity.png](block023_pipelines/images/activity.png)](block023_pipelines/images/activity.gv)

Use RStudio to run `make`
================================================================================

+ Create an RStudio project: *File -> New Project*
+ Create a new text file: *File -> New File -> Text File*
+ Start editing your first `Makefile`!
	```makefile
	all:
		echo Build all

	clean:
		echo Clean all
	```
+ Save it, and name it `Makefile`
+ Select *Build -> Configure Build Tools -> Build Tools -> Project build tools -> Makefile*
+ Select *Build -> Build All*
+ The result and any error messages will appear under the *Build* tab, usually found in the top-right corner of RStudio

### *Build* menu items

+ *Build All* runs `make all`
+ *Clean and Rebuild* runs `make clean all`
+ *Clean All* runs `make clean`

For these menu items to work your `Makefile` needs to have phony targets named `all` and `clean`.

Run `make` from the command line
================================================================================

+ Select *Tools -> Shell*
+ Run

	```sh
	make clean
	make all
	make clean all
	```

Troubleshooting
================================================================================

Missing separator
------------------------------------------------------------

Error: `makefile:2: *** missing separator. Stop.`

Use tabs instead of spaces to indent command lines.

See [Configure RStudio](#configure-rstudio)

------------------------------------------------------------
