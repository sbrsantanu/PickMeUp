//
//  PMUForgetPasswordViewController.m
//  PickMeUp
//
//  Created by Mac on 04/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "PMUForgetPasswordViewController.h"
#import "PMUGlobalAccess.h"
#import "PMULoginViewController.h"

@interface PMUForgetPasswordViewController ()

@end

@implementation PMUForgetPasswordViewController
@synthesize BlurView            = _BlurView;
@synthesize BlurView1           = _BlurView1;
@synthesize LoginViewUIButtonDoLogin    = _LoginViewUIButtonDoLogin;
@synthesize LoginViewUIButtonDoForgetPassword   = _LoginViewUIButtonDoForgetPassword;
@synthesize LoginViewUITextFieldUserPassword    = _LoginViewUITextFieldUserPassword;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self = [super initWithNibName:PMUGlobalAccess.ForgetPasswordViewScreen bundle:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    [_BlurView.layer setOpacity:0.5f];
    [_BlurView1.layer setBorderWidth:1.0f];
    [_BlurView1.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [_BlurView1.layer setCornerRadius:2.25f];
    
    for(id aSubView in [_BlurView1 subviews]){
        if([aSubView isKindOfClass:[UITextField class]]) {
            [aSubView setDelegate:self];
        }
    }
    [self AssignUITextFieldAttributeOnSubviewWithView:_BlurView1];
    
    NSArray *LabelArray         = @[@775,@778];
    NSArray *LabelColoreArray   = [[NSArray alloc] initWithObjects:UIColorFromRGB(0xe3b305),UIColorFromRGB(0xe3b305), nil];
    NSArray *LabelFontArray     = [[NSArray alloc] initWithObjects:@"OpenSans-Semibold",@"OpenSans-Semibold", nil];
    NSArray *LabelFontSizeArray = @[@17.5, @14];
    
    [self ChangeUILabelFontWithColor:LabelColoreArray WithLabels:LabelArray WithFontname:LabelFontArray WithSize:LabelFontSizeArray WithViewName:_BlurView1];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginbg.png"]]];
    
    /*
     */
    
    [_LoginViewUIButtonDoLogin addTarget:self action:@selector(GoToLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    /*
     */
    
    [_LoginViewUIButtonDoForgetPassword addTarget:self action:@selector(DoForgetPassword:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

/*
 */

-(IBAction)DoForgetPassword:(id)sender
{
    
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
    [textField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    PMUAPPPRINTMETHOD();
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)dismissKeyboard {
    if ([self isKeyboardOnScreen]) {
        for(id aSubView in [_BlurView1 subviews]){
            if([aSubView isKindOfClass:[UITextField class]]) {
                [aSubView resignFirstResponder];
            }
        }
    }
}
@end
