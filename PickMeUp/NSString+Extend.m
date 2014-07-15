//
//  NSString+Extend.m
//  Aldente2
//
//  Created by Santanu.Adhikary@sbr-technologies.com on 01/04/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "NSString+Extend.h"

@implementation NSString (Extend)
/*
 */
+ (BOOL)isNilOrEmpty:(NSString *)input {
    return !input || [input isEmpty];
}
/*
 */
- (BOOL)isEmail {
    NSString *regex = @"[a-zA-Z0-9.\\-_]{2,32}@[a-zA-Z0-9.\\-_]{2,32}\\.[A-Za-z]{2,4}";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [regExPredicate evaluateWithObject:self];
}
/*
 */
- (BOOL)isPhoneNumber {
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink|NSTextCheckingTypePhoneNumber
                                                               error:nil];
    
    return [detector numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
}
/*
 */
- (BOOL)isDigit {
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:self];
    
    return [alphaNums isSupersetOfSet:inStringSet];
}
/*
 */
- (BOOL)isNumeric {
    NSString *regex = @"([0-9])+((\\.|,)([0-9])+)?";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [regExPredicate evaluateWithObject:self];
}
/*
 */
- (BOOL)isAlphanumeric {
    NSString *regex = @"^.*(?=.*?[a-zA-Z])(?=.*?[0-9]).+$";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [regExPredicate evaluateWithObject:self];
}
/*
 */
- (BOOL)hasBothCases {
    NSString *regex = @"^.*(?=.*?[a-z])(?=.*?[A-Z]).+$";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [regExPredicate evaluateWithObject:self];
}
/*
 */
- (BOOL)isUrl {
    NSString *regex = @"https?:\\/\\/[\\S]+";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [regExPredicate evaluateWithObject:self];
}
/*
 */
- (BOOL)isMinLength:(NSUInteger)length {
    return (self.length >= length);
}
/*
 */
- (BOOL)isMaxLength:(NSUInteger)length {
    return (self.length <= length);
}
/*
 */
- (BOOL)isMinLength:(NSUInteger)min andMaxLength:(NSUInteger)max {
    return ([self isMinLength:min] && [self isMaxLength:max]);
}
/*
 */
- (BOOL)isEmpty {
    return (!self.length);
}

@end
