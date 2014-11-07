---
title: "Automation: Test drive make"
author: "Shaun Jackman, Jenny Bryan"
output:
  html_document:
    toc: true
    toc_depth: 3
    pandoc_args: "--preserve-tabs"
---

Before we use `make` for real work, we want to prove beyond a shadow of a doubt that it's installed and findable from RStudio and/or the shell.

### Create a temporary RStudio Project

You can delete this project after this test drive, so don't sweat too much about what you name it or where you put it.

  * Create an RStudio project: *File > New Project*
  * Create a new text file: *File > New File > Text File*
  * We are about to write our first `Makefile`!
  
But first ...

### Disable "insert spaces for tab"

Tabs are very meaningful in `Makefiles`, so it's important to make sure your text editor is not "helpfully" but silently converting tabs to spaces.

Here's how to disable this in RStudio.

  * Global setting: *Tools > Global Options... > Code editing*. Make sure "insert spaces for tab" is __unchecked__.
  * Project-specific setting: *Tools > Project Options... > Code editing*. Make sure "insert spaces for tab" is __unchecked__.
  
### Write a toy `Makefile`

Type or paste this into your new text file. Make sure the indentation before `@echo` is always a tab! Save as `Makefile`:
  
```makefile
all:
	@echo Build all

clean:
	@echo Clean all
```

### Configure this Rstudio Project to use `make`

Select *Build > Configure Build Tools > Build Tools > Project build tools > Makefile*.

This will make a new tab and buttons and menus available in RStudio, usually in the upper right-hand pane, similar to the Git stuff.

### Run `make` via RStudio

Select *Build > Build All* (the hammer icon).

The result and any error messages should appear under the *Build* tab.

Hopefully you will see this:

```sh
Build all
```

If you see something like this:

```sh
Makefile:2: *** missing separator.  Stop.
```
you probably have spaces instead of tabs as indentation. Fix that and try again.

RStudio offers these buttons or menu items to run things from your `Makefile`:

  * *Build All* runs `make all`, as we just saw
  * *Clean All* runs `make clean`
  * *Clean and Rebuild* runs `make clean all`

For these menu items to work, your `Makefile` needs to have targets named `all` and `clean`. These non-file targets are called phony targets.

You should be able to select *Build > More > Clean All* and get this:

```sh
Clean all
```

You should be able to select *Build > More > Clean and Rebuild* and get this:

```sh
Clean all
Build all
```

This proves that `make` is installed and working from RStudio.

### Run `make` from the shell

RStudio only provides access to a very limited bit of `make` -- it's even more limited than the RStudio Git client. In the long run, it's important to be able to run `make` from the shell.

  * Select *Tools > Shell*
  * Run

	```sh
	make clean
	make all
	make clean all
	```

You should be seeing similar output as you saw in the Build tab of RStudio.

If you are not, are you getting the error message that's characteristic of a "spaces instead of tabs" problem? Or does it look more like `make` or other commands aren't being found? If the latter, go back to the [Windows installation page](automation02_windows.html) or reach out to the course staff.