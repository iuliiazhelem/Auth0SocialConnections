//
//  ViewController.swift
//  AKSwiftAuth0Test
//

import UIKit

let kIdTokenKeychainName = "id_token"
let kRefreshTokenKeychainName = "refresh_token"
let kProfileKeychainName = "profile"
let kKeychainName = "Auth0"

class ViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!

    @IBAction func clickOpenLockUIButton(sender: AnyObject) {
        let controller = A0Lock.sharedLock().newLockViewController()
        controller.closable = true
        controller.onAuthenticationBlock = { (profile, token) in
            print("User: \(profile!)")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        self.presentViewController(controller, animated: true, completion: nil)

    }

    @IBAction func clickLinkedInButton(sender: AnyObject) {
        self.socialAuthenticateWithName(kLinkedInConnectionName)
    }

    @IBAction func clickInstagramButton(sender: AnyObject) {
        self.socialAuthenticateWithName(kInstagramConnectionName)
    }
    
    @IBAction func clickTwitterButton(sender: AnyObject) {
        self.socialAuthenticateWithName(kTwitterConnectionName)
    }

    @IBAction func clickMicrosoftAccountButton(sender: AnyObject) {
        self.socialAuthenticateWithName(kWindowsLiveConnectionName)
    }

    @IBAction func clickFacebookButton(sender: AnyObject) {
        self.socialAuthenticateWithName(kFacebookConnectionName)
    }
    
    @IBAction func clickGoogleButton(sender: AnyObject) {
        self.socialAuthenticateWithName(kGoogleConnectionName)
    }

    func socialAuthenticateWithName(name:String) {
        let success = { (profile: A0UserProfile, token: A0Token) in
            self.storeToken(token, profile:profile)
            print("User: \(profile)")
        }
        let failure = { (error: NSError) in
            print("Oops something went wrong: \(error)")
        }
        let lock = A0Lock.sharedLock()
        lock.identityProviderAuthenticator().authenticateWithConnectionName(name, parameters: nil, success: success, failure: failure)
    }
    
    @IBAction func clickLogoutButton(sender: AnyObject) {
        self.logoutFromAllConnections()
        self.clearData()
    }
    
    func logoutFromAllConnections() {
        let lock = A0Lock.sharedLock()
        lock.apiClient().logout()
        lock.clearSessions()
    }

    
    //Saving JWT Tokens
    func storeToken(token:A0Token?, profile:A0UserProfile?)
    {
        let keychain = A0SimpleKeychain(service: kKeychainName)
        self.storeIdToken(token?.idToken)
        self.storeProfile(profile)
        
        if let tkn = token, let refreshToken = tkn.refreshToken {
            keychain.setString(refreshToken, forKey: kRefreshTokenKeychainName)
        }
    }
    
    func storeIdToken(idToken:String?)
    {
        if let token = idToken {
            let keychain = A0SimpleKeychain(service: kKeychainName)
            keychain.setString(token, forKey: kIdTokenKeychainName)
        }
    }
    
    func storeProfile(profile:A0UserProfile?)
    {
        if let prof = profile {
            let keychain = A0SimpleKeychain(service: kKeychainName)
            keychain.setData(NSKeyedArchiver.archivedDataWithRootObject(prof), forKey: kProfileKeychainName)
            
            //show profile
            self.setupUsername(prof.name, userId: prof.userId)
        }
    }
    
    func retrieveIdToken() -> String?
    {
        let keychain = A0SimpleKeychain(service: kKeychainName)
        let token = keychain.stringForKey(kIdTokenKeychainName);
        return token;
    }
    
    func retrieveRefreshToken() -> String?
    {
        let keychain = A0SimpleKeychain(service: kKeychainName)
        let token = keychain.stringForKey(kRefreshTokenKeychainName);
        return token;
    }
    
    func retrieveProfile() -> A0UserProfile?
    {
        let keychain = A0SimpleKeychain(service: kKeychainName)
        let data = keychain.dataForKey(kProfileKeychainName)
        let profile = NSKeyedUnarchiver.unarchiveObjectWithData(data!)
        return profile as? A0UserProfile;
    }
    
    func clearData()
    {
        let keychain = A0SimpleKeychain(service: kKeychainName)
        keychain.clearAll()
        
        //show profile
        self.setupUsername("", userId:"")
    }
    
    func setupUsername(username: String, userId: String) {
        dispatch_async(dispatch_get_main_queue()) {
            self.userNameLabel.text = username
            self.userIdLabel.text = userId
        }
    }
    
    func showMessage(message: String) {
        dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: "Auth0", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}

