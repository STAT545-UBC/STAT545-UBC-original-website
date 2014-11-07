---
title: "Automation: Test drive Make"
author: "Shaun Jackman, Jenny Bryan"
output:
  html_document:
    toc: true
    toc_depth: 2
    pandoc_args: "--preserve-tabs"
---

  * Prove `Make` is working from the shell and RStudio
    - Bring the dummy Makefile forward out of activity with the echo commands



Configure RStudio
------------------------------------------------------------

+ `make` is rather picky and requires that lines be indented with tabs and not spaces
+ Select *Tools -> Global Options -> Code Editing* and make sure that *Insert spaces for tabs* is *not* checked
+ If *Tools -> Project Options* is not greyed out, select *Tools -> Project Options -> Code Editing* and make sure that *Insert spaces for tabs* is *not* checked



Use RStudio to run make
================================================================================

+ Create an RStudio project: *File -> New Project*
+ Create a new text file: *File -> New File -> Text File*
+ Start editing your first `Makefile`!
  ```makefile
	all:
		@echo Build all

	clean:
		@echo Clean all
	```
+ Save it, and name it `Makefile`
+ Select *Build -> Configure Build Tools -> Build Tools -> Project build tools -> Makefile*
+ Select *Build -> Build All*
+ The result and any error messages will appear under the *Build* tab, usually found in the top-right corner of RStudio

### *Build* menu items

+ *Build All* runs `make all`
+ *Clean and Rebuild* runs `make clean all`
+ *Clean All* runs `make clean`

For these menu items to work your `Makefile` needs to have targets named `all` and `clean`. These non-file targets are called phony targets.

Run make from the command line
================================================================================

+ Select *Tools -> Shell*
+ Run

	```sh
	make clean
	make all
	make clean all
	```
