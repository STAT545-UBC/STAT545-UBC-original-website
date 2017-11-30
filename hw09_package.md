---
title: "Building your own R package"
output:
  html_document:
    toc: true
    toc_depth: 3
---

### What we have already done

In class we developed a package and showed how to

  * set up the directory structure for a package and put it under version control with `File` -> `New Project`
  * define functions in R scripts located in the `R` directory of the package
  * use `load_all` and `Build & Reload` to simulate loading the package
  * use `Check` to check the package for coherence
  * use `Build & Reload` to properly build and install the package
  * edit the `DESCRIPTION` file of package metadata
  * specify a LICENSE
  * document and export the functions via `roxygen2` comments
  * document the package itself via `use_package_doc()`
  * create documentation and manage the `NAMESPACE` file via `document()`
  * use `testthat` to implement unit testing
  * use a function from another package via `use_package()` and syntax like `otherpkg::foofunction()`
  * connect your local Git repo to a new remote on GitHub via `use_github()`
  * create a `README.md` that comes from rendering `README.Rmd` containing actual usage, via `use_readme_rmd()`
  * create a vignette via `use_vignette()` and build it via `build_vignettes()`

Consult the repository for an example repository that you can start with, where all of the above has been done. You are especially encouraged to walk through the commit history and scrutinize the diffs, noticing which files change at each point. You can fork it or use the Download ZIP button to get this as your starting point. Jenny Bryan has written instructions for both, regarding the `foofactors` package, located [here](hw09_package_onramp-peer-review.html).
  
Remember the [landing page for all the package material](packages00_index.html) also contains lots of [links](packages00_index.html#resources) with extra technical information and general inspiration.

### Your mission

In this homework you will either continue developing the [`powers`](https://github.com/vincenzocoia/powers) package developed in class or Jenny's [`foofactors`](https://github.com/jennybc/foofactors) package; or create your own package. If you do the latter, you must hit all the same points but you'll be starting from scratch.

Aim for the following elements:

  * Define and export at least one new function, i.e. make it available to a user. We'd prefer more than one. Feel free to improve (or delete) the functions we already have.
  * Give function arguments sensible defaults, where relevant.
  * Use assertions to add some validity checks of function input.
  * Document all exported functions.
  * Include at least three unit tests for every function that is exported.
    - There should be at least one expectation for success and one for failure.
  * Your package should pass `check()` without errors (warnings and notes are OK, though it would be great if there were none).
  * Keep updating the README and vignette to show usage of all the functions in the package. Your peer reviewers and TA will only have the README and vignette to go on when they try to use your package. Show them exactly what they can do! Remove boilerplate content from the vignette.
  * Push your package to GitHub, preferably a public repo. *If you are uncomfortable with that, please contact an instructor and we'll work around that.*
  * Write your reflections in a document in your normal STAT 545/547 course repo and open the usual issue there. Make sure to provide a link to your package, so TAs/prof/peers can find it for review!

Ideas for more `foofactor` functions to write:

  - detect factors that should be character because # unique values = length
  - write a version of reorder() that uses `desc()` a la `(d)plyr`
  - write a version of `factor()` that sets levels to the order in which they appear in the data, i.e. set the levels "as is"
  - functions to write and read data frames to plain text delimited files while retaining factor levels; maybe by writing/reading a companion file?

Ideas for more `powers` functions to write:

  - Maybe put another family of transforms via the Box-Cox transform.
  - Maybe something related to logarithms (and/or Box-Cox inverses).
  - Add special features to your functions, like maybe an `na.omit` option that removes `NA`s. Or perhaps it handles strings in a different way that doesn't throw an error (also gives you a chance to import a package like `stringr`).

A general idea for advanced R packages is to develop an S3 Object Oriented (OO) R package (see [this reference](http://adv-r.had.co.nz/OO-essentials.html)). Be warned, though, that this may be a time sink, so is only for the super-eager (you can still get check-plus if you don't do this).

### Due date

Submit an issue with a link to your package sometime by the end of November 28, 2017.

## Rubric

Instructions on how to install a peer's package from GitHub are given by Jenny Bryan for the `foofactors` package [here](hw09_package_onramp-peer-review.html), but extend to other packages. Use the `README.md` and the vignette to figure out what the package does and how to use it.

Check minus: Package does not install. Or installation seemed go OK but one or more of the functions don't work. Or you do something that seems totally natural (probably copied from `README.md` or vignette) and get odd behavior.

Check: Hits most/all the elements. No obvious technical difficulties. Package pleasant to use. `README.md` and vignette are pleasant to read and provide accessible examples of usage. No heroic detective work required. Good work!

Check plus: Exceeded the requirements in number of dimensions. Took `foofactors` or `powers` farther than was required. Wrote a new package from scratch. Experience of installation and usage was dreamy because of excellent documentation and high functionality. You learned something new from reviewing their work and you’re eager to incorporate it into your work. Wow!

Recall the [general homework rubric](http://stat545-ubc.github.io/peer-review01_marking-rubric.html).

## Peer Review


The peer review is ready and is due __December 06, 2017__ (before midnight)! Here's what you'll need to do:

0. Find your github username in the table below. If it's not there, let Giulio know! Slack me `@giulio`.
1. Add the _people who will be giving you a review_ as collaborators to the repo containing your homework submission.
2. Give a review of this homework for the two people you've been assigned to. There should be an issue in their repo titled something like `hw0x ready for grading` -- put your review in there as a comment.
    - If there is no such issue, make one! (in _their_ repo)
    - Please don't mix up your reviewers and reviewees!

** If you were assigned to a MISSING repo, please contact me @gvdr **

Check out the [guidelines for giving a peer review](http://stat545.com/peer-review02_peer-evaluation-guidelines.html).


Your_github       Instructions                                                                                                                                                                                                                                                                                                  
----------------  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
abishekarun       Please add [mylinhthibodeau](https://github.com/mylinhthibodeau) and [ZimingY](https://github.com/ZimingY) as collaborators to your repo containing hw09. Please __review the hw09 submission of [marbazua](https://github.com/marbazua) and [vmichalowski](https://github.com/vmichalowski)__.               
Alexander-Morin   Please add [AnhKhoaVo](https://github.com/AnhKhoaVo) and [rishadhabib](https://github.com/rishadhabib) as collaborators to your repo containing hw09. Please __review the hw09 submission of [Tangjiahui26](https://github.com/Tangjiahui26) and [CassKon](https://github.com/CassKon)__.                     
AnhKhoaVo         Please add [zxkathy](https://github.com/zxkathy) and [margotgunning](https://github.com/margotgunning) as collaborators to your repo containing hw09. Please __review the hw09 submission of [rishadhabib](https://github.com/rishadhabib) and [Alexander-Morin](https://github.com/Alexander-Morin)__.       
arsbar24          Please add [swynes](https://github.com/swynes) and [santiagodr](https://github.com/santiagodr) as collaborators to your repo containing hw09. Please __review the hw09 submission of [yuanjisun](https://github.com/yuanjisun) and [Mathnstein](https://github.com/Mathnstein)__.                             
arthursunbao      Please add [yanchaoluo](https://github.com/yanchaoluo) and [hannahdxz](https://github.com/hannahdxz) as collaborators to your repo containing hw09. Please __review the hw09 submission of [jmurthy12](https://github.com/jmurthy12) and [swynes](https://github.com/swynes)__.                               
bcahn7            Please add [yidie](https://github.com/yidie) and [xinmiaow](https://github.com/xinmiaow) as collaborators to your repo containing hw09. Please __review the hw09 submission of [HScheiber](https://github.com/HScheiber) and [rainerlempert](https://github.com/rainerlempert)__.                             
CassKon           Please add [Alexander-Morin](https://github.com/Alexander-Morin) and [Tangjiahui26](https://github.com/Tangjiahui26) as collaborators to your repo containing hw09. Please __review the hw09 submission of [ilgan](https://github.com/ilgan) and [mylinhthibodeau](https://github.com/mylinhthibodeau)__.     
cheungamanda      Please add [wswade2](https://github.com/wswade2) and [menglinzhou](https://github.com/menglinzhou) as collaborators to your repo containing hw09. Please __review the hw09 submission of [yidie](https://github.com/yidie) and [xinmiaow](https://github.com/xinmiaow)__.                                     
dorawyy           Please add [emilymistick](https://github.com/emilymistick) and [vanflad](https://github.com/vanflad) as collaborators to your repo containing hw09. Please __review the hw09 submission of [wenzhengzzz](https://github.com/wenzhengzzz) and [Kozp](https://github.com/Kozp)__.                               
emilymistick      Please add [emwest](https://github.com/emwest) and [heathersummers](https://github.com/heathersummers) as collaborators to your repo containing hw09. Please __review the hw09 submission of [vanflad](https://github.com/vanflad) and [dorawyy](https://github.com/dorawyy)__.                               
emwest            Please add [suminwei2772](https://github.com/suminwei2772) and [SonjaS1](https://github.com/SonjaS1) as collaborators to your repo containing hw09. Please __review the hw09 submission of [heathersummers](https://github.com/heathersummers) and [emilymistick](https://github.com/emilymistick)__.         
farihakhan        Please add [vibudh2209](https://github.com/vibudh2209) and [juansbr7](https://github.com/juansbr7) as collaborators to your repo containing hw09. Please __review the hw09 submission of [hsmohammed](https://github.com/hsmohammed) and [yeonukkim](https://github.com/yeonukkim)__.                         
gbraich           Please add [HScheiber](https://github.com/HScheiber) and [rainerlempert](https://github.com/rainerlempert) as collaborators to your repo containing hw09. Please __review the hw09 submission of [vibudh2209](https://github.com/vibudh2209) and [juansbr7](https://github.com/juansbr7)__.                   
hannahdxz         Please add [peterwhitman](https://github.com/peterwhitman) and [yanchaoluo](https://github.com/yanchaoluo) as collaborators to your repo containing hw09. Please __review the hw09 submission of [arthursunbao](https://github.com/arthursunbao) and [jmurthy12](https://github.com/jmurthy12)__.             
heathersummers    Please add [SonjaS1](https://github.com/SonjaS1) and [emwest](https://github.com/emwest) as collaborators to your repo containing hw09. Please __review the hw09 submission of [emilymistick](https://github.com/emilymistick) and [vanflad](https://github.com/vanflad)__.                                   
HScheiber         Please add [xinmiaow](https://github.com/xinmiaow) and [bcahn7](https://github.com/bcahn7) as collaborators to your repo containing hw09. Please __review the hw09 submission of [rainerlempert](https://github.com/rainerlempert) and [gbraich](https://github.com/gbraich)__.                               
hsmohammed        Please add [juansbr7](https://github.com/juansbr7) and [farihakhan](https://github.com/farihakhan) as collaborators to your repo containing hw09. Please __review the hw09 submission of [yeonukkim](https://github.com/yeonukkim) and [Shirlett](https://github.com/Shirlett)__.                             
ilgan             Please add [Tangjiahui26](https://github.com/Tangjiahui26) and [CassKon](https://github.com/CassKon) as collaborators to your repo containing hw09. Please __review the hw09 submission of [mylinhthibodeau](https://github.com/mylinhthibodeau) and [ZimingY](https://github.com/ZimingY)__.                 
jmurthy12         Please add [hannahdxz](https://github.com/hannahdxz) and [arthursunbao](https://github.com/arthursunbao) as collaborators to your repo containing hw09. Please __review the hw09 submission of [swynes](https://github.com/swynes) and [santiagodr](https://github.com/santiagodr)__.                         
juansbr7          Please add [gbraich](https://github.com/gbraich) and [vibudh2209](https://github.com/vibudh2209) as collaborators to your repo containing hw09. Please __review the hw09 submission of [farihakhan](https://github.com/farihakhan) and [hsmohammed](https://github.com/hsmohammed)__.                         
KateJohnson       Please add [yuanjisun](https://github.com/yuanjisun) and [Mathnstein](https://github.com/Mathnstein) as collaborators to your repo containing hw09. Please __review the hw09 submission of [qiaoyuet](https://github.com/qiaoyuet) and [sepkamal](https://github.com/sepkamal)__.                             
Kozp              Please add [dorawyy](https://github.com/dorawyy) and [wenzhengzzz](https://github.com/wenzhengzzz) as collaborators to your repo containing hw09. Please __review the hw09 submission of [mattsada](https://github.com/mattsada) and [peterwhitman](https://github.com/peterwhitman)__.                       
marbazua          Please add [ZimingY](https://github.com/ZimingY) and [abishekarun](https://github.com/abishekarun) as collaborators to your repo containing hw09. Please __review the hw09 submission of [vmichalowski](https://github.com/vmichalowski) and [xinyaofan](https://github.com/xinyaofan)__.                     
margotgunning     Please add [sepkamal](https://github.com/sepkamal) and [zxkathy](https://github.com/zxkathy) as collaborators to your repo containing hw09. Please __review the hw09 submission of [AnhKhoaVo](https://github.com/AnhKhoaVo) and [rishadhabib](https://github.com/rishadhabib)__.                             
Mathnstein        Please add [arsbar24](https://github.com/arsbar24) and [yuanjisun](https://github.com/yuanjisun) as collaborators to your repo containing hw09. Please __review the hw09 submission of [KateJohnson](https://github.com/KateJohnson) and [qiaoyuet](https://github.com/qiaoyuet)__.                           
mattsada          Please add [wenzhengzzz](https://github.com/wenzhengzzz) and [Kozp](https://github.com/Kozp) as collaborators to your repo containing hw09. Please __review the hw09 submission of [peterwhitman](https://github.com/peterwhitman) and [yanchaoluo](https://github.com/yanchaoluo)__.                         
menglinzhou       Please add [xinyaofan](https://github.com/xinyaofan) and [wswade2](https://github.com/wswade2) as collaborators to your repo containing hw09. Please __review the hw09 submission of [cheungamanda](https://github.com/cheungamanda) and [yidie](https://github.com/yidie)__.                                 
mlawre01          Please add [yeonukkim](https://github.com/yeonukkim) and [Shirlett](https://github.com/Shirlett) as collaborators to your repo containing hw09. Please __review the hw09 submission of [suminwei2772](https://github.com/suminwei2772) and [SonjaS1](https://github.com/SonjaS1)__.                           
mylinhthibodeau   Please add [CassKon](https://github.com/CassKon) and [ilgan](https://github.com/ilgan) as collaborators to your repo containing hw09. Please __review the hw09 submission of [ZimingY](https://github.com/ZimingY) and [abishekarun](https://github.com/abishekarun)__.                                       
peterwhitman      Please add [Kozp](https://github.com/Kozp) and [mattsada](https://github.com/mattsada) as collaborators to your repo containing hw09. Please __review the hw09 submission of [yanchaoluo](https://github.com/yanchaoluo) and [hannahdxz](https://github.com/hannahdxz)__.                                     
qiaoyuet          Please add [Mathnstein](https://github.com/Mathnstein) and [KateJohnson](https://github.com/KateJohnson) as collaborators to your repo containing hw09. Please __review the hw09 submission of [sepkamal](https://github.com/sepkamal) and [zxkathy](https://github.com/zxkathy)__.                           
rainerlempert     Please add [bcahn7](https://github.com/bcahn7) and [HScheiber](https://github.com/HScheiber) as collaborators to your repo containing hw09. Please __review the hw09 submission of [gbraich](https://github.com/gbraich) and [vibudh2209](https://github.com/vibudh2209)__.                                   
rishadhabib       Please add [margotgunning](https://github.com/margotgunning) and [AnhKhoaVo](https://github.com/AnhKhoaVo) as collaborators to your repo containing hw09. Please __review the hw09 submission of [Alexander-Morin](https://github.com/Alexander-Morin) and [Tangjiahui26](https://github.com/Tangjiahui26)__. 
santiagodr        Please add [jmurthy12](https://github.com/jmurthy12) and [swynes](https://github.com/swynes) as collaborators to your repo containing hw09. Please __review the hw09 submission of [arsbar24](https://github.com/arsbar24) and [yuanjisun](https://github.com/yuanjisun)__.                                   
sepkamal          Please add [KateJohnson](https://github.com/KateJohnson) and [qiaoyuet](https://github.com/qiaoyuet) as collaborators to your repo containing hw09. Please __review the hw09 submission of [zxkathy](https://github.com/zxkathy) and [margotgunning](https://github.com/margotgunning)__.                     
Shirlett          Please add [hsmohammed](https://github.com/hsmohammed) and [yeonukkim](https://github.com/yeonukkim) as collaborators to your repo containing hw09. Please __review the hw09 submission of [mlawre01](https://github.com/mlawre01) and [suminwei2772](https://github.com/suminwei2772)__.                     
SonjaS1           Please add [mlawre01](https://github.com/mlawre01) and [suminwei2772](https://github.com/suminwei2772) as collaborators to your repo containing hw09. Please __review the hw09 submission of [emwest](https://github.com/emwest) and [heathersummers](https://github.com/heathersummers)__.                   
suminwei2772      Please add [Shirlett](https://github.com/Shirlett) and [mlawre01](https://github.com/mlawre01) as collaborators to your repo containing hw09. Please __review the hw09 submission of [SonjaS1](https://github.com/SonjaS1) and [emwest](https://github.com/emwest)__.                                         
swynes            Please add [arthursunbao](https://github.com/arthursunbao) and [jmurthy12](https://github.com/jmurthy12) as collaborators to your repo containing hw09. Please __review the hw09 submission of [santiagodr](https://github.com/santiagodr) and [arsbar24](https://github.com/arsbar24)__.                     
Tangjiahui26      Please add [rishadhabib](https://github.com/rishadhabib) and [Alexander-Morin](https://github.com/Alexander-Morin) as collaborators to your repo containing hw09. Please __review the hw09 submission of [CassKon](https://github.com/CassKon) and [ilgan](https://github.com/ilgan)__.                       
vanflad           Please add [heathersummers](https://github.com/heathersummers) and [emilymistick](https://github.com/emilymistick) as collaborators to your repo containing hw09. Please __review the hw09 submission of [dorawyy](https://github.com/dorawyy) and [wenzhengzzz](https://github.com/wenzhengzzz)__.           
vibudh2209        Please add [rainerlempert](https://github.com/rainerlempert) and [gbraich](https://github.com/gbraich) as collaborators to your repo containing hw09. Please __review the hw09 submission of [juansbr7](https://github.com/juansbr7) and [farihakhan](https://github.com/farihakhan)__.                       
vmichalowski      Please add [abishekarun](https://github.com/abishekarun) and [marbazua](https://github.com/marbazua) as collaborators to your repo containing hw09. Please __review the hw09 submission of [xinyaofan](https://github.com/xinyaofan) and [wswade2](https://github.com/wswade2)__.                             
wenzhengzzz       Please add [vanflad](https://github.com/vanflad) and [dorawyy](https://github.com/dorawyy) as collaborators to your repo containing hw09. Please __review the hw09 submission of [Kozp](https://github.com/Kozp) and [mattsada](https://github.com/mattsada)__.                                               
wswade2           Please add [vmichalowski](https://github.com/vmichalowski) and [xinyaofan](https://github.com/xinyaofan) as collaborators to your repo containing hw09. Please __review the hw09 submission of [menglinzhou](https://github.com/menglinzhou) and [cheungamanda](https://github.com/cheungamanda)__.           
xinmiaow          Please add [cheungamanda](https://github.com/cheungamanda) and [yidie](https://github.com/yidie) as collaborators to your repo containing hw09. Please __review the hw09 submission of [bcahn7](https://github.com/bcahn7) and [HScheiber](https://github.com/HScheiber)__.                                   
xinyaofan         Please add [marbazua](https://github.com/marbazua) and [vmichalowski](https://github.com/vmichalowski) as collaborators to your repo containing hw09. Please __review the hw09 submission of [wswade2](https://github.com/wswade2) and [menglinzhou](https://github.com/menglinzhou)__.                       
yanchaoluo        Please add [mattsada](https://github.com/mattsada) and [peterwhitman](https://github.com/peterwhitman) as collaborators to your repo containing hw09. Please __review the hw09 submission of [hannahdxz](https://github.com/hannahdxz) and [arthursunbao](https://github.com/arthursunbao)__.                 
yeonukkim         Please add [farihakhan](https://github.com/farihakhan) and [hsmohammed](https://github.com/hsmohammed) as collaborators to your repo containing hw09. Please __review the hw09 submission of [Shirlett](https://github.com/Shirlett) and [mlawre01](https://github.com/mlawre01)__.                           
yidie             Please add [menglinzhou](https://github.com/menglinzhou) and [cheungamanda](https://github.com/cheungamanda) as collaborators to your repo containing hw09. Please __review the hw09 submission of [xinmiaow](https://github.com/xinmiaow) and [bcahn7](https://github.com/bcahn7)__.                         
yuanjisun         Please add [santiagodr](https://github.com/santiagodr) and [arsbar24](https://github.com/arsbar24) as collaborators to your repo containing hw09. Please __review the hw09 submission of [Mathnstein](https://github.com/Mathnstein) and [KateJohnson](https://github.com/KateJohnson)__.                     
ZimingY           Please add [ilgan](https://github.com/ilgan) and [mylinhthibodeau](https://github.com/mylinhthibodeau) as collaborators to your repo containing hw09. Please __review the hw09 submission of [abishekarun](https://github.com/abishekarun) and [marbazua](https://github.com/marbazua)__.                     
zxkathy           Please add [qiaoyuet](https://github.com/qiaoyuet) and [sepkamal](https://github.com/sepkamal) as collaborators to your repo containing hw09. Please __review the hw09 submission of [margotgunning](https://github.com/margotgunning) and [AnhKhoaVo](https://github.com/AnhKhoaVo)__.                       
