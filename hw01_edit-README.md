---
title: "Homework 01: Edit README.md and Use R Markdown"
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Overview

We assume you've been keeping up with our live class activities, which have included

  * verifying your R/RStudio/Git/GitHub setup
  * successfully rendering R Markdown

Due by midnight Tuesday 2017-09-19, but I **highly recommend** you aim to submit before class. This assignment should go smoothly, but if the computer gods do not smile upon you, we should be able to straighten things out in class or office hours.

### Create a New Repo

Create a new repo on GitHub. Your homework submission will go here. Feel free to make it either public or private. Name the repository `STAT545-hw01-lastname-firstname`. be sure to initiate the repo with a README.

Note: You can sign up for a student account to get free private repos. If you want a private repo, but can't get one on github, there are alternatives -- just ask Vincenzo.

### Edit `README.md`

When you first visit your new repo, you should see a screen like [this](img/screenshot-new-repo-with-readme.png). You need to edit your `README.md` file to welcome your visitors (you, STAT545 instructor/TAs, STAT545 peers).

If you are already familiar with GitHub, edit the `README.md` any way you wish.

If you are new to Git and GitHub, click on the `README` link in the area that looks like a file browser. Click on the pencil and make an edit. Then head down to "Commit changes". Enter a short *commit message*. Then click "Commit changes". This is how you can edit files in GitHub repository through the browser. If you are still mystified by Git(Hub), you can use this browser-based method to edit `README.md` until you get more comfortable with using Git locally and pushing to GitHub. __However, if at all possible__, we want you to pilot a more powerful workflow:

  - Pull from GitHub (just an empty precaution now, but will matter when you collaborate with others).
  - Make changes locally to local files -- RStudio is a great Markdown editor! Click Preview to see how it's going to look!
  - Save your changes.
  - Commit your changes to your repo.
  - Push the commit to GitHub.

__At the very least__, change `README.md` to something like "This is the repository of Jenny Bryan," just to prove you have been there. Practice making a link, for example, to the [main STAT545 webpage](http://stat545.com).

Much better is to introduce yourself to the class; this page is private to STAT 545 but will be visible to all students and staff. Feel free to read up on Markdown and practice with some of the syntax. Put in a photo or a GIF!

Here's a [sample readme file](https://github.com/STAT545-UBC/STAT545-UBC.github.io/blob/master/hw01_sample_readme.md) that you can use as reference and/or inspiration, and here is the [raw source](https://raw.githubusercontent.com/STAT545-UBC/STAT545-UBC.github.io/master/hw01_sample_readme.md). The *Help* menu in RStudio will bring up a Markdown Quick Reference at any time.


### Add R Markdown and Markdown for Gapminder exploration

This is optional. If you are really struggling, skip it for now. But try!

Polish and extend the R Markdown document started in class on Thursday September 14. Render it to the `github_document` output format. Commit both the `.Rmd` and `.md` files and push them to GitHub.

Give this a decent name, such as `hw01_gapminder.Rmd` (which will produce a companion file, `hw01_gapminder.md`).

### Report your process

**WE REALLY CARE ABOUT THIS! DON'T SKIP IT.**

Include a description of how you got the changes into `README.md` on GitHub.

  * Did you edit in the browser at github.com?
  * Did you pull, edit locally, save, commit, push to github.com?

How did it all work for the R Markdown document?

You're encouraged to reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc. Put this in your README. In a week or two, you can delete this bit.

### Submit the assignment

You **must** do the following to submit the assignment:

1. Add the teaching team as collaborators. Their github alias' are:

> vincenzocoia
> gvdr
> ksedivyhaley
> joeybernhardt
> mynamedaike
> pgonzaleze
> derekcho


2. Write an issue entitled `hw01 ready for grading`, and tag the above teaching team. Here's a convenient string to copy and paste to tag the team:

> @vincenzocoia @gvdr @ksedivyhaley @joeybernhardt @mynamedaike @pgonzaleze @derekcho

3. You're done!

### Rubric

Check minus: `README.md` says equivalent of "This is the repository of Jenny Bryan". All work done via browser at github.com ... but that's just a guess, because student doesn't actually say how it was done. No attempt to submit an R Markdown document exploring the Gapminder data. The homework submission issue is not named correctly, doesn't include the SHA or a link to the work to be reviewed.

Check: something in between. Student may have failed to render to the `github_document` output and commit/push the resulting `.md` file. The homework submission issue might not be perfect, but there was a good effort.

Check plus: `README.md` provides a proper introduction of student to the class. It also demonstrates experimentation with 4 or more aspects of the Markdown syntax. Examples: section headers, links, bold, italic, bullet points, image embed, etc. The student describes how they got the changes into `README.md`. Student has submitted a well-named R Markdown document with exploration of the Gapminder dataset and the rendered markdown file. Student offers a few reflections on their GitHub workflow and their experience with Markdown. The homework submission issue follows the naming convention, includes the SHA, and there's a link to the rendered `.md` for the Gapminder exploration.

## Peer Review


The peer review is ready and is due __September 25, 2017__! Here's what you'll need to do:

0. Find your github username in the table below. If it's not there, let Vincenzo know! Slack me `@vcoia`.
1. Add the _people who will be giving you a review_ as collaborators to the repo containing your Homework 01 submission.
2. Give a review of Homework 01 for the two people you've been assigned to. There should be an issue in their repo titled something like `hw01 ready for grading` -- put your review in there as a comment.
    - If there is no such issue, make one! (in _their_ repo)
    - Please don't mix up your reviewers and reviewees! 

Check out the [guidelines for giving a peer review](http://stat545.com/peer-review02_peer-evaluation-guidelines.html).

|Your github     |Instructions                                                                                                                                                                                                                                                                                     |
|:---------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|abishekarun     |Please add [vanflad](https://github.com/vanflad) and [marbazua](https://github.com/marbazua) as collaborators to your hw01 repo. Please __review the hw01 submission of [sdhanani](https://github.com/sdhanani) and [jenncscampbell](https://github.com/jenncscampbell)__.                       |
|acavalla        |Please add [hsmohammed](https://github.com/hsmohammed) and [yidie](https://github.com/yidie) as collaborators to your hw01 repo. Please __review the hw01 submission of [cindyhurtado](https://github.com/cindyhurtado) and [k3vzhu](https://github.com/k3vzhu)__.                               |
|aiod01          |Please add [vmichalowski](https://github.com/vmichalowski) and [cheungamanda](https://github.com/cheungamanda) as collaborators to your hw01 repo. Please __review the hw01 submission of [hannahdxz](https://github.com/hannahdxz) and [gbraich](https://github.com/gbraich)__.                 |
|Alexander-Morin |Please add [yuanjisun](https://github.com/yuanjisun) and [rdwyer2](https://github.com/rdwyer2) as collaborators to your hw01 repo. Please __review the hw01 submission of [burkeprw](https://github.com/burkeprw) and [diermc](https://github.com/diermc)__.                                     |
|alexrod61       |Please add [burkeprw](https://github.com/burkeprw) and [diermc](https://github.com/diermc) as collaborators to your hw01 repo. Please __review the hw01 submission of [Mathnstein](https://github.com/Mathnstein) and [Shirlett](https://github.com/Shirlett)__.                                 |
|angmelanie      |Please add [nbendriem](https://github.com/nbendriem) and [swynes](https://github.com/swynes) as collaborators to your hw01 repo. Please __review the hw01 submission of [jmurthy12](https://github.com/jmurthy12) and [rainerlempert](https://github.com/rainerlempert)__.                       |
|arsbar24        |Please add [mylinhthibodeau](https://github.com/mylinhthibodeau) and [wswade2](https://github.com/wswade2) as collaborators to your hw01 repo. Please __review the hw01 submission of [vanflad](https://github.com/vanflad) and [marbazua](https://github.com/marbazua)__.                       |
|arthursunbao    |Please add [shadowforti](https://github.com/shadowforti) and [nicolehawe](https://github.com/nicolehawe) as collaborators to your hw01 repo. Please __review the hw01 submission of [Jennica416](https://github.com/Jennica416) and [rishadhabib](https://github.com/rishadhabib)__.             |
|auduman         |Please add [yanchaoluo](https://github.com/yanchaoluo) and [estennw](https://github.com/estennw) as collaborators to your hw01 repo. Please __review the hw01 submission of [hsummers](https://github.com/hsummers) and [ZimingY](https://github.com/ZimingY)__.                                 |
|burkeprw        |Please add [rdwyer2](https://github.com/rdwyer2) and [Alexander-Morin](https://github.com/Alexander-Morin) as collaborators to your hw01 repo. Please __review the hw01 submission of [diermc](https://github.com/diermc) and [alexrod61](https://github.com/alexrod61)__.                       |
|CassKon         |Please add [navysealtf9k](https://github.com/navysealtf9k) and [peterwhitman](https://github.com/peterwhitman) as collaborators to your hw01 repo. Please __review the hw01 submission of [shadowforti](https://github.com/shadowforti) and [nicolehawe](https://github.com/nicolehawe)__.       |
|ChadFibke       |Please add [Taavita](https://github.com/Taavita) and [qiaoyuet](https://github.com/qiaoyuet) as collaborators to your hw01 repo. Please __review the hw01 submission of [yuanjisun](https://github.com/yuanjisun) and [rdwyer2](https://github.com/rdwyer2)__.                                   |
|cheungamanda    |Please add [Shirlett](https://github.com/Shirlett) and [vmichalowski](https://github.com/vmichalowski) as collaborators to your hw01 repo. Please __review the hw01 submission of [aiod01](https://github.com/aiod01) and [hannahdxz](https://github.com/hannahdxz)__.                           |
|cindyhurtado    |Please add [yidie](https://github.com/yidie) and [acavalla](https://github.com/acavalla) as collaborators to your hw01 repo. Please __review the hw01 submission of [k3vzhu](https://github.com/k3vzhu) and [teilhard1976](https://github.com/teilhard1976)__.                                   |
|danaj191        |Please add [sdhanani](https://github.com/sdhanani) and [jenncscampbell](https://github.com/jenncscampbell) as collaborators to your hw01 repo. Please __review the hw01 submission of [wenzhengzzz](https://github.com/wenzhengzzz) and [xinyaofan](https://github.com/xinyaofan)__.             |
|diermc          |Please add [Alexander-Morin](https://github.com/Alexander-Morin) and [burkeprw](https://github.com/burkeprw) as collaborators to your hw01 repo. Please __review the hw01 submission of [alexrod61](https://github.com/alexrod61) and [Mathnstein](https://github.com/Mathnstein)__.             |
|emilymistick    |Please add [mlawre01](https://github.com/mlawre01) and [juansbr7](https://github.com/juansbr7) as collaborators to your hw01 repo. Please __review the hw01 submission of [nbendriem](https://github.com/nbendriem) and [swynes](https://github.com/swynes)__.                                   |
|estennw         |Please add [rishadhabib](https://github.com/rishadhabib) and [yanchaoluo](https://github.com/yanchaoluo) as collaborators to your hw01 repo. Please __review the hw01 submission of [auduman](https://github.com/auduman) and [hsummers](https://github.com/hsummers)__.                         |
|farihakhan      |Please add [oktokat](https://github.com/oktokat) and [Tangjiahui26](https://github.com/Tangjiahui26) as collaborators to your hw01 repo. Please __review the hw01 submission of [julianheavyside](https://github.com/julianheavyside) and [yeonuk.kim.may](https://github.com/yeonuk.kim.may)__. |
|gbraich         |Please add [aiod01](https://github.com/aiod01) and [hannahdxz](https://github.com/hannahdxz) as collaborators to your hw01 repo. Please __review the hw01 submission of [OliviaTabares](https://github.com/OliviaTabares) and [NSKrstic](https://github.com/NSKrstic)__.                         |
|hannahdxz       |Please add [cheungamanda](https://github.com/cheungamanda) and [aiod01](https://github.com/aiod01) as collaborators to your hw01 repo. Please __review the hw01 submission of [gbraich](https://github.com/gbraich) and [OliviaTabares](https://github.com/OliviaTabares)__.                     |
|HScheiber       |Please add [hsummers](https://github.com/hsummers) and [ZimingY](https://github.com/ZimingY) as collaborators to your hw01 repo. Please __review the hw01 submission of [Maria815](https://github.com/Maria815) and [sepkamal](https://github.com/sepkamal)__.                                   |
|hsmohammed      |Please add [jmurthy12](https://github.com/jmurthy12) and [rainerlempert](https://github.com/rainerlempert) as collaborators to your hw01 repo. Please __review the hw01 submission of [yidie](https://github.com/yidie) and [acavalla](https://github.com/acavalla)__.                           |
|hsummers        |Please add [estennw](https://github.com/estennw) and [auduman](https://github.com/auduman) as collaborators to your hw01 repo. Please __review the hw01 submission of [ZimingY](https://github.com/ZimingY) and [HScheiber](https://github.com/HScheiber)__.                                     |
|ilgan           |Please add [menglinzhou](https://github.com/menglinzhou) and [lucymei](https://github.com/lucymei) as collaborators to your hw01 repo. Please __review the hw01 submission of [katemarjohnson](https://github.com/katemarjohnson) and [santiagodr](https://github.com/santiagodr)__.             |
|jenncscampbell  |Please add [abishekarun](https://github.com/abishekarun) and [sdhanani](https://github.com/sdhanani) as collaborators to your hw01 repo. Please __review the hw01 submission of [danaj191](https://github.com/danaj191) and [wenzhengzzz](https://github.com/wenzhengzzz)__.                     |
|Jennica416      |Please add [nicolehawe](https://github.com/nicolehawe) and [arthursunbao](https://github.com/arthursunbao) as collaborators to your hw01 repo. Please __review the hw01 submission of [rishadhabib](https://github.com/rishadhabib) and [yanchaoluo](https://github.com/yanchaoluo)__.           |
|jmurthy12       |Please add [swynes](https://github.com/swynes) and [angmelanie](https://github.com/angmelanie) as collaborators to your hw01 repo. Please __review the hw01 submission of [rainerlempert](https://github.com/rainerlempert) and [hsmohammed](https://github.com/hsmohammed)__.                   |
|juansbr7        |Please add [margotgunning](https://github.com/margotgunning) and [mlawre01](https://github.com/mlawre01) as collaborators to your hw01 repo. Please __review the hw01 submission of [emilymistick](https://github.com/emilymistick) and [nbendriem](https://github.com/nbendriem)__.             |
|julianheavyside |Please add [Tangjiahui26](https://github.com/Tangjiahui26) and [farihakhan](https://github.com/farihakhan) as collaborators to your hw01 repo. Please __review the hw01 submission of [yeonuk.kim.may](https://github.com/yeonuk.kim.may) and [Taavita](https://github.com/Taavita)__.           |
|k3vzhu          |Please add [acavalla](https://github.com/acavalla) and [cindyhurtado](https://github.com/cindyhurtado) as collaborators to your hw01 repo. Please __review the hw01 submission of [teilhard1976](https://github.com/teilhard1976) and [vibudh2209](https://github.com/vibudh2209)__.             |
|katemarjohnson  |Please add [lucymei](https://github.com/lucymei) and [ilgan](https://github.com/ilgan) as collaborators to your hw01 repo. Please __review the hw01 submission of [santiagodr](https://github.com/santiagodr) and [zxkathy](https://github.com/zxkathy)__.                                       |
|Kozp            |Please add [zxkathy](https://github.com/zxkathy) and [suminwei2772](https://github.com/suminwei2772) as collaborators to your hw01 repo. Please __review the hw01 submission of [xinmiaow](https://github.com/xinmiaow) and [margotgunning](https://github.com/margotgunning)__.                 |
|lucymei         |Please add [sepkamal](https://github.com/sepkamal) and [menglinzhou](https://github.com/menglinzhou) as collaborators to your hw01 repo. Please __review the hw01 submission of [ilgan](https://github.com/ilgan) and [katemarjohnson](https://github.com/katemarjohnson)__.                     |
|marbazua        |Please add [arsbar24](https://github.com/arsbar24) and [vanflad](https://github.com/vanflad) as collaborators to your hw01 repo. Please __review the hw01 submission of [abishekarun](https://github.com/abishekarun) and [sdhanani](https://github.com/sdhanani)__.                             |
|margotgunning   |Please add [Kozp](https://github.com/Kozp) and [xinmiaow](https://github.com/xinmiaow) as collaborators to your hw01 repo. Please __review the hw01 submission of [mlawre01](https://github.com/mlawre01) and [juansbr7](https://github.com/juansbr7)__.                                         |
|Maria815        |Please add [ZimingY](https://github.com/ZimingY) and [HScheiber](https://github.com/HScheiber) as collaborators to your hw01 repo. Please __review the hw01 submission of [sepkamal](https://github.com/sepkamal) and [menglinzhou](https://github.com/menglinzhou)__.                           |
|Mathnstein      |Please add [diermc](https://github.com/diermc) and [alexrod61](https://github.com/alexrod61) as collaborators to your hw01 repo. Please __review the hw01 submission of [Shirlett](https://github.com/Shirlett) and [vmichalowski](https://github.com/vmichalowski)__.                           |
|menglinzhou     |Please add [Maria815](https://github.com/Maria815) and [sepkamal](https://github.com/sepkamal) as collaborators to your hw01 repo. Please __review the hw01 submission of [lucymei](https://github.com/lucymei) and [ilgan](https://github.com/ilgan)__.                                         |
|mlawre01        |Please add [xinmiaow](https://github.com/xinmiaow) and [margotgunning](https://github.com/margotgunning) as collaborators to your hw01 repo. Please __review the hw01 submission of [juansbr7](https://github.com/juansbr7) and [emilymistick](https://github.com/emilymistick)__.               |
|mylinhthibodeau |Please add [OliviaTabares](https://github.com/OliviaTabares) and [NSKrstic](https://github.com/NSKrstic) as collaborators to your hw01 repo. Please __review the hw01 submission of [wswade2](https://github.com/wswade2) and [arsbar24](https://github.com/arsbar24)__.                         |
|navysealtf9k    |Please add [wenzhengzzz](https://github.com/wenzhengzzz) and [xinyaofan](https://github.com/xinyaofan) as collaborators to your hw01 repo. Please __review the hw01 submission of [peterwhitman](https://github.com/peterwhitman) and [CassKon](https://github.com/CassKon)__.                   |
|nbendriem       |Please add [juansbr7](https://github.com/juansbr7) and [emilymistick](https://github.com/emilymistick) as collaborators to your hw01 repo. Please __review the hw01 submission of [swynes](https://github.com/swynes) and [angmelanie](https://github.com/angmelanie)__.                         |
|nicolehawe      |Please add [CassKon](https://github.com/CassKon) and [shadowforti](https://github.com/shadowforti) as collaborators to your hw01 repo. Please __review the hw01 submission of [arthursunbao](https://github.com/arthursunbao) and [Jennica416](https://github.com/Jennica416)__.                 |
|NSKrstic        |Please add [gbraich](https://github.com/gbraich) and [OliviaTabares](https://github.com/OliviaTabares) as collaborators to your hw01 repo. Please __review the hw01 submission of [mylinhthibodeau](https://github.com/mylinhthibodeau) and [wswade2](https://github.com/wswade2)__.             |
|oktokat         |Please add [susannaelsie](https://github.com/susannaelsie) and [SonjaS1](https://github.com/SonjaS1) as collaborators to your hw01 repo. Please __review the hw01 submission of [Tangjiahui26](https://github.com/Tangjiahui26) and [farihakhan](https://github.com/farihakhan)__.               |
|OliviaTabares   |Please add [hannahdxz](https://github.com/hannahdxz) and [gbraich](https://github.com/gbraich) as collaborators to your hw01 repo. Please __review the hw01 submission of [NSKrstic](https://github.com/NSKrstic) and [mylinhthibodeau](https://github.com/mylinhthibodeau)__.                   |
|peterwhitman    |Please add [xinyaofan](https://github.com/xinyaofan) and [navysealtf9k](https://github.com/navysealtf9k) as collaborators to your hw01 repo. Please __review the hw01 submission of [CassKon](https://github.com/CassKon) and [shadowforti](https://github.com/shadowforti)__.                   |
|qiaoyuet        |Please add [yeonuk.kim.may](https://github.com/yeonuk.kim.may) and [Taavita](https://github.com/Taavita) as collaborators to your hw01 repo. Please __review the hw01 submission of [ChadFibke](https://github.com/ChadFibke) and [yuanjisun](https://github.com/yuanjisun)__.                   |
|rainerlempert   |Please add [angmelanie](https://github.com/angmelanie) and [jmurthy12](https://github.com/jmurthy12) as collaborators to your hw01 repo. Please __review the hw01 submission of [hsmohammed](https://github.com/hsmohammed) and [yidie](https://github.com/yidie)__.                             |
|rdwyer2         |Please add [ChadFibke](https://github.com/ChadFibke) and [yuanjisun](https://github.com/yuanjisun) as collaborators to your hw01 repo. Please __review the hw01 submission of [Alexander-Morin](https://github.com/Alexander-Morin) and [burkeprw](https://github.com/burkeprw)__.               |
|rishadhabib     |Please add [arthursunbao](https://github.com/arthursunbao) and [Jennica416](https://github.com/Jennica416) as collaborators to your hw01 repo. Please __review the hw01 submission of [yanchaoluo](https://github.com/yanchaoluo) and [estennw](https://github.com/estennw)__.                   |
|santiagodr      |Please add [ilgan](https://github.com/ilgan) and [katemarjohnson](https://github.com/katemarjohnson) as collaborators to your hw01 repo. Please __review the hw01 submission of [zxkathy](https://github.com/zxkathy) and [suminwei2772](https://github.com/suminwei2772)__.                     |
|sdhanani        |Please add [marbazua](https://github.com/marbazua) and [abishekarun](https://github.com/abishekarun) as collaborators to your hw01 repo. Please __review the hw01 submission of [jenncscampbell](https://github.com/jenncscampbell) and [danaj191](https://github.com/danaj191)__.               |
|sepkamal        |Please add [HScheiber](https://github.com/HScheiber) and [Maria815](https://github.com/Maria815) as collaborators to your hw01 repo. Please __review the hw01 submission of [menglinzhou](https://github.com/menglinzhou) and [lucymei](https://github.com/lucymei)__.                           |
|shadowforti     |Please add [peterwhitman](https://github.com/peterwhitman) and [CassKon](https://github.com/CassKon) as collaborators to your hw01 repo. Please __review the hw01 submission of [nicolehawe](https://github.com/nicolehawe) and [arthursunbao](https://github.com/arthursunbao)__.               |
|Shirlett        |Please add [alexrod61](https://github.com/alexrod61) and [Mathnstein](https://github.com/Mathnstein) as collaborators to your hw01 repo. Please __review the hw01 submission of [vmichalowski](https://github.com/vmichalowski) and [cheungamanda](https://github.com/cheungamanda)__.           |
|SonjaS1         |Please add [vibudh2209](https://github.com/vibudh2209) and [susannaelsie](https://github.com/susannaelsie) as collaborators to your hw01 repo. Please __review the hw01 submission of [oktokat](https://github.com/oktokat) and [Tangjiahui26](https://github.com/Tangjiahui26)__.               |
|suminwei2772    |Please add [santiagodr](https://github.com/santiagodr) and [zxkathy](https://github.com/zxkathy) as collaborators to your hw01 repo. Please __review the hw01 submission of [Kozp](https://github.com/Kozp) and [xinmiaow](https://github.com/xinmiaow)__.                                       |
|susannaelsie    |Please add [teilhard1976](https://github.com/teilhard1976) and [vibudh2209](https://github.com/vibudh2209) as collaborators to your hw01 repo. Please __review the hw01 submission of [SonjaS1](https://github.com/SonjaS1) and [oktokat](https://github.com/oktokat)__.                         |
|swynes          |Please add [emilymistick](https://github.com/emilymistick) and [nbendriem](https://github.com/nbendriem) as collaborators to your hw01 repo. Please __review the hw01 submission of [angmelanie](https://github.com/angmelanie) and [jmurthy12](https://github.com/jmurthy12)__.                 |
|Taavita         |Please add [julianheavyside](https://github.com/julianheavyside) and [yeonuk.kim.may](https://github.com/yeonuk.kim.may) as collaborators to your hw01 repo. Please __review the hw01 submission of [qiaoyuet](https://github.com/qiaoyuet) and [ChadFibke](https://github.com/ChadFibke)__.     |
|Tangjiahui26    |Please add [SonjaS1](https://github.com/SonjaS1) and [oktokat](https://github.com/oktokat) as collaborators to your hw01 repo. Please __review the hw01 submission of [farihakhan](https://github.com/farihakhan) and [julianheavyside](https://github.com/julianheavyside)__.                   |
|teilhard1976    |Please add [cindyhurtado](https://github.com/cindyhurtado) and [k3vzhu](https://github.com/k3vzhu) as collaborators to your hw01 repo. Please __review the hw01 submission of [vibudh2209](https://github.com/vibudh2209) and [susannaelsie](https://github.com/susannaelsie)__.                 |
|vanflad         |Please add [wswade2](https://github.com/wswade2) and [arsbar24](https://github.com/arsbar24) as collaborators to your hw01 repo. Please __review the hw01 submission of [marbazua](https://github.com/marbazua) and [abishekarun](https://github.com/abishekarun)__.                             |
|vibudh2209      |Please add [k3vzhu](https://github.com/k3vzhu) and [teilhard1976](https://github.com/teilhard1976) as collaborators to your hw01 repo. Please __review the hw01 submission of [susannaelsie](https://github.com/susannaelsie) and [SonjaS1](https://github.com/SonjaS1)__.                       |
|vmichalowski    |Please add [Mathnstein](https://github.com/Mathnstein) and [Shirlett](https://github.com/Shirlett) as collaborators to your hw01 repo. Please __review the hw01 submission of [cheungamanda](https://github.com/cheungamanda) and [aiod01](https://github.com/aiod01)__.                         |
|wenzhengzzz     |Please add [jenncscampbell](https://github.com/jenncscampbell) and [danaj191](https://github.com/danaj191) as collaborators to your hw01 repo. Please __review the hw01 submission of [xinyaofan](https://github.com/xinyaofan) and [navysealtf9k](https://github.com/navysealtf9k)__.           |
|wswade2         |Please add [NSKrstic](https://github.com/NSKrstic) and [mylinhthibodeau](https://github.com/mylinhthibodeau) as collaborators to your hw01 repo. Please __review the hw01 submission of [arsbar24](https://github.com/arsbar24) and [vanflad](https://github.com/vanflad)__.                     |
|xinmiaow        |Please add [suminwei2772](https://github.com/suminwei2772) and [Kozp](https://github.com/Kozp) as collaborators to your hw01 repo. Please __review the hw01 submission of [margotgunning](https://github.com/margotgunning) and [mlawre01](https://github.com/mlawre01)__.                       |
|xinyaofan       |Please add [danaj191](https://github.com/danaj191) and [wenzhengzzz](https://github.com/wenzhengzzz) as collaborators to your hw01 repo. Please __review the hw01 submission of [navysealtf9k](https://github.com/navysealtf9k) and [peterwhitman](https://github.com/peterwhitman)__.           |
|yanchaoluo      |Please add [Jennica416](https://github.com/Jennica416) and [rishadhabib](https://github.com/rishadhabib) as collaborators to your hw01 repo. Please __review the hw01 submission of [estennw](https://github.com/estennw) and [auduman](https://github.com/auduman)__.                           |
|yeonuk.kim.may  |Please add [farihakhan](https://github.com/farihakhan) and [julianheavyside](https://github.com/julianheavyside) as collaborators to your hw01 repo. Please __review the hw01 submission of [Taavita](https://github.com/Taavita) and [qiaoyuet](https://github.com/qiaoyuet)__.                 |
|yidie           |Please add [rainerlempert](https://github.com/rainerlempert) and [hsmohammed](https://github.com/hsmohammed) as collaborators to your hw01 repo. Please __review the hw01 submission of [acavalla](https://github.com/acavalla) and [cindyhurtado](https://github.com/cindyhurtado)__.           |
|yuanjisun       |Please add [qiaoyuet](https://github.com/qiaoyuet) and [ChadFibke](https://github.com/ChadFibke) as collaborators to your hw01 repo. Please __review the hw01 submission of [rdwyer2](https://github.com/rdwyer2) and [Alexander-Morin](https://github.com/Alexander-Morin)__.                   |
|ZimingY         |Please add [auduman](https://github.com/auduman) and [hsummers](https://github.com/hsummers) as collaborators to your hw01 repo. Please __review the hw01 submission of [HScheiber](https://github.com/HScheiber) and [Maria815](https://github.com/Maria815)__.                                 |
|zxkathy         |Please add [katemarjohnson](https://github.com/katemarjohnson) and [santiagodr](https://github.com/santiagodr) as collaborators to your hw01 repo. Please __review the hw01 submission of [suminwei2772](https://github.com/suminwei2772) and [Kozp](https://github.com/Kozp)__.                 |
