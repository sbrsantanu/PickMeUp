//
//  PMURatingViewController.m
//  PickMeUp
//
//  Created by Mac on 15/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "PMURatingViewController.h"
#import "PMUUserLocationViewController.h"

@interface PMURatingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) IBOutlet UITableView *DriverDetails;
@property (nonatomic,retain) IBOutlet UIView *ThankyouView;
@property (nonatomic,retain) NSArray *SectionArray;
@property (nonatomic,retain) NSArray *UserDetailsArray;

@end

@implementation PMURatingViewController

@synthesize DriverDetails       = _DriverDetails;
@synthesize SectionArray        = _SectionArray;
@synthesize UserDetailsArray    = _UserDetailsArray;
@synthesize ThankyouView        = _ThankyouView;


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
    
    [_DriverDetails setDelegate:self];
    [_DriverDetails setDataSource:self];
    
    _SectionArray = [[NSArray alloc] initWithObjects:@"Driver Name",@"Driver Email",@"Driver Phone",@"taxi Number",@"Licence Number",@"Experience",@"Approximate Time",@"Approximate Distance",@"Love Our Service", nil];
    
    _UserDetailsArray = [[NSArray alloc] initWithObjects:@"Pinaki Dutta",@"pinaki@sbgr-technologies.com",@"+918820324338",@"WB12356",@"SBR1452",@"10 Years",@"12 Mints",@"1 Km",@"", nil];
}
-(IBAction)GoToSettings:(id)sender
{
    PMUUserLocationViewController *Settings = [[PMUUserLocationViewController alloc] init];
    [self GotoDifferentViewWithAnimation:Settings];
}
-(IBAction)RatingButtonClicked:(UIButton *)sender
{
    for (int k=1; k <= [sender tag]; k++) {
        
        UIView   *StarButtonSuperView   = (UIView *)[self.view viewWithTag:[sender.superview tag]];
        UIButton *StarButton = (UIButton *)[StarButtonSuperView viewWithTag:k];
        
        [StarButton setBackgroundImage:[UIImage imageNamed:@"starsel_BG.png"] forState:UIControlStateSelected];
        [StarButton setBackgroundImage:[UIImage imageNamed:@"starsel_BG.png"] forState:UIControlStateNormal];
        [StarButton setBackgroundImage:[UIImage imageNamed:@"starsel_BG.png"] forState:UIControlStateHighlighted];
    }
    
    for (int L=([sender tag]+1); L <= 5; L++) {
        
        UIView   *StarButtonSuperView   = (UIView *)[self.view viewWithTag:[sender.superview tag]];
        UIButton *StarButton = (UIButton *)[StarButtonSuperView viewWithTag:L];
        
        [StarButton setBackgroundImage:[UIImage imageNamed:@"star_BG.png"] forState:UIControlStateSelected];
        [StarButton setBackgroundImage:[UIImage imageNamed:@"star_BG.png"] forState:UIControlStateNormal];
        [StarButton setBackgroundImage:[UIImage imageNamed:@"star_BG.png"] forState:UIControlStateHighlighted];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma tableview Data Content

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section ==8)?100.0f:50.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section == 8)?50.0f:30.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (section == 6 || section ==7)?80.0f:0.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *FooterView = [[UIView alloc] init];
    UIView *FooterViewone = [[UIView alloc] init];
    UILabel *result = [[UILabel alloc] init];
    [result setNumberOfLines:0];
    [result setTextAlignment:NSTextAlignmentRight];
    [result setFont:[UIFont fontWithName:@"OpenSans" size:10.0f]];
    result.backgroundColor = [UIColor clearColor];
    [FooterViewone addSubview:result];
    
    
    switch (section) {
        case 6:
            [FooterViewone setFrame:CGRectMake(10, 0, 300, 30)];
            [FooterView addSubview:FooterViewone];
            [result setFrame:CGRectMake(10, 0, 300, 90)];
            [result setText:@"This is not actual time, it's calculated when driver accepted the request. Still it will depend on road condition and traffic condition."];
            break;
        case 7:
            [FooterViewone setFrame:CGRectMake(10, 30, 300, 30)];
            [FooterView addSubview:FooterViewone];
            [FooterViewone setBackgroundColor:[UIColor blackColor]];
            [result setFrame:CGRectMake(0, 0, 300, 30)];
            [result setTextAlignment:NSTextAlignmentCenter];
            [result setTextColor:UIColorFromRGB(0xe6b917)];
            [result setFont:[UIFont fontWithName:@"OpenSans" size:20.0f]];
            [result setText:@"THANK YOU"];
            break;
    }
    return FooterView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_DriverDetails deselectRowAtIndexPath:indexPath animated:YES];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_SectionArray objectAtIndex:section];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_SectionArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tableCell = [[UITableViewCell alloc] init];
    
    if (indexPath.section == 8) {
        
        [_ThankyouView setFrame:CGRectMake(10, 0, _ThankyouView.layer.frame.size.width, _ThankyouView.layer.frame.size.height)];
        
        for (int i = 1; i<=5; i++) {
            
            UIButton *ButtonRating = (UIButton *)[_ThankyouView viewWithTag:i];
            [ButtonRating addTarget:self action:@selector(RatingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [tableCell.contentView addSubview:_ThankyouView];
        
    } else {
        [tableCell.textLabel setText:[_UserDetailsArray objectAtIndex:indexPath.section]];
        [tableCell.textLabel setFont:[UIFont fontWithName:@"OpenSans" size:12.0f]];
        [tableCell.textLabel setNumberOfLines:0];
    }
    return tableCell;
}
@end
