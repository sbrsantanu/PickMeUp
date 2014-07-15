//
//  PMUEditProfileViewController.m
//  PickMeUp
//
//  Created by Mac on 15/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "PMUEditProfileViewController.h"
#import "PMUSettingsViewController.h"

@interface PMUEditProfileViewController ()<UIScrollViewDelegate,UITextFieldDelegate>

@end

@implementation PMUEditProfileViewController
@synthesize BlurView                                 = _BlurView;
@synthesize BlurView1                                = _BlurView1;
@synthesize SignUpUIScrollViewMainScroll            =   _SignUpUIScrollViewMainScroll;

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
    
    [self.navigationController setNavigationBarHidden:YES];
    [_BlurView.layer setOpacity:0.5f];
    [_BlurView1.layer setBorderWidth:1.0f];
    [_BlurView1.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [_BlurView1.layer setCornerRadius:2.25f];
    
    [_SignUpUIScrollViewMainScroll setDelegate:self];
    [_SignUpUIScrollViewMainScroll setBackgroundColor:[UIColor clearColor]];
    [_SignUpUIScrollViewMainScroll setScrollEnabled:YES];
    [_SignUpUIScrollViewMainScroll setUserInteractionEnabled:YES];
    [_SignUpUIScrollViewMainScroll setPagingEnabled:NO];
    
    NSArray *LabelArray         = @[@775,@778];
    NSArray *LabelColoreArray   = [[NSArray alloc] initWithObjects:UIColorFromRGB(0xe3b305),UIColorFromRGB(0xe3b305), nil];
    NSArray *LabelFontArray     = [[NSArray alloc] initWithObjects:@"OpenSans-Semibold",@"OpenSans-Semibold", nil];
    NSArray *LabelFontSizeArray = @[@20, @14];
    
    [self ChangeUILabelFontWithColor:LabelColoreArray WithLabels:LabelArray WithFontname:LabelFontArray WithSize:LabelFontSizeArray WithViewName:_BlurView1];
    
    
    for(id aSubView in [_BlurView1 subviews]){
        if([aSubView isKindOfClass:[UITextField class]]) {
            [aSubView setDelegate:self];
        }
    }
    [self AssignUITextFieldAttributeOnSubviewWithView:_BlurView1];
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    PMUAPPPRINTMETHOD();
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    PMUAPPPRINTMETHOD();
    [UIView animateWithDuration:0.5f animations:^(void){
        [_SignUpUIScrollViewMainScroll setContentOffset:CGPointMake(0, 0)];
    } completion:^(BOOL finished){
        [textField resignFirstResponder];
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    PMUAPPPRINTMETHOD();
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    PMUAPPPRINTMETHOD();
    [UIView animateWithDuration:0.5f animations:^(void){
        __block float FrameYposition = 0.0f;
        switch (textField.tag) {
            case 99:FrameYposition  =   50.0f;  break;
            case 100:FrameYposition =   70.0f;  break;
            case 101:FrameYposition =   90.0f;  break;
            case 102:FrameYposition =   110.0f; break;
            case 103:FrameYposition =   130.0f; break;
            case 104:FrameYposition =   150.0f; break;
            default:FrameYposition  =   FrameYposition;
        }
        [_SignUpUIScrollViewMainScroll setContentOffset:CGPointMake(_SignUpUIScrollViewMainScroll.frame.origin.x, _SignUpUIScrollViewMainScroll.frame.origin.y+FrameYposition)];
    } completion:nil];
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
