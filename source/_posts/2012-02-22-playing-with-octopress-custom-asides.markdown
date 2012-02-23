---
layout: post
title: "Playing with Octopress -- Custom Asides"
date: 2012-02-22 01:31
comments: true
categories: 
---

If you've followed this blog, you might have noticed a couple of changes in the last days.
In fact, I've been playing around with customizing Octopress and added a couple of custom asides.

## Coderwall
I wanted to add my Coderwall badges in the asides. A bit of googling lead me to another Octopress blog (http://tzangms.com), which was using Mizzy's code (http://mizzy.org/blog/2012/01/13/coderwall-badges-on-the-sidebar/) to display the badges. From there, it was pretty easy to extract the Javascript code from the page source. I only found the original author's page later today, but by then, I had already a working version.

As customization on the original code, I added the img@alt and img@title attributes to be generated from Coderwall's JSON response data. This gives a nice addition for hovering over the badge to get its description, and an alternative description for non-graphic browsers.

{% include_code ../../_includes/asides/coderwall.html %}

## Xbox Live
The second custom aside I created follows the implementation as described on the official Xbox site, which is using an iframe to embed the card. I don't really like the iframe to embed an external page, but this implementation was small and function, which is the essential.

{% include_code ../../_includes/asides/xboxlive.html %}

## Configuration
The coderwall_user and xboxlive_user need to be specified in _config.yml.

## More gamercard services
Given you have a website that generates nice gamercards (there are ton of thems), you can use the above code to include your custom gamercard as an aside.

** tl;dr **
Creating asides is super easy with Jekyll/Octopress. And I'll probably create a few more for fun.
