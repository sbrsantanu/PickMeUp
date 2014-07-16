//
//  PMUViewController.m
//  PickMeUp
//
//  Created by Santanu.Adhikary@sbr-technologies.com on 04/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "PMUViewController.h"
#import "PMUGlobalAccess.h"
#import "PMULoginViewController.h"
#import "PMUUserLocationViewController.h"
#import "PMURegistrationViewController.h"
#import "Reachability.h"
#import "PMURatingViewController.h"

/*
 */
@interface PMUViewController ()

@end
/*
 */
@implementation PMUViewController
/*
 */
@synthesize IndecaterTime               = _IndecaterTime;
/*
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"SScreen.png"]]];
    
    [self startSpin];
    
    _IndecaterTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(StopAnimatingLoaderAndRedirect) userInfo:nil repeats:NO];
}
/*
 */
-(void)StopAnimatingLoaderAndRedirect {
    [UIView animateWithDuration:1 animations:^(void){
        [self stopSpin];
    } completion:^(BOOL finished){
        
        NSUserDefaults *Userdata = [NSUserDefaults standardUserDefaults];
        NSString *UserId = [Userdata objectForKey:@"LogedinUserId"];
        
        if ([UserId intValue] > 0) {
            PMUUserLocationViewController *UserLocation = [[PMUUserLocationViewController alloc] init];
            //PMURatingViewController *UserLocation = [[PMURatingViewController alloc] init];
            [self GotoDifferentViewWithAnimation:UserLocation];
        } else {
            PMULoginViewController *LoginViewController = [[PMULoginViewController alloc] init];
            [self GotoDifferentViewWithAnimation:LoginViewController];
        }
    }];
}

/*
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
