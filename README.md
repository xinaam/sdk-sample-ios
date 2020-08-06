# Mzaalo IOS SDK
This is the official documentation for the integration of Mzaalo iOS SDKs in any application with a valid partner code.

Overview
--------

Mzaalo SDKs are available as following modules:

1.  **MzaaloAuth** : This module contains authentication features like login, logout, Networking etc.

2.  **MzaaloRewards** : This module contains all the features of the MzaaloAuth, plus features of rewards like adding rewards, fetching balance, etc.

Both these modules are shippable as separate pods. Structurally, MzaaloAuth is the subset of MzaaloRewards. This means, any application that includes the dependency for MzaaloRewards automatically gets the functionality for MzaaloAuth out of the box.

Installation
------------

### Requirements

-   Ios 9.0 and above

-   Cocoapods

### Configuration

- To add  MzaaloAuth SDK, add the following line to your podfile

    pod 'MzaaloAuth'
    
- To add  MzaaloRewards SDK, add the following line to your podfile

    pod 'MzaaloRewards'


Getting Started
---------------

The entry point to the SDK is through the setupSDK function which is to be implemented in the  didFinishLaunchingWithOptions method of Appdelegate

Params: 
-   partnerCode : a valid partner code string
-   environment : a MzaaloEnvironment enum with values STAGING or PRODUCTION
-   onSuccess : Callback block for Success
-   onFailure : Callback block for Failure returns an error String

Example:

    @UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {
    
	     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		//DoStuff
	         Mzaalo.sharedInstance.setupSDK(partnerCode: "code", environment: .STAGING, onSuccess: {
		    	 print("success")
	         }) { (err) in
	             print(err)
	         }
	         return true
	     }
    }

Features and Implementation
---------------------------

### AUTHENTICATION

#### Login

Your application should call the login function as soon as the user is identified at your end.

Params: 
-   userId : a unique string identifying the user on your platform
-   userMeta : a Dictionary of type [String:String] it can include fields like email, phone and country_code. A field can be mandatory or optional depending upon the partner configuration in the system.
-   onSuccess : Callback block for Success returns object of type MzaaloUser
-   onFailure : Callback block for Failure returns an error String

Example:

    Mzaalo.sharedInstance.login(userId: "uniqueID", userMeta: ["email":"user@example.com"], onSuccess: { (user) in
		print("success")
    }) { (err) in
		print(err)
    }

The `MzaaloUser` object returned in the `onSuccess` callback of the `login` function has the following public fields:

 - id: String
 - firstName: String
 - lastName: String
 - email: String
 - phone: String
 - gender: String
 - countryCode: String
 - dob: String

#### Logout

Your application should call the logout function when the user logs out from your application or when the user identity is no longer available to you.

Example:

    Mzaalo.sharedInstance.logout()

#### Get User object

Returns an object of type MzaaloUser

Example:

    Mzaalo.sharedInstance.loggedInUser()

### REWARDS

#### Fetch Reward Balance

Call this function if you want to fetch the balance of the user that is currently logged in. 

Example:

    Mzaalo.sharedInstance.getBalance(onSuccess: { (balance:Int) in
		print(balance)
    }, onFailure: { (err:String) in
		print(err)
    })

#### Register Rewards Action

This is a feature that allows the application to register an action to the Mzaalo SDK, that should credit some rewards to the user.

Params: 
-   action : a MzaaloRewardsAction enum

-   eventMeta : a Dictionary of type [String:Any] 

-   onSuccess : Callback block for Success 

-   onFailure : Callback block for Failure returns an error String

Example:

    Mzaalo.sharedInstance.registerRewardAction(action: .checkedIn , eventMeta: [:], onSuccess: {
              print("success")
    }) { (err) in
              print(err)
     }

 Note:

1.  MzaaloRewardsAction Enum can have the following valid values
-   contentViewed -
Send this if you want to give rewards to the user for watching content

-   checkedIn -
Send this if you want to give rewards to the user for launching the app or visiting some section of the app on a daily basis

-   signedUp -
Send this if you want to give reward to the user for signing up on your application. In this case, call this once the above mentioned login function has been successfully executed.

-   referralApplied  -
When a user applies a referral code on the platform which he/she received from some other user previously. This will credit the rewards to the user who referred the current user.

2.  eventMeta Dictionary can have the following conditional parameters based on the action being triggered

| Action | eventMeta property | Description | DataType | Example |
|----|-----|----|----|----|
| contentViewed | total_watch_time | The duration(in seconds) for which the user has watched the content | Int | 600 (if the user watched a movie for ten minutes) |
| referralApplied | referee_user_id | Unique user ID of the user at your system who referred the current user | String | abcdefg |
| referralApplied | referee_user_meta | This is the user meta of the person who referred this user. It's format is same as mentioned in the login function for userMeta parameter | [String:String] | ["email":"user@example.com"] |

