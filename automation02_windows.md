---
title: "Automation: Special considerations for Windows"
author: "Shaun Jackman, Dean Attali, Jenny Bryan"
output:
  html_document:
    toc: true
    toc_depth: 2
    pandoc_args: "--preserve-tabs"
---

Install `make` on Microsoft Windows
------------------------------------------------------------

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

__TO DO__:

  * issue about Make on PATH
  * issue about which shell Make is using