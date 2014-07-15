//
//  PMUUserLocationViewController.m
//  PickMeUp
//
//  Created by Mac on 07/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "PMUUserLocationViewController.h"
#import "PMUGlobalAccess.h"
#import "PMUSettingsViewController.h"

@interface PMUUserLocationViewController ()
{
    BOOL firstLocationUpdate_;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

@end

@implementation PMUUserLocationViewController
/*
 */
@synthesize UserCurrentLocationMapView              = _UserCurrentLocationMapView;
/*
 */
@synthesize PickMeUpButton                          = _PickMeUpButton;

@synthesize BlurView                                 = _BlurView;
@synthesize BlurView1                                = _BlurView1;

/*
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
/*
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self RegisterDeviceForGetCurrentLocation];
    
    [self.navigationController setNavigationBarHidden:YES];
    [_BlurView.layer setOpacity:0.5f];
    [_BlurView1.layer setBorderWidth:1.0f];
    [_BlurView1.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [_BlurView1.layer setCornerRadius:2.25f];
    
    [_UserCurrentLocationMapView setDelegate:self];
    [_UserCurrentLocationMapView setUserInteractionEnabled:YES];
    [_UserCurrentLocationMapView setBackgroundColor:[UIColor clearColor]];
    [_UserCurrentLocationMapView setMapType:MKMapTypeStandard];
    [_UserCurrentLocationMapView setZoomEnabled:YES];
    
    [self ChangeUserLocation];
    
    UIView *HeaderView = (UIView *)[self.view viewWithTag:99];
    UIImageView *HeaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 5, 120, 45)];
    [HeaderImageView setBackgroundColor:[UIColor clearColor]];
    [HeaderImageView setImage:[UIImage imageNamed:@"pmu"]];
    [HeaderView addSubview:HeaderImageView];
    
    UIButton *SettingsButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 13, 32, 32)];
    [SettingsButton setBackgroundImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    [SettingsButton setBackgroundImage:[UIImage imageNamed:@"settings"] forState:UIControlStateSelected];
    [SettingsButton setBackgroundImage:[UIImage imageNamed:@"settings"] forState:UIControlStateHighlighted];
    [SettingsButton setBackgroundColor:[UIColor clearColor]];
    [SettingsButton setUserInteractionEnabled:YES];
    [SettingsButton addTarget:self action:@selector(GoToSettings:) forControlEvents:UIControlEventTouchUpInside];
    [HeaderView addSubview:SettingsButton];
    
    HeaderView.layer.masksToBounds = NO;
    HeaderView.layer.shadowOffset = CGSizeMake(0, 3);
    HeaderView.layer.shadowRadius = 5;
    HeaderView.layer.shadowOpacity = 0.5;
    
    [self.view bringSubviewToFront:HeaderView];
    
    [_PickMeUpButton addTarget:self action:@selector(PickmeUpOperation:) forControlEvents:UIControlEventTouchUpInside];
}
/*
 */
-(IBAction)GoToSettings:(id)sender
{
    NSLog(@"this haskd");
    PMUSettingsViewController *SettingsView = [[PMUSettingsViewController alloc] init];
    [self GotoDifferentViewWithAnimation:SettingsView];
}
/*
 */
-(IBAction)PickmeUpOperation:(id)sender
{
    @try {
        //
        PMUSettingsViewController *SettingsView = [[PMUSettingsViewController alloc] init];
        [self GotoDifferentViewWithAnimation:SettingsView];
        
    }
    @catch (NSException *exception) {
        UIAlertView *PickmeUpOperationAlert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"there is some error, Try again Later" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [PickmeUpOperationAlert show];
    }
}
/*
*/
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}
/*
 */
-(void)ChangeUserLocation
{
    float spanX = 0.00725;
    float spanY = 0.00725;
    MKCoordinateRegion region;
    region.center.latitude = UserCoordinate.latitude;
    region.center.longitude = UserCoordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    [_UserCurrentLocationMapView setRegion:region animated:YES];
    
    [geocoder reverseGeocodeLocation:CoreLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            
            [point setCoordinate:CLLocationCoordinate2DMake(UserCoordinate.latitude, UserCoordinate.longitude)];
            [point setTitle:[NSString stringWithFormat:@"%@,%@,%@",
                             placemark.subThoroughfare, placemark.thoroughfare,placemark.locality]];
            [point setSubtitle:[NSString stringWithFormat:@"%@,%@",placemark.subLocality,placemark.postalCode]];
            [_UserCurrentLocationMapView addAnnotation:point];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
/*
*/
    
   
}
/*
 */
-(void)RegisterDeviceForGetCurrentLocation
{
    CoreLocationManager = [[CLLocationManager alloc] init];
    geocoder            = [[CLGeocoder alloc] init];
    [CoreLocationManager setDelegate:self];
    [CoreLocationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [CoreLocationManager setDistanceFilter:kCLDistanceFilterNone];
    [CoreLocationManager startUpdatingLocation];
    
    CoreLocation = [CoreLocationManager location];
    UserCoordinate = [CoreLocation coordinate];
    
    NSLog(@"user lattitude ------ %f",UserCoordinate.latitude);
    NSLog(@"user longitude ------ %f",UserCoordinate.longitude);
    
}
/*
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CoreLocation = [locations objectAtIndex:0];
    [CoreLocationManager stopUpdatingLocation];
    UserCoordinate = [CoreLocation coordinate];
    
    NSLog(@"user lattitude ------ %f",UserCoordinate.latitude);
    NSLog(@"user longitude ------ %f",UserCoordinate.longitude);
    
    [self ChangeUserLocation];
    
}

/*
 */
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"There is some error while updating location ... err --- %@",[NSString stringWithFormat:@"%@",error]);
}
/*
 */
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [_UserCurrentLocationMapView setCenterCoordinate:userLocation.coordinate animated:YES];
}
/*
 */
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
}
/*
 */
-(void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    NSLog(@"Err ===%@",[NSString stringWithFormat:@"%@",error]);
}

/*
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
/*
 */

/*
 */

@end
