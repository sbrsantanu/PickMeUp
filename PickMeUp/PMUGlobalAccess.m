//
//  PMUGlobalAccess.m
//  PickMeUp
//
//  Created by Santanu.Adhikary@sbr-technologies.com on 04/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "PMUGlobalAccess.h"

// Screen after app launch




/*
 */
NSString * const MainScreenIphoneFive                      = @"PMUViewControllerBig";
NSString * const MainScreenIphoneFour                      = @"PMUViewControllerSmall";
/*
 */
NSString * const LoginScreenIphoneFive                     = @"PMULoginViewController";
NSString * const LoginScreenIphoneFour                     = @"PMULoginViewControllerSmall";
/*
 */
NSString * const SignupScreenIphoneFive                    = @"PMURegistrationViewController";
NSString * const SignupScreenIphoneFour                    = @"PMURegistrationViewControllerSmall";
/*
 */
NSString * const ForgotPassScreenIphoneFive                = @"PMUForgetPasswordViewController";
NSString * const ForgotPassScreenIphoneFour                = @"PMUForgetPasswordViewControllerSmall";
/*
 */
NSString * const APPLogoIcon                               = @"logo";
/*
 */
NSString * const APPBackgroundImage                        = @"bg";
NSString * const APPLoaderIcon                             = @"Loader";
/*
 */
NSString * const APPSelectedCheckboxIcon                   = @"check-box1";
/*
 */
NSString * const APPUnSelectedCheckboxIcon                 = @"check-box2";
/*
 */

NSString * const NSUSERDEFAULTUSERDEVICETOKEN              = @"APPUSERDEVICETOKEN";
/*
 */
NSString * const LoginScreenEmailPlaceholderString         = @"Email/Username";
/*
 */
NSString * const LoginScreenPasswordPlaceholderString      = @"Password";
/*
 */
float const Iphone5Height                                  = 500.0f;
/*
 */
float const Iphone4Height                                  = 480.0f;
/*
 */
float const AppLoaderXcord                                 = 140.0f;
/*
 */
float const AppLoaderYcord                                 = 380.0f;
/*
 */
float const AppLoaderWidth                                 = 26.0f;
/*
 */
float const AppLoaderHeight                                = 26.0f;

/*
 */

NSString * const GlobalFontName                             = @"OpenSans-Semibold";

@implementation PMUGlobalAccess

/*
 *  Global Color Decleration
 */

//+(UIColor * const)GlobalBckgroundColor { return [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:PMUGlobalAccess.GlobalBckgroundImage]]; }

+(UIColor * const)GlobalBckgroundColor { return [UIColor blackColor]; }

/*
 *  Global Image name decleration
 */

+(NSString * const)GlobalBckgroundImage { return APPBackgroundImage; }
+(NSString * const)APPLogoIcon { return APPLogoIcon; }
+(NSString * const)APPBackgroundImage { return APPBackgroundImage; }
+(NSString * const)APPLoaderIcon { return APPLoaderIcon; }
+(NSString * const)APPSelectedCheckboxIcon { return APPSelectedCheckboxIcon; }
+(NSString * const)APPUnSelectedCheckboxIcon { return APPUnSelectedCheckboxIcon; }

/*
 *  All global strings
*/

+(NSString * const)UserDevicetokenString { return NSUSERDEFAULTUSERDEVICETOKEN; }
+(NSAttributedString * const)LoginScreenEmailTextFieldPlaceholderString { return [[NSAttributedString alloc] initWithString:LoginScreenEmailPlaceholderString]; }
+(NSAttributedString * const)LoginScreenPasswordTextFieldPlaceholderString { return [[NSAttributedString alloc] initWithString:LoginScreenPasswordPlaceholderString]; }

/*
 *  All NibName
*/

+(NSString *)MainViewScreen { return (self.DeviceIsIphoneFive)?MainScreenIphoneFive:MainScreenIphoneFour; }
+(NSString *)LoginViewScreen { return (self.DeviceIsIphoneFive)?LoginScreenIphoneFive:LoginScreenIphoneFour; }
+(NSString *)RegistrationViewScreen { return (self.DeviceIsIphoneFive)?SignupScreenIphoneFive:SignupScreenIphoneFour; }
+(NSString *)ForgetPasswordViewScreen { return (self.DeviceIsIphoneFive)?ForgotPassScreenIphoneFive:ForgotPassScreenIphoneFour; }

/*
 *  Global Methods
 */

+(BOOL)DeviceIsIphoneFive { return ([[UIScreen mainScreen] bounds].size.height > Iphone5Height)?YES:NO;}

-(void)RegisterDeviceForRemoteNotification
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
}
-(void)CancelAllNotification
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}
-(void)DeleteAllBadgeCounter
{
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
}
-(void)RegisterDeviceForRemoteNotificationWithBadgeCounter:(BOOL)DisableBadgeCounter WithRemoveAllNotification:(BOOL)RemoveAllNotification
{
    [self RegisterDeviceForRemoteNotification];
    if (DisableBadgeCounter)
        [self CancelAllNotification];
    if (RemoveAllNotification)
        [self DeleteAllBadgeCounter];
}
-(NSString * const)FilterUserDevicetokenWithdevicetoken:(NSString *)UserDeviceToken{
    
    return [[[UserDeviceToken stringByReplacingOccurrencesOfString:@"<"withString:@""]
              stringByReplacingOccurrencesOfString:@">" withString:@""]
              stringByReplacingOccurrencesOfString: @" " withString: @""];
}
-(void)SetUserDevicetokenWithDeviceToken:(NSString *)UserDeviceToken;
{
    NSUserDefaults *UserDefaults = PMUGlobalAccess.DecleareUserDefaults;
    [UserDefaults setObject:UserDeviceToken forKey:PMUGlobalAccess.UserDevicetokenString];
    [UserDefaults synchronize];
}
-(NSString * const)GetUserDeviceToken
{
    NSUserDefaults *UserDefaults = PMUGlobalAccess.DecleareUserDefaults;
    return [UserDefaults objectForKey:PMUGlobalAccess.UserDevicetokenString];
}
+(NSUserDefaults * const)DecleareUserDefaults {
    NSUserDefaults *DefineUserDefaults = [NSUserDefaults standardUserDefaults];
    return DefineUserDefaults;
}

/*
 *  Frame
 */

+(float const)LoaderXposition { return AppLoaderXcord; }
+(float const)LoaderYposition { return AppLoaderYcord; }
+(float const)LoaderWidth { return AppLoaderWidth; }
+(float const)LoaderHeight { return AppLoaderHeight; }

/*
 Fonts
 */

+(NSString * const)GlobalFontName { return GlobalFontName; }

@end
