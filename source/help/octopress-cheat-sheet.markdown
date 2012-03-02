---
layout: page
title: "Octopress Cheat Sheet"
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
    rake new_post["title"]                #creates new blog post in source/_posts/
    rake new_page[path/to/file.html]		#creates path/to/file.html
    rake new_page[path/to/file.markdown]	#creates path/to/file.markdown
    rake new_page[path/to/folder]		#creates path/to/folder/index.markdown


Site regeneration and testing
    rake generate   # Generates posts and pages into the public directory
    rake watch      # Watches source/ and sass/ for changes and regenerates
    rake preview    # Watches, and mounts a webserver at http://localhost:4000

(And I should be using the preview functionality BEFORE committing everything back to the server to see any changes).

Deploying to GitHub (given you followed the [installation guide](http://octopress.org/docs/deploying/github/))
    rake generate
    rake deploy
    git add .
    git commit -m "updated blog"
    git push origin source


Deploying to Heroku (given you followed the [installation guide](http://octopress.org/docs/deploying/heroku/))
    rake generate
    git add .
    git commit -m "updated blog"
    git push origin master


Note: There's my `regen.sh` that automatizes the updating to the server
    $ ./regen.sh

Updating Octopress (from original GitHub source)
    git pull octopress master	#and pray you don't get merge conflicts


Obviously, a visual git client could be used, but for what purpose? Scripts are faster.


## Markdown Syntax
Original documentation: [Daring Fireball](http://daringfireball.net/projects/markdown/syntax)  
Another documentation: [kohanut](http://kohanut.com/docs/using.markdown)  
Not used here, but useful for GitHub commits: [GitHub Flavored Markdown](http://github.github.com/github-flavored-markdown/)  

### Section headings
    # H1
    ## H2
    ###### H6 (which is max)


### Emphasizes
    *emphasized text - single asterisk*
    _emphasized text - single underscore_
    **bold text - double asterisk**
    __bold text - double underscore__
    
    --barred text--
    ==double-barred text==

--barred text--
==double-barred text==

Literal signs must be escaped.
    \*literal asterisk\*
    \_literal underscore\_


### Paragraphs
    Some text.
    More text on the same paragraph.
    
    New paragraph.  
    More text after forced line break. Note the double space at the end of the previous line.



### Blockquote
Just like in emails.
    > A blockquote, like quoting in emails
    > can span over multiple lines
    > > double nested
    > > > now this can get messy.


### Lists
#### Unordered lists
    *   Element 1
    *   Element 2

    +   Element 1
    +   Element 2

    -   Element 1
    -   Element 2


#### Ordered lists
    1.  Element 1
    2.  Element 2

#### Ordered lists for lazy people (e.g. me)
    1.  Element 1
    1.  Element 2

#### Conflicts with normal punctuation can be resolved with a backslash escape.
    1986\. What a great season.

### Links
    [link text](#page-anchor)
    [link text](url)


#### Reference-style links to re-use same link several times (explicit version)
    [an example][id] reference-style link				
    [id]: http://example.com/  "Optional Title Here"	#defined anywhere in the document. best as a footnote

#### Reference-style links (implicit version)
    [Google][]											#implicit id, i.e. name is id
    [Google]: http://google.com/
    Visit [Daring Fireball][] for more information.
    [Daring Fireball]: http://daringfireball.net/


#### Automatic links
    <http://example.com/>
    <address@example.com>	#will try to fool mail address collector bots


### Source code
#### Inline source
    `printf();`	#single backtick
    ``SELECT `id` FROM `people`;	#double backtick makes single backtick usabe in code 

#### Source paragraph
Indented paragraph
        #source goes here
    	#1-tab indenting
        #4-spaces indenting
or triple-backtick. See further down about this.


### Images
    ![Alt text](/path/to/img.jpg "Optional title")
or see further below for Octopress/Jekyll tag.


### Misc
#### Backslash escaping
available for following characters
    \   backslash
    `   backtick
    *   asterisk
    _   underscore
    {}  curly braces
    []  square brackets
    ()  parentheses
    #   hash mark
    +   plus sign
    -   minus sign (hyphen)
    .   dot
    !   exclamation mark


#### Horizontal rule 
    * * *
    ***
    *****
    - - -
    ---------------------------------------



## Octopress Plugins

### Source embedding

Triple backticks
    ``` [language] [title] [url] [link text]
    #code goes here
    ```

Codeblock element
    \{% codeblock [title] [lang:language] [url] [link text] %\}
    #code goes here
    \{% endcodeblock %\}

Gist
    {% gist gist_id [filename] %}
    {% gist 1059334 svg_bullets.rb %}	#e.g.
Note: how to get a gist ID?

Files
    {% include_code [title] [lang:language] path/to/file %}	#path must be relative to root (or source?) folder, else you get a nice "source not found" instead.
    {% include_code A CoffeeScript Test test.coffee lang:coffeescript %}

jsFiddle (a site for code sharing, apparently)
    {% jsfiddle shorttag [tabs] [skin] [height] [width] %}

### Image embedding
    {% img [class names] /path/to/image [width] [height] [title text [alt text]] %}	#path must be relative to root (or source?) folder


    {% img http://placekitten.com/890/280 %}
    {% img left http://placekitten.com/320/250 Place Kitten #2 %}
    {% img right http://placekitten.com/300/500 150 250 Place Kitten #3 %}
    {% img right http://placekitten.com/300/500 150 250 'Place Kitten #4' 'An image of a very cute kitten' %}


### Video embedding
    {% video url/to/video [width height] [url/to/poster] %}


## More Jekyll stuff

### Render partial
From [here](http://octopress.org/docs/plugins/render-partial/): Partials get resolved and embedded BEFORE Jekyll translation.
    {% render_partial path/to/file %}		#path can be anywhere on generating machine (best inside blog git repo)
    {% render_partial ~/Documents/README.markdown %}	#e.g.
    {% render_partial documentation/TOC.markdown %}		#partials can be used for shared content, e.g. a TOC generator


### Blockquote
From [here](http://octopress.org/docs/plugins/blockquote/):
    {% blockquote [author[, source]] [link] [source_link_title] %}
    Quote string
    {% endblockquote %}


### Pullquote
From [here](http://octopress.org/docs/plugins/pullquote/):
    {% pullquote %}
    Surround your paragraph with the pull quote tags. Then when you come to
    the text you want to pull, {" surround it like this "} and that's all there is to it.
    {% endpullquote %}

