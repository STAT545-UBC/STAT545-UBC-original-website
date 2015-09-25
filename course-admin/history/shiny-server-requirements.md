---
title: "Shiny server requirements"
author: "Jenny Bryan"
date: "5 June, 2014"
output: html_document
---

*What is this document? I think it's something I wrote in 2014 to explain our Shiny needs to myself and dept head. Found it lying around in a directory I want to delete.*

## What is Shiny?

> A web application framework for R

> Turn your analyses into interactive web applications

> No HTML, CSS, or JavaScript knowledge required

[Shiny web home at RStudio](http://shiny.rstudio.com)

[Shiny gallery](http://shiny.rstudio.com/gallery/)

## What is Shiny server?

If you want to build Shiny apps and serve them up on the web, you need the ability to __deploy__ them to a __Shiny server__, which is a specialized web server. There are, in theory, 2 options:

  * [ShinyApps.io](http://www.rstudio.com/products/hosted-shiny/): Use RStudio's servers and let them deal with the technical stuff. As of 2014-06-05, this is in closed alpha (Jenny has gotten an account, but not tried it yet). Unclear when this will really go live and what the pricing model will be. Probably not a solution for us, i.e. not affordable given the number of developers and users we would want to support.
  * [Shiny Server](http://www.rstudio.com/products/shiny/shiny-server/): Run your own Shiny server. There are 2 sub-options:
    - Open Source and free edition: "Great for hosting lightweight public applications; Does not support authentication or SSL; Single R process per application"
    - Professional and not necessarily free edition: "Perfect for workgroups and enterprises; Supports authentication and SSL; Includes admin dashboard with both realtime and historical performance data; Can use multiple R processes per app; Priority Email Support; 8 hour response during business hours (ET)"

Discussion among Jenny, Thé, Rick, and Davor lead to the conclusion that we need Shiny Server Pro.

Regular pricing for Shiny Server Pro (don't worry, there are academic discounts!):

  * 20 concurrent connections: $9,995/server/year
  * 200 concurrent connections: $24,995/server/year
  
BTW A [*connection*](http://www.rstudio.com/faq-items/what-exactly-is-a-concurrent-connection/) is "a browser session connected to the Shiny Server" -- so it is someone using or viewing a Shiny app. If Shiny is being used in a course, you would probably want the server to support at least as many connections as there are students in the class. If students are *developing* Shiny apps that might be of interest to the wider world, then you might need to support a much larger number of connections (at least at peak interest).

Academic discount for Shiny Server Pro:

  * __FREE__ for teaching
  * 50% of regular price for research

## Shiny server pro

Early June 2014 we got Shiny Server Pro under a free academic license, using STAT 545 as the justification. We will use it over the summer as a beta test. The goal is to incorporate Shiny into STAT 545 in October or November 2014. Students in the course will develop their own apps.

What we need to support Shiny Server in anticipated real world conditions:

  * Single socket Xeon E5 8 core 2.3 Ghz CPU, 64GB server (could handle 150 concurrent users)
    - example: a Dell R420 server = $5000
  * Amount of storage depends on size of the datasets that underpin the apps
    - Thé says user's data storgage/backup can possibly use existing infrastructure; needs to be worked out and tested
    - Specific concern: integration with Active Directory which handles authentication for ugrad.stat.ubc.ca where we host all teaching lab accounts
    - Specific concern: if app is intensive on "write and read many small files" this would go beyond our storage hardware beyond it performance limit
  * IT personnel time for admin/testing/setup cost. Priceless.
  * In the [Shiny Server Administrator’s Guide](https://s3.amazonaws.com/rstudio-shiny-server-pro-build/docs/shiny-server-pro-1.1.0-admin-guide.pdf) on page 83, this FAQ seems relevant:
    - Q: 7.4.2 Does Shiny Server work on Amazon Elastic Compute Cloud (EC2)?
    - A: Absolutely. Many customers deploy Shiny Server and Shiny Server Professional on the Amazon Web Services (AWS) framework.
    - *Add some of our discussion about this*

Funding sources

  * [TLEF](http://tlef.ubc.ca)
  * Flex learning
  * Data science development fund