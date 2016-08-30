# Auth0SocialConnections

This sample exposes how to integrate social connections into your application (Microsoft, Google, Twitter, LinkedIn, Instagram) using Auth0.

For this you need to add the following to your `Podfile`:
```
pod 'Lock', '~> 1.24'
pod 'Lock-Twitter', '~> 1.1'
pod 'Lock-Google', '~> 2.0'
pod 'SimpleKeychain'
```

## Important snippets

### Step 1: Register the Authenticator 
```swift
let linkedin = A0WebViewAuthenticator(connectionName: kLinkedInConnectionName, lock: A0Lock.sharedLock())
A0Lock.sharedLock().registerAuthenticators([linkedin]);
```

```Objective-C
A0Lock *lock = [A0Lock sharedLock];
A0WebViewAuthenticator *linkedin = [[A0WebViewAuthenticator alloc] initWithConnectionName:kLinkedInConnectionName lock:lock];
[lock registerAuthenticators:@[twitter, linkedin, instagram, windowslive, google]];
```

### Step 2: Authenticate with a Connection name 
```swift
let success = { (profile: A0UserProfile, token: A0Token) in
  print("User: \(profile)")
}
let failure = { (error: NSError) in
  print("Oops something went wrong: \(error)")
}
let lock = A0Lock.sharedLock()
lock.identityProviderAuthenticator().authenticateWithConnectionName(name, parameters: nil, success: success, failure: failure)
```

```Objective-C
void(^success)(A0UserProfile *, A0Token *) = ^(A0UserProfile *profile, A0Token *token) {
  NSLog(@"User: %@", profile);
};
void(^error)(NSError *) = ^(NSError *error) {
  NSLog(@"Oops something went wrong: %@", error);
};
  
A0Lock *lock = [A0Lock sharedLock];
[[lock identityProviderAuthenticator] authenticateWithConnectionName:connectionName
                                                          parameters:nil
                                                             success:success
                                                             failure:error];
```

Before using the example please make sure that you change some keys in the `Info.plist` file with your data:

##### Auth0 data from [Auth0 Dashboard](https://manage.auth0.com/#/applications):

- Auth0ClientId
- Auth0Domain
- CFBundleURLSchemes

```
<key>CFBundleTypeRole</key>
<string>None</string>
<key>CFBundleURLName</key>
<string>auth0</string>
<key>CFBundleURLSchemes</key>
<array>
<string>a0{CLIENT_ID}</string>
</array>
```

##### Twitter data from the configured [social connection](https://manage.auth0.com/#/connections/social). For more details about connecting your app to Twitter see [this link](https://auth0.com/docs/connections/social/twitter):

- TwitterConsumerKey
- TwitterConsumerSecret

##### Google data from the `GoogleServices-Info.plist` file which you can download from [this wizard](https://developers.google.com/mobile/add?platform=ios). For more details about connecting your app to Google see [this link](https://auth0.com/docs/connections/social/google) and [this iOS doc](https://auth0.com/docs/libraries/lock-ios/native-social-authentication#google):

- GOOGLE_APP_ID
- REVERSED_CLIENT_ID
- CFBundleURLSchemes

```
<key>CFBundleTypeRole</key>
<string>None</string>
<key>CFBundleURLName</key>
<string>Google</string>
<key>CFBundleURLSchemes</key>
<array>
<string>{REVERSED_CLIENT_ID}</string>
</array>
```

For more information about social connections with Auth0 please check the following links:

* [Google](https://auth0.com/docs/connections/social/google)
* [Twitter](http://docs.aws.amazon.com/mobile/sdkforios/developerguide/)
* [LinkedIn](https://auth0.com/docs/connections/social/linkedin)
* [Instagram](https://auth0.com/docs/connections/social/instagram)
* [Microsoft](https://auth0.com/docs/connections/social/microsoft-account)

