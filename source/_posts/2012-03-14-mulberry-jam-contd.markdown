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

Giving the demo-app "kitchensink" (located in `demos`) a closer look cleared a couple of questions I still had, so here I go:

## Customization

### Page-defs
A page-def defines the template for generated pages, i.e. the layout, components and capabilities to be used on a page.  
Custom page-defs can be generated with the command below:
	mulberry create page_def <name>
which will create a file at `<app-root>/page_defs/<name>.yml`.  
More info [here](https://github.com/Toura/mulberry/wiki/Page-Definitions)

All pre-existing page-defs lie in `<mulberry-root>/base_apps/toura/page_defs` and have their purpose written in their name, making it easy to guess what they may be intended for.  
Here's a list of them, subject to changes as new versions arrise:  
	audio-with-images-phone.yml
	audio-with-images-tablet.yml
	debug.yml
	default.yml
	favorites.yml
	feed-item.yml
	feed-list-phone.yml
	feed-list-tablet.yml
	full-screen-images.yml
	google-map-phone.yml
	google-map-tablet.yml
	grid-view.yml
	home-phone.yml
	home-tablet.yml
	home-with-header-phone.yml
	home-with-header-tablet.yml
	hotspots.yml
	images-and-text-phone.yml
	images-and-text-tablet.yml
	location-list.yml
	node-gallery.yml
	search.yml
	videos-and-text-phone.yml
	videos-and-text-tablet.yml
If you are creating your own page-defs for more than one project, I makes sense to put them inside this folder (and to commit them back to contribute to the project).

A page-def defines which components will be visible for pages based on it. E.g.:  
	home-with-header-phone:
	  screens:
	  - name: index
		backgroundImage: true
		regions:
		- className: header-image
		  components:
		  - PageHeaderImage

		- scrollable: true
		  components:
		  - BodyText
		  - ChildNodes

		- className: nav
		  components:
		  - AppNav


### Components
	mulberry create component <name>
which will create a Dojo UI component at `<app-root>/app/components/<name>.js` and `<app-root>/app/components/<name>/<name>.haml`).  
See [here](https://github.com/Toura/mulberry/wiki/Creating-Custom-Components) for more info.

### Capability
**obsolete**
	mulberry create capability <name>
which will create a file at `<app-root>/javascript/capabilities/<name>.js`.  
[More info](https://github.com/Toura/mulberry/wiki/Capabilities)

### Datasource
	mulberry create datasource <name>
which will create a JSON file at `<app-root>/assets/data/<name>.json`. It can hold any data (as long as it's valid JSON) and it's up to the app to implement the functionality to read and use it.

### Feature flags
See [here](https://github.com/Toura/mulberry/wiki/Feature-Flags) for info on feature flags that determine whether a given feature is active or not.


## App customization

### App Icon, Splash Screen, and Project file
When generating the app, the default PhoneGap app icon and splash screen, as well as the default Toura (xcodeproj) projects are copied into our app's `<app-root>/build` folder,
where they could be further customized. (Although I'm not sure if re-generating the app overwrites the customized versions).

The source files are located at `<mulberry-root>/builder/project_templates/iOS/Toura` for the projects and further below in `<mulberry-root>/builder/project_templates/iOS/Toura/Resources/icons`
and `<mulberry-root>/builder/project_templates/iOS/Toura/Resources/splash` respectively for icons and splash screens.

It would be a nice extension to Mulberry if I could refer to my custom icons, loading screens, etc. in the config.yml and having those replace the default versions.

### Universal build
At the moment, the iPhone and iPad have 2 separate projects (`Toura.xcodeproj` and `Toura-iPad.xcodeproj`).
But I guess, having a third `Toura-universal.xcodeproj` for universal apps might be another welcome extension.

## Automatic build
Command line and Jenkins integration
[This link](http://nachbaur.com/blog/building-ios-apps-for-over-the-air-adhoc-distribution) looks helpful.


**tl;dr** I hope this short guide was useful to you.  
I've created a [help page](/help/mulberry-cheat-sheet.html) and although it's more a reminder for myself, you can use it as an easy overview.

Next up: Further Mulberry app customization -- adapting style and layout.
