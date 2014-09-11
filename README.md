## Duke Medicine Mobile Companion

This app is a proof of concept companion app for [Epic Systems](http://www.epic.com/)' [Haiku](https://itunes.apple.com/us/app/epic-haiku/id348308661?mt=8) and [Canto](https://itunes.apple.com/us/app/epic-canto/id395395172?mt=8) mobile applications for iOS devices, initially developed by [Ricky Bloomfield](http://www.rickybloomfield.com) at [Duke Medicine](http://www.dukemedicine.org).   The app is designed to demonstrate a few relatively straightforward ways to extend and enhance functionality of the Epic mobile apps to give interested medical centers a means to further customize functionality for their organizations.

Please note that this app does not directly integrate with Epic or make use of any Epic technologies.  At the most basic level, it simply accepts custom URLs from Haiku or Canto that allow the app to display additional information, and then allows the user to quickly return to the Haiku or Canto.  Under no circumstances should the app be used to receive or display any protected health information (PHI).

The app is released under the [MIT License](http://opensource.org/licenses/MIT).  We invite you to experiment with the code and use it as a springboard to create something new and exciting for your organization!  If you do, please consider sharing those changes with the community so we can all benefit.

## Installation

The app was written using the latest iOS technologies, including the [Swift](https://developer.apple.com/swift/) programming language.  Therefore, it requires at least Xcode 6 to compile and run, although it will run on any iOS device running iOS 7 or later.

If you're not familiar with app development for iOS devices, getting started will require a couple steps but is relatively easy.  To install the app, first install Xcode (version 6 or higher) from the App Store to the Mac of your choice, and then [download the archive](https://github.com/dukemedicine/Duke-Medicine-Mobile-Companion/archive/master.zip) from GitHub.  Double-click the `Duke Medicine Mobile Companion.xcodeproj` file to open the app in Xcode.  You can build and run in the included simulator, or connect an iOS device and install on that device.  For more information, please see the [iOS Developer Center](https://developer.apple.com/devcenter/ios/index.action).

## Features

The app works by accepting URLs prefixed with `dukemedmc://`.  Additional information should be passed along to the app after this URL scheme.  This proof of concept includes customizations to Haiku and Canto that add these links to strategic locations to augment functionality (see details below).  For more information regarding those Haiku and Canto customizations, please refer to the UGM presentation PAC13 from Sept. 15, 2014 entitled, "Hacking Haiku: When You Just Can't Leave Well Enough Alone."

There are currently three distinct URL schemes supported by the app:

- BiliTool links: `dukemedmc://bilitool/`
- Maps links: `dukemedmc://maps/`
- UpToDate links: `dukemedmc://uptodate/`

Note that the first component of the URL path (`bilitool`, `maps` or `uptodate`) defines the type of data that is being sent.  Additional data should be sent as subsequent path components, which will be described in more detail below.

Once these links are opened in the app, the content is displayed and a button is provided to take the user directly back to their previous location in Haiku or Canto.

#### BiliTool links

BiliTool links demonstrate the ability to make use of specific data points  in original ways, such as with a risk calculator.

[BiliTool](http://emr.bilitool.net/) is a risk-based calculator used to determine the need for bilirubin lights or exchange transfusions in a newborn with jaundice.  It has a simple web-based API that accepts three pieces of data: infant age in hours, bilirubin value and bilirubin units ('us' or 'si').  A custom Epic print group was created and applied to the laboratory section of Haiku and Canto that pulls the infant birth date and time, bilirubin value, bilirubin test date and time and uses those values to calculate the infants age in hours in order to generate a URL in the following format:

`dukemedmc://bilitool/emr.bilitool.net/auto?hours=96&bilirubin=5.1&units=us&Submit=Submit`

The app accepts this URL and uses everything after `dukemedmc://bilitool/` to open the BiliTool API to the appropriate page.

#### Maps links

Maps links demonstrate the ability to use the app to direct users to another third-party application, passing data to the application at the same time.

A custom routine was written to override the standard maps links in Haiku and Canto provide the links in the following format:

`dukemedmc://maps/maps?q=+Duke+University+Hospital`

The app accepts this URL and uses everything after `dukemedmc://maps/` to open the maps location within the app (by default) or the maps app of your choice.  If you prefer to use Apple Maps or Google Maps, simply change this setting in the 'Settings' tab of the app.

#### UpToDate links

UpToDate links demonstrate the ability to add reference links to Haiku and Canto with a easy way to return to Haiku and Canto afterwards.

A custom routine was written that uses the title of a problem or medication to generate a link that initiates an [UpToDate](http://www.uptodate.com/home) search.  The links are in the following format:

`dukemedmc://uptodate/www.uptodate.com/contents/search?search=congestive%20heart%20failure`

The app accepts this URL and uses everything after `dukemedmc://uptodate/` to open the UpToDate to the appropriate page.

## Future

This app represents just a simple example of ways Haiku and Canto could be extended.  Much more could be done and your ideas are always welcome!  In addition to simply using URLs to display data in novel ways, other useful features could be added, such as user-specific push notifications or general announcement notifications via an open-source library such as [iNotify](https://github.com/nicklockwood/iNotify).

Copyright © 2014 Duke Medicine
