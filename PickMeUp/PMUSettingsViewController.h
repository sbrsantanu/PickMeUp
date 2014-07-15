//
//  PMUSettingsViewController.h
//  PickMeUp
//
//  Created by Mac on 10/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMUGlobalMethods.h"
#import <CoreLocation/CoreLocation.h>
@interface PMUSettingsViewController : PMUGlobalMethods <UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>

@end
