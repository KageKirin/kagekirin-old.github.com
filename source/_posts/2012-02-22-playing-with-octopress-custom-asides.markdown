---
layout: post
title: "Playing with Octopress -- Custom Asides"
date: 2012-02-22 01:31
comments: true
categories: 
---

If you've followed this blog, you might have noticed a couple of changes in the last days.
In fact, I've been playing around with customizing Octopress by adding a couple of custom asides.

## Coderwall
I wanted to add my Coderwall badges in the asides. A bit of googling lead me to another Octopress blog (http://tzangms.com), which was using Mizzy's code (http://mizzy.org/blog/2012/01/13/coderwall-badges-on-the-sidebar/) to display the badges. From there, it was pretty to exctract the Javascript code from the page source. I only found the original author's page later today, but I had already a working code by then.

As a kind of customization on that code, I added the img@alt and img@title attributes, also generated from Coderwall's JSON response data.

```
{% if site.coderwall_user %}
<section>
  <h1>Coderwall Badges</h1>
  <p>
    <script type="text/javascript">
      function display_coderwall(args) {
        var badges = args["data"]["badges"];
        var wall = '';
        for ( var i = 0; i < badges.length; i++ ) {
          var alt_txt = badges[i]["name"];
          var title_txt = badges[i]["name"] + ' - ' + badges[i]["description"];
          wall += '<a href="http://coderwall.com/{{site.coderwall_user}}/"><img src="'
            + badges[i]["badge"]
            + '" width="48" height="48" alt="' + alt_txt
            + '" title="' + title_txt
            + '"/></a>';
        }
        document.write(wall);
      }
    </script>
    <script src="http://coderwall.com/{{site.coderwall_user}}.json?callback=display_coderwall"></script>
  </p>
  {% if site.coderwall_show_endorse_link %}
  <p><a href="http://coderwall.com/{{site.coderwall_user}}"><img src="http://api.coderwall.com/{{site.coderwall_user}}/endorsecount.png" /></a></p>
  {% endif %}
</section>
{% endif %}
```

## Xbox Live
The second custom aside I created is taking the Xbox Live Gamercard from the official Xbox site. It's using an iframe, which I don't really like, but it's working, that's the essential.

{% codeblock xboxlive.html %}
{% if site.xboxlive_user %}
<section>
  <h1>Xbox Live</h1>
  <iframe src="http://gamercard.xbox.com/{{site.xboxlive_user}}.card" scrolling="no" frameBorder="0" height="140" width="204">{{site.xboxlive_user}}</iframe>
</section>
{% endif %}
{% endcodeblock %}

## Configuration
You will need to specify a coderwall_user and xboxlive_user in _config.yml for this to work.

## More gamercard services
Given you have a nice gamercard web app, you can use the above code to include your custom gamercard as an aside.

** tl;dr **
Creating asides is super easy with Jekyll/Octopress. And I'll probably create a few more for fun.
