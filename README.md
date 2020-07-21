# BoilerKeyExtension-Safari
[BoilerKeyExtension](https://github.com/bscholer/BoilerKeyExtension) rewritten as a Safari App Extension in Swift.

# Setup
The red circle indicates you have not set up the extension yet.

<img src="https://imgur.com/I26pSjl.png" width="400">

Clicking on setup will bring up instructions on initializing your information.

<img src="https://imgur.com/tykEJnU.png" width="400">

The link will automatically be validated, and the circle will turn green.
You still need to enter your username and pin, then setup will complete.

<img src="https://imgur.com/j0Y8ZQ4.png" width="400">

The green circle indicates everything is set up and you will be able to log in automatically.

<img src="https://imgur.com/8nFBxxX.png" width="400">

All you have to do now is open safari and enable the extension!
If you change your pin/username, or delete the permissions in BoilerKey, you can use the configuration button to modify any part of your setup.

# Releases
There is currently no download because I do not have an Apple developer account.
In order to distribute this app, IN ANY WAY a developer account is required.
I am not able to submit this app to the app store, or even build the app into a downloadable package without signing it using a developer account.
I'm not keen on paying $99/year for this project that few people, if anyone will use. If anyone would like to distribute this, please do so.

# Security
You may be worried about the security of bypassing 2fa and logging in entirely automatically.
This app stores your credentials and 2fa information in an encrypted keychain that is accessable only by the app and extension.
It will never send your credentials or data anywhere, everything happens on your machine.
