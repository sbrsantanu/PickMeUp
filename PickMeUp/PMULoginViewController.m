//
//  PMULoginViewController.m
//  PickMeUp
//
//  Created by Mac on 04/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "PMULoginViewController.h"
#import "PMUGlobalAccess.h"
#import "PMUForgetPasswordViewController.h"
#import "PMURegistrationViewController.h"
#import "PMUUserLocationViewController.h"
#import "Reachability.h"

@interface PMULoginViewController () <UITextFieldDelegate,UIAlertViewDelegate,UIScrollViewDelegate,HnadleNsUrlConnectionDelegate>
{
    NSMutableData *webResponseData;
    handelURLConnection *AppHandelURLConnection;
}

@property (nonatomic,retain) NSOperationQueue *MainWebserviceQue;
@end

@implementation PMULoginViewController

// Synthesize of those property decleared in GlobalMethods

@synthesize LoginViewUIScrollViewMainScroll          = _LoginViewUIScrollViewMainScroll;
@synthesize LoginViewUIButtonDoForgetPassword        = _LoginViewUIButtonDoForgetPassword;
@synthesize LoginViewUIButtonDoLogin                 = _LoginViewUIButtonDoLogin;
@synthesize LoginViewUIButtonDoSignup                = _LoginViewUIButtonDoSignup;
@synthesize BlurView                                 = _BlurView;
@synthesize BlurView1                                = _BlurView1;
@synthesize MainWebserviceQue                        = _MainWebserviceQue;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self = [super initWithNibName:PMUGlobalAccess.LoginViewScreen bundle:nil];
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
    
    AppHandelURLConnection = [[handelURLConnection alloc] init];
    
    _MainWebserviceQue = [NSOperationQueue new];
    
    UITextField *LoginTextFieldEmail = (UITextField *)[self.view viewWithTag:12];
    UITextField *LogintextFieldPassword = (UITextField *)[self.view viewWithTag:13];
    [LoginTextFieldEmail setDelegate:self];
    [LogintextFieldPassword setDelegate:self];
    
    [self AssignUITextFieldAttributeOnSubviewWithView:_BlurView1];
    
    NSArray *LabelArray         = @[@775, @776, @777, @778];
    NSArray *LabelColoreArray   = [[NSArray alloc] initWithObjects:UIColorFromRGB(0xe3b305),[UIColor lightGrayColor],UIColorFromRGB(0xe3b305),UIColorFromRGB(0xe3b305), nil];
    NSArray *LabelFontArray     = [[NSArray alloc] initWithObjects:@"OpenSans-Semibold",@"OpenSans",@"OpenSans-Semibold",@"OpenSans", nil];
    NSArray *LabelFontSizeArray = @[@25, @10, @14, @12];
    
    [self ChangeUILabelFontWithColor:LabelColoreArray WithLabels:LabelArray WithFontname:LabelFontArray WithSize:LabelFontSizeArray WithViewName:_BlurView1];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginbg.png"]]];
    
    [_LoginViewUIScrollViewMainScroll setDelegate:self];
    [_LoginViewUIScrollViewMainScroll setUserInteractionEnabled:YES];
    [_LoginViewUIScrollViewMainScroll setScrollEnabled:YES];
    [_LoginViewUIScrollViewMainScroll setPagingEnabled:NO];
    [_LoginViewUIScrollViewMainScroll setScrollsToTop:YES];
    [_LoginViewUIScrollViewMainScroll setBackgroundColor:[UIColor clearColor]];
    
    /*
     */
    
    [_LoginViewUIButtonDoLogin addTarget:self action:@selector(DoLogin:) forControlEvents:UIControlEventTouchUpInside];
    /*
     */
    
    [_LoginViewUIButtonDoForgetPassword addTarget:self action:@selector(RecoverPassword:) forControlEvents:UIControlEventTouchUpInside];
    /*
     */
    
    [_LoginViewUIButtonDoSignup addTarget:self action:@selector(GoToSignup:) forControlEvents:UIControlEventTouchUpInside];
}

/*
 */

-(IBAction)DoLogin:(id)sender
{
    
    BOOL ValidationStatus = true;
    
    UITextField *LoginTextFieldEmail    = (UITextField *)[self.view viewWithTag:12];
    UITextField *LogintextFieldPassword = (UITextField *)[self.view viewWithTag:13];
    
    Reachability *hostReachability = [Reachability reachabilityWithHostName:WEBSERVICEURL];
    NetworkStatus hostStatus = [hostReachability currentReachabilityStatus];
    
    NSLog(@"hostStatus ==== %ld",hostStatus);
    
    if (![self CleanTextField:[LoginTextFieldEmail text]].length>0)
    {
        ValidationStatus = false;
        [self ShowAlertWithTitle:@"Validation Error" WithMessage:@"Provide Email Please" WithTag:123];
        
    }
    else if([self ValidateEmail:[self CleanTextField:LoginTextFieldEmail.text]])
    {
        ValidationStatus = false;
        [self ShowAlertWithTitle:@"Validation Error" WithMessage:@"Provide Proper Email Please" WithTag:124];
        
    }
    else if (![self CleanTextField:[LogintextFieldPassword text]].length>0)
    {
        [self ShowAlertWithTitle:@"Validation Error" WithMessage:@"Password Please" WithTag:125];
        ValidationStatus = false;
        
    }
    else if([self CleanTextField:LogintextFieldPassword.text].length < 6 || [self CleanTextField:LogintextFieldPassword.text].length > 12)
    {
        [self ShowAlertWithTitle:@"Validation Error" WithMessage:@"Password length should be 6-12" WithTag:126];
        ValidationStatus = false;
        
    }
//    else if (hostStatus == NotReachable)
//    {
//        [self ShowAlertWithTitle:@"Network Connectivity Error" WithMessage:@"Please Check Your Internet Connection Once" WithTag:127];
//        ValidationStatus = false;
//    }
    if (ValidationStatus) {
        
        [self.view setUserInteractionEnabled:NO];
        [self startSpin];
        NSString *LOGIN_PARAM = @"email&^*^&password&^*^&service_type";
        NSArray *ParamArray = [LOGIN_PARAM componentsSeparatedByString:@"&^*^&"];
        NSArray *FieldArray = [[NSArray alloc] initWithObjects:[self CleanTextField:[LoginTextFieldEmail text]],[self CleanTextField:[LogintextFieldPassword text]],@"pickmeup_login",nil];
        NSDictionary *ParamDictionary = [self GenerateParamValueForSubmit:ParamArray FieldArray:FieldArray];
        NSString *GeneratedParam = [self CallURLForServerReturn:[ParamDictionary mutableCopy] URL:@"iosappservice.php"];
        [AppHandelURLConnection setDelegate:self];
        [AppHandelURLConnection getValuFromURLWithPost:GeneratedParam URLFOR:[NSString stringWithFormat:@"%@%@",WEBSERVICEURL,@"iosappservice.php"]];
    }
}

/*
 */

-(void)HnadleNsUrlConnection:(handelURLConnection *)myObj json:(NSDictionary *)ReturnedData {
    
    [self stopSpin];
    id parsed = removeNull(ReturnedData);
    @try {
        [self.view setUserInteractionEnabled:YES];
        NSLog(@"parsed --- %@",parsed);
        if ([[parsed objectForKey:@"status"] isEqualToString:@"success"]) {
            
            NSUserDefaults *GlobaluserDefault = [NSUserDefaults standardUserDefaults];
            [GlobaluserDefault setObject:[parsed objectForKey:@"user_id"] forKey:@"LogedinUserId"];
            [GlobaluserDefault synchronize];
            
            PMUUserLocationViewController *UserLocation = [[PMUUserLocationViewController alloc] init];
            [self GotoDifferentViewWithAnimation:UserLocation];
            
        } else {
            [self ShowAlertWithTitle:@"Error" WithMessage:[parsed objectForKey:@"error"] WithTag:118];
        }
    }
    @catch (NSException *exception) {
        [self.view setUserInteractionEnabled:YES];
        [self ShowAlertWithTitle:@"Error" WithMessage:[NSString stringWithFormat:@"%@",exception] WithTag:118];
    }
    @finally {
        [self.view setUserInteractionEnabled:YES];
    }
}

/*
 */
-(void)HnadleNsUrlConnectionErr:(handelURLConnection *)myObj Errdata:(NSError *)Errdata {
    
    [self.view setUserInteractionEnabled:YES];
    [self ShowAlertWithTitle:@"Error" WithMessage:[NSString stringWithFormat:@"%@",Errdata] WithTag:117];
}

/*
 */

-(IBAction)RecoverPassword:(id)sender
{
    PMUForgetPasswordViewController *LoginViewController = [[PMUForgetPasswordViewController alloc] init];
    [self GotoDifferentViewWithAnimation:LoginViewController];
}

/*
 */

-(IBAction)GoToSignup:(id)sender
{
    PMURegistrationViewController *LoginViewController = [[PMURegistrationViewController alloc] init];
    [self GotoDifferentViewWithAnimation:LoginViewController];
}

/*
 */

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/*
 */

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/*
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
 */
-(void)HideKeyboard
{
    for(id aSubView in [self.view subviews]){
        /*
         */
        if([aSubView isKindOfClass:[UITextField class]]) {
            
            /*
             */
            UITextField *textField=(UITextField*)aSubView;
            [textField resignFirstResponder];
        }
    }
}

/*
 Dealloc all alocated memory manually
 */

-(void)viewWillAppear:(BOOL)animated
{
    _LoginViewUIScrollViewMainScroll            = nil;
    _LoginViewUIButtonDoForgetPassword          = nil;
    _LoginViewUIButtonDoLogin                   = nil;
    _LoginViewUIButtonDoSignup                  = nil;
    for(id aSubView in [self.view subviews]){
        /*
         */
        if([aSubView isKindOfClass:[UITextField class]]) {
            
            /*
             */
            UITextField *textField=(UITextField*)aSubView;
            textField     = nil;
        }
    }
    [self HideKeyboard];
}

@end
