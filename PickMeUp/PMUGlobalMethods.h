//
//  PMUGlobalMethods.h
//  PickMeUp
//
//  Created by Santanu.Adhikary@sbr-technologies.com on 04/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import <UIKit/UIKit.h>

id removeNull(id rootObject);

@interface PMUGlobalMethods : UIViewController  <UIAlertViewDelegate>
{
//  @Instance variables
//    - also known as ivars, are variables intended to be used inside of the class.
    
    UIImage *image;
    UIImageView *loadingView;
}

/*
 @property 
 - offers a way to define the information that a class is intended to encapsulate. If you declare an object/variable using @property, then that object/variable will be accessible to other classes importing its class.
 @atomic 
 - is the default behavior. If an object is declared as atomic then it becomes thread-safe. Thread-safe means, at a time only one thread of a particular instance of that class can have the control over that object.
 @nonatomic
 - Nonatomic means multiple thread access the variable(dynamic type).
 - Nonatomic is thread unsafe. -but it is fast in performance
 - Nonatomic is NOT default behavior,we need to add nonatomic keyword in property attribute.
 - it may result in unexpected behavior, when two different process (threads) access the same variable at the same time.
 @retain
 - is required when the attribute is a pointer to an object.
 The setter method will increase retain count of the object, so that it will occupy memory in autorelease pool.
 @copy 
 - If you use copy, you can't use retain. Using copy instance of the class will contain its own copy.
 Even if a mutable string is set and subsequently changed, the instance captures whatever value it has at the time it is set. No setter and getter methods will be synthesized.
 @readonly 
 - If you don't want to allow the property to be changed via setter method, you can declare the property readonly.
 Compiler will generate a getter, but not a setter.
 @assign 
 - will generate a setter which assigns the value to the instance variable directly, rather than copying or retaining it. This is best for primitive types like NSInteger and CGFloat, or objects you don't directly own, such as delegates.
 Keep in mind retain and assign are basically interchangeable when garbage collection is enabled.
*/

@property (nonatomic,weak) NSTimer                                   *IndecaterTime;

@property (nonatomic,retain) IBOutlet UIScrollView                   *LoginViewUIScrollViewMainScroll;
@property (nonatomic,retain) IBOutlet UITextField                    *LoginViewUITextFieldUserEmail;
@property (nonatomic,retain) IBOutlet UITextField                    *LoginViewUITextFieldUserPassword;
@property (nonatomic,retain) IBOutlet UIButton                       *LoginViewUIButtonDoLogin;
@property (nonatomic,retain) IBOutlet UIButton                       *LoginViewUIButtonDoForgetPassword;
@property (nonatomic,retain) IBOutlet UIButton                       *LoginViewUIButtonDoSignup;

@property (nonatomic,retain) IBOutlet UIScrollView                   *SignUpUIScrollViewMainScroll;
@property (nonatomic,retain) IBOutlet UITextField                    *SignUpViewUITextFieldUserFullName;
@property (nonatomic,retain) IBOutlet UITextField                    *SignUpViewUITextFieldUserEmail;
@property (nonatomic,retain) IBOutlet UITextField                    *SignUpViewUITextFieldUserPhoneNumber;
@property (nonatomic,retain) IBOutlet UITextField                    *SignUpViewUITextFieldUserPassword;
@property (nonatomic,retain) IBOutlet UITextField                    *SignUpViewUITextFieldUserConfirmPassword;
@property (nonatomic,retain) IBOutlet UITextField                    *SignUpViewUITextFieldUserCity;

@property (nonatomic,retain) IBOutlet UIView *BlurView;
@property (nonatomic,retain) IBOutlet UIView *BlurView1;

- (void)startSpin;
- (void)stopSpin;
- (void)GotoDifferentViewWithAnimation:(UIViewController *)ViewControllerName;
- (void)AssignUITextFieldAttributeOnSubviewWithView:(UIView *)AttributedSubview;
-(void)ChangeUILabelFontWithColor:(NSArray *)Color WithLabels:(NSArray *)Labels WithFontname:(NSArray *)Fontname WithSize:(NSArray *)Size WithViewName:(UIView *)ViewName;
- (BOOL) isKeyboardOnScreen;
-(NSString *)CleanTextField:(NSString *)TextfieldName;
-(BOOL)ValidateEmail:(NSString *)EmailValue;
-(BOOL)ValidateSpecialCharacter:(NSString *)DataValue;
-(BOOL)validatePhone:(NSString*)phone;
-(void)ShowAlertWithTitle:(NSString *)Title WithMessage:(NSString *)Message WithTag:(int)Tag;
-(NSDictionary *)GenerateParamValueForSubmit:(NSArray *)ParamArray FieldArray:(NSArray *)FieldArray;
-(NSString *)CallURLForServerReturn: (NSMutableDictionary *)TotalData URL:(NSString *)UrlType;
@end

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
/*
 * handelURLConnection cless is made for handle url connection using the delegate method.
 * handelURLConnection class will esposible for fetch data and will send local notification to the
 * parent class from where this class is accessing
 *
 */

@class handelURLConnection;

@protocol HnadleNsUrlConnectionDelegate <NSObject>

@required

- (void)HnadleNsUrlConnection:(handelURLConnection *)myObj json:(NSDictionary *)json;
- (void)HnadleNsUrlConnectionErr:(handelURLConnection *)myObj Errdata:(NSError *)Errdata;

@end

@interface handelURLConnection : NSObject {
    __weak id <HnadleNsUrlConnectionDelegate> _delegate;
}

@property (nonatomic, weak) id <HnadleNsUrlConnectionDelegate> delegate;

- (void)getValuFromURL:(NSString *)url;
- (void)getValuFromURLWithPost:(NSString *)ParamDictionary URLFOR:(NSString *)URLFOR;
@end
