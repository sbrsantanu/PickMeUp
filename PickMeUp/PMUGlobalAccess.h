//
//  PMUGlobalAccess.h
//  PickMeUp
//
//  Created by Santanu.Adhikary@sbr-technologies.com on 04/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMUGlobalAccess : NSObject

/*
 *  Global Color Decleration
*/
/*
*/
+(UIColor * const)GlobalBckgroundColor;

/*
 *  Global Image name decleration
*/
/*
 */
+(NSString * const)GlobalBckgroundImage;
/*
 */
+(NSString * const)APPLogoIcon;
/*
 */
+(NSString * const)APPBackgroundImage;
/*
 */
+(NSString * const)APPLoaderIcon;
/*
 */
+(NSString * const)APPSelectedCheckboxIcon;
/*
 */
+(NSString * const)APPUnSelectedCheckboxIcon;

/*
 *  All global strings
 */
/*
 */
+(NSString * const)UserDevicetokenString;
/*
 */
+(NSAttributedString * const)LoginScreenEmailTextFieldPlaceholderString;
/*
 */
+(NSAttributedString * const)LoginScreenPasswordTextFieldPlaceholderString;

/*
 *  Global Methods
*/

-(void)RegisterDeviceForRemoteNotification;
/*
 */
-(void)CancelAllNotification;
/*
 */
-(void)DeleteAllBadgeCounter;
/*
 */
-(void)RegisterDeviceForRemoteNotificationWithBadgeCounter:(BOOL)DisableBadgeCounter WithRemoveAllNotification:(BOOL)RemoveAllNotification;
/*
 */
+(BOOL)DeviceIsIphoneFive;
/*
 */
-(NSString * const)FilterUserDevicetokenWithdevicetoken:(NSString *)UserDeviceToken;
/*
 */
-(void)SetUserDevicetokenWithDeviceToken:(NSString *)UserDeviceToken;
/*
 */
-(NSString * const)GetUserDeviceToken;
/*
 */
+(NSUserDefaults * const)DecleareUserDefaults;

/*
 *  All NibName
 */
/*
 */
+(NSString *)MainViewScreen;
/*
 */
+(NSString *)LoginViewScreen;
/*
 */
+(NSString *)RegistrationViewScreen;
/*
 */
+(NSString *)ForgetPasswordViewScreen;

/*
 *  Frame
*/
/*
 */
+(float const)LoaderXposition;
/*
 */
+(float const)LoaderYposition;
/*
 */
+(float const)LoaderWidth;
/*
 */
+(float const)LoaderHeight;

@end
