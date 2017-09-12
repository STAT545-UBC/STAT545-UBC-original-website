---
output:
  html_document:
    toc: true
    toc_depth: 4
---

### cm002 2017-09-07 Thursday overview

#### Since last time:

- you should at least have R and RStudio installed.

#### Today:

- Housekeeping: changes to website:
    - office hours
    - `cm` pages adopting different layout
- Introduction to R and RStudio. Live coding about [R basics, workspace and working directory, RStudio projects](block002_hello-r-workspace-wd-project.html).

#### To do before next class:

- Please fill out [this](https://goo.gl/forms/dBcmAvIuEsXzxU7D2) survey.
- R/RStudio novices: finish [today's](block002_hello-r-workspace-wd-project.html) activity
- Finish getting your [git](http://happygitwithr.com/install-git.html) and [GitHub](http://happygitwithr.com/github-acct.html) setup done.
- Optional: check out [swirl](http://swirlstats.com) -- it offers mini walk-through courses in R.

#### Resources for effective programming and data analytic work:

- Google's [R style guide](https://google.github.io/styleguide/Rguide.xml).
- Jenny Bryan's [deep thoughts about data analytic work](https://www.slideshare.net/jenniferbryan5811/cm002-deep-thoughts), and related links:
    * Jack Handey's Deep Thoughts were a Saturday Night Live thing, many moons ago
    * [Emacs Speaks Statistics (ESS)](http://ess.r-project.org) manual. ESS + Emacs is still a great way to work with R, especially if you want one editor/IDE to cover other (non-R) languages. I used ESS before eventually switching to RStudio. Still waiting for the [Emacs key-bindings](https://support.rstudio.com/hc/communities/public/questions/200757977-Emacs-key-bindings-again-) :(
    * Vince Buffalo [tweet](https://twitter.com/vsbuffalo/status/358699162679787521) re: "write code for humans, write data for computers". Apparently he also uses the phrase in his new book [Bioinformatics Data Skills](http://shop.oreilly.com/product/0636920030157.do).
    * [Tweet](https://twitter.com/jiffyclub/status/508761376488030208) by `@jiffyclub` illustrating agony of working with data formatted for human eyeballs
        - his [iPython notebook](http://nbviewer.ipython.org/github/abostroem/2014-09-10-LBL/blob/master/pandas/load_precip_data.ipynb)
        - [data](http://cdec.water.ca.gov/cgi-progs/reports/PRECIPOUT.2011) he was working with from California's Department of Water Resources Data Exchange Center
    * [The International Obfuscated C Code Contest](http://www.ioccc.org)
    * [swirl](http://swirlstats.com): "a software package for the R programming language that turns the R console into an interactive learning environment"

#### Optional resources: `python`

`python` is another very effective programming language for data analysis. We won't cover this language in class, but in case you'd like to get a feel for the language, here are some resources.

1. I recommend installing [`anaconda`](https://docs.continuum.io/anaconda/install/) as a means for programming in `python` through `Jupyter Notebook`s. By the way -- you can program in  _both_ R and python in a Jupyter Notebook!
2. Take a look at the [Think Python](http://greenteapress.com/wp/think-python/) book. These chapters are particularly relevant for today's class:
    - [Ch. 2](http://greenteapress.com/thinkpython/html/thinkpython003.html), [Ch. 10](http://greenteapress.com/thinkpython/html/thinkpython011.html), [Ch. 12](http://greenteapress.com/thinkpython/html/thinkpython013.html) and sections [8.1](http://greenteapress.com/thinkpython/html/thinkpython009.html#toc86), [8.2](http://greenteapress.com/thinkpython/html/thinkpython009.html#toc87), [8.4](http://greenteapress.com/thinkpython/html/thinkpython009.html#toc89) and [8.10](http://greenteapress.com/thinkpython/html/thinkpython009.html#toc95)
3. The [Python documentation](https://docs.python.org/3/) is also useful. The following are relevant for today's class:
    - [standard data types](https://docs.python.org/3/library/stdtypes.html)
    - [builtin functions](https://docs.python.org/3/library/functions.html)
