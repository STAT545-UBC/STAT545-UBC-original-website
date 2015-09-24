---
title: "The Shell"
output:
  html_document:
    toc: yes
    toc_depth: 4
---


### What is the Shell?

The `shell` (or `bash` or `terminal`) is a program on your computer whose job is to run other programs, rather than do calculations itself. The `shell` is a very old program and in a time before the mouse it was the only way to interact with a computer. It is still extremely popular among programmers because it is very powerful, fast, and is particularly powerful at automating repetitive tasks.

Here we use the `shell` for a more modest goal: To navigate the file system, confirm the present working directory, and cement the `git` to `GitHub` connection.

### Starting the shell

In RStudio, go to *Tools > Shell*. This should take you to the shell (on Mac: Terminal, on Windows: GitBash or equivalent). It should be a simple blinking cursor, waiting for input and looks similar to this (white text on black background, or black text on white background):

![](http://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Bash_screenshot.png/440px-Bash_screenshot.png)


### Using the shell

The most basic commands are listed below:

* [`pwd`](https://en.wikipedia.org/wiki/Pwd) (**p**rint **w**orking **d**irectory). Shows the folder (or directory) you are currently operating in. This is not necessarily the same as the `R` working directory you get from `getwd()`.
* [`ls`](https://en.wikipedia.org/wiki/Ls) (**l**i**s**t all files). Shows all files in the current working directory. This is equivalent to looking at the files in your Finder/Explorer/File Manager. Use `ls -a` to also list hidden files, such as `.Rhistory` and `.git`.
* [`cd`](https://en.wikipedia.org/wiki/Cd_(command)) (**c**hange **d**irectory). Allows you to navigate through your folders by changing the shell's working directory. You can navigate like so:
    * go to subfolder `foo` of current working directory: `cd foo`
    * go to parent folder of current working directory: `cd ..`
    * go to home folder: [`cd ~`](http://tilde.club/~ford/tildepoint.jpg) or simply `cd`
    * go to folder using absolute path, works regardless of your current working directory: `cd /home/my_username/Desktop`. Windows uses a slightly different syntax with the slashes between the folder names reversed, `\`, e.g. `cd C:\Users\MY_USERNAME\Desktop`.
      * Pro tip 1: Dragging and dropping a file or folder into the terminal window will paste the absolute path into the window.
      * Pro tip 2: Use the `tab` key to autocomplete unambiguous folder and file names. Hit `tab` twice to see all ambiguous options.
* Use arrow-up and arrow-down to repeat previous commands. Or search for previous commands with `CTRL`+`r`.
* `git status` is the most used git command and informs you of your current branch,  any changes or untracked files, and whether you are in sync with your remotes.
* `git remote -v` lists all remotes. Very useful for making sure `git` knows about your remote and that the remote address is correct.
* `git remote add origin GITHUB_URL` adds the remote `GITHUB_URL` with nickname `origin`.
* `git remote set-url origin GITHUB_URL` changes the remote url of `origin` to `GITHUB_URL`. This way you can fix typos in the remote url.

Go back to the [index for the all the Git stuff](git00_index.html).
