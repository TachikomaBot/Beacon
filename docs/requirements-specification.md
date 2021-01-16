## Requirements Specification

## User Stories

**US-1** As a user, I want to record my interactions with law enforcement\
**US-2** As a user, I want to alert some contacts that I'm in an altercation with Law Enforcement\
**US-3** As a user, I want a backup of my recordings to be stored off my phone in case it is destroyed, lost or stolen\
**US-4** As a user, I want to choose who I contact when I need to alert someone of an altercation with Law Enforcement\
**US-5** As a user, I want to control how recordings are made, as audio or video, to conserve battery\
**US-6** As a user, I want to know what resources are around me to help with my day to day life\
**US-7** As a user, I want to know what my rights are when interacting with Law Enforcement

## Use Cases

**Name**: Register Contact\
**Identifier**: UC-1\
**Description**: The user can enter the contact information for a new contact\
**Preconditions**: There is an available contact slot not filled\
**Postconditions**: A new contact is registered by the app\
**Course of Action**: \
The user presses the add contact button\
The user enters the contact's name\
The user enters the contact's mobile phone number\
The user enters the contact's primary email address\
The user completes the process by pressing enter\
**Alternative Course**: The user cancels the registration by pressing cancel

**Name**: Upload Registered Contact Details to Users Cloud Drive \
**Identifier**: UC-2\
**Description**: When the user adds a new contact to the app, the contact information should be saved to the cloud \
**Preconditions**: The phone is connected to the internet and a new contact has just been registered \
**Postconditions**: The contact details for the newly registered user is uploaded to their Cloud Drive \
**Course of Action**: \
A new contact is registered to the app \
The app uploads the contact details to the cloud \
**Alternative Course**: If the phone does not have internet connectivity, \
The app stores the action to upload the contact details into a queue of actions to perform once internet connectivity is restored \
When internet connectivity is reestablished the action to upload the contact details is de-queued and performed

**Name**: Edit Contact\
**Identifier**: UC-3\
**Description**: The user can edit existing contact information of a contact \
**Preconditions**: The contact information for the selected contact is edited \
**Postconditions**: The contact information for the selected contact is edited \
**Course of Action**: \
The user presses the edit contact button \
The user may edit the contact's name \
The user may edit the contact's mobile phone number \
The user may edit the contact's primary email address \
The user completes the process by pressing enter \
**Alternative Course**: The user cancels the edit by pressing cancel

**Name**: Upload Edited Contact Details to the Users Cloud Drive \
**Identifier**: UC-4\
**Description**: When the user edits contact in the app, the edited contact information should be saved to the cloud \
**Preconditions**: The phone is connected to the internet and a contact has just been edited \
**Postconditions**: The contact details for the edited user is uploaded to their Cloud Drive \
**Course of Action**: \
A contact has been edited in the app \
The app uploads the newly edited details to the cloud, overwriting the existing details relating to that contact \
**Alternative Course**: If the phone does not have internet connectivity, \
The app stores the action to upload the contact details into a queue of actions to perform once internet connectivity is restored\
When internet connectivity is reestablished the action to upload the contact details is de-queued and performed

**Name**: Delete Contact\
**Identifier**: UC-5\
**Description**: The user can remove a contact from their list of contacts\
**Preconditions**: There is an existing contact to delete\
**Postconditions**: The contact information for the selected contact is removed\
**Course of Action**: \
The user selects an existing contact\
The user presses the delete contact button\
**Alternative Course**: The user cancels the deletion by pressing cancel

**Name**: Remove Contact Details from the Users Cloud Drive \
**Identifier**: UC-6 \
**Description**: When the user removes a contact from the app, the contact details should be removed from the cloud \
**Preconditions**: The phone is connected to the internet and a contact has just been removed \
**Postconditions**: The contact details for the removed user is removed from their Google Drive cloud \
**Course of Action**: \
A contact has been removed from the app \
The app access the users Cloud Drive and deletes the contact details from the cloud for the user that was removed from the app locally \
**Alternative Course**: If the phone does not have internet connectivity, \
The app stores the action to remove the contact details into a queue of actions to perform once internet connectivity is restored 
When internet connectivity is reestablished the action to remove the contact details is de-queued and performed

**Name**: User Action to Alert Contacts \
**Identifier**: UC-7 \
**Description**: The user can press and swipe left on the Primary Action Button on the main screen \
**Preconditions**: The phone is unlocked, and the app is open and active at the main screen \
**Postconditions**: The transmission manager begins the process of alerting contacts \
**Course of Action**: \
The user presses down and swipes left on the primary button \
The transmission manager is notified that it must begin the process of sending alerts to contacts \
The phone vibrates for a short period that the action has been registered\
**Alternative Course**: If the transmission manager cannot be started, \
The system attempts to start the transmission manager some number of times, \
If after some number of times the transmission manager cannot be started then, \
The phone vibrates to notify the user there is an issue, \
An error fragment is displayed on the screen that the alerts were not sent

**Name**: Short Vibration on Successful Task Completion \
**Identifier**: UC-8 \
**Description**: The phone should vibrate for a small time period to notify the user that it has successfully performed a task relating to the Primary Action Button \
**Preconditions**: The app has successfully performed an action as requested by the user through the Primary Action Button \
**Postconditions**: The phone has vibrated for a short period \
**Course of Action**: \
After a task involving the Primary Action button is completed successfully, the app should perform a short vibration through the Vibrate API\
**Alternative Course**: None

**Name**: Notification on Successful Task Completion \
**Identifier**: UC-9 \
**Description**: The app should send a notification to the user that the action requested through the Primary Action Button has been performed \
**Preconditions**: The app has successfully performed an action as requested by the user through the Primary Action Button \
**Postconditions**: The notification is pushed to the user through the Notification API \
**Course of Action**: \
After a task involving the Primary Action button is completed successfully, the app should push a notification to the user through the Notification API\
**Alternative Course**: None

**Name**: Two Vibrations in Quick Succession on Failed Task Completion \
**Identifier**: UC-10 \
**Description**: The phone should vibrate twice for a small time period in quick succession to notify the user that it has failed to performed a task relating to the Primary Action Button \
**Preconditions**: The app has failed to performed an action as requested by the user through the Primary Action Button \
**Postconditions**: The phone vibrated twice for a short period, in quick succession \
**Course of Action**: \
After a task involving the Primary Action button is completed successfully, through the Vibrate API, the app should request two short vibrations one second apart\
**Alternative Course**: None

**Name**: Notification on Failed Task Completion \
**Identifier**: UC-11 \
**Description**: The app should send a notification to the user that the action requested through the Primary Action Button has not been performed \
**Preconditions**: The app has failed to perform an action as requested by the user through the Primary Action Button \
**Postconditions**: The notification is pushed to the user through the Notification API \
**Course of Action**: \
After a task involving the Primary Action button is completed unsuccessfully, the app should push a notification to the user through the Notification API \
This Notification should offer the user the option to try the action again, from the Notification object \
**Alternative Course**: None

**Name**: Create Objects That Contain the Contact Details and the Alert Message \
**Identifier**: UC-12 \
**Description**: A management system constructs objects for each contact, containing SMS / Email contact information and the message to be sent \
**Preconditions**: The user has pressed and swiped left on the Primary Action button on the main screen or pressed and held the Primary Action Button for 3 seconds \
**Postconditions**: The Send Alert Manager contains a queue of transmission objects \
**Course of Action**: \
The user presses down and swipes left on the primary button \
The transmission manager is notified that it must begin the process of sending alerts to contacts \
**Alternative Course**: None

**Name**: Process Message/Contact Objects Waiting in Queue \
**Identifier**: UC-13 \
**Description**: The Send Alert Manager must process objects to be sent \
**Preconditions**: There are transmission objects that have not yet been processed \
**Postconditions**: There are no transmission objects to process \
**Course of Action**: \
If there is a either a suitable cell or wireless network the phone is connected to, then the app processes the transmission objects in the queue \
A transmission object is fully processed if both SMS and email are sent, otherwise it is inserted at the end of the queue for reprocessing \
If a transmission objet is fully processed it is removed from the queue \
**Alternative Course**: If the app can send either SMS or email but not the other due to connectivity, \
The message type that can be sent is sent, and the object is sent to the back of the queue, with the sent component marked as sent, \
When the other connection method is available, the other message type is sent and the object is removed from the queue

**Name**: Detect and Access Camera on Android \
**Identifier**: UC-14A \
**Description**: The app must detect then access the camera \
**Preconditions**: The OS version implements below API 21\
**Postconditions**: The app has access to the Camera \
**Course of Action**: \
The user presses down and swipes right on Primary Action Button, or long presses the Primary Action Button for 3 seconds \
The Camera API determines whether there is an available camera \
The Camera API provides access to the camera if it exists \
**Alternative Course**: If either camera does not function/exist or access can not be granted, \
A notification dialog will notify the user that recording unavailable

**Name**: Detect and Access Camera on Android \
**Identifier**: UC-14B \
**Description**: The app must detect then access the camera \
**Preconditions**: The OS version implements at or above API 21 \
**Postconditions**: The app has access to the Camera \
**Course of Action**: \
The user presses down and swipes right on Primary Action Button, or long presses the Primary Action Button for 3 seconds \
Through the Camera2 API CameraManager, the app has access to open and available cameras \
**Alternative Course**: If either camera does not function/exist or access can not be granted, \
A notification dialog will notify the user that recording unavailable 

**Name**: Start Camera Session on iOS \
**Identifier**: UC-15 \
**Description**: The SDK supports iOS 2.2+ \
**Preconditions**: The camera exists and can be accessed \
**Postconditions**: The app has access to the Camera \
**Course of Action**: \
The user presses down and swipes right on Primary Action Button, or long presses the Primary Action Button for 3 seconds \
Through the AVFoundation Capture API, the app has access to the camera on the device \
**Alternative Course**: If either camera does not function/exist or access can not be granted, \
A notification dialog will notify the user that recording unavailable 

**Name**: Preview Recording for User to Watch on Android \
**Identifier**: UC-16A \
**Description**: A preview of what the camera sees must be made available to the user to watch \
**Preconditions**: The OS version implements below API 21 and a camera is accessed by the app \
**Postconditions**: A preview of the camera view is presented on the screen \
**Course of Action**: \
The user presses down and swipes right on Primary Action Button, or long presses the Primary Action Button for 3 seconds \
A camera preview class extends SurfaceView and implements SurfaceHolder previews the live images \
**Alternative Course**: If a preview cannot be provided, \
A notification dialog will notify the user that the device is recording but preview is unavailable \
The notification provides the capability to stop the recording

**Name**: Preview Recording for User to Watch on Android \
**Identifier**: UC-16B \
**Description**: A preview of what the camera sees must be made available to the user to watch \
**Preconditions**: The OS version implements API 21 or above and a camera is accessed by the app \
**Postconditions**: A preview of the camera view is presented on the screen \
**Course of Action**: \
The user presses down and swipes right on Primary Action Button, or long presses the Primary Action Button for 3 seconds \
A Camera Capture Session is initiated and the output surface is set to the screen to preview \
**Alternative Course**: If a preview cannot be provided, \
A notification dialog will notify the user that the device is recording but preview is unavailable \
The notification provides the capability to stop the recording

**Name**: Preview Recording for User to Watch on iOS \
**Identifier**: UC-17 \
**Description**: A preview of what the camera sees must be made available to the user to watch \
**Preconditions**: The SDK supports iOS 2.2+ \
**Postconditions**: A preview of the camera view is presented on the screen \
**Course of Action**: \
The user presses down and swipes right on Primary Action Button, or long presses the Primary Action Button for 3 seconds \
An AVCaptureSession is initiated and the output surface is set to the screen to preview \
**Alternative Course**: If a preview cannot be provided, \
A notification dialog will notify the user that the device is recording but preview is unavailable \
The notification provides the capability to stop the recording

**Name**: Overlay Interaction Over Previewed Recording for User to Stop or Zoom on Android \
**Identifier**: UC-18 \
**Description**: A preview of what the camera sees must be made available to the user to interact with to zoom or stop \
**Preconditions**: The OS version implements above or below API 21 \
**Postconditions**: The user can interact with the preview of the camera view through the touchscreen \
**Course of Action**: \
The user presses down and swipes right on Primary Action Button, or long presses the Primary Action Button for 3 seconds \
A UI with attached Listeners is overlayed ontop of the SurfaceView from the Camera with a stop button \
The user can also use the pinch ability to control the Camera to zoom in and out \
**Alternative Course**: If an interaction interface cannot be provided, \
A notification dialog will notify the user that the device is recording \
The notification provides the capability to stop the recording

**Name**: Overlay Interaction Over Previewed Recording for User to Stop or Zoom on iOS \
**Identifier**: UC-19 \
**Description**: A preview of what the camera sees must be made available to the user to interact with to zoom or stop \
**Preconditions**: The SDK supports iOS 2.2+ \
**Postconditions**: The user can interact with the preview of the camera view through the touchscreen \
**Course of Action**: \
The user presses down and swipes right on Primary Action Button, or long presses the Primary Action Button for 3 seconds \
The AVCaptureInput API is used to retrieve user input when the user presses the stop button, or pinches to zoom \
**Alternative Course**: If an interaction interface cannot be provided, \
A notification dialog will notify the user that the device is recording \
The notification provides the capability to stop the recording

**Name**: Save Video to Android Device \
**Identifier**: UC-20 \
**Description**: A video that the user recorded with the Camera needs to be saved to the device \
**Preconditions**: The OS version implements above or below API 21 and the Camera has finished recording \
**Postconditions**: A video file is saved to the device that corresponds to the interval of time between when the recording started and stopped \
**Course of Action**: \
The user presses the stop button on the previewed screen \
The Recording is saved to the device through the MediaRecorder API \
The previewed screen of the camera ends and the screen returns to the main menu \
**Alternative Course**: If there is an error in the process of saving the video file to temporary storage \
An error dialog is presented to the user informing them the video could not be saved

**Name**: Save AudioVideo file to iOS Device \
**Identifier**: UC-21 \
**Description**: A video that the user recorded with the Camera needs to be saved to the device \
**Preconditions**:The SDK supports iOS 2.2+ and the Camera has finished recording \
**Postconditions**: An audiovideo file is saved to the device that corresponds to the interval of time between when the recording started and stopped \
**Course of Action**: \
The user presses the stop button on the preview screen \
The Recording is saved to the device through the AVCaptureFileOutput API \
The previewed screen of the camera ends and the screen returns to the main menu \
**Alternative Course**: If there is an error in the process of saving the video file to temporary storage \
An error dialog is presented to the user informing them the video could not be saved

**Name**: Record Audio on Android \
**Identifier**: UC-22 \
**Description**: Audio must be recorded when the user activates the record function \
**Preconditions**: The microphone must be functional and accessible \
**Postconditions**: The microphone is activated and recording audio to temporary memory \
**Course of Action**: \
The user presses down and swipes right on Primary Action Button, or long presses the Primary Action Button for 3 seconds \
Through the MediaRecorder API the app accesses the Microphone \
The app sets the audio format for the audio recording to be saved as \
The app sets the filename for the audio recording \
The app sets the autoencoder \
The app sets the autoencoder \
The app completes initialization with the prepare method \
**Alternative Course**: If the microphone is not functional or accessible \
An error dialog is presented to the user informing them the audio cannot be recorded

**Name**: Record Audio on iOS \
**Identifier**: UC-23 \
**Description**: Audio must be recorded when the user activates the record function \
**Preconditions**: The microphone must be functional and accessible and the SDK supports iOS 2.2+\
**Postconditions**: The microphone is activated and records audio to temporary memory \
**Course of Action**: \
The user presses down and swipes right on Primary Action Button, or long presses the Primary Action Button for 3 seconds \
Through the AVCaptureAudioFileOutput the app records audio to temporary memory\
**Alternative Course**: If the microphone is not functional or accessible \
An error dialog is presented to the user informing them the audio cannot be recorded

**Name**: Save Audio File to Android Device \
**Identifier**: UC-24 \
**Description**: Recorded audio must be saved to temporary storage \
**Preconditions**: The microphone has finished recording \
**Postconditions**: A audio file is saved to the device that corresponds to the interval of time between when the recording started and stopped  \
**Course of Action**: \
The user presses the stop button on the previewed screen, and the MediaRecorder stop method is called \
The Recording is saved to the device through the MediaRecorder API \
The microphone is released and stops recording \
**Alternative Course**: If there is an error in the process of saving the audio file to temporary storage \
An error dialog is presented to the user informing them the video could not be saved

**Name**: Save Audio File to iOS Device \
**Identifier**: UC-25 \
**Description**: Recorded audio must be saved to temporary storage \
**Preconditions**: The microphone has finished recording \
**Postconditions**: A audio file is saved to the device that corresponds to the interval of time between when the recording started and stopped  \
**Course of Action**: \
The user presses the stop button on the previewed screen, and the MediaRecorder stop method is called \
The Recording is saved to the device through the MediaRecorder API \
The microphone is released and stops recording \
**Alternative Course**: If there is an error in the process of saving the audio file to temporary storage \
An error dialog is presented to the user informing them the video could not be saved

**Name**: Toggle Recording From Camera Does Not Detect Light \
**Identifier**: UC-26 \
**Description**: The Camera should shut off for 10 seconds intervals if no light is detected \
**Preconditions**: The app has access to a functional camera \
**Postconditions**: The Camera is shut off for 10 seconds and no video is saved for that period \
**Course of Action**: \
When no light is detected from the camera for a period of 2 seconds, the camera turns off and enters stasis mode \
After 10 seconds, the camera turns on \
If no light is detected after the camera has been on for 2 seconds, it turns off once again, and returns to stasis mode \
If light is detected, the camera stays on and video is recorded until a prolongued period (5 seconds) of no light after which it turns off and enters stasis mode \
**Alternative Course**: None

**Name**: Toggle Recording From Camera If Phone Does Not Detect Movement \
**Identifier**: UC-27 \
**Description**: The Camera should shut off for 10 seconds intervals if no movement is detected \
**Preconditions**: The app has access to a functional gyroscope \
**Postconditions**: The Camera is shut off for 10 seconds and no video is saved for that period \
**Course of Action**: \
When no movement is detected from the gyroscope for a period of 2 seconds, the camera turns off and enters stasis mode \
Every second, the gyroscope is polled to check for movement \
If no movement is detected the camera stays off
If movement is detected, the camera turns on and video is recorded until a prolongued period (5 seconds) of no movement after which the camera turns off \
**Alternative Course**: If there is no functional or accessible gyroscope, \
The phone screen is set always on

**Name**: Toggle Screen Display If No Light is Detected from Camera \
**Identifier**: UC-28 \
**Description**: The phone screen should be turned off when there is no light detected from the camera, and on when there is light \
**Preconditions**: The app has access to a functional camera \
**Postconditions**: The screen is off when there is no light detected, or on if there is light \
**Course of Action**: \
When no light is detected from the camera for a period of 2 seconds, the phone screen turns off \
After 10 seconds, the camera turns on \
If no light is detected after the camera has been on for 2 seconds, the phone screens stays dark \
If light is detected, the screen stays on until a prolongued period (5 seconds) of no light after which it turns off \
**Alternative Course**: If there is no functional or accessible camera, \
The phone screen is set always on

**Name**: Toggle Screen Display If Phone is Face Down \
**Identifier**: UC-29 \
**Description**: The phone screen should be turned off when the screen is face down on a flat surface \
**Preconditions**: The app has access to a functional gyroscope \
**Postconditions**: The screen is off when the phone is still and facing down, and on otherwise \
**Course of Action**: \
If the app determines the phone is still and face down through the gyroscope, then it turns the screen off \
Otherwise the screen is on
**Alternative Course**: If there is no functional or accessible gyroscope, \
The phone screen is set always on

**Name**: Save Metadata to Device \
**Identifier**: UC-30 \
**Description**: The metadata related to audio and video recordings must be saved to temporary storage \
**Preconditions**: The camera and microphone have been released \
**Postconditions**: Metadata of the audio and video file is saved to the device that corresponds to the interval of time between when the recording started and stopped \
**Course of Action**: \
The user presses the stop button on the previewed screen, the microphone and camera are released \
The audio and video files are saved to temporary memory \
Relevant metadata is extracted from the temporary files and saved in temporary memory along with the media files \
**Alternative Course**: If there is an error in the process of saving the audio file to temporary storage \
An error dialog is presented to the user informing them the metadata could not be saved

**Name**: Mix Audio and Video Temporary Files Together on Android \
**Identifier**: UC-31 \
**Description**: Audio and Video files should be mixed together \
**Preconditions**: The camera and microphone have been released, and accessible audio/video files are saved to temporary memory \
**Postconditions**: A muxed audiovideo file is saved to temporary memory \
**Course of Action**: \
The user presses the stop button on the previewed screen, the microphone and camera are released \
The audio, video and metadata files are saved to temporary memory \
The MediaMuxer API is used to combine the two separate media files into one \
The separate media files are deleted upon successful creation of the combined audiovisual recording \
**Alternative Course**: If the MediaMuxer fails to mix the two files, \
It retries multiple times and if none are successful, \
The two separate media files are uploaded to the cloud individually

**Name**: Segment Recordings To Limit File Size on Android \
**Identifier**: UC-32 \
**Description**: Audio and video recordings should be automatically limited by filesize or recording length \
**Preconditions**: The camera or microphone is recording and the filesize or recording length limit has been reached \
**Postconditions**: A segment of the full recording is created and added to a queue to upload \
**Course of Action**: \
When the recording filesize or length limit has been reached, the recording of audio and/or video ends \
The separate audio and video files are saved to temporary memory \
A new audio and video recording is started \
Metadata is extracted/collected and saved for the completed recording \
The seperate audio/video tracks are muxed to form a single media file \
The separate audio/video tracks are deleted from temporary memory \
The metadata file and the combined audiovisual file are added to a queue to upload \
**Alternative Course**: If the MediaMuxer fails to mix the two files, \
It retries multiple times and if none are successful, \
The two separate media files are uploaded to the cloud individually with the metadata file \
**Alternative Course**: If the separate media files cannot be saved to temporary memory or cannot be read to mix together, \
An error fragment notifies the user that part of the recording has been lost \
**Alternative Course**: If the separate files or the mixed file cannot be saved to memory due to storage limits, \
An error fragment notifies the user that the recording cannot continue due to memory limitations

**Name**: Segment Recordings To Limit File Size on iOS \
**Identifier**: UC-33 \
**Description**: Audio and video recordings should be automatically limited by filesize or recording length \
**Preconditions**: The camera or microphone is recording and the filesize or recording length limit has been reached \
**Postconditions**: A segment of the full recording is created and added to a queue to upload \
**Course of Action**: \
When the recording filesize or length limit has been reached, the audiovideo recording ends \
The AV file is saved to temporary memory \
A new AV recording is started \
Metadata is extracted/collected and saved for the completed recording \
The metadata file and the audiovisual file are added to a queue to upload \
**Alternative Course**: If the AV filecannot be saved to memory due to storage limits, \
An error fragment notifies the user that the recording cannot continue due to memory limitations

**Name**: Resumable Upload to Google Drive Linked to Google Account \
**Identifier**: UC-34 \
**Description**: Mixed audiovisual media and metadata must be uploaded to the linked Google Account cloud storage \
**Preconditions**: There is an audiovisual file yet to be uploaded \
**Postconditions**: A copy of the file is uploaded to the linked Google Account cloud storage \
**Course of Action**: \
The user presses the stop recording button \
OR the app automatically ends a recording to upload \
The mixed audiovisual file is constructed and added to a queue of files to be uploaded \
A URI request is sent to the Drive to start a resumable upload \
A POST is used to upload a new file \
The app saves the URI for the resumable session \
When the upload is complete, the media file is removed from the upload queue\
**Alternative Course**: If the app is interrupted in uploading a file, \
The upload stops, and resumes with a PUT requeust when connectivity is restored \
**Alternative Course**: If the Google Drive storage limit has been met or exceeded, \
An error fragment notifies the user that their Google Drive Storage is full \

**Name**: Resumable Upload to iCloud Drive Linked to Apple Account \
**Identifier**: UC-35 \
**Description**: AV media and metadata must be uploaded to the users iCloud Drive \
**Preconditions**: There is an audiovisual file yet to be uploaded and the iOS is 8.0+ \
**Postconditions**: A copy of the file is uploaded to the users iCloud Drive \
**Course of Action**: \
The user presses the stop recording button \
OR the app automatically ends a recording to upload \
The audiovisual file is constructed and added to a queue of files to be uploaded \
The app access the user's iCloud Drive through the CloudKit API to upload the AV file 
When the upload is complete, the media file is removed from the upload queue
**Alternative Course**: If the app is interrupted in uploading a file, \
The upload stops, and resumes with a when connectivity is restored \
**Alternative Course**: If the iCloud Drive storage limit has been met or exceeded, \
An error fragment notifies the user that their iCloud Drive Storage is full \

**Name**: Initial App Access Through Google/Apple Sign In \
**Identifier**: UC-36 \
**Description**: The app should identify the user through their Google/Apple Account \
**Preconditions**: The user has a Google account and the device has a data connection \
**Postconditions**: The user can access the app through their Google/Apple Account \
**Course of Action**: \
When the user first installs and opens the app for the first time, they are prompted to sign into a Google/Apple Account \
After the user has completed the sign-in flow, the app saves their account details for later \
**Alternative Course**: If the user incorrectly enters their Google/Apple sign-in details, \
The process returns to the first step to sign into their Google/Apple Account

**Name**: De-Link App from Google/Apple Account \
**Identifier**: UC-37 \
**Description**: The user should be able to de-link the app from their Google Account which removes app preferences and settings from their Google/Apple Account \
**Preconditions**: The user has a Google/Apple account and the app is linked with that account \
**Postconditions**: The app is de-linked from the users Google/Apple account, removing all app preferences and settings \
**Course of Action**: \
The user clicks on the settings button in the top right of the main page \
The user clicks on the Account Management Button \
The user clicks on the Delink App from Google/Apple Account Button \
The user's sign in information is wiped from the app, the app preferences and settings are wiped from Google's/Apple's servers and the user is returned to the Sign-In Screen of the app\
**Alternative Course**: None

**Name**: User Authentication to Access Sensitive Settings and Data\
**Identifier**: UC-38 \
**Description**: The user must log into their Google/Apple Account to access sensitive settings or data in the app \
**Preconditions**: The user has a Google/Apple account and the device has a data connection \
**Postconditions**: The user can access sensitive settings and data in the app if they are able to log into their Google/Apple Account \
**Course of Action**: \
When the user clicks on buttons that lead to sensitive settings or portals to data, they are presented with the Google/Apple Sign In dialog \
If the user successfully logs into their Google/Apple account, they can proceed to access sensitive settings and data \
**Alternative Course**: If the user incorrectly enters their Google/Apple sign-in token, \
The process returns to the first step to sign into their Google/Apple Account \

**Name**: Hide App Details in the App Switcher View\
**Identifier**: UC-39 \
**Description**: The app must not show any details when in the app switcher \
**Preconditions**: The phone is in the app switcher view \
**Postconditions**: A blank app window is presented to the user in the app switcher view \
**Course of Action**: \
When the user presses the app switcher button in the bottom right navigation bar, the app if open turns to a blank frame \
Even if the app is not the current open app, when is it viewable on the task switcher it should show a blank frame \
If the user selects the app from the task switcher, the app details are viewable again as it is the primary open app \
**Alternative Course 1**: None 

**Name**: Save User Preferences and Settings to Google/Apple Cloud Drive \
**Identifier**: UC-40 \
**Description**: The application should save user app preferences to the cloud \
**Preconditions**: The user has a Google/Apple account and it is connected to the app (through Sign-In) \
**Postconditions**: User preferences and settings that are changed locally are saved to the Google/Apple cloud\
**Course of Action**: \
When the user changes app settings and preferences from the default, these users values should be saved to the Google/Apple Cloud \
**Alternative Course**: If the user is not connected to the internet, \
The change to app preferences and settings is applied locally \
When the phone reconnects to the internet, the changed preferences and settings are uploaded to the cloud

**Name**: Load User Preferences and Settings from Google/Apple Cloud \
**Identifier**: UC-41 \
**Description**: The application should load user app preferences from the cloud \
**Preconditions**: The user has a Google/Apple account and it is connected to the app (through Sign-In) \
**Postconditions**: User preferences and settings that are stored in the cloud overwrite default values in the local app \
**Course of Action**: \
The app should check if there any settings or preferences stored in the cloud \
If there are, these cloud values should overwrite the default local values \
**Alternative Course**: If the user is not connected to the internet, \
The Load User Pref system should perodically check for internet connectivity \
When connectivity is restored, cloud preferences should be loaded from the cloud and overwrite default values in the app

**Name**: Access Recorded Media Files Stored in Google/Apple Drive \
**Identifier**: UC-42 \
**Description**: The application should allow the user the ability to view recorded files in their Cloud Drive through the app \
**Preconditions**: The phone is connected to the internet and the user is able to authenticate themselves to access their cloud storage \
**Postconditions**: The user is presented with their recordings that have been uploaded to their Google/Apple Drive cloud \
**Course of Action**: \
The user selects the cloud storage option from the settings menu \
The app re-authenticates the user through the Google/Apple Sign-In flow \
Assuming the user can authenticate themselves, the filename and some details such as timestamps of recorded media on the Google/Apple Drive are presented to the user in a list \
**Alternative Course**: If the user cannot authenticate themselves, \
They are returned to the main settings menu
**Alternative Course**: If the app cannot retrieve the list of recordings from the Google Drive, \
And error fragment notifies the user of the error and returns the user to the previous settings menu

**Name**: Play Recorded Media Files Stored in Google/Apple Drive \
**Identifier**: UC-43 \
**Description**: The application should allow the user the ability to playback any media file they have recorded and are stored in their Google/Apple Drive \
**Preconditions**: The phone is connected to the internet, the user is able to authenticate themselves to access their cloud storage and there is at least one media file \
**Postconditions**: The selected media file is streamed from their cloud to the device and played through the MediaPlayer API / AVPlayer API \
**Course of Action**: \
The user selects a media file from a list of available options \
The MediaPlayer begins streaming the selected file to the phone and plays it on the screen and speakers \
**Alternative Course**: If there is an error in streaming data to the device, \
An error fragment notifies the user of the error and returns the user to the list of recordings in their Google Drive

**Name**: Delete Recorded Media Files Stored in Google/Apple Cloud Drive \
**Identifier**: UC-44 \
**Description**: The application should allow the user the ability to delete selected media files they have recorded and are stored in their Google/Apple Drive \
**Preconditions**: The phone is connected to the internet, the user is able to authenticate themselves to access their cloud storage and there is at least one media file \
**Postconditions**: The selected media file is deleted from their Google/Apple Drive \
**Course of Action**: \
The user selects one or more media files from a list of available options \
A Post is sent through the Drive REST API to the Google/Apple Drive to delete the selected files\
**Alternative Course**: If there is an issue in deleting the files from the cloud,
An error fragment notifies the user of the error and returns the user to the list of recordings in their Google Drive

**Name**: Stop Camera Recording Below Battery Threshold \
**Identifier**: UC-45 \
**Description**: The application stop recording from the camera if the phone battery is below some threshold \
**Preconditions**: The app has control over the camera and is recording through it \
**Postconditions**: The app stops recording from the camera and releases its control over it \
**Course of Action**: \
The app checks if the battery is below a threshold value \
If it is, the app releases its control over the camera and stop recording video \
The app notifies the user that video has stopped being recorded \
**Alternative Course**: None

**Name**: Community Resources\
**Identifier**: UC-46 \
**Description**: The app should display a list of community resources, with title, description and map location\
**Preconditions**: The is on the main page \
**Postconditions**: The user navigates to the Community Resources page \
**Course of Action**: \
The user presses on the Community Resources button \
The Community Resources page is presented to the user\
**Alternative Course**: If the community resources page cannot load, \
The user is returned to the main page

**Name**: Know Your Rights\
**Identifier**: UC-47 \
**Description**: The app should display a list of important rights they have when dealing with Law Enforcement\
**Preconditions**: The user navigates to the Know Your Rights page\
**Postconditions**: A list of information is presented to the user\
**Course of Action**: \
The user presses on the Know Your Rights button\
The Know Your Rights page is presented to the user\
**Alternative Course**: If the Know Your Rights page cannot load, \
The user is returned to the main page

**Name**: Control Primary Action of Recording and Alerting Through Voice Control\
**Identifier**: UC-48 \
**Description**: The user should be able to alert contact and record video with their voice and without having to touch the phone\
**Preconditions**: The microphone works and the phone is setup to recognize the user's voice\
**Postconditions**: Either, or both, actions are performed\
**Course of Action**: \
The user uses their voice to perform the relevant action\
The app performs the action\
**Alternative Course**: If the phone does not recognize the command,\
The phone responds that it did not understand the command

**Name**: Retrieve Phone Location On Android \
**Identifier**: UC-49 \
**Description**: The app must use the Google Play Services API to retrieve the phone's location when an alert is being sent out \
**Preconditions**: The user has begun the process of sending out alerts \
**Postconditions**: The app has the last known location of the phone \
**Course of Action**: \
The user performs the action to send alerts to contacts \
Through the Play Services API, the phone retrieves the last known location of the phone \
**Alternative Course**: If the last known location of the user is from a period of time that was too long in the past,\
The app notifies the user that it cannot locate the phone
**Alternative Course**: If the phone location cannot be obtained , \
No location is provided as part of the alerts

**Name**: Retrieve Phone Location On iOS \
**Identifier**: UC-50 \
**Description**: The app must use the Core Locations API to retrieve the phone's location when an alert is being sent out \
**Preconditions**: The user has begun the process of sending out alerts \
**Postconditions**: The app has the last known location of the phone \
**Course of Action**: \
The user performs the action to send alerts to contacts \
Through the Core Locations API, the phone retrieves the location of the phone \
**Alternative Course**: If the phone location cannot be obtained , \
No location is provided as part of the alerts

**Name**: Attach Location Address to Alerts on Android \
**Identifier**: UC-51 \
**Description**: The app must convert a Location object to a Location Address that is human understandable to send to contacts \
**Preconditions**: The user has begun the process of sending out alerts and has the last known location of the phone \
**Postconditions**: The app has a Location Address that corresponds to the Location and it is attatched to the alerts that will be sent to contacts in SMS and email \
**Course of Action**: \
The Location of the phone is retrieved, \
The Location object is converted to a Location address \
The Location Address is attached to the alerts that will be sent to contacts \
**Alternative Course**: If the Location object cannot be parsed,
No location address is attached to the alerts

**Name**: Attach Location Address to Alerts on iOS \
**Identifier**: UC-52 \
**Description**: The app must convert Coordinates to a Placemark that is human understandable to send to contacts \
**Preconditions**: The user has begun the process of sending out alerts and knows the Coordinates of the phone \
**Postconditions**: The app has a Placemark that corresponds to the Coordinates and it is attatched to the Alerts that will be sent to contacts in SMS and email \
**Course of Action**: \
The Coordinates of the phone is retrieved, \
The Coordinates are converted to a Placemark address \
The Placemark Address is attached to the Alerts that will be sent to contacts \
**Alternative Course**: If the Location object cannot be parsed,
No location address is attached to the alerts

**Name**: Users Can Log in and View their Recorded Media through a Web Browser \
**Identifier**: UC-53 \
**Description**: The user could access their stored files through a web browser \
**Preconditions**: The user is using a browser \
**Postconditions**: The user has access to their files through a browser based web app\
**Course of Action**: \
The user logs into their Google/Apple account in the web browser, \
Their files are presented to them in the browser \
**Alternative Course**: If the log in process fails, \
The user is returned to the log in page

**Name**: Users Can Delete their Recorded Media through a Web Browser \
**Identifier**: UC-54 \
**Description**: The user could delete their stored files through a web browser \
**Preconditions**: The user is using a browser \
**Postconditions**: The user can delete their files through a browser based web app\
**Course of Action**: \
The user selects a file to delete \
The user clicks on the delete button \
The file is deleted from the Google\Apple Cloud Drive\
**Alternative Course**: If the deletion process fails, \
The user is returned to the view of their media files

**Name**: Users Can Log Out of their Account in a Browser\
**Identifier**: UC-55 \
**Description**: The user can log out of  \
**Preconditions**: The user logged into their Google/Apple account connected to the app on a browser \
**Postconditions**: The user can delete their files through a browser based web app\
**Course of Action**: \
The user clicks on the log out button \
The user is returned to the log in screen and their session is ended with their Google/Apple Drive \
**Alternative Course**: If the logout process fails, \
The user is returned to the main view of their media files

## MoSCoW Ranking

**Must Haves**\
UC-1 - Register Contact\
UC-3 - Edit Contact\
UC-5 - Delete Contact\
UC-7 - User Action to Alert Contacts\
UC-11 - Notification on Failed Task Completion\
UC-12 - Create Objects That Contain the Contact Details and the Alert Message\
UC-13 - Process Message/Contact Objects Waiting in Queue\
UC-14A - Detect and Access Camera on Android\
UC-14B - Detect and Access Camera on Android\
UC-15 - Start Camera Session on iOS\
UC-16A - Preview Recording for User to Watch on Android\
UC-16B - Preview Recording for User to Watch on Android\
UC-17 - Preview Recording for User to Watch on iOS\
UC-18 - Overlay Interaction Over Previewed Recording for User to Stop or Zoom on Android\
UC-19 - Overlay Interaction Over Previewed Recording for User to Stop or Zoom on iOS\
UC-20 - Save Video to Android Device\
UC-21 - Save AudioVideo file to iOS Device\
UC-22 - Record Audio on Android\
UC-23 - Record Audio on iOS\
UC-24 - Save Audio File to Android Device\
UC-25 - Save Audio File to iOS Device\
UC-30 - Save Metadata to Device\
UC-31 - Mix Audio and Video Temporary Files Together on Android\
UC-34 - Resumable Upload to Google Drive Linked to Google Account\
UC-35 - Resumable Upload to iCloud Drive Linked to Apple Account\
UC-36 - Initial App Access Through Google/Apple Sign In\
UC-37 - De-Link App from Google/Apple Account\
UC-38 - User Authentication to Access Sensitive Settings and Data\
UC-46 - Community Resources\
UC-47 - Know Your Rights\

**Should Haves**\
UC-2 - Upload Registered Contact Details to Users Cloud Drive\
UC-4 - Upload Edited Contact Details to the Users Cloud Drive\
UC-6 - Remove Contact Details from the Users Cloud Drive\
UC-8 - Short Vibration on Successful Task Completion\
UC-9 - Notification on Successful Task Completion\
UC-10 - Two Vibrations in Quick Succession on Failed Task Completion\
UC-39 - Hide App Details in the App Switcher View\
UC-42 - Access Recorded Media Files Stored in Google/Apple Drive\
UC-43 - Play Recorded Media Files Stored in Google/Apple Drive\
UC-44 - Delete Recorded Media Files Stored in Google/Apple Cloud Drive\
UC-49 - Retrieve Phone Location On Android\
UC-50 - Retrieve Phone Location On iOS\
UC-51 - Attach Location Address to Alerts on Android\
UC-52 - Attach Location Address to Alerts on iOS\

**Would Haves**\
UC-26 - Toggle Recording From Camera Does Not Detect Light\
UC-27 - Toggle Recording From Camera If Phone Does Not Detect Movement\
UC-28 - Toggle Screen Display If No Light is Detected from Camera\
UC-29 - Toggle Screen Display If Phone is Face Down\
UC-32 - Segment Recordings To Limit File Size on Android\
UC-33 - Segment Recordings To Limit File Size on iOS\
UC-40 - Save User Preferences and Settings to Google/Apple Cloud Drive\
UC-41 - Load User Preferences and Settings from Google/Apple Cloud\
UC-45 - Stop Camera Recording Below Battery Threshold\

**Could Haves**\
UC-48 - Control Primary Action of Recording and Alerting Through Voice Control\
UC-53 - Users Can Log in and View their Recorded Media through a Web Browser\
UC-54 - Users Can Delete their Recorded Media through a Web Browser\
UC-55 - Users Can Log Out of their Account in a Browser\
