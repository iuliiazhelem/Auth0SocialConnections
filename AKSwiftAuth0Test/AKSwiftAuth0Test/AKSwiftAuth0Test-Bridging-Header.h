//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import "Lock.h"
#import <Lock/Lock.h>
#import <Lock-Twitter/A0TwitterAuthenticator.h>
#import <Lock-Google/A0GoogleAuthenticator.h>
#import <Lock-Facebook/A0FacebookAuthenticator.h>
#import <SimpleKeychain.h>

static NSString *kLinkedInConnectionName = @"linkedin";
static NSString *kFacebookConnectionName = @"facebook";
static NSString *kInstagramConnectionName = @"instagram";
static NSString *kTwitterConnectionName = @"twitter";
static NSString *kGoogleConnectionName = @"google-oauth2";
static NSString *kWindowsLiveConnectionName = @"windowslive";

static NSString *kTwitterConsumerKey = @"TwitterConsumerKey";
static NSString *kTwitterConsumerSecret = @"TwitterConsumerSecret";
static NSString *kGoogleClientId = @"CLIENT_ID";
