---
layout: post
title: "Mulberry Jam"
date: 2012-03-07 01:00
comments: true
categories: 
---

I've been tinkering with [Mulberry/Toura](http://mulberry.toura.com) (read Mulberry by Toura) lately. It's surprisingly easy how you can create a simple app.
For my needs, a simple "information app", it's really perfect.  
But since I had some starter issues, here's a short tutorial on what I did.  
Note: I will mostly cover the iOS apps development process since I just happen to have this hardware.
(OK, me not wanting to bother with installing Eclipse at the moment is the other perfectly valid reason).


## Installation
You can install Mulberry from the [release package](http://mulberry.toura.com/download/) or by cloning its [git repo on GitHub](https://github.com/Toura/mulberry). I recommend you to do the latter because it's easier to get updates.
In fact, you should fork it first, then clone your fork, and finally add the official repo as another remote.

The [installation](https://github.com/Toura/mulberry/tree/master/install/osx) script will install all the missing parts but you will need to have Java and Xcode4 (on OSX, obviously) installed beforehand.

Although the installation script should fetch everything automatically, there are 2 points that need attention:
-  the PhoneGap version that comes with it lags 2 minor revisions behind (1.5.0 was just released), so you will want to update PhoneGap from the [official release](link here) (or its GitHub repo if you're feeling like it).
-  Ruby 1.9.2 might fail to install on OSX for some reason.

Actually, if you're installing from the GitHub clone, just modify `install.sh` to the following (starting around line 133):  
(Search-and-replace is your friend).
``` bash starting around line 133 of osx/install.sh
if [[ $(cat ~/Documents/PhoneGapLib/VERSION ) =~ '1.5.0' ]]
then
	echo "PhoneGap 1.5.0 is installed."
else
	echo "Downloading PhoneGap 1.5.0 to tmp/callback-phonegap-b81151f..."

	cd tmp
	curl https://nodeload.github.com/callback/phonegap/zipball/1.5.0 --O phonegap.1.5.0.zip

	unzip -q phonegap.1.5.0.zip
	cd ..

	hdiutil mount tmp/callback-phonegap-b81151f/iOS/PhoneGap-1.5.0.dmg

	open /Volumes/PhoneGap-1.5.0/PhoneGap-1.5.0.pkg
fi
```

RVM has issues installing Ruby 1.9.3 on OSX for some reasons. :(  
But you can install Ruby 1.9.2 (i.e. leave your Ruby installation for Octopress as it is) and change the reference to Ruby in the `.rvmrc` to:
	rvm use 1.9.2@mulberry
	
The (probably safer) alternative way is to modify install.sh again to install Ruby 1.9.2 instead. (Again, search-and-replace works miracles for that).
``` bash starting at around line 66 of osx/install.sh
if [[ $RVMRUBIES =~ '1.9.2' ]]
then
	echo "Ruby 1.9.2 is installed..."
else
	echo "Installing Ruby 1.9.2 via RVM..."
	rvm install 1.9.2
fi

# a bit below
if [[ $RVMGEMSETS =~ 'mulberry' ]]
then
	echo "Mulberry gemset exists..."
else
	echo "Creating Mulberry gemset..."
	rvm use 1.9.2
	rvm gemset create 'mulberry'
fi

# a few lines further down
rvm use 1.9.2@mulberry
```

Here's the full change:
{% gist 1990770 %}

The install script will add a few lines to `.bash_profile`. You might need to adapt this to your installation. (`.profile` is usually the default shell config on OSX).


## Hello Mulberry and Terminology
In Mulberry's terms, creating the base for an app is called "to scaffold", so this is the first command to invoke.  
Note that you have to be inside the folder you installed Mulberry to for it to work. (That's an issue related to RVM, afaik).

In my setup, I created an folder called `Apps` in the root folder of Mulberry and symbolically linked it to ~/Documents/Coding/Apps so I can retrieve it easily.

In `<mulberry-root>/<my-apps>`, just run
	mulberry scaffold HelloMulberry
to create the scaffolding of your very own app, called `HelloMulberry` in this case, and which should not exist prior to running the command.
**Note for git**: since your project will lie inside mulberry's root folder, it will be tracked by the base repo.
To change this, you could move the app folder to some temp folder, run `git init` there and move it back (and `git submodule add` it if required).

For all the remaining commands to work, you need to be inside the folder created for your app.
	
Once the scaffold command has returned safely, you can directly test your app with these commands:

	mulberry generate
to generate all the pages and create the custom components.

	mulberry serve
to generate and launch a webserver (on port 3001 by default) from where you can access your app in Mobile Safari.

	mulberry test
to launch the full compilation process, at which end it will start Xcode from where you can Apple-R(un) the app either in the simulator or on your provisioned device.

There is a fully featured demo in `<mulberry-root>/demo` that is worth checking out as an example. There used to be other apps in previous revisions (which disappeared in a recent update),
but it might be interesting to branch them as well.

 
## Content creation
The base command to create new content is
	mulberry create <what> <name>
with a few exceptions I will explain later.
	
### Adding pages
	mulberry create page <pagename>
will create a file at `<app-root>/pages/<pagename>.md` that contains the basic YAML front matter for defining a page, and some sample text.

To access this newly created page, you need to edit `<app-root>/sitemap.yml` in order to include it at the correct place in the page hierarchy. It's YAML, and it really contains just the hierarchy. Mulberry will arrange the pages to present the links on the subsequent pages in the order you declare them.
``` yaml real-life example of a sitemap.yml
- home:
  - osu
  - dojokun
  - organization:
    - founder
    - president
    - vicepresident
    - ikocommittee
- about
```

Pages all lie in `<app-root>/pages/`, without any hierarchy. Good naming (prefixes?) might greatly ease the pain of dealing with lots of pages.

### Adding images, videos and audios
From my (naive and potentially wrong) understanding of the docs, these kind of *assets* can be added for visualization/playback to a page with the right page-def (format) to present it.
This also counts for all the other type of implemented assets, or for your custom ones.

Any asset needs to be placed inside the correct folder, which is  
`<app-root>/assets/<asset-type>/` for the asset file itself,  
`<app-root>/assets/<asset-type>/captions/` for a *caption* describing the asset, which is a markdown file with the same name as the asset,  
and the reference to it must be placed inside the page referring to it.  
(Don't panic, it'll all become much clearer in the example below).


#### Example: a sample video
1.  We place our asset `sample_video.mp4` into `<app-root>/assets/videos/sample_video.mp4`.  
1.  We create the caption `sample_video.md` in `<app-root>/assets/videos/captions/sample_video.md`. (e.g. `touch <app-root>/assets/videos/captions/sample_video.md`).  
1.  We edit `sample_video.md` as follows:  
``` yaml an example markdown for a sample video
---
name: A sample video
---

This is a sample video.
```  
The only YAML front matter needed is the name of the video.  
1.  We create a new page for this video with `mulberry create page video_page` and edit it as follows:  
1.1.  We change the page_def to a page able to display the video: `videos-and-text-<platform>` sounds like a good candidate.  
    page_def:
        phone: videos-and-text-phone
        tablet: videos-and-text-tablet
1.1.  We add a reference to our video to the `videos` list in the front matter:  
    videos: sample_video.mp4
1.1.  Optionally, we add a header image and a short describing text inside the markdown area after the front matter.  
And that's it.

The `<app-root>/pages/video_page.md` should look like this:  

``` yaml a sample page for videos
---
title: videotest
page_def:
    phone: videos-and-text-phone
    tablet: videos-and-text-tablet
    
# each of these properties can contain an array of filenames
images:
videos: sample_video.mp4
audios:
feeds:
locations:
data:
   
# this should optionally point at an image in the images dir
header_image:
---
A test video
```

I didn't mention it, but the video or image has to be in a format readable by the target platform. (JPEG, PNG is fine for pictures, MP4 great for videos, and MP3 an obvious choice for audio).

When re-generating (or serving) the app, the video will be accessible on the page you put it on.


### Adding data, feeds, locations
What the [doc](https://github.com/Toura/mulberry/wiki/Command-Line-Interface) says, but honestly, I have no idea what they mean. Could you explain it to me?
What do they mean by data (a database, a blob?), feed (RSS/ATOM feed reference?) and locations (GPS or Google Maps locations?) ?

I have not really investigated, nor understood the stuff below, but I'll edit this later once the understanding is there.
***


## Customization

### Page-defs

### Components

## App Icon

## Flash screen

## Universal Apps
there should be way to create them...

## Automatic build
Command line and Jenkins integration


**tl;dr** I hope this short guide was useful to you.  
I've created a [help page](/help/mulberry-cheat-sheet.html) and although it's more a reminder for myself, you can use it as an easy overview.


