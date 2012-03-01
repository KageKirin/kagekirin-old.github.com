---
layout: page
title: "help"
date: 2012-02-20 01:39
comments: false
sharing: true
footer: true
---

If you found this page, you're good. It isn't referenced on the site.

This page is merely a cheat sheet to help with all the commands and syntaxes used by Octopress, since I'm too lazy to open up several pages everytime I want to write a post.
For reference, the original Octopress docs are [here](http://octopress.org/docs/).

## Octopress Rake Commands

Page generation
```
rake new_post["title"]					#creates new blog post in source/_posts/
rake new_page[path/to/file.html]		#creates path/to/file.html
rake new_page[path/to/file.markdown]	#creates path/to/file.markdown
rake new_page[path/to/folder]			#creates path/to/folder/index.markdown
```

Site regeneration and testing
```
rake generate   # Generates posts and pages into the public directory
rake watch      # Watches source/ and sass/ for changes and regenerates
rake preview    # Watches, and mounts a webserver at http://localhost:4000
```
(And I should be using the preview functionality BEFORE committing everything back to the server to see any changes).

Deploying to GitHub (given you followed the [installation guide](http://octopress.org/docs/deploying/github/))
```
rake generate
rake deploy
git add .
git commit -m "updated blog"
git push origin source
```

Deploying to Heroku (given you followed the [installation guide](http://octopress.org/docs/deploying/heroku/))
```
rake generate
git add .
git commit -m "updated blog"
git push origin master
```

Note: There's my `regen.sh` that automatizes the updating to the server
```
$ ./regen.sh
```

Updating Octopress (from original GitHub source)
```
git pull octopress master	#and pray you don't get merge conflicts
```

Obviously, a visual git client could be used, but for what purpose? Scripts are faster.


## Markdown Syntax
Original documentation: [Daring Fireball](http://daringfireball.net/projects/markdown/syntax)
Another documentation: [kohanut](http://kohanut.com/docs/using.markdown)
Not used here, but useful for GitHub commits: [GitHub Flavored Markdown](http://github.github.com/github-flavored-markdown/)






## Octopress Plugins

### Source embedding

Triple backticks
{% codeblock %}
``` [language] [title] [url] [link text]
code snippet
```
{% endcodeblock %}

Codeblock element
```
{% codeblock [title] [lang:language] [url] [link text] %}
#code goes here
{% endcodeblock %}
```

Gist
```
{% gist gist_id [filename] %}
{% gist 1059334 svg_bullets.rb %}	#e.g.
```
Note: how to get a gist ID?

Files
```
{% include_code [title] [lang:language] path/to/file %}	#path must be relative to root (or source?) folder, else you get a nice "source not found" instead.
{% include_code A CoffeeScript Test test.coffee lang:coffeescript %}
```

jsFiddle (a site for code sharing, apparently)
```
{% jsfiddle shorttag [tabs] [skin] [height] [width] %}
```


### Image embedding
```
{% img [class names] /path/to/image [width] [height] [title text [alt text]] %}	#path must be relative to root (or source?) folder
```

```
{% img http://placekitten.com/890/280 %}
{% img left http://placekitten.com/320/250 Place Kitten #2 %}
{% img right http://placekitten.com/300/500 150 250 Place Kitten #3 %}
{% img right http://placekitten.com/300/500 150 250 'Place Kitten #4' 'An image of a very cute kitten' %}
```

### Video embedding
```
{% video url/to/video [width height] [url/to/poster] %}
```

## More stuff

### Render partial
From [here](http://octopress.org/docs/plugins/render-partial/). Partials get resolved and embedded BEFORE Jekyll translation.

```
{% render_partial path/to/file %}	#path can be anywhere on generating machine (best inside blog git repo)
{% render_partial ~/Documents/README.markdown %}	#e.g.
{% render_partial documentation/TOC.markdown %}		#partials can be used for shared content, e.g. a TOC generator
```

### Blockquote
From [here](http://octopress.org/docs/plugins/blockquote/)
```
{% blockquote [author[, source]] [link] [source_link_title] %}
Quote string
{% endblockquote %}
```

### Pullquote
From [here](http://octopress.org/docs/plugins/pullquote/)
```
{% pullquote %}
Surround your paragraph with the pull quote tags. Then when you come to
the text you want to pull, {" surround it like this "} and that's all there is to it.
{% endpullquote %}
```





