---
title: "Building Shiny apps - Homework"
author: "Dean Attali (with minor edits by gvdr)"
output:
  html_document:
    toc: yes
    toc_depth: 4
---

## Deadline

The homework is due Tuesday, November 21 2017.

## What we've done

This week we create a Shiny app that lets you search for products from the BC Liquor Store based on price, alcohol type, and country. We used [this dataset](https://github.com/STAT545-UBC/STAT545-UBC.github.io/blob/master/shiny_supp/2016/bcl-data.csv) and [this code](./shiny01_activity.html#final-shiny-app-code) for our app.

## What you need to do

**Build a new Shiny app**

The app we developed is functional, but there are plenty of improvements that can be made. You can compare the app we developed to [Dean's version of this app](http://daattali.com/shiny/bcl/) to get an idea of what a more functional app could include. For the homework, you need to either develop a new Shiny app, using your preferred dataset (or one you want to know more about). If you are short on ideas, you can instead add 3 or more features to the BC Liquor Store app we developed together.

### Building details

Regardless of whether you create a new app or just add new features to our BC Liquor Store app, you **must** do the following 5 things:

1. Your app should be split into a `ui.R` file and a `server.R` file. Note that so far in class we only had our apps inside an `app.R` file. You can read [this official Shiny help page](http://shiny.rstudio.com/articles/app-formats.html) if you need more help with this part.

2. Your app should be deployed online on [shinyapps.io](http://www.shinyapps.io). Make sure your app actually works online (sometimes your app will work in RStudio but will have errors on shinyapps.io - make sure you deploy early and often to make debugging easier).
    - If you want to really challenge yourself, you can try getting your own Shiny Server and host your app yourself. Read [this tutorial](http://deanattali.com/2015/05/09/setup-rstudio-shiny-server-digital-ocean/) for help on setting that up.

3. Add a `README.md` file to your Shiny app folder in your course repository. In the `README.md` you should describe your app and add a link to the URL where the app is hosted.

4. Include the code for your Shiny app in your repository, as the marker will need to review your code.

5. Whatever dataset you will use, acknowledge its source clearly and extensively. Remember that we value open, reproducible science: this means that the user of your app should have direct access to the data, or know where to go to access it.

#### Possible features for the BC Liquor Store app.

If you decide to create a new app, then you are free to do whatever you want - get creative! If you want to use the BC Liquor Store app, you need to add at least 3 new features to it. There are countless possibilities, but here are just a few ideas. Notice: you may want to read this and get inspired even if you'll develop your own shiny app. You can choose any 3 or more ideas from this list or do anything else.

- Add an option to sort the results table by price.
    - **Hint:** Use `checkboxInput()` to get TRUE/FALSE values from the user.

- Add an image of the BC Liquor Store to the UI.
    - **Hint:** Place the image in a folder named `www`, and use `img(src = "imagename.png")` to add the image.

- Use the `DT` package to turn the current results table into an interactive table.
    - **Hint:** Install the `DT` package, replace `tableOutput()` with `DT::dataTableOutput()` and replace `renderTable()` with `DT::renderDataTable()`.

- Add parameters to the plot.
    - **Hint:** You will need to add input functions that will be used as parameters for the plot. You could use `shinyjs::colourInput()` to let the user decide on the colours of the bars in the plot.

- The app currently behaves strangely when the user selects filters that return 0 results. For example, try searching for wines from Belgium. There will be an empty plot and empty table generated, and there will be a warning message in the R console. Try to figure out why this warning message is appearing, and how to fix it.
    - **Hint:** The problem happens because `renderPlot()` and `renderTable()` are trying to render an empty data frame. To fix this issue, the `filtered` reactive expression should check for the number of rows in the filtered data, and if that number is 0 then return `NULL` instead of a 0-row data frame.

- Place the plot and the table in separate tabs.
    - **Hint:** Use `tabsetPanel()` to create an interface with multiple tabs.

- If you know CSS, add CSS to make your app look nicer.
    - **Hint:** Add a CSS file under `www` and use the function `includeCSS()` to use it in your app.

- Experiment with packages that add extra features to Shiny, such as `shinyjs`, `leaflet`, `shinydashboard`, `shinythemes`, `ggvis`.
    - **Hint:** Each package is unique and has a different purpose, so you need to read the documentation of each package in order to know what it provides and how to use it.

- Show the number of results found whenever the filters change. For example, when searching for Italian wines $20-$40, the app would show the text "We found 122 options for you".
    - **Hint:** Add a `textOutput()` to the UI, and in its corresponding `renderText()` use the number of rows in the `filtered()` object.

- Allow the user to download the results table as a .`.csv` file.
    - **Hint:** Look into the `downloadButton()` and `downloadHandler()` functions.

- When the user wants to see only wines, show a new input that allows the user to filter by sweetness level. Only show this input if wines are selected.
    - **Hint:** Create a new input function for the sweetness level, and use it in the server code that filters the data. Use `conditionalPanel()` to conditionally show this new input. The `condition` argument of `conditionalPanel` should be something like `input.typeInput == "WINE"`.

- Allow the user to search for multiple alcohol types simultaneously, instead of being able to choose only wines/beers/etc.
    - **Hint:** There are two approaches to do this. Either change the `typeInput` radio buttons into checkboxes (`checkboxGroupInput()`) since checkboxes support choosing multiple items, or change `typeInput` into a select box (`selectInput()`) with the argument `multiple = TRUE` to support choosing multiple options.

- If you look at the dataset, you'll see that each product has a "type" (beer, wine, spirit, or refreshment) and also a "subtype" (red wine, rum, cider, etc.). Add an input for "subtype" that will let the user filter for only a specific subtype of products. Since each type has different subtype options, the choices for subtype should get re-generated every time a new type is chosen. For example, if "wine" is selected, then the subtypes available should be white wine, red wine, etc.
    - **Hint:** Use `uiOutput()` to create this input in the server code.

- Provide a way for the user to show results from *all* countries (instead of forcing a filter by only one specific country).
    - **Hint:** There are two ways to approach this. You can either add a value of "All" to the dropdown list of country options, you can include a checkbox for "Filter by country" and only show the dropdown when it is unchecked (see [my version of this app](http://daattali.com/shiny/bcl/) to see this option in action). In both cases you'll still need to update the server code appropriately to filter by country only when the user chooses to.

## Resources

Don't forget to check out some of the [awesome resources](./shiny01_activity.html#resources) for Shiny, they can really help you out.

## Rubric

Your peer reviewer will evaluate your app based only on the Shiny app that you deploy and on the `README.md` file that described what you app does. Your peer reviewer will not download your code. Therefore, you really need to make sure your app works on shinyapps.io, otherwise your reviewer will not be able to give you a mark.

The course TA that will mark your assignment will also look at your code, so make sure you include the code for the app.

Check minus: The deployed app does not work or results in many errors. There is no `README` file describing what app does.

Check: Shiny app runs. The `README` file describes either a new app or 3+ additions to our BC Liquor Store app. Whatever is described in the README is actually implemented in the app.

Check plus: Amazing Shiny app. Lots of new features or a very cool new app idea. App looks great visually. App is deployed on a Shiny Server instead of on shinyapps.io.

Recall the [general homework rubric](http://stat545-ubc.github.io/peer-review01_marking-rubric.html).

## Peer Review


The peer review is ready and is due __November 24, 2017__ (before midnight)! Here's what you'll need to do:

0. Find your github username in the table below. If it's not there, let Giulio know! Slack me `@giulio`.
1. Add the _people who will be giving you a review_ as collaborators to the repo containing your homework submission.
2. Give a review of this homework for the two people you've been assigned to. There should be an issue in their repo titled something like `hw0x ready for grading` -- put your review in there as a comment.
    - If there is no such issue, make one! (in _their_ repo)
    - Please don't mix up your reviewers and reviewees!

** If you were assigned to a MISSING repo, please contact me @gvdr **

** If you did not yet communicate me your github handle, please do **

Check out the [guidelines for giving a peer review](http://stat545.com/peer-review02_peer-evaluation-guidelines.html).


Your_github       Instructions                                                                                                                                                                                                                                                                                            
----------------  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
abishekarun       Please add [Shirlett](https://github.com/Shirlett) and [Alexander-Morin](https://github.com/Alexander-Morin) as collaborators to your repo containing hw08. Please __review the hw08 submission of [zxkathy](https://github.com/zxkathy) and [yeonukkim](https://github.com/yeonukkim)__.               
Alexander-Morin   Please add [Mathnstein](https://github.com/Mathnstein) and [Shirlett](https://github.com/Shirlett) as collaborators to your repo containing hw08. Please __review the hw08 submission of [abishekarun](https://github.com/abishekarun) and [zxkathy](https://github.com/zxkathy)__.                     
AnhKhoaVo         Please add [juansbr7](https://github.com/juansbr7) and [swynes](https://github.com/swynes) as collaborators to your repo containing hw08. Please __review the hw08 submission of [santiagodr](https://github.com/santiagodr) and [hannahdxz](https://github.com/hannahdxz)__.                           
arsbar24          Please add [ZimingY](https://github.com/ZimingY) and [heathersummers](https://github.com/heathersummers) as collaborators to your repo containing hw08. Please __review the hw08 submission of [jmurthy12](https://github.com/jmurthy12) and [HScheiber](https://github.com/HScheiber)__.               
arthursunbao      Please add [wswade2](https://github.com/wswade2) and [suminwei2772](https://github.com/suminwei2772) as collaborators to your repo containing hw08. Please __review the hw08 submission of [farihakhan](https://github.com/farihakhan) and [Tangjiahui26](https://github.com/Tangjiahui26)__.           
bcahn7            Please add [sepkamal](https://github.com/sepkamal) and [Kozp](https://github.com/Kozp) as collaborators to your repo containing hw08. Please __review the hw08 submission of [wenzhengzzz](https://github.com/wenzhengzzz) and [xinyaofan](https://github.com/xinyaofan)__.                             
CassKon           Please add [peterwhitman](https://github.com/peterwhitman) and [ilgan](https://github.com/ilgan) as collaborators to your repo containing hw08. Please __review the hw08 submission of [cheungamanda](https://github.com/cheungamanda) and [vanflad](https://github.com/vanflad)__.                     
cheungamanda      Please add [ilgan](https://github.com/ilgan) and [CassKon](https://github.com/CassKon) as collaborators to your repo containing hw08. Please __review the hw08 submission of [vanflad](https://github.com/vanflad) and [margotgunning](https://github.com/margotgunning)__.                             
dorawyy           Please add [gbraich](https://github.com/gbraich) and [rishadhabib](https://github.com/rishadhabib) as collaborators to your repo containing hw08. Please __review the hw08 submission of [marbazua](https://github.com/marbazua) and [SonjaS1](https://github.com/SonjaS1)__.                           
emilymistick      Please add [rainerlempert](https://github.com/rainerlempert) and [xinmiaow](https://github.com/xinmiaow) as collaborators to your repo containing hw08. Please __review the hw08 submission of [emwest](https://github.com/emwest) and [hsmohammed](https://github.com/hsmohammed)__.                   
emwest            Please add [xinmiaow](https://github.com/xinmiaow) and [emilymistick](https://github.com/emilymistick) as collaborators to your repo containing hw08. Please __review the hw08 submission of [hsmohammed](https://github.com/hsmohammed) and [Mathnstein](https://github.com/Mathnstein)__.             
farihakhan        Please add [suminwei2772](https://github.com/suminwei2772) and [arthursunbao](https://github.com/arthursunbao) as collaborators to your repo containing hw08. Please __review the hw08 submission of [Tangjiahui26](https://github.com/Tangjiahui26) and [gbraich](https://github.com/gbraich)__.       
gbraich           Please add [farihakhan](https://github.com/farihakhan) and [Tangjiahui26](https://github.com/Tangjiahui26) as collaborators to your repo containing hw08. Please __review the hw08 submission of [rishadhabib](https://github.com/rishadhabib) and [dorawyy](https://github.com/dorawyy)__.             
hannahdxz         Please add [AnhKhoaVo](https://github.com/AnhKhoaVo) and [santiagodr](https://github.com/santiagodr) as collaborators to your repo containing hw08. Please __review the hw08 submission of [yanchaoluo](https://github.com/yanchaoluo) and [vibudh2209](https://github.com/vibudh2209)__.               
heathersummers    Please add [mylinhthibodeau](https://github.com/mylinhthibodeau) and [ZimingY](https://github.com/ZimingY) as collaborators to your repo containing hw08. Please __review the hw08 submission of [arsbar24](https://github.com/arsbar24) and [jmurthy12](https://github.com/jmurthy12)__.               
HScheiber         Please add [arsbar24](https://github.com/arsbar24) and [jmurthy12](https://github.com/jmurthy12) as collaborators to your repo containing hw08. Please __review the hw08 submission of [juansbr7](https://github.com/juansbr7) and [swynes](https://github.com/swynes)__.                               
hsmohammed        Please add [emilymistick](https://github.com/emilymistick) and [emwest](https://github.com/emwest) as collaborators to your repo containing hw08. Please __review the hw08 submission of [Mathnstein](https://github.com/Mathnstein) and [Shirlett](https://github.com/Shirlett)__.                     
ilgan             Please add [yuanjisun](https://github.com/yuanjisun) and [peterwhitman](https://github.com/peterwhitman) as collaborators to your repo containing hw08. Please __review the hw08 submission of [CassKon](https://github.com/CassKon) and [cheungamanda](https://github.com/cheungamanda)__.             
jmurthy12         Please add [heathersummers](https://github.com/heathersummers) and [arsbar24](https://github.com/arsbar24) as collaborators to your repo containing hw08. Please __review the hw08 submission of [HScheiber](https://github.com/HScheiber) and [juansbr7](https://github.com/juansbr7)__.               
juansbr7          Please add [jmurthy12](https://github.com/jmurthy12) and [HScheiber](https://github.com/HScheiber) as collaborators to your repo containing hw08. Please __review the hw08 submission of [swynes](https://github.com/swynes) and [AnhKhoaVo](https://github.com/AnhKhoaVo)__.                           
KateJohnson       Please add [yeonukkim](https://github.com/yeonukkim) and [qiaoyuet](https://github.com/qiaoyuet) as collaborators to your repo containing hw08. Please __review the hw08 submission of [yuanjisun](https://github.com/yuanjisun) and [peterwhitman](https://github.com/peterwhitman)__.                 
Kozp              Please add [menglinzhou](https://github.com/menglinzhou) and [sepkamal](https://github.com/sepkamal) as collaborators to your repo containing hw08. Please __review the hw08 submission of [bcahn7](https://github.com/bcahn7) and [wenzhengzzz](https://github.com/wenzhengzzz)__.                     
marbazua          Please add [rishadhabib](https://github.com/rishadhabib) and [dorawyy](https://github.com/dorawyy) as collaborators to your repo containing hw08. Please __review the hw08 submission of [SonjaS1](https://github.com/SonjaS1) and [rainerlempert](https://github.com/rainerlempert)__.                 
margotgunning     Please add [cheungamanda](https://github.com/cheungamanda) and [vanflad](https://github.com/vanflad) as collaborators to your repo containing hw08. Please __review the hw08 submission of [yidie](https://github.com/yidie) and [mlawre01](https://github.com/mlawre01)__.                             
Mathnstein        Please add [emwest](https://github.com/emwest) and [hsmohammed](https://github.com/hsmohammed) as collaborators to your repo containing hw08. Please __review the hw08 submission of [Shirlett](https://github.com/Shirlett) and [Alexander-Morin](https://github.com/Alexander-Morin)__.               
mattsada          Please add [mlawre01](https://github.com/mlawre01) and [vmichalowski](https://github.com/vmichalowski) as collaborators to your repo containing hw08. Please __review the hw08 submission of [mylinhthibodeau](https://github.com/mylinhthibodeau) and [ZimingY](https://github.com/ZimingY)__.         
menglinzhou       Please add [yanchaoluo](https://github.com/yanchaoluo) and [vibudh2209](https://github.com/vibudh2209) as collaborators to your repo containing hw08. Please __review the hw08 submission of [sepkamal](https://github.com/sepkamal) and [Kozp](https://github.com/Kozp)__.                             
mlawre01          Please add [margotgunning](https://github.com/margotgunning) and [yidie](https://github.com/yidie) as collaborators to your repo containing hw08. Please __review the hw08 submission of [vmichalowski](https://github.com/vmichalowski) and [mattsada](https://github.com/mattsada)__.                 
mylinhthibodeau   Please add [vmichalowski](https://github.com/vmichalowski) and [mattsada](https://github.com/mattsada) as collaborators to your repo containing hw08. Please __review the hw08 submission of [ZimingY](https://github.com/ZimingY) and [heathersummers](https://github.com/heathersummers)__.           
peterwhitman      Please add [KateJohnson](https://github.com/KateJohnson) and [yuanjisun](https://github.com/yuanjisun) as collaborators to your repo containing hw08. Please __review the hw08 submission of [ilgan](https://github.com/ilgan) and [CassKon](https://github.com/CassKon)__.                             
qiaoyuet          Please add [zxkathy](https://github.com/zxkathy) and [yeonukkim](https://github.com/yeonukkim) as collaborators to your repo containing hw08. Please __review the hw08 submission of [KateJohnson](https://github.com/KateJohnson) and [yuanjisun](https://github.com/yuanjisun)__.                     
rainerlempert     Please add [marbazua](https://github.com/marbazua) and [SonjaS1](https://github.com/SonjaS1) as collaborators to your repo containing hw08. Please __review the hw08 submission of [xinmiaow](https://github.com/xinmiaow) and [emilymistick](https://github.com/emilymistick)__.                       
rishadhabib       Please add [Tangjiahui26](https://github.com/Tangjiahui26) and [gbraich](https://github.com/gbraich) as collaborators to your repo containing hw08. Please __review the hw08 submission of [dorawyy](https://github.com/dorawyy) and [marbazua](https://github.com/marbazua)__.                         
santiagodr        Please add [swynes](https://github.com/swynes) and [AnhKhoaVo](https://github.com/AnhKhoaVo) as collaborators to your repo containing hw08. Please __review the hw08 submission of [hannahdxz](https://github.com/hannahdxz) and [yanchaoluo](https://github.com/yanchaoluo)__.                         
sepkamal          Please add [vibudh2209](https://github.com/vibudh2209) and [menglinzhou](https://github.com/menglinzhou) as collaborators to your repo containing hw08. Please __review the hw08 submission of [Kozp](https://github.com/Kozp) and [bcahn7](https://github.com/bcahn7)__.                               
Shirlett          Please add [hsmohammed](https://github.com/hsmohammed) and [Mathnstein](https://github.com/Mathnstein) as collaborators to your repo containing hw08. Please __review the hw08 submission of [Alexander-Morin](https://github.com/Alexander-Morin) and [abishekarun](https://github.com/abishekarun)__. 
SonjaS1           Please add [dorawyy](https://github.com/dorawyy) and [marbazua](https://github.com/marbazua) as collaborators to your repo containing hw08. Please __review the hw08 submission of [rainerlempert](https://github.com/rainerlempert) and [xinmiaow](https://github.com/xinmiaow)__.                     
suminwei2772      Please add [xinyaofan](https://github.com/xinyaofan) and [wswade2](https://github.com/wswade2) as collaborators to your repo containing hw08. Please __review the hw08 submission of [arthursunbao](https://github.com/arthursunbao) and [farihakhan](https://github.com/farihakhan)__.                 
swynes            Please add [HScheiber](https://github.com/HScheiber) and [juansbr7](https://github.com/juansbr7) as collaborators to your repo containing hw08. Please __review the hw08 submission of [AnhKhoaVo](https://github.com/AnhKhoaVo) and [santiagodr](https://github.com/santiagodr)__.                     
Tangjiahui26      Please add [arthursunbao](https://github.com/arthursunbao) and [farihakhan](https://github.com/farihakhan) as collaborators to your repo containing hw08. Please __review the hw08 submission of [gbraich](https://github.com/gbraich) and [rishadhabib](https://github.com/rishadhabib)__.             
vanflad           Please add [CassKon](https://github.com/CassKon) and [cheungamanda](https://github.com/cheungamanda) as collaborators to your repo containing hw08. Please __review the hw08 submission of [margotgunning](https://github.com/margotgunning) and [yidie](https://github.com/yidie)__.                   
vibudh2209        Please add [hannahdxz](https://github.com/hannahdxz) and [yanchaoluo](https://github.com/yanchaoluo) as collaborators to your repo containing hw08. Please __review the hw08 submission of [menglinzhou](https://github.com/menglinzhou) and [sepkamal](https://github.com/sepkamal)__.                 
vmichalowski      Please add [yidie](https://github.com/yidie) and [mlawre01](https://github.com/mlawre01) as collaborators to your repo containing hw08. Please __review the hw08 submission of [mattsada](https://github.com/mattsada) and [mylinhthibodeau](https://github.com/mylinhthibodeau)__.                     
wenzhengzzz       Please add [Kozp](https://github.com/Kozp) and [bcahn7](https://github.com/bcahn7) as collaborators to your repo containing hw08. Please __review the hw08 submission of [xinyaofan](https://github.com/xinyaofan) and [wswade2](https://github.com/wswade2)__.                                         
wswade2           Please add [wenzhengzzz](https://github.com/wenzhengzzz) and [xinyaofan](https://github.com/xinyaofan) as collaborators to your repo containing hw08. Please __review the hw08 submission of [suminwei2772](https://github.com/suminwei2772) and [arthursunbao](https://github.com/arthursunbao)__.     
xinmiaow          Please add [SonjaS1](https://github.com/SonjaS1) and [rainerlempert](https://github.com/rainerlempert) as collaborators to your repo containing hw08. Please __review the hw08 submission of [emilymistick](https://github.com/emilymistick) and [emwest](https://github.com/emwest)__.                 
xinyaofan         Please add [bcahn7](https://github.com/bcahn7) and [wenzhengzzz](https://github.com/wenzhengzzz) as collaborators to your repo containing hw08. Please __review the hw08 submission of [wswade2](https://github.com/wswade2) and [suminwei2772](https://github.com/suminwei2772)__.                     
yanchaoluo        Please add [santiagodr](https://github.com/santiagodr) and [hannahdxz](https://github.com/hannahdxz) as collaborators to your repo containing hw08. Please __review the hw08 submission of [vibudh2209](https://github.com/vibudh2209) and [menglinzhou](https://github.com/menglinzhou)__.             
yeonukkim         Please add [abishekarun](https://github.com/abishekarun) and [zxkathy](https://github.com/zxkathy) as collaborators to your repo containing hw08. Please __review the hw08 submission of [qiaoyuet](https://github.com/qiaoyuet) and [KateJohnson](https://github.com/KateJohnson)__.                   
yidie             Please add [vanflad](https://github.com/vanflad) and [margotgunning](https://github.com/margotgunning) as collaborators to your repo containing hw08. Please __review the hw08 submission of [mlawre01](https://github.com/mlawre01) and [vmichalowski](https://github.com/vmichalowski)__.             
yuanjisun         Please add [qiaoyuet](https://github.com/qiaoyuet) and [KateJohnson](https://github.com/KateJohnson) as collaborators to your repo containing hw08. Please __review the hw08 submission of [peterwhitman](https://github.com/peterwhitman) and [ilgan](https://github.com/ilgan)__.                     
ZimingY           Please add [mattsada](https://github.com/mattsada) and [mylinhthibodeau](https://github.com/mylinhthibodeau) as collaborators to your repo containing hw08. Please __review the hw08 submission of [heathersummers](https://github.com/heathersummers) and [arsbar24](https://github.com/arsbar24)__.   
zxkathy           Please add [Alexander-Morin](https://github.com/Alexander-Morin) and [abishekarun](https://github.com/abishekarun) as collaborators to your repo containing hw08. Please __review the hw08 submission of [yeonukkim](https://github.com/yeonukkim) and [qiaoyuet](https://github.com/qiaoyuet)__.       
