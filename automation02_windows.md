---
title: "make: Special considerations for Windows"
author: "Shaun Jackman, Dean Attali, Jenny Bryan"
output:
  html_document:
    toc: true
    toc_depth: 2
    pandoc_args: "--preserve-tabs"
---

### Install `make` on Microsoft Windows

We are still working out the best way to install `make` on Windows. Our current best recommendation is to install *msysGit*, which includes `make` as well as `git` and `bash`.

Download and [install msysGit](https://github.com/msysgit/msysgit/releases/download/Git-1.9.4-preview20140929/msysGit-netinstall-1.9.4-preview20140929.exe). The two software packages [msysGit](https://github.com/msysgit/msysgit) and [Git for Windows](http://msysgit.github.io/) are related. Both install `git` and `bash`, but only *msysGit* installs `make`. The programs installed by *msysGit* are found by default in `C:\msysGit\bin`. Here is the [complete list](https://github.com/msysgit/msysgit/tree/master/bin) of programs included with *msysGit*. For this activity, RStudio needs to be able to find in your `PATH` environment variable the program `make`, the [shell](git09_shell.html) `bash`, other utilities like `rm` and `cp`, and `Rscript`.

Here is another alternative for installing `make` alone:

  * Go to the [Make for Windows](http://gnuwin32.sourceforge.net/packages/make.htm) web site
  * Download the [Setup program](http://gnuwin32.sourceforge.net/downlinks/make.php)
  * Install the file you just downloaded and copy to your clipboard the directory in which it is being installed
    - FYI: The default directory is `C:\Program Files (x86)\GnuWin32\`
  * You now have `make` installed, but you need to tell Windows where to find the program. This is called [updating your `PATH`](https://www.google.ca/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=windows%20update%20path%20variable). You will want to update the `PATH` to include the `bin` directory of the newly installed program.

### Update your `PATH`

If you installed `Make for Windows` (as opposed to the `make` that comes with `Git for Windows`), you still need to update your `PATH`.

These are the steps on Windows 7 (we don't have such a write-up yet for Windows 8 -- feel free to send one!):

  * Click on the Windows logo
  * Right click on *Computer*
  * Select *Properties*
  * Select *Advanced System Settings*
  * Select *Environment variables*
  * Select the line that has the `PATH` variable. You may have to scroll down to find it
  * Select *Edit*
  * Go to the end of the line and add a semicolon `;`, followed by the path where the program was installed, followed by `\bin`.
    - Typical example of what one might add: `;C:\Program Files (x86)\GnuWin32\bin`
  * Click Okay and close all the windows that you opened
  * Quit RStudio and open it again.
  * You should now be able to use `make` from RStudio and the command line

### Issues we are still clarifying

See [issue 58](https://github.com/STAT545-UBC/Discussion/issues/58) for what seems to be the most comprehensive statement of the Windows situation.

What are the tricky bits?

  * Getting the same `Makefile` to "work" via RStudio's Build buttons/menus and in the [shell](git09_shell.html). And, for that matter, which [shell](git09_shell.html)? Git Bash or ???
  * Ensuring `make`, `Rscript`, `pandoc`, `rm`, etc. can be found = updating `PATH`.
  * Getting `make` to use the correct [shell](git09_shell.html).
    - See [issue 54](https://github.com/STAT545-UBC/Discussion/issues/54) on the Discussion repo.
