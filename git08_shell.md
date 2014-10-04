---
title: "The Shell"
output:
  html_document:
    toc: yes
    toc_depth: 4
---


### What is the Shell?

The `shell` (or `bash` or `terminal`) is a program on your computer who's job is to run other programs, rather than do calculations itself. It is a very old program and in a time before the mouse this was the only way to interact with a computer (other than rewiring). It is still extremely popular among programmers because it is very powerful, fast, and can easily be set up to automate repetitive tasks.

Here we use the `shell` for much simpler tasks: To navigate the file system, confirm the present working directory, and confirm the git to GitHub connection.

### Starting the shell

In RStudio, go to `Tools -> Shell`. This should take you to the shell (on Mac: Terminal, on Windows: GitBash). It should be a simple blinking cursor, waiting for input and looks similar to this (white text on black background, or black text on white background):

![](http://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Bash_screenshot.png/440px-Bash_screenshot.png)


### Using the shell

The most basic commands are listed below:

* `pwd` (**p**rint **w**orkging **d**irectory) - not necessarily the R working directory from `getwd()`.
* `ls` (**l**i**s**t all files)
* `cd` (**c**hange **d**irectory)
    * go up
    * go down
* `git status`
* `git remote -v`