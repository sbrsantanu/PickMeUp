//
//  PMUUserLocationViewController.h
//  PickMeUp
//
//  Created by Mac on 07/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PMUGlobalMethods.h"

@interface PMUUserLocationViewController : PMUGlobalMethods <MKMapViewDelegate,CLLocationManagerDelegate,MKAnnotation,UIAlertViewDelegate>
{
    /*
     */
    CLLocationManager   *CoreLocationManager;
    /*
     */
    CLLocation          *CoreLocation;
    /*
     */
    CLLocationCoordinate2D UserCoordinate;
}
/*
 */
@property (nonatomic,retain) IBOutlet MKMapView *UserCurrentLocationMapView;
/*
 */
@property (nonatomic,retain) IBOutlet UIButton *PickMeUpButton;
/*
 */
@end
