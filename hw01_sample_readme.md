# A Sample Readme in the Style of Github Markdown

## Status

|    **Item**    | **Status** |
|----------------|------------|
| Finished-ness  | :thumbsup: |
| Happiness      | :bowtie:   |
| Markdowny-ness | :octocat:  |

## Overview
**For your homework, you will be creating a readme document to introduce yourself to the class and experiment with the range of Markdown features.**

The following readme document, however, is sillier and not meant to represent the type of readme document that you will be creating for your STAT 545a homework. Instead, it is meant to illustrate the range of what's possible in the world of Markdown. If you feel inspired by any part of this document, click the **raw** button above this file to see the source code that made it possible.

## Features

*The header above is "H2" size. The headers below will range from "H2" to "H4" depending on the number of hashtags in front of them*

### Basic Word Processing and Manipulation

#### Bold statements!

Want to *italicize* something? Maybe even **bold** or ~~strikeout~~ a phrase? How about **combining <del>*a few of</del> them at a* time?** For that, Markdown has you covered.

#### Bullet point basics

- How about lists?
- They work nicely too
	+ Sometimes
		* we can
			- even
				+ indent them

***What if we want ordered lists?***

1. They are easy
2. to pull off
3. as well.
4. We can even
	- have non-ordered lists
	- nested into the numbered ones
		1. Or vice versa.
		2. Isn't that great?

#### Header how-tos

The header above is "H4" size. This readme document's headers' sizes range from "H2" to "H4" depending on the number of hashtags in front of them

### Quoting quotables

Starting a line with a simple `>` turns words into quotes. Take, for example, this perspicacious line from the great Sir Arthur Conan Doyle of Sherlock Holmes fame:

> "It is a capital mistake to theorize before one has data. Insensibly one begins to twist facts to suit theories, instead of theories to suit facts."
>
> Sir Arthur Conan Doyle

### Citing code

Code can be cited too! And you can highlight your code too if you specify the source programming language.

```R
whatsyour <- function(x) {
    # Determines whether your function is Conjunction or Junction based on
    # arbitrary criteria
    #
    # Args:
    #   x: A number of some sort. Or not, that works too (We're not picky)
    #
    # Returns:
    #   The truth.
    if(x > 1) {
        print('Conjunction')
    }
    else {
        print('Junction')
    }
}

```

### Imagining images

They say a picture is worth 1000 words - but have you ever considered how many lines of code that might convert to? Regardless of the answer, Markdown makes it easy include pictures of all sorts into your document. Don't believe me? See the source code yourself!

![alt text](https://imgs.xkcd.com/comics/stove_ownership.png "Although maybe it's just a phase, like freshman year of college when I realized I could just buy frosting in a can.")

We can even include gifs. Fancy that?

![](https://i.imgur.com/zNssDtS.gif)

### Link logic

Let's say that the comic sourced in the previous section had a home page where it could be viewed - we can [link to that page using Markdown](https://xkcd.com/418/) with relative ease. If you look at the source code, it's really quite simple, so there's not much more to say about this here!

### HTML has you covered for everything else

Finding it hard to do that <i>one thing</i> that you want to do with Markdown? Prefer using `<a href = "destination">Word</a>` instead of Markdown's `[Word](destination)` syntax? Well, as you can see <a href="https://daringfireball.net/projects/markdown/syntax#html">at this link</a>, it is possible to use inline HTML for markup that is not covered otherwise by Markdown. That said, Markdown syntax can tackle most of the crucial functions required for this readme file and most others like it.

Some common uses for incorporating HTML inline with Markdown include:

- Using an image as a link
- Including non-bordered tables to create makeshift columns
- Facilitating perfectionism

## Further Reading and Resources

Still confused? Want to have some other resources to look at other than the source code of this readme.md file? Here are a few additional guides that you can reference as you complete your own readme.md file and beyond:

- [RStudio Markdown Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)
- [Github Markdown Cheat Sheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
- [How to Set Up Sublime Text For Markdown Editing](http://plaintext-productivity.net/2-04-how-to-set-up-sublime-text-for-markdown-editing.html)
- [Markdown Syntax Summary by John Gruber, Creator of Markdown Format](https://daringfireball.net/projects/markdown/syntax)

## To-Dos

- [x] @jrebane drafts initial sample readme
- [x] Emoji's added
- [x] Snarky text intensified
- [x] Add useful reference resources
- [ ] Reviewed by @jennybc