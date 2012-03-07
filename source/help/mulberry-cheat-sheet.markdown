---
layout: page
title: "Mulberry Cheat Sheet"
date: 2012-02-20 01:39
comments: false
sharing: true
footer: true
---

[Official documentation](https://github.com/Toura/mulberry/wiki/)

# Installation
Installation is mostly automatic. It's started by running `install/<your-platform>/install.sh`.

## Required base packages

### OSX
For OSX, the required packages are:  
-  Xcode in version 4.3 or later
-  Java

## Packages built and installed by script if not found:

### OSX
-  RVM
-  Ruby (in version 1.9.2 or 1.9.3 depending on script). Ruby@1.9.3 might *NOT* build on OSX 10.7.3.
-  Rubygems and following gems:
  -  Bundler
  -  Mulberry (obviously)
-  Homebrew
-  Ant (through Brew)
-  Android SDK
-  PhoneGap


# Basic commands

	mulberry scaffold
creates a new app scaffolding

	mulberry serve
builds app for web and starts http server on port 3001

	mulberry deploy
builds app for deployment and creates xcode workspaces

	mulberry test
builds app for deployment, creates xcode workspaces and opens them for testing. Apple-R to run in simulator/on device.

# Content creation commands

