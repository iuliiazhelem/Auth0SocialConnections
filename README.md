# Auth0SocialConnections

This sample exposes how to integrate Auth0 social connection (Microsoft, Google, Twitter, LinkedIn, Instagram) into your application.


Before using the example please make sure that you change some keys in `Info.plist` with your data:

##### Auth0 data from [Auth0 Dashboard](https://manage.auth0.com/#/applications)
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

##### Twitter data from the configured [Social connection](https://manage.auth0.com/#/connections/social). For more details about connection your app to Twitter see [link](https://auth0.com/docs/connections/social/twitter)
- TwitterConsumerKey
- TwitterConsumerSecret

##### Google data from the `GoogleServices-Info.plist` file which you can download from [this wizard](https://developers.google.com/mobile/add?platform=ios). For more details about connection your app to Google see [link](https://auth0.com/docs/connections/social/google) and [iOS doc](https://auth0.com/docs/libraries/lock-ios/native-social-authentication#google)
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

