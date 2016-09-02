//
//  AppDelegate.m
//  AKAuth0TestApp
//

#import "AppDelegate.h"
#import <Lock/Lock.h>
#import <Lock-Twitter/A0TwitterAuthenticator.h>
#import <Lock-Google/A0GoogleAuthenticator.h>
#import "AppConstants.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    A0Lock *lock = [A0Lock sharedLock];
    [lock applicationLaunchedWithOptions:launchOptions];
    
    NSString *twitterApiKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:kTwitterConsumerKey];
    NSString *twitterApiSecret = [[NSBundle mainBundle] objectForInfoDictionaryKey:kTwitterConsumerSecret];
    A0TwitterAuthenticator *twitter = [A0TwitterAuthenticator newAuthenticatorWithKey:twitterApiKey andSecret:twitterApiSecret];
    
    A0GoogleAuthenticator *google = [A0GoogleAuthenticator newAuthenticator];
    google.clientProvider = lock;
    //Need for configuring the google authenticator from GoogleService-Info.plist
    [google applicationLaunchedWithOptions:launchOptions];

    A0WebViewAuthenticator *linkedin = [[A0WebViewAuthenticator alloc] initWithConnectionName:kLinkedInConnectionName lock:lock];
    A0WebViewAuthenticator *instagram = [[A0WebViewAuthenticator alloc] initWithConnectionName:kInstagramConnectionName lock:lock];
    A0WebViewAuthenticator *windowslive = [[A0WebViewAuthenticator alloc] initWithConnectionName:kWindowsLiveConnectionName lock:lock];
    
    [lock registerAuthenticators:@[twitter, linkedin, instagram, windowslive, google]];
    
    [A0LockLogger logAll];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//to allow native logins using other iOS apps, e.g: Twitter, Facebook, Safari etc
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    A0Lock *lock = [A0Lock sharedLock];
    return [lock handleURL:url sourceApplication:sourceApplication];
}

@end
