---
title: "FAQ"
output:
  html_document:
    toc: true
    toc_depth: 3
    includes:
      after_body: include/nothing.html
---

### When is the course offered?

September - December of each academic year.  
Typical format: STAT 545A 1.5 credits in September through mid October, followed by STAT 547M 1.5 credits from mid October through early December.  
Same time slot, same room.  
This was/is/will be the deal in 2014/2015, 2015/2016 and 2016/2017, at the least.

### Course facts for Sept - Dec 2016 run

|          | STAT 545A                       | STAT547M                        |
|----------|---------------------------------|---------------------------------|
| title    | Exploratory Data Analysis       | Basic Training for Data Science |
| SSC link | [STAT 545A][SSC 545A]           | [STAT 547M][SSC 547M]           |
| credits  | 1.5                             | 1.5                             |
| dates    | Sep 06, 2016 to Oct 20, 2016    | Oct 25, 2016 to Dec 02, 2016    |
| meets    | Tues Thurs 9:30 - 11am          | Tues Thurs 9:30 - 11am          |
| where    | [ESB 2012][esb2012]             | [ESB 2012][esb2012]             |
| pre-req  | none (but see below)            | STAT 545A                       |

[esb1042]: http://www.maps.ubc.ca/?225
[esb2012]: https://ssc.adm.ubc.ca/classroomservices/function/viewlocation?userEvent=ShowLocation&buildingID=ESB&roomID=2012
[SSC 545A]: https://courses.students.ubc.ca/cs/main?pname=subjarea&tname=subjareas&req=5&dept=STAT&course=545A&section=101
[SSC 547M]: https://courses.students.ubc.ca/cs/main?pname=subjarea&tname=subjareas&req=5&dept=STAT&course=547M&section=101

Up-to-date info on office hours: TBD
<!-- [here](https://github.com/STAT545-UBC/Discussion/issues/85) -->

### What's up with the two half courses?

For several years, I taught STAT 545A as a 1.5 credit course. I -- and many students -- felt there was alot of great, relevant content that could go into an additional 1.5 credits.

We piloted a full semester of data exploration, visualization, and all-around data wrangling in 2014/2015. And so far, it has stuck. It was structured as two half courses primarily so that several year's worth of STAT 545A alums could register for STAT 547M and get the "missing half" of the course. And now it's hard to break the cycle.

### Am I allowed to register in ...?

  * "I have taken STAT 545A for 1.5 credits in the past. Can I take STAT 547M?"
    - YES. But STAT 545 has changed to keep current with the R world. It is your responsibility to level up. Examples: the use of Git for version control, GitHub for collaboration, `knitr` and R Markdown for dynamic documents, `ggplot2` for graphics, `dplyr` for data aggregation.
  * "Can I just take the second half, i.e. STAT 547M?"
    - NO, not unless you have taken STAT 545A previously.
  * "Can I take just the first half, i.e. STAT 545A?"
    - YES. But development is proceeding with the ultimate goal of creating a full 3 credit course. I will try to make each half stand alone reasonably well, but that is not my top priority.
  * "What do you advise I do?"
    - Take STAT 545A and STAT 547M!
  * "I am an undergraduate. Can I take this course?"
    - PROBABLY. Contact me.
    - [There is a form for this.](https://www.grad.ubc.ca/forms/enrolment-undergraduate-students-graduate-course)
  * "I am a registered UBC student. Can I audit?"
    - PROBABLY. Contact me.
    - If you are a registered UBC student and course participation doesn't cost you additional money, I will almost certainly require that you audit officially.
    - There is a form for this: [UBC undergrads](http://students.ubc.ca/enrolment/courses/academic-planning/audit) and [graduate students](http://www.grad.ubc.ca/current-students/managing-your-program/audit)
  * "I am an unclassified student, SFU student, post-doctoral fellow, etc. Can I sit in the course?"
    - PROBABLY. Contact me.
  * "What if I've never had a stats class?"
    - There are no official pre-requisites for STAT 545A but most students will have had at least one prior statistics course or comparable experience.

### Should I register in ...?

This course is open to any graduate student at UBC. Students from other departments vastly outnumber those from Statistics. In fact, the most successful students are often grad students from other fields who need to analyze and visualize data for a thesis. They are highly motivated and excel.

However, __if you have never programmed or worked at the command line before, prepare for a shock.__ This will be a powerful, positive experience, but it's a big adjustment. Come suffer through the worst part of the learning curve in good company!

### Do I need a computer?

YES. You absolutely must have access to a computer on which you can install software, download data, etc. In fact, *class meetings* will be a mix of lecture, discussion, and live coding. Students will get the most out of this if they can bring their own laptop to class every day. If this is not possible, we will try to help you work something out.

### Where do course marks come from?

Course mark = 75% homework, 15% peer review, 10% engagement (i.e. attendance, participation in discussion in-class and/or online)

Students submit homework once a week, generally 5 per half-semester. I have abandoned the notion of "final projects". I've seen it encourage too much sudden, heroic effort, often to disappointing effect.

  * [General guidelines](hw00_homework-guidelines.html) for homework submission

Each homework will be evaluated by 2 peer reviewers. The performance of thoughtful peer review will count as 15% of the overall course mark.

  * [General homework rubric](peer-review01_marking-rubric.html) to apply in peer review
  * [Evaluation of peer review](peer-review02_peer-evaluation-guidelines.html)
  
No final exam.

### How do I get help?

  * [General, external strategies](help-general.html) for solving computing problems, especially with R
  * [Specific advice](help-STAT545.html) within these courses
