Scraping and Sentiment with R
================
gvdr

![](https://i.ytimg.com/vi/8_5TCqHVEW8/maxresdefault.jpg)

We are starting in this lecture, and end in the next one.

The goal is to build a little collection of songs from our own preferred
artist. Let’s say, it’s *Straight Line Stitch* (they are great\!). A
little kicker for the
[morning](https://www.youtube.com/watch?v=4_5VAKdHMek).

The **highly suggested** browser (or, at least, the one that I’ll be
using) is [Firefox](https://www.mozilla.org/en-US/firefox/developer/),
the developer edition.

## Packages

> Don’t be afraid of the dark you’re still held up by the stars

We are going to use a bunch of the usual packages:

``` r
library(tidyverse)
library(magrittr)
library(purrr)
library(glue)
library(stringr)
```

and introduce a new one:

``` r
library(rvest)
library(xml2)
```

which is meant explicitly to scrape stuff from a webpage. We are going
to use a couple more in the bonus section, if we get there.

## The lyrics

We are going to extract the lyrics from here:
<https://www.musixmatch.com/> . Chose it because it’s rather consistent,
and it’s from Bologna, Italy (yeah\!).

The webiste offers the first 15 lyrics up front. That will do for the
moment (and fixing that is not that easy). Let’s take a look
[here](https://www.musixmatch.com/artist/Straight-Line-Stitch#).

## Titles

First thing first, we would like to get a list of those title. Let’s see
how.

``` r
url_titles <- "https://www.musixmatch.com/artist/Straight-Line-Stitch#"

page_title <- read_html(url_titles)
```

Now, what is this `page_title` object?

let’s see:

``` r
page_title
```

    ## {xml_document}
    ## <html xmlns:og="http://ogp.me/ns#" class="artist-page-page">
    ## [1] <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# musixma ...
    ## [2] <body spellcheck="false" class="">\n  <div id="fb-root"></div>\n  <d ...

OK. It’s a document. Thanks. And it’s an XML document. That’s sort of
html. We’ll handle it with `xml2` and `rvest`. Let’s see a bit more of
that page.

``` r
page_title %>% html_structure()
```

    ## <html.artist-page-page [xmlns:og]>
    ##   <head [prefix]>
    ##     <style>
    ##       {cdata}
    ##     <script>
    ##       {cdata}
    ##     <script>
    ##       {cdata}
    ##     <script>
    ##       {cdata}
    ##     <script>
    ##       {cdata}
    ##     <script [async, src]>
    ##     <script [type]>
    ##       {cdata}
    ##     <link [rel, type, href]>
    ##     <link [rel, type, href]>
    ##     <script>
    ##       {cdata}
    ##     <meta [name, content]>
    ##     <meta [name, content]>
    ##     <title>
    ##       {text}
    ##     <meta [charset]>
    ##     <meta [http-equiv, content]>
    ##     <meta [http-equiv, content]>
    ##     <meta [name, content]>
    ##     <meta [name, content]>
    ##     <meta [name, content]>
    ##     <meta [name, content]>
    ##     <meta [name, content]>
    ##     <meta [name, content]>
    ##     <meta [name, content]>
    ##     <link [href, rel]>
    ##     <link [href, rel]>
    ##     <link [href, rel]>
    ##     <link [href, rel]>
    ##     <link [rel, type, href, title]>
    ##     <link [rel, href]>
    ##     <link [rel, href]>
    ##     <link [rel, href]>
    ##     <meta [name, content]>
    ##     <link [rel, href, hreflang]>
    ##     <link [rel, href, hreflang]>
    ##     <link [rel, href, hreflang]>
    ##     <link [rel, href, hreflang]>
    ##     <link [rel, href, hreflang]>
    ##     <link [rel, href, hreflang]>
    ##     <link [rel, href, hreflang]>
    ##     <link [rel, href, hreflang]>
    ##     <meta [name, content]>
    ##     <meta [name, content]>
    ##     <meta [name, content]>
    ##     <meta [name, content]>
    ##     <link [rel, sizes, href]>
    ##     <link [rel, sizes, href]>
    ##     <link [rel, href]>
    ##     <meta [property, content]>
    ##     <meta [property, content]>
    ##     <meta [name, content]>
    ##     <link [rel, href]>
    ##     <link [rel, href]>
    ##     <link [rel, href]>
    ##     <meta [property, content]>
    ##     <meta [property, content]>
    ##     <meta [property, content]>
    ##     <meta [property, content]>
    ##     <meta [property, content]>
    ##     <meta [property, content]>
    ##     <meta [property, content]>
    ##     <meta [property, content]>
    ##     <meta [http-equiv, content]>
    ##     <script>
    ##       {cdata}
    ##     <script>
    ##       {cdata}
    ##     <script [type]>
    ##       {cdata}
    ##     <script [type]>
    ##       {cdata}
    ##   <body. [spellcheck]>
    ##     {text}
    ##     <div#fb-root>
    ##     {text}
    ##     <div#site>
    ##       <div#artist-page . [data-reactroot]>
    ##         <div#header .navbar [role]>
    ##           <nav.top-bar.desktop-bar [data-topbar]>
    ##             <section.top-bar-section>
    ##               <ul.title-area>
    ##                 <li.name>
    ##                   <h1>
    ##                     <a#logo [href]>
    ##                       <img [alt, width, src]>
    ##               <ul.search-nav [role]>
    ##                 <li.search.has-form>
    ##                   <form>
    ##                     <div#search-bar>
    ##                       <input#search-input [type, placeholder, value, autocomplete]>
    ##                       <button#search-button .button-icon>
    ##                         <i.icon.icon-search>
    ##               <div.top-bar-right>
    ##                 <ul.site-nav [role]>
    ##                   <li>
    ##                     <a [href]>
    ##                       {text}
    ##                   <li>
    ##                     <a [href]>
    ##                       {text}
    ##                   <li>
    ##                     <a [href]>
    ##                       {text}
    ##                 <ul.user-nav>
    ##                   <li>
    ##                     <ul.user-nav-items.loggedOut>
    ##                       <li#sign-in>
    ##                         <a [data-external-link, href]>
    ##                           {text}
    ##                       <li#sign-up>
    ##                         <a [data-external-link, href]>
    ##                           {text}
    ##           <nav.top-bar.mobile-top-bar>
    ##             <ul.title-area>
    ##               <li.offcanvas-toggler>
    ##                 <a [href]>
    ##                   <i.icon.icon-list>
    ##               <li.name>
    ##                 <h1>
    ##                   <a [href]>
    ##                     <img [alt, src]>
    ##               <li.toggle-search-bar>
    ##                 <a [href]>
    ##                   <span>
    ##                     <i.icon.icon-search>
    ##               <li.search.has-form>
    ##                 <form>
    ##                   <div#search-bar>
    ##                     <input#search-input [type, placeholder, value, autocomplete]>
    ##                     <button#search-button .button-icon>
    ##                       <i.icon.icon-search>
    ##                   <button.button.button-link.search-bar-cancel>
    ##                     <i.icon.icon-cross>
    ##           <noscript>
    ##         <div#content [role]>
    ##           <div.artist-page.main-wrapper [itemtype]>
    ##             <meta [content, itemprop]>
    ##             <div.profile-header.artist-header>
    ##               <div.main-wrapper>
    ##                 <div.noCoverPlaceholder>
    ##                 <div.bg>
    ##                 <div.profile-info>
    ##                   <div.profile-head-link>
    ##                     <div.profile-image>
    ##                       <img.profile-avatar.large [itemprop, src, alt]>
    ##                     <div.profile-data>
    ##                       <meta [itemprop, content]>
    ##                       <meta [itemprop, content]>
    ##                       <span.lyricsLabel>
    ##                         {text}
    ##                       <h1. [title, itemprop]>
    ##                         {text}
    ##                       <ul.genres>
    ##                         <li>
    ##                           <a [href]>
    ##                             {text}
    ##                     <a.verify-link [href]>
    ##                       {text}
    ##                   <button.button-primary.contribute-button>
    ##                     {text}
    ##                     {comment}
    ##                     {text}
    ##                   <ul.profile-head-info>
    ##                   <span>
    ##                   <span>
    ##             <div.profile-content>
    ##               <div>
    ##                 <div.section-header>
    ##                   <ul.tabs>
    ##                     <li#overview .selected>
    ##                       <a [href]>
    ##                         {text}
    ##                     <li#community .>
    ##                       <a [href]>
    ##                         {text}
    ##                     <li#albums .>
    ##                       <a [href]>
    ##                         {text}
    ##                 <div.tab-content>
    ##                   <div.main-wrapper>
    ##                     <div.main>
    ##                       <div.row>
    ##                         <div.main-panel>
    ##                           <div#top-songs .box.box-style-plain>
    ##                             <div.box-header>
    ##                               <h3.box-title>
    ##                                 {text}
    ##                                 {comment}
    ##                                 {text}
    ##                               <div.actions>
    ##                             <div.box-content>
    ##                               <div>
    ##                                 <div>
    ##                                   <ul.tracks.list>
    ##                                     <li.showPosition.showCoverart>
    ##                                       <span.position>
    ##                                         {text}
    ##                                       <div.track-card.media-card.has-picture>
    ##                                         <div.media-card-picture>
    ##                                           <img [srcset, alt]>
    ##                                         <div.media-card-body>
    ##                                           <div.media-card-text>
    ##                                             <h2.media-card-title>
    ##                                               <a.title [href]>
    ##                                                 <span>
    ##                                                   {text}
    ##                                             <h3.media-card-subtitle>
    ##                                               <span.artist-field>
    ##                                                 <span>
    ##                                                   <a.artist [href]>
    ##                                                     {text}
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                     <li.showPosition.showCoverart>
    ##                                       <span.position>
    ##                                         {text}
    ##                                       <div.track-card.media-card.has-picture>
    ##                                         <div.media-card-picture>
    ##                                           <img [srcset, alt]>
    ##                                         <div.media-card-body>
    ##                                           <div.media-card-text>
    ##                                             <h2.media-card-title>
    ##                                               <a.title [href]>
    ##                                                 <span>
    ##                                                   {text}
    ##                                             <h3.media-card-subtitle>
    ##                                               <span.artist-field>
    ##                                                 <span>
    ##                                                   <a.artist [href]>
    ##                                                     {text}
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                     <li.showPosition.showCoverart>
    ##                                       <span.position>
    ##                                         {text}
    ##                                       <div.track-card.media-card.has-picture>
    ##                                         <div.media-card-picture>
    ##                                           <img [srcset, alt]>
    ##                                         <div.media-card-body>
    ##                                           <div.media-card-text>
    ##                                             <h2.media-card-title>
    ##                                               <a.title [href]>
    ##                                                 <span>
    ##                                                   {text}
    ##                                             <h3.media-card-subtitle>
    ##                                               <span.artist-field>
    ##                                                 <span>
    ##                                                   <a.artist [href]>
    ##                                                     {text}
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                     <li.showPosition.showCoverart>
    ##                                       <span.position>
    ##                                         {text}
    ##                                       <div.track-card.media-card.has-picture>
    ##                                         <div.media-card-picture>
    ##                                           <img [srcset, alt]>
    ##                                         <div.media-card-body>
    ##                                           <div.media-card-text>
    ##                                             <h2.media-card-title>
    ##                                               <a.title [href]>
    ##                                                 <span>
    ##                                                   {text}
    ##                                             <h3.media-card-subtitle>
    ##                                               <span.artist-field>
    ##                                                 <span>
    ##                                                   <a.artist [href]>
    ##                                                     {text}
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                     <li.showPosition.showCoverart>
    ##                                       <span.position>
    ##                                         {text}
    ##                                       <div.track-card.media-card.has-picture>
    ##                                         <div.media-card-picture>
    ##                                           <img [srcset, alt]>
    ##                                         <div.media-card-body>
    ##                                           <div.media-card-text>
    ##                                             <h2.media-card-title>
    ##                                               <a.title [href]>
    ##                                                 <span>
    ##                                                   {text}
    ##                                             <h3.media-card-subtitle>
    ##                                               <span.artist-field>
    ##                                                 <span>
    ##                                                   <a.artist [href]>
    ##                                                     {text}
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                     <li.showPosition.showCoverart>
    ##                                       <span.position>
    ##                                         {text}
    ##                                       <div.track-card.media-card.has-picture>
    ##                                         <div.media-card-picture>
    ##                                           <img [srcset, alt]>
    ##                                         <div.media-card-body>
    ##                                           <div.media-card-text>
    ##                                             <h2.media-card-title>
    ##                                               <a.title [href]>
    ##                                                 <span>
    ##                                                   {text}
    ##                                             <h3.media-card-subtitle>
    ##                                               <span.artist-field>
    ##                                                 <span>
    ##                                                   <a.artist [href]>
    ##                                                     {text}
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                     <li.showPosition.showCoverart>
    ##                                       <span.position>
    ##                                         {text}
    ##                                       <div.track-card.media-card.has-picture>
    ##                                         <div.media-card-picture>
    ##                                           <img [srcset, alt]>
    ##                                         <div.media-card-body>
    ##                                           <div.media-card-text>
    ##                                             <h2.media-card-title>
    ##                                               <a.title [href]>
    ##                                                 <span>
    ##                                                   {text}
    ##                                             <h3.media-card-subtitle>
    ##                                               <span.artist-field>
    ##                                                 <span>
    ##                                                   <a.artist [href]>
    ##                                                     {text}
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                     <li.showPosition.showCoverart>
    ##                                       <span.position>
    ##                                         {text}
    ##                                       <div.track-card.media-card.has-picture>
    ##                                         <div.media-card-picture>
    ##                                           <img [srcset, alt]>
    ##                                         <div.media-card-body>
    ##                                           <div.media-card-text>
    ##                                             <h2.media-card-title>
    ##                                               <a.title [href]>
    ##                                                 <span>
    ##                                                   {text}
    ##                                             <h3.media-card-subtitle>
    ##                                               <span.artist-field>
    ##                                                 <span>
    ##                                                   <a.artist [href]>
    ##                                                     {text}
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                     <li.showPosition.showCoverart>
    ##                                       <span.position>
    ##                                         {text}
    ##                                       <div.track-card.media-card.has-picture>
    ##                                         <div.media-card-picture>
    ##                                           <img [srcset, alt]>
    ##                                         <div.media-card-body>
    ##                                           <div.media-card-text>
    ##                                             <h2.media-card-title>
    ##                                               <a.title [href]>
    ##                                                 <span>
    ##                                                   {text}
    ##                                             <h3.media-card-subtitle>
    ##                                               <span.artist-field>
    ##                                                 <span>
    ##                                                   <a.artist [href]>
    ##                                                     {text}
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                     <li.showPosition.showCoverart>
    ##                                       <span.position>
    ##                                         {text}
    ##                                       <div.track-card.media-card.has-picture>
    ##                                         <div.media-card-picture>
    ##                                           <img [srcset, alt]>
    ##                                         <div.media-card-body>
    ##                                           <div.media-card-text>
    ##                                             <h2.media-card-title>
    ##                                               <a.title [href]>
    ##                                                 <span>
    ##                                                   {text}
    ##                                             <h3.media-card-subtitle>
    ##                                               <span.artist-field>
    ##                                                 <span>
    ##                                                   <a.artist [href]>
    ##                                                     {text}
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                     <li.showPosition.showCoverart>
    ##                                       <span.position>
    ##                                         {text}
    ##                                       <div.track-card.media-card.has-picture>
    ##                                         <div.media-card-picture>
    ##                                           <img [srcset, alt]>
    ##                                         <div.media-card-body>
    ##                                           <div.media-card-text>
    ##                                             <h2.media-card-title>
    ##                                               <a.title [href]>
    ##                                                 <span>
    ##                                                   {text}
    ##                                             <h3.media-card-subtitle>
    ##                                               <span.artist-field>
    ##                                                 <span>
    ##                                                   <a.artist [href]>
    ##                                                     {text}
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                     <li.showPosition.showCoverart>
    ##                                       <span.position>
    ##                                         {text}
    ##                                       <div.track-card.media-card.has-picture>
    ##                                         <div.media-card-picture>
    ##                                           <img [srcset, alt]>
    ##                                         <div.media-card-body>
    ##                                           <div.media-card-text>
    ##                                             <h2.media-card-title>
    ##                                               <a.title [href]>
    ##                                                 <span>
    ##                                                   {text}
    ##                                             <h3.media-card-subtitle>
    ##                                               <span.artist-field>
    ##                                                 <span>
    ##                                                   <a.artist [href]>
    ##                                                     {text}
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                     <li.showPosition.showCoverart>
    ##                                       <span.position>
    ##                                         {text}
    ##                                       <div.track-card.media-card.has-picture>
    ##                                         <div.media-card-picture>
    ##                                           <img [srcset, alt]>
    ##                                         <div.media-card-body>
    ##                                           <div.media-card-text>
    ##                                             <h2.media-card-title>
    ##                                               <a.title [href]>
    ##                                                 <span>
    ##                                                   {text}
    ##                                             <h3.media-card-subtitle>
    ##                                               <span.artist-field>
    ##                                                 <span>
    ##                                                   <a.artist [href]>
    ##                                                     {text}
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                     <li.showPosition.showCoverart>
    ##                                       <span.position>
    ##                                         {text}
    ##                                       <div.track-card.media-card.has-picture>
    ##                                         <div.media-card-picture>
    ##                                           <img [srcset, alt]>
    ##                                         <div.media-card-body>
    ##                                           <div.media-card-text>
    ##                                             <h2.media-card-title>
    ##                                               <a.title [href]>
    ##                                                 <span>
    ##                                                   {text}
    ##                                             <h3.media-card-subtitle>
    ##                                               <span.artist-field>
    ##                                                 <span>
    ##                                                   <a.artist [href]>
    ##                                                     {text}
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                     <li.showPosition.showCoverart>
    ##                                       <span.position>
    ##                                         {text}
    ##                                       <div.track-card.media-card.has-picture>
    ##                                         <div.media-card-picture>
    ##                                           <img [srcset, alt]>
    ##                                         <div.media-card-body>
    ##                                           <div.media-card-text>
    ##                                             <h2.media-card-title>
    ##                                               <a.title [href]>
    ##                                                 <span>
    ##                                                   {text}
    ##                                             <h3.media-card-subtitle>
    ##                                               <span.artist-field>
    ##                                                 <span>
    ##                                                   <a.artist [href]>
    ##                                                     {text}
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                         <meta [content, itemprop]>
    ##                                 <div.load-more-pager>
    ##                                   <a.button.page-load-more [href, data-page]>
    ##                                     {text}
    ##                         <div.side-panel>
    ##                           <div.box.box-style-plain>
    ##                             <div.box-content>
    ##                               <div. [style]>
    ##                                 <div#div_gpt_ad_336x280_musixmatch_artist_sidebar_top [style]>
    ##                                   <script [type]>
    ##                                     {cdata}
    ##                           <div#albums .box.box-style-plain>
    ##                             <div.box-header>
    ##                               <h3.box-title>
    ##                                 {text}
    ##                                 {comment}
    ##                                 {text}
    ##                               <div.actions>
    ##                             <div.box-content>
    ##                               <ul.song-writers>
    ##                                 <li>
    ##                                   <a [href]>
    ##                                     {text}
    ##                                 <li>
    ##                                   <a [href]>
    ##                                     {text}
    ##                                 <li>
    ##                                   <a [href]>
    ##                                     {text}
    ##                                 <li>
    ##                                   <a [href]>
    ##                                     {text}
    ##                                 <li>
    ##                                   <a [href]>
    ##                                     {text}
    ##                                 <li>
    ##                                   <a [href]>
    ##                                     {text}
    ##                                 <li>
    ##                                   <a [href]>
    ##                                     {text}
    ##                                 <li>
    ##                                   <a [href]>
    ##                                     {text}
    ##                                 <li>
    ##                                   <a [href]>
    ##                                     {text}
    ##                                 <li>
    ##                                   <a [href]>
    ##                                     {text}
    ##                           <div#albums .box.box-style-plain>
    ##                             <div.box-header>
    ##                               <h3.box-title>
    ##                                 {text}
    ##                                 {comment}
    ##                                 {text}
    ##                               <div.actions>
    ##                                 <a.see-all-action [href]>
    ##                                   {text}
    ##                             <div.box-content>
    ##                               <ul.albums.list>
    ##                                 <li>
    ##                                   <div.album-card.media-card.has-picture>
    ##                                     <div.media-card-picture>
    ##                                       <img [srcset, alt]>
    ##                                     <div.media-card-body>
    ##                                       <div.media-card-text>
    ##                                         <h2.media-card-title>
    ##                                           <a [href]>
    ##                                             {text}
    ##                                         <h3.media-card-subtitle>
    ##                                           {text}
    ##                                     <meta [content, itemprop]>
    ##                                     <meta [content, itemprop]>
    ##                                 <li>
    ##                                   <div.album-card.media-card.has-picture>
    ##                                     <div.media-card-picture>
    ##                                       <img [srcset, alt]>
    ##                                     <div.media-card-body>
    ##                                       <div.media-card-text>
    ##                                         <h2.media-card-title>
    ##                                           <a [href]>
    ##                                             {text}
    ##                                         <h3.media-card-subtitle>
    ##                                           {text}
    ##                                     <meta [content, itemprop]>
    ##                                     <meta [content, itemprop]>
    ##                                 <li>
    ##                                   <div.album-card.media-card.has-picture>
    ##                                     <div.media-card-picture>
    ##                                       <img [srcset, alt]>
    ##                                     <div.media-card-body>
    ##                                       <div.media-card-text>
    ##                                         <h2.media-card-title>
    ##                                           <a [href]>
    ##                                             {text}
    ##                                         <h3.media-card-subtitle>
    ##                                           {text}
    ##                                     <meta [content, itemprop]>
    ##                                     <meta [content, itemprop]>
    ##                                 <li>
    ##                                   <div.album-card.media-card.has-picture>
    ##                                     <div.media-card-picture>
    ##                                       <img [srcset, alt]>
    ##                                     <div.media-card-body>
    ##                                       <div.media-card-text>
    ##                                         <h2.media-card-title>
    ##                                           <a [href]>
    ##                                             {text}
    ##                                         <h3.media-card-subtitle>
    ##                                           {text}
    ##                                     <meta [content, itemprop]>
    ##                                     <meta [content, itemprop]>
    ##                                 <li>
    ##                                   <div.album-card.media-card.has-picture>
    ##                                     <div.media-card-picture>
    ##                                       <img [srcset, alt]>
    ##                                     <div.media-card-body>
    ##                                       <div.media-card-text>
    ##                                         <h2.media-card-title>
    ##                                           <a [href]>
    ##                                             {text}
    ##                                         <h3.media-card-subtitle>
    ##                                           {text}
    ##                                     <meta [content, itemprop]>
    ##                                     <meta [content, itemprop]>
    ##         <span>
    ##         <div#footer>
    ##           <div.main-wrapper>
    ##             <div.footer-container>
    ##               <div.mxm-footer__sitemap>
    ##                 <div.mxm-footer__sitemap-logo>
    ##                   <div.mui-logo>
    ##                     <a.mui-logo__link [href]>
    ##                       <img.mui-logo__img [src, alt, width]>
    ##                   <div.mxm-footer__language>
    ##                     <button#language-menu .small.button.dropdown>
    ##                       {text}
    ##               <div.mxm-footer__sitemap-links>
    ##                 <h4>
    ##                   {text}
    ##                 <ul>
    ##                   <li>
    ##                     <a [data-external-link, target, href]>
    ##                       {text}
    ##                   <li>
    ##                     <a [data-external-link, target, href]>
    ##                       {text}
    ##                   <li>
    ##                     <a [data-external-link, target, href]>
    ##                       {text}
    ##                   <li>
    ##                     <a [data-external-link, target, href]>
    ##                       {text}
    ##                   <li>
    ##                     <a [data-external-link, target, href]>
    ##                       {text}
    ##               <div.mxm-footer__sitemap-links>
    ##                 <h4>
    ##                   {text}
    ##                 <ul>
    ##                   <li>
    ##                     <a [data-external-link, target, href]>
    ##                       {text}
    ##                   <li>
    ##                     <a [data-external-link, target, href]>
    ##                       {text}
    ##                   <li>
    ##                     <a [data-external-link, target, href]>
    ##                       {text}
    ##                   <li>
    ##                     <a [data-external-link, target, href]>
    ##                       {text}
    ##               <div.mxm-footer__sitemap-links>
    ##                 <h4>
    ##                   {text}
    ##                 <ul>
    ##                   <li>
    ##                     <a [data-external-link, target, href]>
    ##                       {text}
    ##                   <li>
    ##                     <a [data-external-link, target, href]>
    ##                       {text}
    ##                       {comment}
    ##                       {text}
    ##                       <span.label.label-primary.text-uppercase>
    ##                         {text}
    ##                   <li>
    ##                     <a [href]>
    ##                       {text}
    ##                   <li>
    ##                     <a [data-external-link, href]>
    ##                       {text}
    ##                   <li>
    ##                     <a [data-external-link, target, href]>
    ##                       {text}
    ##             <div.mxm-footer__footer-language>
    ##               <button#language-menu .small.button.dropdown>
    ##                 {text}
    ##             <div.mxm-footer__footnote>
    ##               <div.copyright>
    ##                 <span>
    ##                   {text}
    ##                 <span.mxm-footer__footnote-dash>
    ##                   {text}
    ##                 <ul [itemtype]>
    ##                   <link [itemprop, href]>
    ##                   <li>
    ##                     <a.social-icon.fb-icon [target, href, itemprop, type]>
    ##                       <i.icon.icon-facebook2>
    ##                   <li>
    ##                     <a.social-icon.tw-icon [target, href, itemprop, type]>
    ##                       <i.icon.icon-twitter>
    ##                   <li>
    ##                     <a.social-icon.googleplus-icon [target, href, itemprop, type]>
    ##                       <i.icon.icon-googleplus>
    ##                   <li>
    ##                     <a.social-icon.youtube-icon [target, href, itemprop, type]>
    ##                       <i.icon.icon-youtube2>
    ##                   <li>
    ##                     <a.social-icon.pinterest-icon [target, href, itemprop, type]>
    ##                       <i.icon.icon-pinterest>
    ##                   <li>
    ##                     <a.social-icon.instagram-icon [target, href, itemprop, type]>
    ##                       <i.icon.icon-instagram>
    ##               <p>
    ##                 {text}
    ##         <span>
    ##     {text}
    ##     <script>
    ##       {cdata}
    ##     <script [async, src]>
    ##     <script>
    ##       {cdata}

Wait, whaaaaaat?

![](https://media.giphy.com/media/ZkEXisGbMawMg/giphy.gif)

To the browser\! Look at that “class” tags: they are *css selectors*,
and we will use them as handles to navigate into the extremely complex
list that we get from a web page.

Sometimes, we can be lucky. For example, the css selector for the titles
are in the class “.title”. Let’s see.

``` r
page_title %>%
  html_nodes(".title")
```

    ## {xml_nodeset (15)}
    ##  [1] <a class="title" href="/lyrics/Straight-Line-Stitch/Laughing-In-The ...
    ##  [2] <a class="title" href="/lyrics/Straight-Line-Stitch/Black-Veil"><sp ...
    ##  [3] <a class="title" href="/lyrics/Straight-Line-Stitch/Never-Surrender ...
    ##  [4] <a class="title" href="/lyrics/Straight-Line-Stitch/What-You-Do-to- ...
    ##  [5] <a class="title" href="/lyrics/Straight-Line-Stitch/Taste-of-Ashes" ...
    ##  [6] <a class="title" href="/lyrics/Straight-Line-Stitch/Conversion"><sp ...
    ##  [7] <a class="title" href="/lyrics/Straight-Line-Stitch/Promise-Me"><sp ...
    ##  [8] <a class="title" href="/lyrics/Straight-Line-Stitch/Bar-Room-Brawl" ...
    ##  [9] <a class="title" href="/lyrics/Straight-Line-Stitch/One-Reason"><sp ...
    ## [10] <a class="title" href="/lyrics/Straight-Line-Stitch/Yesterday-s-Gon ...
    ## [11] <a class="title" href="/lyrics/Straight-Line-Stitch/Eucharist"><spa ...
    ## [12] <a class="title" href="/lyrics/Straight-Line-Stitch/Living-Dead"><s ...
    ## [13] <a class="title" href="/lyrics/Straight-Line-Stitch/Adult-Cinema">< ...
    ## [14] <a class="title" href="/lyrics/Straight-Line-Stitch/Bleeding-Heart- ...
    ## [15] <a class="title" href="/lyrics/Straight-Line-Stitch/Cold-Front"><sp ...

That’s still quite a mess: we have too much stuff, such as some links
(called “href”) and more text than we need. Let’s clean it up with
`html_text()`

``` r
page_title %>%
  html_nodes(".title") %>%
  html_text()
```

    ##  [1] "Laughing In The Rearview" "Black Veil"              
    ##  [3] "Never Surrender"          "What You Do to Me"       
    ##  [5] "Taste of Ashes"           "Conversion"              
    ##  [7] "Promise Me"               "Bar Room Brawl"          
    ##  [9] "One Reason"               "Yesterday's Gone"        
    ## [11] "Eucharist"                "Living Dead"             
    ## [13] "Adult Cinema"             "Bleeding Heart Theory"   
    ## [15] "Cold Front"

Wundebar\! Now we have 15 song titles. But we want the lyrics\! Let’s do
better.

``` r
SLS_df <- data_frame(Band = "Straight Line Stitch",
                     Title = page_title %>%
                       html_nodes(".title") %>%
                       html_text())
```

Now we are going to use a bit of string
magic

``` r
SLS_lyrics <- SLS_df %>% mutate(Link = glue('https://www.musixmatch.com/lyrics/{Band}/{Title}') %>%
                           str_replace_all(" ","-"))
```

It seems it works.

There is a better trick to do this job. If we look again at what we get
when we select the `.title` you may see that the *actual* link is there,
coded as `href`. Can we extract that? Yes we can\!

``` r
page_title %>%
  html_nodes(".title") %>%
  html_attrs() %>%
  glimpse()
```

    ## List of 15
    ##  $ : Named chr [1:2] "title" "/lyrics/Straight-Line-Stitch/Laughing-In-The-Rearview"
    ##   ..- attr(*, "names")= chr [1:2] "class" "href"
    ##  $ : Named chr [1:2] "title" "/lyrics/Straight-Line-Stitch/Black-Veil"
    ##   ..- attr(*, "names")= chr [1:2] "class" "href"
    ##  $ : Named chr [1:2] "title" "/lyrics/Straight-Line-Stitch/Never-Surrender"
    ##   ..- attr(*, "names")= chr [1:2] "class" "href"
    ##  $ : Named chr [1:2] "title" "/lyrics/Straight-Line-Stitch/What-You-Do-to-Me"
    ##   ..- attr(*, "names")= chr [1:2] "class" "href"
    ##  $ : Named chr [1:2] "title" "/lyrics/Straight-Line-Stitch/Taste-of-Ashes"
    ##   ..- attr(*, "names")= chr [1:2] "class" "href"
    ##  $ : Named chr [1:2] "title" "/lyrics/Straight-Line-Stitch/Conversion"
    ##   ..- attr(*, "names")= chr [1:2] "class" "href"
    ##  $ : Named chr [1:2] "title" "/lyrics/Straight-Line-Stitch/Promise-Me"
    ##   ..- attr(*, "names")= chr [1:2] "class" "href"
    ##  $ : Named chr [1:2] "title" "/lyrics/Straight-Line-Stitch/Bar-Room-Brawl"
    ##   ..- attr(*, "names")= chr [1:2] "class" "href"
    ##  $ : Named chr [1:2] "title" "/lyrics/Straight-Line-Stitch/One-Reason"
    ##   ..- attr(*, "names")= chr [1:2] "class" "href"
    ##  $ : Named chr [1:2] "title" "/lyrics/Straight-Line-Stitch/Yesterday-s-Gone"
    ##   ..- attr(*, "names")= chr [1:2] "class" "href"
    ##  $ : Named chr [1:2] "title" "/lyrics/Straight-Line-Stitch/Eucharist"
    ##   ..- attr(*, "names")= chr [1:2] "class" "href"
    ##  $ : Named chr [1:2] "title" "/lyrics/Straight-Line-Stitch/Living-Dead"
    ##   ..- attr(*, "names")= chr [1:2] "class" "href"
    ##  $ : Named chr [1:2] "title" "/lyrics/Straight-Line-Stitch/Adult-Cinema"
    ##   ..- attr(*, "names")= chr [1:2] "class" "href"
    ##  $ : Named chr [1:2] "title" "/lyrics/Straight-Line-Stitch/Bleeding-Heart-Theory"
    ##   ..- attr(*, "names")= chr [1:2] "class" "href"
    ##  $ : Named chr [1:2] "title" "/lyrics/Straight-Line-Stitch/Cold-Front"
    ##   ..- attr(*, "names")= chr [1:2] "class" "href"

In particular, we want the element called `href`. Hey, we can get that
with `map`\!

``` r
page_title %>%
  html_nodes(".title") %>%
  html_attrs() %>%
  map_chr("href")
```

    ##  [1] "/lyrics/Straight-Line-Stitch/Laughing-In-The-Rearview"
    ##  [2] "/lyrics/Straight-Line-Stitch/Black-Veil"              
    ##  [3] "/lyrics/Straight-Line-Stitch/Never-Surrender"         
    ##  [4] "/lyrics/Straight-Line-Stitch/What-You-Do-to-Me"       
    ##  [5] "/lyrics/Straight-Line-Stitch/Taste-of-Ashes"          
    ##  [6] "/lyrics/Straight-Line-Stitch/Conversion"              
    ##  [7] "/lyrics/Straight-Line-Stitch/Promise-Me"              
    ##  [8] "/lyrics/Straight-Line-Stitch/Bar-Room-Brawl"          
    ##  [9] "/lyrics/Straight-Line-Stitch/One-Reason"              
    ## [10] "/lyrics/Straight-Line-Stitch/Yesterday-s-Gone"        
    ## [11] "/lyrics/Straight-Line-Stitch/Eucharist"               
    ## [12] "/lyrics/Straight-Line-Stitch/Living-Dead"             
    ## [13] "/lyrics/Straight-Line-Stitch/Adult-Cinema"            
    ## [14] "/lyrics/Straight-Line-Stitch/Bleeding-Heart-Theory"   
    ## [15] "/lyrics/Straight-Line-Stitch/Cold-Front"

Or, even better, by letting `rves` do the job for us:

``` r
page_title %>%
  html_nodes(".title") %>%
  html_attr("href")
```

    ##  [1] "/lyrics/Straight-Line-Stitch/Laughing-In-The-Rearview"
    ##  [2] "/lyrics/Straight-Line-Stitch/Black-Veil"              
    ##  [3] "/lyrics/Straight-Line-Stitch/Never-Surrender"         
    ##  [4] "/lyrics/Straight-Line-Stitch/What-You-Do-to-Me"       
    ##  [5] "/lyrics/Straight-Line-Stitch/Taste-of-Ashes"          
    ##  [6] "/lyrics/Straight-Line-Stitch/Conversion"              
    ##  [7] "/lyrics/Straight-Line-Stitch/Promise-Me"              
    ##  [8] "/lyrics/Straight-Line-Stitch/Bar-Room-Brawl"          
    ##  [9] "/lyrics/Straight-Line-Stitch/One-Reason"              
    ## [10] "/lyrics/Straight-Line-Stitch/Yesterday-s-Gone"        
    ## [11] "/lyrics/Straight-Line-Stitch/Eucharist"               
    ## [12] "/lyrics/Straight-Line-Stitch/Living-Dead"             
    ## [13] "/lyrics/Straight-Line-Stitch/Adult-Cinema"            
    ## [14] "/lyrics/Straight-Line-Stitch/Bleeding-Heart-Theory"   
    ## [15] "/lyrics/Straight-Line-Stitch/Cold-Front"

``` r
SLS_df %<>%
  mutate(Link = page_title %>%
  html_nodes(".title") %>%
  html_attr("href"))
```

Cool, we don’t gain much in terms of line of code, but it will be
usefull later\!

## And `purrr`\!

Cool, now we want to put grab all lyrics. Let’s start with one at a
time. What is the url we want?

``` r
url_song <- glue("https://www.musixmatch.com{SLS_df$Link[1]}")

url_song
```

    ## https://www.musixmatch.com/lyrics/Straight-Line-Stitch/Laughing-In-The-Rearview

And let’s grab the lyrics for that song. The content is marked by a css
selector called “p.mxm-lyrics\_\_content“. That stands for”p“, an object
of class paragraph, plus”mxm-lyrics\_\_content“, the specific class for
the lyrics.

``` r
url_song %>%
  read_html() %>%
  html_nodes(".mxm-lyrics__content") %>%
  html_text()
```

    ## [1] "You never say what you mean, mean what you say\n\nPick up the pieces"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
    ## [2] "And heal the pain of your cruelty\nMaybe one day you'll be able to say\nThat you're truly free but there's no guarantee\n\nIt's always the same everywhere you go\nWelcome to the slide-show\nRight up front for the whole world to see your display\nYou will never get away\n\nYou never say what you mean, mean what you say\nI'll blow you away, blow you away\nShot down in a blaze now you're lost\nWithout a trace, without a trace\n\nBut don't get caught\nOut by the undertow, out by the undertow\nBecause today is the day that you'll never\nNever escape, never escape\n\nI hope you see my face as clear as day\nAnd it continues to haunt you\nMaybe someday you'll be able to breakthrough\nBut you don't have that kind of virtue\n\nIt's always the same every time I move\nLike you got something to prove, something to prove\nYou think I'd lose my edge over the third degree\nExcuse me if I disagree\n\nYou never say what you mean, mean what you say\nI'll blow you away, blow you away\nShot down in a blaze now you're lost\nWithout a trace, without a trace\n\nBut don't get caught\nOut by the undertow, out by the undertow\nBecause today is the day that you'll never\nNever escape, never escape\n\nYou'll never escape\nYou turned your back on me\nYou turned your back on me\n\nYou'll never, never escape\nYou'll never, never escape\nYou'll never, never escape\nYou'll never, never escape"

Ach, notice that it comes in different blocks: one for each section of
text, broken by the advertisment. Well, we can just `collapse()` them
together with `glue`. As we are doing this, let’s turn that flow into a
function:

``` r
get_lyrics <- function(link){
  glue("https://www.musixmatch.com{link}") %>%
   read_html() %>%
   html_nodes(".mxm-lyrics__content") %>%
   html_text() %>%
   collapse(sep = "\n") %>%
    return()
}
```

Let’s test it\!

``` r
SLS_df$Link[3] %>%
  get_lyrics()
```

    ## Out from the darkness into the light
    ## I opened up my eyes, awakened by the sight
    ## Of the walls that are closing in, it's happening again
    ## Just another black cloud that's become my only friend
    ## 
    ## Bring it up, brother, no one said it'd be easy
    ## And you don't have to believe me when I tell you
    ## It's not over, it's not over
    ## 
    ## I've gone too far to back down now
    ## Gotta finish what I started
    ## It's not over, no, it's not over
    ## 
    ## So hold on, said we'll never surrender
    ## If there's a chance of losing more then let it go
    ## So hold on, said we'll never surrender
    ## If there's a chance of losing more then let it go
    ## 
    ## Another sleepless night alone and I can't do this on my own
    ## I'm reaching out to touch the one just like me
    ## But no one seems to hear my voice
    ## It echoes across the void, shattering with the noise
    ## 
    ## Bring it on, this is the day for redemption
    ## You don't have to wake him
    ## Whether we're wrong or if we're right
    ## Whether we're wrong or if we're right
    ## 
    ## I've gone too far to back down now
    ## Gotta finish what I started
    ## It's not over, no, it's not over
    ## 
    ## So hold on, said we'll never surrender
    ## If there's a chance of losing more then let it go
    ## So hold on, said we'll never surrender
    ## If there's a chance of losing more then let it go
    ## So hold on
    ## 
    ## This is the fight of our lives
    ## So hold on
    ## With all the [Incomprehensible]
    ## Hold on, hold on, hold on, hold on
    ## 
    ## So hold on, said we'll never surrender
    ## If there's a chance of losing more then let it go
    ## So hold on, said we'll never surrender
    ## If there's a chance of losing more then let it go
    ## 
    ## Hold on, hold on

Now we can use purrr to map that function over our dataframe\!

``` r
SLS_df %<>%
  mutate(Lyrics = map_chr(Link, get_lyrics))
```

Ok, here we were quite lucky, as all the links were right. In general we
may want to play safe, and use a `possibly` wrapper so not to have to
stop everything in case something bad happens.

## The flow

**Explore, try, test, automatize, test.**

Scraping data from the web will require a lot of trial and error. In
general, I like this flow: I explore the pages that I want to scrape,
trying to identify patterns that I can exploit. Then I try, on a smaller
subset, and I test if it worked. Then I automatize it, using `purrr` or
something similar. And finally some more testing.

## Another Artist

Let’s do this for Angel Haze. Notice that here we **have** to use the
attributes from the web page, as the name of the authors of the lyrics
is not always the same (the `glue` approach would fail).

``` r
AH_url <- "https://www.musixmatch.com/artist/Angel-Haze"

AH_lyrics <- data_frame(Band = "Angel Haze",
                        
                         Title = AH_url %>%
                          read_html() %>%
                           html_nodes(css = ".title") %>%
                           html_text(),
                        
                         Link = AH_url %>%
                          read_html() %>%
                           html_nodes(css = ".title") %>%
                          html_attr("href")
                        )
```

**WE ARRIVED PRETTY MUCH HERE IN CLASS**

### Bonus: sentiment analysis

The idea is to attribute to each word a score, expressing wether it’s
more negative and positive, and then to sum up. To do this, we are going
to use Julia Silge’s *Tidytext* library and a *vocabulary* of words for
which we have the scores (there are different options, we are using
“afinn”).

``` r
library(tidytext)
afinn <- get_sentiments("afinn")
```

Now, a bit of massaging: we breaks the lyrics into their words, remove
the words that are considered not interesting (they are called “stop
words”), stitch the dataframe to the scoress from afinn, and do the math
for each song.

``` r
SLS_df %>%
  unnest_tokens(word, Lyrics) %>% #split words
  anti_join(stop_words, by = "word") %>% #remove dull words
  inner_join(afinn, by = "word") %>% #stitch scores
  group_by(Title) %>% #and for each song
  summarise(Length = n(), #do the math
    Score = sum(score)/Length) %>%
  arrange(-Score)
```

    ## # A tibble: 15 x 3
    ##                       Title Length       Score
    ##                       <chr>  <int>       <dbl>
    ##  1               Promise Me     17  0.23529412
    ##  2         Yesterday's Gone     15  0.20000000
    ##  3        What You Do to Me     17  0.17647059
    ##  4              Living Dead     26  0.07692308
    ##  5                Eucharist      9  0.00000000
    ##  6           Bar Room Brawl     22 -0.04545455
    ##  7               Black Veil     13 -0.07692308
    ##  8          Never Surrender     18 -0.55555556
    ##  9               Cold Front     12 -0.58333333
    ## 10           Taste of Ashes     16 -0.68750000
    ## 11 Laughing In The Rearview     19 -0.78947368
    ## 12               One Reason     10 -0.90000000
    ## 13               Conversion     15 -1.46666667
    ## 14    Bleeding Heart Theory     14 -1.92857143
    ## 15             Adult Cinema      2 -3.00000000

So, what was the most positive song?

``` r
SLS_df %>%
  filter(Title == "Promise Me") %$%
  Lyrics %>%
  glue()
```

    ## This is the last day
    ## The last day that I sway
    ## No longer will you dictate what I do or say
    ## I've taken a leave of absence
    ## I've taken a leave of the senses
    ## And there's nothing in the world that could change this
    ## I can't change this
    ## No regrets
    ## I'm calling on you angels of truth
    ## Tell me that you'll never fall through
    ## Promise me Promise me
    ## Don't crumble like paper mache’
    ## Tell me that you'll always find your way
    ## Promise me Promise me
    ## This is the last day
    ## The last day that I sway
    ## No longer will they dictate what I do or say
    ## Not another dying day
    ## A part of me that's wasted away
    ## And there's nothing in the world that could change this
    ## You can't change this
    ## No regrets
    ## I'm calling on you angels of truth
    ## Tell me that you'll never fall through
    ## Promise me Promise me
    ## Don't crumble like paper mache’
    ## Tell me that you'll always find your way
    ## Promise me Promise me
    ## Standing on the sidelines
    ## Where I've been left behind
    ## Right here on the sidelines
    ## Waiting for the right time
    ## And life goes by
    ## Life goes by
    ## I'm calling on you angels of truth
    ## Tell me that you'll never fall through
    ## Promise me Promise me
    ## Don't crumble like paper mache’
    ## Tell me that you'll always find your way
    ## Promise me Promise me
    ## This is the last day
    ## And life goes by

## What about the rest?

We want to do it also for other artists. Best things is to turn some of
those scripts into functions. Let’s try with a *A Tribe Called Red* and
*Angel Haze* (I picked them ’cause they are great, and also because they
will show some limitations of the code I’m interested to tackle).

When we are about to do something over over, it’s better to write
functions. So, let’s do it\!

### Challenge

Another singer you should, should, should listen to is *Militia Vox*.
Try to replicate our work with her lyrics. What’s the problem?

note: this is loosely inspired by Max Humber’s
[post](https://www.r-bloggers.com/fantasy-hockey-with-rvest-and-purrr/)
and David Laing’s post
[here](https://laingdk.github.io/kendrick-lamar-data-science/).
