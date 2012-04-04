---
layout: post
title: "Jekyll plugin for Graphviz"
date: 2012-04-04 23:28
comments: true
categories: ["octopress", "jekyll"]
---

I stumbled over this small Jekyll plugin for Octopress
which allows to use [graphviz](http://www.graphviz.org/) notation inside a blog post.  
[original link](http://dryman.github.com/blog/2012/04/04/jekyll-graphviz-plugin/)

Obviously, you need to have graphviz installed on your generating system.
(`port install graphviz` should do it if you have MacPorts installed).

Here's a short test

    {% graphviz %}
    digraph G {
      compound=true;
      subgraph cluster0 {
        a -> b;
        a -> c;
        b -> d;
        c -> d;
      }
      subgraph cluster1 {
        e -> g;
        e -> f;
      }
      b -> f [lhead=cluster1];
      d -> e;
      c -> g [ltail=cluster0, lhead=cluster1];
      c -> e [ltail=cluster0];
      d -> h;
    }
    {% endgraphviz %}

should give the diagram below:

{% graphviz %}
digraph G {
  compound=true;
  subgraph cluster0 {
  a -> b;
  a -> c;
  b -> d;
  c -> d;
  }
  subgraph cluster1 {
  e -> g;
  e -> f;
  }
  b -> f [lhead=cluster1];
  d -> e;
  c -> g [ltail=cluster0, lhead=cluster1];
  c -> e [ltail=cluster0];
  d -> h;
}
{% endgraphviz %}

Now, where I see great use for this plugin (and probably gonna use it in the future), is to generate UML diagrams to describe a given architecture, flow charts to describe data or work flows, or schemata describing some algorithm.

You probably should install the plugin from
[its repository](https://github.com/dryman/dryman.github.com/blob/src/plugins/graphviz_block.rb)
or wait until it has been integrated into the mainline Octopress branch.


And for the hardcore coders, it should be possible to add it to Mulberry/Toura as well, as it's based on Jekyll as well.
(Although I see hardly any need to generate diagrams for an app. Then again, there might be a need for it).

