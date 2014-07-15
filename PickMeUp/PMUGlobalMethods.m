//
//  PMUGlobalMethods.m
//  PickMeUp
//
//  Created by Santanu.Adhikary@sbr-technologies.com on 04/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "PMUGlobalMethods.h"
#import "PMUGlobalAccess.h"

id removeNull(id rootObject) {
    
    if ([rootObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *sanitizedDictionary = [NSMutableDictionary dictionaryWithDictionary:rootObject];
        [rootObject enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            id sanitized = removeNull(obj);
            if (!sanitized) {
                [sanitizedDictionary setObject:@"" forKey:key];
            } else {
                [sanitizedDictionary setObject:sanitized forKey:key];
            }
        }];
        return [NSMutableDictionary dictionaryWithDictionary:sanitizedDictionary];
    }
    
    if ([rootObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *sanitizedArray = [NSMutableArray arrayWithArray:rootObject];
        [rootObject enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            id sanitized = removeNull(obj);
            if (!sanitized) {
                [sanitizedArray replaceObjectAtIndex:[sanitizedArray indexOfObject:obj] withObject:@""];
            } else {
                [sanitizedArray replaceObjectAtIndex:[sanitizedArray indexOfObject:obj] withObject:sanitized];
            }
        }];
        return [NSMutableArray arrayWithArray:sanitizedArray];
    }
    
    if ([rootObject isKindOfClass:[NSNull class]]) {
        return (id)nil;
    } else {
        return rootObject;
    }
}

@implementation PMUGlobalMethods

-(void)GotoDifferentViewWithAnimation:(UIViewController *)ViewControllerName {
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.25f;
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:ViewControllerName animated:NO];
    
}

#pragma mark Spin Button

- (void)startSpin
{
    if (!loadingView) {
        
        loadingView = [[UIImageView alloc] initWithFrame:CGRectMake(PMUGlobalAccess.LoaderXposition, PMUGlobalAccess.LoaderYposition, PMUGlobalAccess.LoaderWidth, PMUGlobalAccess.LoaderHeight)];
        loadingView.image = [UIImage imageNamed:PMUGlobalAccess.APPLoaderIcon];
        [self.view addSubview:loadingView];
        
    }
    
    loadingView.hidden = NO;
    [CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
	CGRect frame = [loadingView frame];
	loadingView.layer.anchorPoint = CGPointMake(0.5, 0.5);
	loadingView.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
	[CATransaction commit];
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
	[CATransaction setValue:[NSNumber numberWithFloat:2.0] forKey:kCATransactionAnimationDuration];
    
	CABasicAnimation *animation;
	animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	animation.fromValue = [NSNumber numberWithFloat:0.0];
	animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    animation.speed = 3.0f;
	animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
	animation.delegate = self;
	[loadingView.layer addAnimation:animation forKey:@"rotationAnimation"];
	[CATransaction commit];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)finished
{
	if (finished)
	{
		[self startSpin];
	}
}

- (void)stopSpin
{
    [loadingView.layer removeAllAnimations];
    loadingView.hidden = YES;
}

- (void)AssignUITextFieldAttributeOnSubviewWithView:(UIView *)AttributedSubview
{
    for(id aSubView in [AttributedSubview subviews]){
        /*
         */
        if([aSubView isKindOfClass:[UITextField class]]) {
            
            /*
             */
            UITextField *textField=(UITextField*)aSubView;
            /*
             */
            textField.layer.masksToBounds = YES;
            /*
             */
            textField.layer.borderColor   = [[UIColor lightGrayColor]CGColor];
            /*
             */
            textField.layer.borderWidth   = 0.5f;
            /*
             */
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
            textField.leftView = paddingView;
            textField.leftViewMode = UITextFieldViewModeAlways;
            
            /*
             */
            textField.font = [UIFont fontWithName:@"OpenSans" size:12];
            /*
             */
            textField.textColor = [UIColor lightGrayColor];
        }
    }
}

-(void)ChangeUILabelFontWithColor:(NSArray *)Color WithLabels:(NSArray *)Labels WithFontname:(NSArray *)Fontname WithSize:(NSArray *)Size WithViewName:(UIView *)ViewName
{
    for (int LabelTag = 0; LabelTag < [Labels count]; LabelTag++) {
        UILabel *LoginHeader = (UILabel *)[ViewName viewWithTag:[[Labels objectAtIndex:LabelTag] intValue]];
        [LoginHeader setTextColor:[Color objectAtIndex:LabelTag]];
        [LoginHeader setFont:[UIFont fontWithName:[Fontname objectAtIndex:LabelTag] size:[[Size objectAtIndex:LabelTag] floatValue]]];
    }
}

- (BOOL) isKeyboardOnScreen
{
    PMUAPPPRINTMETHOD();
    BOOL isKeyboardShown = NO;
    NSArray *windows = [UIApplication sharedApplication].windows;
    if (windows.count > 1) {
        NSArray *wSubviews =  [windows[1]  subviews];
        if (wSubviews.count) {
            CGRect keyboardFrame = [wSubviews[0] frame];
            CGRect screenFrame = [windows[1] frame];
            if (keyboardFrame.origin.y+keyboardFrame.size.height == screenFrame.size.height) {
                isKeyboardShown = YES;
            }
        }
    }
    return isKeyboardShown;
}

-(NSString *)CleanTextField:(NSString *)TextfieldName
{
    NSString *Cleanvalue = [TextfieldName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return Cleanvalue;
}
-(BOOL)ValidateEmail:(NSString *)EmailValue
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    NSString* CleanEmailValue = [self CleanTextField:EmailValue];
    if([emailTest evaluateWithObject:CleanEmailValue] == NO)
        return YES;
    else
        return NO;
}
-(BOOL)ValidateSpecialCharacter:(NSString *)DataValue
{
    NSCharacterSet *ALLOWEDCHARATERSET =[[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    NSString *Cleanvalue = [self CleanTextField:DataValue];
    if ([Cleanvalue rangeOfCharacterFromSet:ALLOWEDCHARATERSET].location != NSNotFound)
        return NO;
    else
        return YES;
}
-(BOOL)validatePhone:(NSString*)phone {
    if ([phone length] < 10) {
        return NO;
    }
    NSString *phoneRegex = @"^[0-9]{3}-[0-9]{3}-[0-9]{4}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return ![test evaluateWithObject:phone];
}
-(void)ShowAlertWithTitle:(NSString *)Title WithMessage:(NSString *)Message WithTag:(int)Tag {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:Title message:Message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView setTag:Tag];
    [alertView show];
}

-(NSDictionary *)executeFetch:(NSString *)query
{
    
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    return results;
}

-(NSDictionary *)GenerateParamValueForSubmit:(NSArray *)ParamArray FieldArray:(NSArray *)FieldArray {
    
    @try {
        
        NSMutableDictionary *ParamDictionary = [[NSMutableDictionary alloc] initWithCapacity:FieldArray.count];
        if (ParamArray.count > 0) {
            if(FieldArray.count >0) {
                for (int i = 0; i<ParamArray.count; i++) {
                    [ParamDictionary setObject:[FieldArray objectAtIndex:i] forKey:[ParamArray objectAtIndex:i]];
                }
            } else {
                NSLog(@"Field data is blank");
            }
        } else {
            NSLog(@"Param object is blank");
        }
        return ParamDictionary;
    }
    @catch (NSException *Exception) {
        NSLog(@"Err in ParamDictionary %@",Exception);
    }
}

-(NSString *)CallURLForServerReturn: (NSMutableDictionary *)TotalData URL:(NSString *)UrlType
{
    NSMutableString *URLstring = [[NSMutableString alloc]init];
    int i=0;
    for (id key in TotalData) {
        i++;
        id anObject = [TotalData objectForKey:key];
        if(i==TotalData.count)
            [URLstring appendString:[NSString stringWithFormat:@"%@=%@",key,[[self CleanTextField:anObject] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        else
            [URLstring appendString:[NSString stringWithFormat:@"%@=%@&",key,[[self CleanTextField:anObject] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
    NSString *FinalString = [NSString stringWithFormat:@"%@%@?%@",WEBSERVICEURL,UrlType,URLstring];
    return FinalString;
    
}
- (NSString *) stripTags:(NSString *)s
{
    
    NSRange r;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}
/*
 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"alertView tag --- %ld",(long)alertView.tag);
}
@end

/*
 * handelURLConnection cless is made for handle url connection using the delegate method.
 * handelURLConnection class will esposible for fetch data and will send local notification to the
 * parent class from where this class is accessing
 *
 */

#import "AFNetworking.h"

@implementation handelURLConnection

@synthesize delegate = _delegate;

- (void)jobCompleted:(id)json {
    
    NSError *error;
    NSDictionary* jsonData  = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];
   // NSLog(@"jsonData ---- %@",jsonData);
    [_delegate HnadleNsUrlConnection:self json:(NSDictionary *)jsonData];
    
}

-(void)getErrorToaccesssData:(NSError *)Errdata {
    
    [_delegate HnadleNsUrlConnectionErr:self Errdata:(NSError *)Errdata];
}
- (void)getValuFromURLWithPost:(NSString *)ParamDictionary URLFOR:(NSString *)URLFOR {
    
    dispatch_queue_t fetchQ = dispatch_queue_create("Pulling", NULL);
    
    dispatch_async(fetchQ, ^{
        
        NSArray *myParametersone = [ParamDictionary componentsSeparatedByString:[NSString stringWithFormat:@"%@?",URLFOR]];
       // NSLog(@"myParametersone ----- %@",myParametersone);
        NSString *myParameters = [myParametersone objectAtIndex:1];
        NSURL *url = [NSURL URLWithString:URLFOR];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url];
        request.HTTPMethod = @"POST";
        request.HTTPBody = [myParameters dataUsingEncoding: NSASCIIStringEncoding];
        [NSURLConnection sendAsynchronousRequest: request queue: [NSOperationQueue mainQueue] completionHandler:
         ^(NSURLResponse *r, NSData *data, NSError *error) {
             if (error) {
                 [self getErrorToaccesssData:error];
             } else {
                 [self jobCompleted:data];
             }
         }];
    });
    
}
- (void)getValuFromURL:(NSString *)url {
    
    dispatch_queue_t fetchQ = dispatch_queue_create("Pulling", NULL);
    dispatch_async(fetchQ, ^{
        NSURLRequest *RequestedURL = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        AFHTTPRequestOperation *operation_login = [[AFHTTPRequestOperation alloc]initWithRequest:RequestedURL];
        [operation_login setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self jobCompleted:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self getErrorToaccesssData:error];
        }];
        [operation_login start];
    });
}
@end
