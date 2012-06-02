---
layout: post
title: "My Work Environment (Valhalla, 2012)"
date: 2012-06-02 19:07
comments: true
categories: 
---

One of those posts, where I rant about my work environment.

At work, I'm pretty much bound to a Windows environment,
since all the tools only work there.
So, I'm running Windows7
(to which I got upgraded just recently, for the sake of my own sanity, which was at stake for using Vista in 2012)
on a DELL Precision T3500 with Radeon Graphics.
For the IDE, it's naturally Visual Studio,
namely Visual Studio 2008 Team System.
Per default, I had no version of Visual Assist X,
forcing me to buy my own license
(talking about "tools of the trade" when you can't have access to the swiss army knife of VS).
I also installed MetalScroll,
which makes finding references inside of one file pretty easy.
And IncrediBuild,
which apparently costs way more in Japan,
due to some dirty tricks from the Isreali Embassy (the only provider of this product in Japan),
which tries to suck the lifeblood out of japanese software companies through their pricing.

For the source version control,
we're using Perforce,
so I'm stuck with their tools,
and despite there being a couple of welcome improvements in the latest versions,
i.e. streams,
I don't have access to them as the server is running in older version.
In fact, I often wish (at least 5 times a day) I could use git locally,
but the git-p4 bridges don't work that well.
(The hg-p4 bridge does work well, but I don't remember the way I set it up at my former employer).

For file editing related things (other than C++),
I'm using Notepad++,
which, although not perfect,
doesn't give me headaches about usability issues.

I set up P4 to use P4merge for merging files, since I like the 3 way-view with
"theirs", "base" and "ours" on the top,
and "merge result" below.
For diffs, I'm using a very handy tool called "diffuse",
which allows for super fast diff'ing with only keyboard interaction.
(The only issue I'm having with it is that it tends to break files with japanese encoding.
But then again, it's the comments that are in japanese,
and I just delete them since "you shouldn't need to comment your code").

For other file related actions,
I'm either using the vanilla explorer,
or Total Commander (which is my preference when it comes to moving lots of files).

JWPce is my preference for writing Japanese,
as it includes a pretty neat dictionary,
and I'm so used to this tool,
that I can hardly read Japanese without.
(Yeah, I'm lazy and I know it).

For the other dev tools,
it's pretty classic,
XDK for working on Xbox360,
and SN Tools for working on PS3.

Oh yeah, one of the tools that come in handy is Oracle's -Sun's- Virtual Machine VirtualBox.
I have already a (several) Linux installation to automatize some backups
and I'm running one from time to time to test software before installing it on my main system.
It's also pretty cool to track down hardware or driver issues that occur on the host system,
but should not be reproducible on the VM.

And that's pretty much it.
I'm using some batch files to simplify a couple of workflows,
but nothing really extraordinary.