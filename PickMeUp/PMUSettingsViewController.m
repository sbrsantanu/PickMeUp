//
//  PMUSettingsViewController.m
//  PickMeUp
//
//  Created by Mac on 10/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "PMUSettingsViewController.h"
#import "PMUAppDelegate.h"
#import "PMUUserLocationViewController.h"
#import "PMUPrivacyViewController.h"
#import "PMUTOSViewController.h"
#import "PMUEditProfileViewController.h"
#import "PMUChangePassViewController.h"
#import "PMUUserDetailsViewController.h"

@interface PMUSettingsViewController ()
{
    NSArray *GeneralSettings,*ProfileSettings,*PrivacySettings,*LocationSettings,*GeneralInformation,*VersionInformation;
}
@property (nonatomic,retain) IBOutlet UITableView *SettingsTable;

@end

@implementation PMUSettingsViewController
@synthesize SettingsTable           = _SettingsTable;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIView *HeaderView = (UIView *)[self.view viewWithTag:99];
    UIImageView *HeaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 5, 120, 45)];
    [HeaderImageView setBackgroundColor:[UIColor clearColor]];
    [HeaderImageView setImage:[UIImage imageNamed:@"pmu"]];
    [HeaderView addSubview:HeaderImageView];
    
    UIButton *SettingsButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 13, 32, 32)];
    [SettingsButton setBackgroundImage:[UIImage imageNamed:@"arrow-left.png"] forState:UIControlStateNormal];
    [SettingsButton setBackgroundImage:[UIImage imageNamed:@"arrow-left.png"] forState:UIControlStateSelected];
    [SettingsButton setBackgroundImage:[UIImage imageNamed:@"arrow-left.png"] forState:UIControlStateHighlighted];
    [SettingsButton setBackgroundColor:[UIColor clearColor]];
    [SettingsButton setUserInteractionEnabled:YES];
    [SettingsButton addTarget:self action:@selector(GoToLanding:) forControlEvents:UIControlEventTouchUpInside];
    [HeaderView addSubview:SettingsButton];
    
    HeaderView.layer.masksToBounds = NO;
    HeaderView.layer.shadowOffset = CGSizeMake(0, 3);
    HeaderView.layer.shadowRadius = 5;
    HeaderView.layer.shadowOpacity = 0.5;
    
    [_SettingsTable setDelegate:self];
    [_SettingsTable setDataSource:self];
    
    GeneralSettings = [[NSArray alloc] initWithObjects:@"General Settings",@"Privacy Settings",@"Location Service",@"General Information",@"Version Summery",@"Destroy Session", nil];
    ProfileSettings = [[NSArray alloc] initWithObjects:@"View Profile",@"Edit Profile", nil];
    PrivacySettings = [[NSArray alloc] initWithObjects:@"Password Settings", nil];
    LocationSettings = [[NSArray alloc] initWithObjects:@"Location Service", nil];
    GeneralInformation = [[NSArray alloc] initWithObjects:@"General Information", nil];
    VersionInformation = [[NSArray alloc] initWithObjects:@"Version Information", nil];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tableCell = [[UITableViewCell alloc] init];
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                 [tableCell.textLabel setText:@"View Profile"];
            } else {
                [tableCell.textLabel setText:[ProfileSettings objectAtIndex:indexPath.row]];
            }
            break;
        case 1:
            [tableCell.textLabel setText:[PrivacySettings objectAtIndex:indexPath.row]];
            break;
        case 2:
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
                [tableCell.textLabel setText:@"Location Service disabled"];
            } else {
                [tableCell.textLabel setText:@"Location Service enabled"];
            }
            break;
        case 3:
            if (indexPath.row == 0) {
                [tableCell.textLabel setText:@"Terms & Services"];
            } else {
                [tableCell.textLabel setText:@"Privacy Policy"];
            }
            break;
        case 4:
            [tableCell.textLabel setText:@"Year introduced: 2013 \nCapacity: 8, 16 and 32 GB \nColors: white, blue, pink, green, yellow \nModel number on the back cover: A1532 or A1507 or A1529 \n\niPhone 5c (GSM model) A1532 or A1456 \niPhone 5c (CDMA model) A1516 or A1526 or A1529 \niPhone 5c (GSM model China) \n\nMore details: The front is flat and made of glass. The back is hard-coated polycarbonate (plastic). There's a SIM tray on the right side that holds a 'fourth form factor' (4FF) or nano-SIM card. The IMEI is etched on the back cover."];
            break;
        case 5:
            [tableCell.textLabel setText:@"Sign Out"];
             break;
        default:
            return 0;
            break;
    }
    [tableCell.textLabel setFont:[UIFont fontWithName:@"OpenSans" size:(indexPath.section == 4)?12.0f:14.0f]];
    [tableCell.textLabel setNumberOfLines:0];
    if (indexPath.section != 4 && indexPath.section !=2) {
       
        UIImage *ImageArrow = [UIImage imageNamed:@"arrow-left-new.png"];
        UIButton *accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [accessoryButton setBackgroundImage:ImageArrow forState:UIControlStateNormal];
        accessoryButton.frame = CGRectMake(0, 0, 22, 22);
        tableCell.accessoryView = accessoryButton;
        
    }
    if (indexPath.section == 2) {
        UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(250, 10, 0, 0)];
        [mySwitch setBackgroundColor:[UIColor clearColor]];
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
            [mySwitch setOn:NO];
        } else {
            [mySwitch setOn:YES];
        }
        [mySwitch setUserInteractionEnabled:NO];
        [tableCell.contentView addSubview:mySwitch];
    }
    return tableCell;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *FooterView = [[UIView alloc] init];
    UILabel *result = [[UILabel alloc] init];
    [result setNumberOfLines:0];
    [result setTextAlignment:NSTextAlignmentRight];
    [result setFont:[UIFont fontWithName:@"OpenSans" size:10.0f]];
    result.backgroundColor = [UIColor clearColor];
    [FooterView addSubview:result];
    switch (section) {
        case 0:
            [result setFrame:CGRectMake(10, 0, 300, 50)];
            [result setText:@"Messages is the only app with this option, so you can't apply it to your Twitter or Facebook apps. IMG_1090. Below is an alert on the left and a banner on."];
            break;
        case 1:
            [result setFrame:CGRectMake(10, 0, 300, 20)];
            [result setText:@"Change your password."];
            break;
        case 2:
            [result setFrame:CGRectMake(10, 0, 300, 90)];
            [result setText:@"You can set permission from your iphone settings only. This app is not provide you the provestion to access phone settings./n/nIf location service is disabled then you can't access most of the features of this app."];
        case 3:
            [result setFrame:CGRectMake(10, 0, 300, 90)];
            [result setText:@"You can set permission from your iphone settings only. This app is not provide you the provestion to access phone settings./n/nIf location service is disabled then you can't access most of the features of this app."];
            break;
        case 4:
            [result setFrame:CGRectMake(10, 0, 300, 50)];
            [result setText:@"App current version history."];
            break;
        case 5:
            [result setFrame:CGRectMake(10, 0, 300, 50)];
            [result setText:@"Sign Out from your account. It will destroy all current session data. Make sure before you signout."];
            break;
    }
    return FooterView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 50.0f;
            break;
        case 1:
            return 20.0f;
            break;
        case 2:
            return 80.0f;
            break;
        case 3:
            return 80.0f;
            break;
        case 4:
            return 50.0f;
            break;
        case 5:
            return 50.0f;
            break;
        default:
            return 0;
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_SettingsTable deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    PMUUserDetailsViewController *Terms = [[PMUUserDetailsViewController alloc] init];
                    [self GotoDifferentViewWithAnimation:Terms];
                    break;
                }
                case 1:
                {
                    PMUEditProfileViewController *EditProfile = [[PMUEditProfileViewController alloc] init];
                    [self GotoDifferentViewWithAnimation:EditProfile];
                    break;
                }
            }
            break;
        case 1:
            {
                PMUChangePassViewController *EditProfile = [[PMUChangePassViewController alloc] init];
                [self GotoDifferentViewWithAnimation:EditProfile];
                break;
            }
        case 2:
        {
                break;
        }
        case 3:
            switch (indexPath.row) {
                case 0:
                {
                    PMUTOSViewController *Terms = [[PMUTOSViewController alloc] init];
                    [self GotoDifferentViewWithAnimation:Terms];
                    break;
                }
                case 1:
                {
                    PMUPrivacyViewController *privacy = [[PMUPrivacyViewController alloc] init];
                    [self GotoDifferentViewWithAnimation:privacy];
                    break;
                }
            }
            break;
        case 5:
        {
            UIAlertView *SignoutAlert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Are you sure to signout" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Sign Out", nil];
            [SignoutAlert setTag:777];
            [SignoutAlert show];
            break;
        }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 50.0f;
            break;
        case 1:
            return 50.0f;
            break;
        case 2:
            return 50.0f;
            break;
        case 3:
            return 50.0f;
            break;
        case 4:
            return 300.0f;
            break;
        case 5:
            return 50.0f;
            break;
        default:
            return 0;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [ProfileSettings count];
            break;
        case 1:
            return [PrivacySettings count];
            break;
        case 2:
            return [LocationSettings count];
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 1;
            break;
        case 5:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [GeneralSettings objectAtIndex:section];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [GeneralSettings count];
}
-(IBAction)GoToLanding:(id)sender
{
    PMUUserLocationViewController *UserLocation = [[PMUUserLocationViewController alloc] init];
    [self GotoDifferentViewWithAnimation:UserLocation];
}

#pragma Uialertview protocol details

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 777) {
        
        if (buttonIndex == 1) {
            
            PMUAppDelegate *mainDelegate = (PMUAppDelegate *)[[UIApplication sharedApplication] delegate];
            [mainDelegate SignOutFromAccount];
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
