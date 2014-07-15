//
//  PMUUserDetailsViewController.m
//  PickMeUp
//
//  Created by Mac on 15/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "PMUUserDetailsViewController.h"
#import "PMUSettingsViewController.h"

@interface PMUUserDetailsViewController ()
@property (nonatomic,retain) IBOutlet UITableView *UserDetailstable;
@property (nonatomic,retain) NSArray *DetailsArray;
@property (nonatomic,retain) NSArray *UserDataArray;
@end

@implementation PMUUserDetailsViewController
@synthesize UserDetailstable        = _UserDetailstable;
@synthesize DetailsArray            = _DetailsArray;
@synthesize UserDataArray           = _UserDataArray;

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
    [SettingsButton addTarget:self action:@selector(GoToSettings:) forControlEvents:UIControlEventTouchUpInside];
    [HeaderView addSubview:SettingsButton];
    
    HeaderView.layer.masksToBounds = NO;
    HeaderView.layer.shadowOffset = CGSizeMake(0, 3);
    HeaderView.layer.shadowRadius = 5;
    HeaderView.layer.shadowOpacity = 0.5;
    
    _DetailsArray = [[NSArray alloc] initWithObjects:@"Name",@"Email",@"Contact Number",@"City",@"Location Service", nil];
    _UserDataArray = [[NSArray alloc] initWithObjects:@"Santanu Das Adhikary",@"santanu@gmail.com",@"8820324338",@"Kolkata",@"Location Service Enabled", nil];
    [_UserDetailstable setDelegate:self];
    [_UserDetailstable setDataSource:self];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *TableCell = [[UITableViewCell alloc] init];
    [TableCell.textLabel setText:[_UserDataArray objectAtIndex:indexPath.section]];
    [TableCell.textLabel setFont:[UIFont fontWithName:@"OpenSans" size:12.0f]];
    [TableCell.textLabel setNumberOfLines:0];

    if (indexPath.section == 4) {
        UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(250, 10, 0, 0)];
        [mySwitch setBackgroundColor:[UIColor clearColor]];
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
            [mySwitch setOn:NO];
        } else {
            [mySwitch setOn:YES];
        }
        [mySwitch setUserInteractionEnabled:NO];
        [TableCell.contentView addSubview:mySwitch];
    }
    return TableCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_UserDetailstable deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 4:
            return 100.0f;
            break;
        default:
            return 0.0f;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_DetailsArray objectAtIndex:section];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_DetailsArray count];
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
            case 4:
            [result setFrame:CGRectMake(10, 0, 300, 90)];
            [result setText:@"You can set permission from your iphone settings only. This app is not provide you the provestion to access phone settings./n/nIf location service is disabled then you can't access most of the features of this app."];
            break;
            break;
    }
    return FooterView;
}
-(IBAction)GoToSettings:(id)sender
{
    PMUSettingsViewController *Settings = [[PMUSettingsViewController alloc] init];
    [self GotoDifferentViewWithAnimation:Settings];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
