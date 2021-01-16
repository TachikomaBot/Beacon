## Project Description
Beacon is an Android app that makes it easy to both record and alert preset contacts when that the user is in an encounter with Law Enforcement, with as little phone interaction as possible. Beacon is intended to be used with marginalized youth that have frequent encounters with a variety of different types of Law Enforcement, to ensure they have their own recording of the encounter should they need it later for legal or other purposes. The ability to alert contacts also ensures that the user can feel secure that should Law Enforcement officials detain or otherwise impede their free movement or ability to communicate, there are people on their side that will look out for them.

## Glossary
* **Third Party** - A person or company which some of our features run through
* **UI (User Interface)** - The design of the app and how it looks while in use
* **Law Enforcement** - Public sector agents that operate at the municipal, provincial or federal level of government in Canada to enforce the law.
* **Marginalized Youth** - A heterogenous group, individuals from 15 to 24 that have low income and face economic hardship, are  disproportionately likely to be of a racial or ethnic minority. Often raised without stable parents, and may be parents themselves. They are likely to have a history of mental illness or disability, in addition to substance abuse issues. Furthermore, they are more at risk of physical and/or sexual violence.

## Similar Products
**Mobile Justice**\
[Play Store](https://play.google.com/store/apps/details?id=org.aclu.mobile.justice.ca)
* 3.1 stars, 684 reviews
* 50,000+ installs
* Recent reviews are 1 star, frequent crashes
[Apple Store](http://itunes.apple.com/app/id1031663730)
* Reports to the ACLU
* Not for personal use to help yourself, record police interacts with others to send to third party (ACLU)
* User does not retain access to the recorded footage
* Function that lets the user see rights related to recording police
* Can fill out an “incident report” with specific things the police may have done to someone else
* Unique apps for each American state

Source of Inspiration
* Using the app as a third party to record other's interaction with LE or those with positions of power to share the recording with the person involved in the altercation

**Shortcuts**\
[Apple Store](https://www.icloud.com/shortcuts/2d68cb1ee7b84f08ace2fd600b9855b5)
* Shortcut call Police
* Can download a voice command, “Siri, I'm getting pulled over”, hands-free use
* Records interaction and texts predetermined contact
* Can text or email the recorded footage and share location to whomever or save to Dropbox, iCloud

Source of Inspiration
* The ability to use voice controls to activate the app which could be vitale to the user's safety when involved in a tense situation and they cannot stick their hands in their pockets
* Feature not requested, but would be an excellent stretch goal

**CopWatchAU**\
[Apple Store](https://apps.apple.com/au/app/copwatchau/id1306361719)
* Last updated in 2018
* 3 reviews, 5 stars
* Can add up to 3 contacts to message 
* Can record and upload to private cloud storage, over wifi or data
* Lists rights regarding recording police interactions in Australia

Source of Inspiration
* Client's source of inspiration, from 3 contacts to uploading recording to personal cloud
* UI used as a source of inspiration of what **not** to do

## Relevant Open Source Apps

None that perform the same combination of sending alerts to preset contacts AND recording video which is then uploaded to the cloud

[**OpenWatch**](https://github.com/OpenWatch/OpenWatch-Android)
* This Android application gives the user the ability to record and upload the video online (it is unclear where, to which server).
* The user can also recieve alerts from the central server regarding major events that would be important to document
* The github project was last updated 6 years ago
* There are no images of the app available
* The link to the app store is dead so the app cannot be tested
* The app requires API level 8 or below (as of this writing Android is at API 29)

From an examination of the Github project, this app is too old to provide useful guidance for our app. In addition we have a stretch goal of developing our app for iOS, which this project does not support.

## Required Technologies
**Front End** : Android OS, Android Studio, Flutter\
**Back End**: Google Cloud Services

## Possible useful Technology

**drive-android-quickstart**
https://github.com/googlearchive/drive-android-quickstart

This provides sample code for access the files (photos) in google team drive from Android app.

Function
Takes photos and stores them in Drive
Displays a file picker to the user to select where to save files
Shows you how to write file content
Shows you how to set file metadata including title and MIME type

**Get Current Location in Android**
https://javapapers.com/android/get-current-location-in-android/

This provides sample code for access the current location in android app, especially how to request current location from LocationManager, as well as compare the pro and con of using GPS and Network to get the location. 

GPS vs Network
Network Location provider is comparatively faster than the GPS provider in providing the location co-ordinates.
GPS provider may be very very slow in in-door locations and will drain the mobile battery.
Network location provider depends on the cell tower and will return our nearest tower location.
GPS location provider, will give our location accurately.

**Message API**
https://developers.google.com/android/reference/com/google/android/gms/nearby/messages/Messages

API which allows your app to publish simple message and subscribes to receive those messages from nearby devices.

**G-mail API**
https://developers.google.com/gmail/api/guides/sending

Two ways for sending email using Gmail API.
