//
//  PMURatingViewController.m
//  PickMeUp
//
//  Created by Mac on 15/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "PMURatingViewController.h"

@interface PMURatingViewController ()

@end

@implementation PMURatingViewController

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
    
    
    for (int i = 1; i<=5; i++) {
        
        UIButton *ButtonRating = (UIButton *)[self.view viewWithTag:i];
        [ButtonRating addTarget:self action:@selector(RatingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
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

@end
