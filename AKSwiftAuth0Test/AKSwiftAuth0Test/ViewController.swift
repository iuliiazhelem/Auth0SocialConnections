//
//  ViewController.swift
//  AKSwiftAuth0Test
//
//  Created by Iuliia Zhelem on 26.07.16.
//  Copyright © 2016 Akvelon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

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
    
    @IBAction func clickGoogleButton(sender: AnyObject) {
        self.socialAuthenticateWithName(kGoogleConnectionName)
    }

    func socialAuthenticateWithName(name:String) {
        let success = { (profile: A0UserProfile, token: A0Token) in
            print("User: \(profile)")
        }
        let failure = { (error: NSError) in
            print("Oops something went wrong: \(error)")
        }
        let lock = A0Lock.sharedLock()
        lock.identityProviderAuthenticator().authenticateWithConnectionName(name, parameters: nil, success: success, failure: failure)
    }
}

