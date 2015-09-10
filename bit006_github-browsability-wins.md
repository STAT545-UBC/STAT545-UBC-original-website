# The unreasonable effectiveness of GitHub browsability

One of my favorite aspects of GitHub is the ability to inspect a repository's files in a browser. Certain practices make browsing more rewarding and can postpone the day when you must create a proper website for a project. Perhaps indefinitely.

#### Be savvy about your files

Keep files in the plainest, web-friendliest form that is compatible with your main goals. Plain text is the very best. GitHub offers special handling for certain types of files:

  * Markdown files, which may be destined for conversion into, e.g., HTML
  * Markdown files named `README.md`
  * HTML files, often the result of compiling Markdown files
  * Source code, such as `.R` files
  * Delimited files, containing data one might bring into R via `read.table()`
  * PNG files
  
Sidebar: let's acknowledge the discomfort some people feel about putting downstream products under version control. Specifically, if you've got an R Markdown document `foo.rmd`, it can be `knit()` to produce the intermediate product `foo.md`, which can be converted to the ultimate output `foo.html`. Which of those files are you "allowed" to put under version control? Source-is-real hardliners will say only `foo.rmd` but pragmatists know this can be a serious bummer in real life. Just because I *can* rebuild everything from scratch, it doesn't mean I *want* to. The taboo of keeping derived products under version control originates from compilation of binary executables from source. In that context, software built on, say, a Mac would not work on, say, Windows and so it made sense to keep these binaries out of the holy source code repository. Also, you could assume the people with access to the repository have the full development stack and relish opportunities to use it. These arguments are less applicable to the `foo.rmd --> foo.md --> foo.html` thing. We don't have to blindly follow traditions from the compilation domain. This is a note about cool things GitHub can do with various file types, if they happen to end up in your repo. I won't ask you how they got there.
  
#### Markdown

You will quickly discover that GitHub renders Markdown files very nicely. By clicking on `foo.md`, you'll get a decent preview of `foo.html`. Yay!

Aggressively exploit this handy feature. Make Markdown your default format for narrative text files and use them liberally to embed notes to yourself and others in a repository hosted on GitHub. It's an easy way to get pseudo-webpages inside a project "for free". You may never even compile these files to HTML explicitly; in many cases, the HTML preview offered by GitHub is all you ever need.

~~Since GitHub does not provide automatic previewing of *R Markdown* files,~~ it can be handy to include the intermediate Markdown files produced by `knitr` in your repo, even if you choose to `.gitignore` the final HTML. Also, don't use the `.rmd` extension unless you really have R chunks in your Markdown; if a file is plain Markdown, say that clearly with the `.md` extension and enjoy the automatic preview. *Update: [GitHub now syntax highlights R markdown nicely](https://github.com/github/markup/pull/343), but, of course, the code blocks just sit there un-executed, so my advice about keeping intermediate Markdown still holds. [Here's how to retain](block007_first-use-rmarkdown.html#step-3-save-the-intermediate-markdown) the intermediate Markdown.*

For a quick, stand-alone document that doesn't fit neatly into a repository or project (yet), make it a [Gist](https://gist.github.com). Example: Hadley Wickham's ["first stab at a basic R programming curriculum"](https://gist.github.com/hadley/6734639). Gists can contain multiple files, so you can still provide the R script or R Markdown source __and__ the resulting Markdown, [as I've done here](https://gist.github.com/jennybc/97f2a969e2985f1362f3).

#### `README.md`

You probably already know that GitHub renders `README.md` at the top-level of your repo as the *de facto* landing page. This is analogous to what happens when you point a web browser at a directory instead of a specific web page: if there is a file named `index.html`, that's what the server will show you by default. On GitHub, files named `README.md` play exactly this role for directories in your repo. 

Implication: for any logical group of files or mini project-within-your-project, create a sub-directory in your repository. And then create a `README.md` file to annotate these files, collect relevant links, etc. Now when you navigate to the sub-directory on GitHub the nicely rendered `README.md` will simply appear.

Some repositories consist solely of `README.md`. Examples: Jeff Leek's write-ups on [How to share data with a statistician](https://github.com/jtleek/datasharing) or [Developing R packages](https://github.com/jtleek/rpackages).

If you've got a directory full of web-friendly figures, such as PNGs, you can use [code like this](https://gist.github.com/jennybc/0239f65633e09df7e5f4) to generate a `README.md` for a quick DIY gallery, as Karl Broman has done with [his FruitSnacks](https://github.com/kbroman/FruitSnacks/blob/master/PhotoGallery.md). I have also used this device to share Keynote slides on GitHub (*mea culpa!*). Export them as PNGs images and throw 'em into a README gallery: slides on [file organization](https://github.com/Reproducible-Science-Curriculum/rr-organization1/tree/27883c8fc4cdd4dcc6a8232f1fe5c726e96708a0/slides/organization-slides) and some on [file naming](https://github.com/Reproducible-Science-Curriculum/rr-organization1/tree/27883c8fc4cdd4dcc6a8232f1fe5c726e96708a0/slides/naming-slides).

#### HTML

If you have an HTML file in a GitHub repository, simply visiting the file shows the raw HTML. Boo. But if you preface the link with `http://htmlpreview.github.com/?`, you will see properly rendered HTML. Illustration:

  * Visiting an HTML fil on GitHub gets you this:
    - <https://github.com/STAT545-UBC/STAT545-UBC.github.io/blob/master/bit003_api-key-env-var.html>
  * But if we visit the file in a different way -- if we preface the URL as described above -- we see it more like a normal webpage:
    - <http://htmlpreview.github.io/?https://github.com/STAT545-UBC/STAT545-UBC.github.io/blob/master/bit003_api-key-env-var.html>
    
This sort of enhanced link might be one of the useful things to put in a `README.md` or other Markdown file in the repo.

*Update: you may also want to check out [rawgit.com](http://rawgit.com) or this [Chrome extension](https://chrome.google.com/webstore/detail/github-html-preview/cphnnfjainnhgejcpgboeeakfkgbkfek?hl=en).*

#### Source code

You will notice that GitHub does automatic syntax highlighting for source code. For example, notice the coloring of this [R script](https://github.com/jennybc/swcR_duke/blob/master/code/01_countrySpecificInterceptSlope.R). The file's extension is the primary determinant for if/how syntax highlighting will be applied. You can see information on recognized languages, the default extensions and more [here](https://github.com/github/linguist/blob/master/lib/linguist/languages.yml). You should be doing it anyway, but let this be another reason to follow convention in your use of file extensions.

Note you can click on "Raw" in this context as well, to get just the plain text and nothing but the plain text.
    
#### Delimited files

GitHub will nicely render "tabular data in the form of `.csv` (comma-separated) and `.tsv` (tab-separated) files." You can read more in the [blog post](https://github.com/blog/1601-see-your-csvs) announcing this feature in August 2013 or in [this GitHub help page](https://help.github.com/articles/rendering-csv-and-tsv-data).

Advice: take advantage of this! If something in your repo can be naturally stored as delimited data, by all means, do so. Make the comma or tab your default delimiter and use the file suffixes GitHub is expecting. I have noticed that GitHub is more easily confused than, say, R about things like quoting, so always inspect the GitHub-rendered `.csv` or `.tsv` file in the browser. You may need to do light tidying to get the automagic rendering to work properly.

Here's an example of a tab delimited file on GitHub: [lotr_clean.tsv](https://github.com/jennybc/lotr/blob/master/lotr_clean.tsv), originally found [here](http://www-958.ibm.com/software/data/cognos/manyeyes/datasets/words-spoken-by-character-race-scene/versions/1.txt).

Note you can click on "Raw" in this context as well, to get just the plain text and nothing but the plain text.

#### PNGs

PNG is the "no brainer" format in which to store figures for the web. But many of us like a vector-based format, such as PDF, for general purpose figures. Bottom line: PNGs will drive you less crazy than PDFs on GitHub. To reduce the aggravation around viewing figures in the browser, make sure to have a PNG version in the repo.

Examples:

  * [This PNG figure](https://github.com/jennybc/STAT545A/blob/master/hw06_scaffolds/01_justR/stripplot_wordsByRace_The_Fellowship_Of_The_Ring.png) just shows up in the browser
  * A different figure [stored as PDF](https://github.com/jennybc/STAT545A/blob/master/r.pch.pdf) ~~produces the dreaded, annoying "View Raw" speed bump. You'll have to click through and, on my OS + browser, wait for the PDF to appear in an external PDF viewer.~~ *2015-06-19 update: since I first wrote this GitHub has [elevated its treament of PDFs](https://github.com/blog/1974-pdf-viewing) so YAY.*
  
#### Linking to a ZIP archive of your repo

The browsability of GitHub make your work accessible to people who care about your content but who don't (yet) use Git themselves. What if such a person wants all the files? Yes, there is a clickable "Download ZIP" button offered by GitHub. But what if you want a link to include in, say, an email or other document? If you add `/archive/master.zip` *to the end* of the URL for your repo, you construct a link that will download a ZIP archive of your repository. Click here to try this out on a very small repo:

<https://github.com/jennybc/lotr/archive/master.zip>

Go look in your downloads folder!

#### Links

* To link to another page in your repo, just use a relative link: `[admin](courseAdmin/)` will link to the `courseAdmin/` directory inside the current directory. `[admin](/courseAdmin/)` will link to the top-level `courseAdmin/` directory from any where in the repo

* The same idea also works for images. `![](image.png)` will include `image.png` located in the current directory

* You can link to issues with `#` followed by the issue number, e.g. #10.

#### More stuff I could write up?

Variations on this theme:

  * whether/how internal links work in issues (short answer: not so much, I fear)

  * embedding a PNG from the repo in a `.md` file; ditto for an issue
