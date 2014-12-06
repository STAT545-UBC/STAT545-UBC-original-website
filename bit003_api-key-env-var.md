# Store an API key as an environment variable

Problem: You're using an API and you need to provide your key or token to authenticate yourself. You don't want to do this interactively and repeatedly. You  don't want to store the key in your scripts or push it to GitHub by mistake.

Solution: Store it as an environment variable and retrieve it with `Sys.getenv()` in an R script or an RMarkdown document.

Motivating example: I use this method to interact with GitHub via the [`github` R package](https://github.com/cscheid/rgithub), a wrapper around the Github v3 API.

Source: The [`httr` package](https://github.com/hadley/httr) has a vignette, [Best practices for writing an API package](http://cran.r-project.org/web/packages/httr/vignettes/api-packages.html), that advocates this approach (but lacks this excruciating detail).

How to do it:

  * Identify your home directory. Not sure? Enter `normalizePath("~/")` in the R console.
  
  * Create a new text file. If in RStudio, do *File > New File > Text file.*
  
  * Put a line like this for the key you wish to store:
  
        GITHUB_TOKEN=blahblahblahblahblahblah
        
    where `GITHUB_TOKEN` is a name relevant to the API you're accessing and `blahblahblahblahblahblah` is your actual key.
    
  * Put a line break at the end! If you're using an editor that shows line numbers, there should be two lines, where the second one is empty.
  
  * Save in your home directory with the filename `.Renviron`. If questioned, YES you do want to use a filename that begins with a dot `.`.
  
  * Note that by default [dotfiles](http://linux.about.com/cs/linux101/g/dot_file.htm) are usually hidden. But within RStudio, the file browser will make `.Renviron` visible and therefore easy to edit in the future.
  
  * Restart R! `.Renviron` is processed only [at the start of an R session](http://stat.ethz.ch/R-manual/R-patched/library/base/html/Startup.html).
  
  * Use `Sys.getenv()` to access your API-key-stored-as-environment-variable and provide to your API wrapper of choice. For example, here's how I use my `GITHUB_TOKEN` with the `github` package:
  
        library(github)
        ctx <- create.github.context(access_token = Sys.getenv("GITHUB_TOKEN"))
        # ... proceed to use other package functions to open issues, etc.
    
    The details of how your API wrapper wants you to provide your key will vary by the package but hopefully this helps!

*FAQ: Why define this environment variable via `.Renviron` instead of in `.bash_profile` or `.bashrc`?*

Because there are many combinations of OS and ways of running R where the `.Renviron` approach "just works" and the bash stuff does not. When R is a child process of, say, Emacs or RStudio, you can't always count on environment variables being passed to R. Put them in an R-specific start-up file and save yourself some grief.
