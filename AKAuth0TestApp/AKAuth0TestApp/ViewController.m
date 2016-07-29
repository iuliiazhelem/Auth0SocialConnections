//
//  ViewController.m
//  AKAuth0TestApp
//
//  Created by Iuliia Zhelem on 26.07.16.
//  Copyright © 2016 Akvelon. All rights reserved.
//

#import "ViewController.h"
#import "AppConstants.h"
#import <Lock/Lock.h>

@interface ViewController ()

- (IBAction)clickLinkedInButton:(id)sender;
- (IBAction)clickInstagramButton:(id)sender;
- (IBAction)clickTwitterButton:(id)sender;
- (IBAction)clickOpenLockUIButton:(id)sender;
- (IBAction)clickMicrosoftAccountButton:(id)sender;

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

- (IBAction)clickTwitterButton:(id)sender {
    void(^success)(A0UserProfile *, A0Token *) = ^(A0UserProfile *profile, A0Token *token) {
        NSLog(@"User: %@", profile);
    };
    void(^error)(NSError *) = ^(NSError *error) {
        NSLog(@"Oops something went wrong: %@", error);
        
    };
    A0Lock *lock = [A0Lock sharedLock];
    [[lock identityProviderAuthenticator] authenticateWithConnectionName:kTwitterConnectionName
                                                              parameters:nil
                                                                 success:success
                                                                 failure:error];
}

- (IBAction)clickOpenLockUIButton:(id)sender {
    A0Lock *lock = [A0Lock sharedLock];
    
    A0LockViewController *controller = [lock newLockViewController];
    controller.closable = YES;
    controller.onAuthenticationBlock = ^(A0UserProfile *profile, A0Token *token) {
        NSLog(@"User: %@", profile);
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)clickMicrosoftAccountButton:(id)sender {
    void(^success)(A0UserProfile *, A0Token *) = ^(A0UserProfile *profile, A0Token *token) {
        NSLog(@"User: %@", profile);
    };
    void(^error)(NSError *) = ^(NSError *error) {
        NSLog(@"Oops something went wrong: %@", error);
        
    };
    A0Lock *lock = [A0Lock sharedLock];
    [[lock identityProviderAuthenticator] authenticateWithConnectionName:kWindowsLiveConnectionName
                                                              parameters:nil
                                                                 success:success
                                                                 failure:error];
}

@end
