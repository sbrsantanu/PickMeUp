//
//  PMUAppDelegate.h
//  PickMeUp
//
//  Created by Santanu.Adhikary@sbr-technologies.com on 04/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMUGlobalAccess.h"
/*
 */
@class PMUViewController;
/*
 */
@interface PMUAppDelegate : UIResponder <UIApplicationDelegate>
/*
 */
@property (strong, nonatomic) UIWindow *window;
/*
 */
@property (nonatomic,retain) UINavigationController *NavigationController;
/*
 */
@property (strong, nonatomic) PMUViewController *viewController;
/*
 */
@property (nonatomic,weak) PMUGlobalAccess *GlobalAccess;
/*
 */
@property (nonatomic,strong) NSString * deviceTokenString;
/*
 */
-(void)SignOutFromAccount;
@end
