//
//  ViewController.swift
//  AKSwiftAuth0Test
//
//  Created by Iuliia Zhelem on 26.07.16.
//  Copyright © 2016 Akvelon. All rights reserved.
//

import UIKit
import Lock

let kInstagramConnectionName = "instagram"
let kLinkedInConnectionName = "linkedin"
let kTwitterConnectionName = "twitter"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func clickLinkedInButton(sender: AnyObject) {
        let success = { (profile: A0UserProfile, token: A0Token) in
            print("User: \(profile)")
        }
        let failure = { (error: NSError) in
            print("Oops something went wrong: \(error)")
        }
        let lock = A0Lock.sharedLock()
        lock.identityProviderAuthenticator().authenticateWithConnectionName(kLinkedInConnectionName, parameters: nil, success: success, failure: failure)
    }

    @IBAction func clickInstagramButton(sender: AnyObject) {
        let success = { (profile: A0UserProfile, token: A0Token) in
            print("User: \(profile)")
        }
        let failure = { (error: NSError) in
            print("Oops something went wrong: \(error)")
        }
        let lock = A0Lock.sharedLock()
        lock.identityProviderAuthenticator().authenticateWithConnectionName(kInstagramConnectionName, parameters: nil, success: success, failure: failure)
    }
    
    @IBAction func clickTwitterButton(sender: AnyObject) {
        let success = { (profile: A0UserProfile, token: A0Token) in
            print("User: \(profile)")
        }
        let failure = { (error: NSError) in
            print("Oops something went wrong: \(error)")
        }
        let lock = A0Lock.sharedLock()
        lock.identityProviderAuthenticator().authenticateWithConnectionName(kTwitterConnectionName, parameters: nil, success: success, failure: failure)
    }

}

