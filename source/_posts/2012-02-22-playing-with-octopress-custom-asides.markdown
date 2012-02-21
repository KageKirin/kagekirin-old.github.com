---
layout: post
title: "Playing with Octopress - Custom Asides"
date: 2012-02-22 01:31
comments: true
categories: 
---

If you've followed this blog, you might noticed a couple of changes in the last days.
In fact, I've been playing around with customizing Octopress by adding a couple of custom asides.

## Coderwall

I wanted to add my Coderwall badges in the asides. A bit of googling lead me to another Octopress blog (http://tzangms.com), which was using Mizzy's code (http://mizzy.org/blog/2012/01/13/coderwall-badges-on-the-sidebar/) to display the badges. From there, it was pretty to exctract the Javascript code from the page source. I only found the original author's page later today, but I had already a working code by then.

As a kind of customization on that code, I added the img@alt and img@title attributes, also generated from tCoderwall's JSON response data.

(I'll update this post after I found out how to post source code)

## Xbox Live

The second custom aside I created is taking the Xbox Live Gamercard from the official Xbox site. It's using an iframe, which I don't really like, but it's working that'S the essential.


And that's it. Too late to properly write anyway.

