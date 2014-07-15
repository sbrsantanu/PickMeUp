//
//  PMULoginViewController.h
//  PickMeUp
//
//  Created by Mac on 04/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMUGlobalMethods.h"

@interface PMULoginViewController : PMUGlobalMethods

@end


@interface NSError (FHSTwitterEngine)

+ (NSError *)badRequestError;
+ (NSError *)noDataError;
+ (NSError *)imageTooLargeError;

@end