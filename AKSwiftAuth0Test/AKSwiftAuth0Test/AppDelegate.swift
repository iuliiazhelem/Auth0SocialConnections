//
//  AppDelegate.swift
//  AKSwiftAuth0Test
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        A0Lock.sharedLock().applicationLaunchedWithOptions(launchOptions)
        
        let twitterApiKey = NSBundle.mainBundle().objectForInfoDictionaryKey(kTwitterConsumerKey) as! String
        let twitterApiSecret = NSBundle.mainBundle().objectForInfoDictionaryKey(kTwitterConsumerSecret) as! String
        let twitter = A0TwitterAuthenticator.newAuthenticatorWithKey(twitterApiKey, andSecret:twitterApiSecret)
    
        let facebook = A0FacebookAuthenticator.newAuthenticatorWithDefaultPermissions();
        
        let google = A0GoogleAuthenticator.newAuthenticator()
        google.clientProvider = A0Lock.sharedLock()
        //Need for configuring the google authenticator from GoogleService-Info.plist
        google.applicationLaunchedWithOptions(launchOptions)
        
        let linkedin = A0WebViewAuthenticator(connectionName: kLinkedInConnectionName, lock: A0Lock.sharedLock())
        let instagram = A0WebViewAuthenticator(connectionName: kInstagramConnectionName, lock: A0Lock.sharedLock())
        let windowslive = A0WebViewAuthenticator(connectionName: kWindowsLiveConnectionName, lock: A0Lock.sharedLock())
            
        A0Lock.sharedLock().registerAuthenticators([twitter, linkedin, instagram, windowslive, google, facebook]);

        A0LockLogger.logAll()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return A0Lock.sharedLock().handleURL(url, sourceApplication: sourceApplication)
    }
}

