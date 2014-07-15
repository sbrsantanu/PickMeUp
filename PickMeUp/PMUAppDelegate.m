//
//  PMUAppDelegate.m
//  PickMeUp
//
//  Created by Santanu.Adhikary@sbr-technologies.com on 04/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "PMUAppDelegate.h"
#import "PMUViewController.h"
#import "PMUGlobalAccess.h"
#import "PMULoginViewController.h"

/*
 */
@implementation PMUAppDelegate
/*
 */
@synthesize NavigationController            = _NavigationController;
/*
 */
@synthesize GlobalAccess                    = _GlobalAccess;
/*
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    /*
     *  Application launch, declare all veriables
     *  @Window
     *  @NavigationController
     *  @windowVisibility
     *  @ViewController
     */
    
    self.window                         = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:PMUGlobalAccess.GlobalBckgroundColor];
    self.window.rootViewController      = _NavigationController =  [self navigationController];
    [self HideAppnavigationBar];
    [self.window makeKeyAndVisible];
    
    _GlobalAccess = [self SetGlobalAccess];
    [_GlobalAccess RegisterDeviceForRemoteNotificationWithBadgeCounter:YES WithRemoveAllNotification:YES];
    return YES;
}
/*
 */
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
}
/*
 */
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
}
/*
 */
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    self.deviceTokenString = [_GlobalAccess FilterUserDevicetokenWithdevicetoken:deviceToken.description];
    [_GlobalAccess SetUserDevicetokenWithDeviceToken:self.deviceTokenString];
}
/*
 */
-(void)HideAppnavigationBar
{
    [_NavigationController setNavigationBarHidden:YES];
}
/*
 */
-(PMUGlobalAccess * const)SetGlobalAccess {
    return [[PMUGlobalAccess alloc] init];
}
/*
 */
- (UINavigationController *)navigationController {
    return [[UINavigationController alloc] initWithRootViewController:[self RootViewController]];
}
/*
 */
- (PMUViewController *)RootViewController {
    return self.viewController = [[PMUViewController alloc] initWithNibName:PMUGlobalAccess.MainViewScreen bundle:nil];
}
/*
 */
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}
/*
 */
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}
/*
 */
- (void)applicationWillEnterForeground:(UIApplication *)application
{
  
}
/*
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
   
}
/*
 */
- (void)applicationWillTerminate:(UIApplication *)application
{

}
/*
 */
-(void)SignOutFromAccount
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    PMULoginViewController *LoginView = [[PMULoginViewController alloc] init];
    [self.NavigationController pushViewController:LoginView animated:NO];
}
@end
