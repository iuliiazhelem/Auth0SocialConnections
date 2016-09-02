//
//  ViewController.m
//  AKAuth0TestApp
//

#import "ViewController.h"
#import "AppConstants.h"
#import <Lock/Lock.h>
#import <SimpleKeychain.h>

static NSString *kIdTokenKeychainName = @"id_token";
static NSString *kAccessTokenKeychainName = @"access_token";
static NSString *kRefreshTokenKeychainName = @"refresh_token";
static NSString *kProfileKeychainName = @"profile";
static NSString *kKeychainName = @"Auth0";

@interface ViewController ()

- (IBAction)clickLinkedInButton:(id)sender;
- (IBAction)clickInstagramButton:(id)sender;
- (IBAction)clickTwitterButton:(id)sender;
- (IBAction)clickOpenLockUIButton:(id)sender;
- (IBAction)clickMicrosoftAccountButton:(id)sender;
- (IBAction)clickFacebookButton:(id)sender;
- (IBAction)clickGoogleButton:(id)sender;
- (IBAction)clickLogoutButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userIdLabel;

@end

@implementation ViewController

- (IBAction)clickLinkedInButton:(id)sender {
    [self socialAuthenticateWithName:kLinkedInConnectionName];
}

- (IBAction)clickInstagramButton:(id)sender {
    [self socialAuthenticateWithName:kInstagramConnectionName];
}

- (IBAction)clickTwitterButton:(id)sender {
    [self socialAuthenticateWithName:kTwitterConnectionName];
}

- (IBAction)clickOpenLockUIButton:(id)sender {
    A0Lock *lock = [A0Lock sharedLock];
    
    A0LockViewController *controller = [lock newLockViewController];
    controller.closable = YES;
    controller.onAuthenticationBlock = ^(A0UserProfile *profile, A0Token *token) {
        [self storeToken:token profile:profile];
        NSLog(@"User: %@", profile);
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)clickMicrosoftAccountButton:(id)sender {
    [self socialAuthenticateWithName:kWindowsLiveConnectionName];
}

- (IBAction)clickFacebookButton:(id)sender {
    [self socialAuthenticateWithName:kFacebookConnectionName];
}

- (IBAction)clickGoogleButton:(id)sender {
    [self socialAuthenticateWithName:kGoogleConnectionName];
}

- (void)socialAuthenticateWithName:(NSString *)connectionName {
    void(^success)(A0UserProfile *, A0Token *) = ^(A0UserProfile *profile, A0Token *token) {
        [self storeToken:token profile:profile];
        NSLog(@"User: %@", profile);
    };
    void(^error)(NSError *) = ^(NSError *error) {
        [self clearData];
        NSLog(@"Oops something went wrong: %@", error);
        
    };
    A0Lock *lock = [A0Lock sharedLock];
    [[lock identityProviderAuthenticator] authenticateWithConnectionName:connectionName
                                                              parameters:nil
                                                                 success:success
                                                                 failure:error];
    
}

- (IBAction)clickLogoutButton:(id)sender {
    [self logoutFromAllConnections];
    [self clearData];
}

//Saving JWT Tokens
- (void)storeToken:(A0Token *)token profile:(A0UserProfile *)profile
{
    A0SimpleKeychain *keychain = [A0SimpleKeychain keychainWithService:kKeychainName];
    [keychain setString:token.idToken forKey:kIdTokenKeychainName];
    [keychain setString:token.refreshToken forKey:kRefreshTokenKeychainName];
    [keychain setString:token.accessToken forKey:kAccessTokenKeychainName];
    [keychain setData:[NSKeyedArchiver archivedDataWithRootObject:profile] forKey:kProfileKeychainName];
    
    //show profile
    [self setupTextForUsername:profile.userId forUserId:profile.name];
}

- (void)storeIdToken:(NSString *)idToken
{
    A0SimpleKeychain *keychain = [A0SimpleKeychain keychainWithService:kKeychainName];
    [keychain setString:idToken forKey:kIdTokenKeychainName];
}

- (void)storeProfile:(A0UserProfile *)profile
{
    A0SimpleKeychain *keychain = [A0SimpleKeychain keychainWithService:kKeychainName];
    [keychain setData:[NSKeyedArchiver archivedDataWithRootObject:profile] forKey:kProfileKeychainName];
    
    //show profile
    [self setupTextForUsername:profile.userId forUserId:profile.name];
}

- (NSString *)retrieveIdToken
{
    A0SimpleKeychain *keychain = [A0SimpleKeychain keychainWithService:kKeychainName];
    NSString* token = [keychain stringForKey:kIdTokenKeychainName];
    return token;
}

- (NSString *)retrieveAccessToken
{
    A0SimpleKeychain *keychain = [A0SimpleKeychain keychainWithService:kKeychainName];
    NSString* token = [keychain stringForKey:kAccessTokenKeychainName];
    return token;
}

- (NSString *)retrieveRefreshToken
{
    A0SimpleKeychain *keychain = [A0SimpleKeychain keychainWithService:kKeychainName];
    NSString* token = [keychain stringForKey:kRefreshTokenKeychainName];
    return token;
}

- (A0UserProfile *)retrieveProfile
{
    A0SimpleKeychain *keychain = [A0SimpleKeychain keychainWithService:kKeychainName];
    A0UserProfile *profile = [NSKeyedUnarchiver unarchiveObjectWithData:[keychain dataForKey:kProfileKeychainName]];
    return profile;
}

- (void)clearData
{
    A0SimpleKeychain *keychain = [A0SimpleKeychain keychainWithService:kKeychainName];
    [keychain clearAll];
    
    //show profile
    [self setupTextForUsername:@"" forUserId:@""];
}

- (void)setupTextForUsername:(NSString *)username forUserId:(NSString *)userId
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.userNameLabel.text = username;
        self.userIdLabel.text = userId;
    });
}

- (void)logoutFromAllConnections {
    A0Lock *lock = [A0Lock sharedLock];
    A0APIClient *client = [lock apiClient];
    
    [client logout];
    [lock clearSessions];
}

@end
