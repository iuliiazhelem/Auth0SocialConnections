//
//  ViewController.m
//  AKAuth0TestApp
//
//  Created by Iuliia Zhelem on 26.07.16.
//  Copyright © 2016 Akvelon. All rights reserved.
//

#import "ViewController.h"
#import <Lock/Lock.h>

static NSString *kLinkedInConnectionName = @"linkedin";
static NSString *kInstagramConnectionName = @"instagram";

@interface ViewController ()

- (IBAction)clickLinkedInButton:(id)sender;
- (IBAction)clickInstagramButton:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)clickLinkedInButton:(id)sender {
    A0Lock *lock = [A0Lock sharedLock];
    
    void(^success)(A0UserProfile *, A0Token *) = ^(A0UserProfile *profile, A0Token *token) {
        NSLog(@"User: %@", profile);
    };
    void(^error)(NSError *) = ^(NSError *error) {
        NSLog(@"Oops something went wrong: %@", error);
    };
    
    [[lock identityProviderAuthenticator] authenticateWithConnectionName:kLinkedInConnectionName
                                                              parameters:nil
                                                                 success:success
                                                                 failure:error];
}

- (IBAction)clickInstagramButton:(id)sender
{
    A0Lock *lock = [A0Lock sharedLock];
    
    void(^success)(A0UserProfile *, A0Token *) = ^(A0UserProfile *profile, A0Token *token) {
        NSLog(@"User: %@", profile);
    };
    void(^error)(NSError *) = ^(NSError *error) {
        NSLog(@"Oops something went wrong: %@", error);
    };
    
    [[lock identityProviderAuthenticator] authenticateWithConnectionName:kInstagramConnectionName
                                                              parameters:nil
                                                                 success:success
                                                                 failure:error];
    
}

@end
