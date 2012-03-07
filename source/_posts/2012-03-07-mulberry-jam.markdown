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


# Installation
You can install Mulberry from the [release package](http://mulberry.toura.com/download/) or by cloning its [git repo on GitHub](https://github.com/Toura/mulberry). I recommend you to do the latter because it's easier to get updates.
In fact, you should fork it first, then clone your fork, and finally add official one as another remote.

The [installation](https://github.com/Toura/mulberry/tree/master/install/osx) script will install all the missing parts but you will need to have Java and Xcode4 (on OSX, obviously) installed before hand.

But since the PhoneGap version that comes with it lags 2 minor revisions behind, so you will want to update PhoneGap from the [official release](link here) (or its GitHub repo if you're feeling like it).

Actually, if you're installing from the GitHub clone, just modify `install.sh` to the following (starting around line 133):
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

Note that rvm cannot install Ruby 1.9.3 on OSX for some reasons. :( But you can install Ruby 1.9.2 (i.e. leave your Ruby installation for Octopress as it is) and change the reference to Ruby in the `.rvmrc` (make sure it's the correct file) to 
	rvm use 1.9.2@mulberry
	
The (probably safer) alternative way is to modify install.sh again to install Ruby 1.9.2 instead.
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

(I should probably modify mine and show the gist. Will do that later).

(TODO add more details about custom install)

# Hello Mulberry and Terminology
In Mulberry's terms, creating the base for an app is called "to scaffold", so this is the first command to invoke.  
Note that you have to be inside the folder you installed Mulberry to for it to work.
(I created an folder called `Apps` in the root folder of Mulberry and symbolically linked it to ~/Documents/Coding/Apps so I can retrieve it easily).

In `<mulberry-root>/<my-apps>`, just run
	mulberry scaffold 
to create the scaffolding of your very first own app.
	
Once the scaffold command has returned safely, you can directly test your app with these commands:
	mulberry serve
to launch a webserver (on port 3001 by default) from where you can access your app in Mobile Safari.

	mulberry test
to launch the full compilation process, at which end it will start Xcode from where you can Apple-R(un) the app either in the simulator or on your provisioned device.

Note: there is fully featured demo in `<mulberry-root>/demo` that is worth checking out as an example.

 
# Content creation

## Adding pages

## Adding images
## Adding videos and audios

## Adding data, feeds etc.
What the doc says, but honestly, I have no idea what they mean. Could you explain it to me?

# Customization
## Page-defs

## Components

## App Icon
## Flash screen

# Universal Apps
there should be way to create them...

# Automatic build
Command line and Jenkins integration


**tl;dr** I hope this short guide was useful to you.  
I've created a [help page]() and although it's more a reminder for myself, you can use it as an easy overview.
