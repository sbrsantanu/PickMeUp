//
//  PMURegistrationViewController.m
//  PickMeUp
//
//  Created by Mac on 04/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "PMURegistrationViewController.h"
#import "PMUGlobalAccess.h"
#import "PMULoginViewController.h"

@interface PMURegistrationViewController () <UITextFieldDelegate,UIAlertViewDelegate,UIScrollViewDelegate>

@end

@implementation PMURegistrationViewController

@synthesize SignUpUIScrollViewMainScroll            =   _SignUpUIScrollViewMainScroll;
@synthesize SignUpViewUITextFieldUserFullName       =   _SignUpViewUITextFieldUserFullName;
@synthesize SignUpViewUITextFieldUserEmail          =   _SignUpViewUITextFieldUserEmail;
@synthesize SignUpViewUITextFieldUserCity           =   _SignUpViewUITextFieldUserCity;
@synthesize SignUpViewUITextFieldUserPhoneNumber    =   _SignUpViewUITextFieldUserPhoneNumber;
@synthesize SignUpViewUITextFieldUserPassword       =   _SignUpViewUITextFieldUserPassword;
@synthesize SignUpViewUITextFieldUserConfirmPassword=   _SignUpViewUITextFieldUserConfirmPassword;
@synthesize BlurView                                 = _BlurView;
@synthesize BlurView1                                = _BlurView1;
@synthesize LoginViewUIButtonDoLogin                 = _LoginViewUIButtonDoLogin;
@synthesize LoginViewUIButtonDoSignup               = _LoginViewUIButtonDoSignup;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self = [super initWithNibName:PMUGlobalAccess.RegistrationViewScreen bundle:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginbg.png"]]];
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
    
    /*
     */
    
    [_LoginViewUIButtonDoLogin addTarget:self action:@selector(GoToLogin:) forControlEvents:UIControlEventTouchUpInside];
    /*
     */
    
    [_LoginViewUIButtonDoSignup addTarget:self action:@selector(DoSignup:) forControlEvents:UIControlEventTouchUpInside];
    
}
/*
 */

-(IBAction)DoSignup:(id)sender
{
    PMULoginViewController *LoginViewController = [[PMULoginViewController alloc] init];
    [self GotoDifferentViewWithAnimation:LoginViewController];
}
/*
 */

-(IBAction)GoToLogin:(id)sender
{
    PMULoginViewController *LoginViewController = [[PMULoginViewController alloc] init];
    [self GotoDifferentViewWithAnimation:LoginViewController];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
