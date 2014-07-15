//
//  PMUTOSViewController.m
//  PickMeUp
//
//  Created by Mac on 15/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "PMUTOSViewController.h"
#import "PMUSettingsViewController.h"

@interface PMUTOSViewController ()

@end

@implementation PMUTOSViewController

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
    
    UILabel *Headinglabel = (UILabel *)[self.view viewWithTag:101];
    [Headinglabel setFont:[UIFont fontWithName:GLOBALTEXTFONT_Title size:14.0f]];
    
    UITextView *MainTextView = (UITextView *)[self.view viewWithTag:100];
    [MainTextView setFont:[UIFont fontWithName:@"OpenSans" size:12.0f]];
    [MainTextView setTextAlignment:NSTextAlignmentJustified];
    [MainTextView setText:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."];
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
