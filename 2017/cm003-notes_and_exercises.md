# cm003: Getting Started with GitHub and git -- with RStudio

__September 12, 2017__

Today, time permitting, we'll aim to:

- have a github repo set up 
- have that repo cloned locally
- get fluent in RStudio's git client
- if there's time: markdown and RMarkdown

## Working on GitHub

- Let's start with a survey of github. Let's use the [MDS public repo](https://github.com/UBC-MDS/public) as an example. Notice...
    - __Directory__: You can see a directory of files, along with a _README_ (in other folders, too).
        - Can't make folders on gh... need to make locally. 
    - __File Rendering__: GitHub renders certain file types nicely.
        - Markdown! csv/tsv! pdf!
        - Not html :(
        - Basically get a free website. [Make it browsable!](http://happygitwithr.com/repo-browsability.html).
    - __Editing__: Use the "pen" icon. Then "commit". Not so good for big changes (can't save) -- we'll see how to make changes locally later. 
    - __Commits__: List that shows the entire "history" of the project since you initiated git. See at the repo's "home" directory. 
    - __diffs__: Click on a commit to see what was changed!
    - File __History__ and __Blame__: History shows the commit history of the file; blame shows who did what. 
    - __Issues__: A way for open dialogue to happen amongst your team.
- Exercise 1:
    - Create a new public github repo.
    - Initiate with a README file. 
    - Edit the README file by adding some new text.
- Exercise 2: Navigate to the [github repo that makes the stat545.com website](https://github.com/STAT545-UBC/STAT545-UBC.github.io). Investigate the file `cm001_course-intro-sw-install-account-signup.md` in the main repo.
    - When was the last change made? By whom?
    - What was added on line 10 in the most recent change?
    - Who was the last person to change line 17?
    - When was the first commit made? By whom? What did the file look like after that change?
- Exercise 3: Collaboration
    - Add your neighbour as a collaborator to your github repo. Go to Settings -> Collaborators, and type in their github username.
    - Modify _your neighbour's_ README by adding some text, like "<my name> was here."
    - Add an issue titled something like "README should be reviewed" and tag the repo owner by preceding their username with `@`.
    - Repo owners: check your email. You should have a notification. Close the issue (or comment+close).
        - NOTE: Click "Watch" to be notified of issues even if your aren't tagged!
- Exercise 4: forking.
    - _Fork_ your _other_ neighbour's repo by navigating to their repo and clicking "fork".
        - You'll have your own copy of their repo on your account.
    - Add a new file called `testing.md`, and add some text to it.
    - Make a pull request by clicking `pull request`. Be sure to leave a comment. 
    - Owners of the repo: Accept the pull request.
- What happened in Exercise 4? A _separate copy_ of the repo was modified, and _merged_ to the main repo. 


## Working Locally

GitHub can't offer the suite of editing capabilities that you have on your local machine. So we set up a _local_ version of the repo and communicate with the _remote_ repo. 

- Exercise 5: (Do together) Connect RStudio to git and GitHub
    - Did you `config` git? Enter the commands (with your credentials) specified at the top of [this](http://happygitwithr.com/hello-git.html#hello-git) page.
    - Psst... what is this "terminal" or "shell"? A "control center" for your computer (and remote servers!)
    - _Clone_ your github repo to your local machine in RStudio. [instructions](http://happygitwithr.com/rstudio-git-github.html#clone-the-new-github-repository-to-your-computer-via-rstudio)
        - Don't have the "Version Control" option after clicking File -> New Project? Follow [these](http://happygitwithr.com/rstudio-see-git.html) instructions.
    - Open your README file, and add a line. Could be `I added this line locally.`
        - YES RStudio can be used as a regular text editor!
    - Go over to the `git` tab. Stage, commit, pull, and push your change.
    - Navigate to your remote repo. Do you see the change? You should!
    
- Exercise 6: (Do yourself) Toy line
    - Make a new R script in your local repo.
    - Go [here](http://stat545.com/block002_hello-r-workspace-wd-project.html#rstudio-projects) and copy-and-paste the "toy line" script (chunks 3,4,5 in that section).
    - Click "compile notebook" on it!
    - Commit these changes, and push to your repo (after `pull`ing!)
    - Do you see the change on your remote repo?
- Advanced stuff.
    - FYI: Alternatives to GitHub: bare repo on your own server.
    - Merge conflicts. Branch. Revert.
        - Do via source tree, or bash. 

## Git and GitHub take-home Lessons

- GitHub is not git! It holds your repo remotely.
    - There are alternatives to GitHub, like Bitbucket or a bare repo on your own server. 
    - Useful for collaboration! How many times do you want to send a file to your supervisor/advisor? email is clunky... 
- Working with git:
    - local repository: a self-contained project on your computer
    - remote repository: that project on some "cloud", like GitHub, BitBucket, your own server, ...
    - git client: program on your computer that helps you use git (commit, push, pull, ...)
- Adopt git in your workflow! This means:
    - Dedicate a self-contained directory to your project.
    - Set up an R project for the directory.
    - Set up git for that directory. 
    - __Save__ perpetually, __commit__ often, __pull/push__ (to github) periodically!
- git can be painful.
    - Problems? Often best to just burn it down and start fresh...
    - Documentation difficult to read. Check out [this parody](https://git-man-page-generator.lokaltog.net/) of github documentation. 
    - Use a git client to make it easier to work with git. RStudio, Source Tree, GitHub desktop, ...


## Markdown and R Markdown

Regular markdown:

- [Markdown syntax](https://daringfireball.net/projects/markdown/syntax).
    - Some functionality in Slack.
    - Can also include raw HTML.
- In RStudio, render this to HTML by clicking "preview".
    - Files: `md` -> `html`. Could do `pdf` or even Word, too.

RMarkdown:

- Differences between markdown and R markdown.
    - Includes LaTeX (super useful for theses -- check out LyX if you're new).
    - code chunks!
    - YAML header. Can make some [pretty html files](http://rmarkdown.rstudio.com/html_document_format.html) with YAML.
- How to render: `rmarkdown::render` or click "knit". 
    - Files: `Rmd` -> `md` -> `html` or `pdf` or word (and other permutations... `keep_md: yes` to keep the intermediate `md` file. Or `output: github_document`). [Useful slide](https://speakerdeck.com/jennybc/happy-git-and-github-for-the-user?slide=56)