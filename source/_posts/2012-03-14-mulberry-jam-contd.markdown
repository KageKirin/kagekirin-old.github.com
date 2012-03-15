---
layout: post
title: "Mulberry Jam (cont'd)"
date: 2012-03-14 01:00
comments: true
categories: 
---

Follow up on last week's post about Mulberry.

There have been a couple of changes with Xcode 4.3, iOS 5.1 and some updates in Mulberry that gave a hard time...
In the end, I had to re-scaffold my test-apps from scratch and move my content over because of a few noteworthy changes.  
Incidentally, those changes concern the parts I did not treat in detail in my last post (or just brushed over without investigating it into depth),
thus this follow-up makes a lot of sense.


## Customization

### Page-defs
A page-def defines the template for generated pages, i.e. the layout, components and capabilities to be used on a page.  
Custom page-defs can be generated with the command below:
	mulberry create page_def <name>
which will create a file at `<app-root>/page_defs/<name>.yml`.  
More info [here](https://github.com/Toura/mulberry/wiki/Page-Definitions)

### Components
	mulberry create component <name>
which will create a file at `<app-root>/javascript/components/<name>.js`.  
See [here](https://github.com/Toura/mulberry/wiki/Creating-Custom-Components) for more info.

### Capability
	mulberry create capability <name>
which will create a file at `<app-root>/javascript/capabilities/<name>.js`.  
[More info](https://github.com/Toura/mulberry/wiki/Capabilities)

### Datasource
	mulberry create datasource <name>
which will create a file at `<app-root>/javascript/data/<name>.js`.  

### Feature flags
See [here](https://github.com/Toura/mulberry/wiki/Feature-Flags) for info on feature flags that determine whether a given feature is active or not.

## App Icon
By default, we get the PhoneGap app icon. To change it, replace the following files:
(TODO: include list of files here)

## Flash screen
By default, we get the PhoneGap flash screen. To change it, replace the following files:

## Universal Apps
Atm, iPhone and iPad projects are created separately, but there should be way to create them, be it by editing the Xcode project (not a good idea as it gets regenerated), or by changing some little colde somewhere.
(TODO: find out where and post modified script).

## Automatic build
Command line and Jenkins integration
[This link](http://nachbaur.com/blog/building-ios-apps-for-over-the-air-adhoc-distribution) looks helpful.


**tl;dr** I hope this short guide was useful to you.  
I've created a [help page](/help/mulberry-cheat-sheet.html) and although it's more a reminder for myself, you can use it as an easy overview.


