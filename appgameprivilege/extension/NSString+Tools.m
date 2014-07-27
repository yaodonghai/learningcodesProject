//
//  NSString+Tools.m
//  MiniXiyou
//
//  Created by 姚东海 on 16/4/14.
//  Copyright (c) 2014年 junewong. All rights reserved.
//

#import "NSString+Tools.h"

@implementation NSString (Tools)


//key 要替换的  value 替换成什么
-(NSString*)replacingDictionary:(NSDictionary*)replacedic{
    NSString * replacestring=self;
    if ([replacedic isKindOfClass:[NSDictionary class]]&&replacedic.count>0) {
            for(NSString *key in replacedic){
                replacestring = [self stringByReplacingOccurrencesOfString:key withString:[replacedic objectForKey:key]];
            }
     
    }
    return replacestring;
}


-(NSDictionary*)getResponseDictionary{
    __block NSString *  jsonString=self;
    NSError *error;
    //(.|\\s)*或([\\s\\S]*)可以匹配包括换行在内的任意字符
    NSRegularExpression *regexW3tc = [NSRegularExpression
                                      regularExpressionWithPattern:@"<!-- W3 Total Cache:([\\s\\S]*)-->"
                                      options:NSRegularExpressionCaseInsensitive
                                      error:&error];
    [regexW3tc enumerateMatchesInString:jsonString
                                options:0
                                  range:NSMakeRange(0, jsonString.length)
                             usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                 jsonString=[jsonString stringByReplacingOccurrencesOfString:[jsonString substringWithRange:result.range] withString:@""];
                             }];
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    // fetch the json response to a dictionary
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    // pass it to the block
    // check the code (success is 0)
    
    return responseDictionary;
}



-(NSString*)filtration:(NSString*)regEx_html{
    
 __block  NSString * Filtrationstring=self;
    NSError *error;
    //(.|\\s)*或([\\s\\S]*)可以匹配包括换行在内的任意字符
    //NSString *regEx_html = "<[^>]+>";
    NSRegularExpression *regexW3tc = [NSRegularExpression
                                      regularExpressionWithPattern:@"<[^>]+>"
                                      options:NSRegularExpressionCaseInsensitive
                                      error:&error];
    
    [regexW3tc enumerateMatchesInString:regEx_html
                                options:0
                                  range:NSMakeRange(0, regEx_html.length)
                             usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                 
                                 Filtrationstring= [Filtrationstring stringByReplacingOccurrencesOfString:[regEx_html substringWithRange:result.range] withString:@""];
                             }];
    
   return Filtrationstring = [Filtrationstring stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 *   是否装有APP
 *
 *  @return 是否
 */
-(BOOL)isInstallationApp{

    NSURL *url = [NSURL URLWithString:self];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        return YES;
    }else{
        return NO;
    }
}


/**
 *  安装APP
 */
-(void)installApp{
    NSURL *url = [NSURL URLWithString:self];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}



/**
 *  检测是否为邮箱
 *  @return 是否是
 */
- (BOOL) validateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}



/**
 *  需要过滤的特殊字符
 *  @return 是否是
 */
-(BOOL)isIncludeSpecialCharact{
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [self rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€-"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}

/**
 *  是否有中文
 *  @return 是否是
 */
-(BOOL)isChineseWord{
    BOOL yes=NO;
    
    int length = [self length];
    
    for (int i=0; i<length; ++i)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        const char    *cString = [subString UTF8String];
        if (strlen(cString) == 3)
        {
            return YES;
            NSLog(@"汉字:%s", cString);
        }
    }
    
    return yes;
}

/**
 *  是否为数字
 *  @return 是否是
 */
-(BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

/**
 *  截止nstring 的颜色
 *
 *  @param nstringArray 要截止的nsstring
 *  @param cutcolor     截止的nsstring 的颜色
 *  @return NSMutableAttributedString
 */

-(NSMutableAttributedString*)getAttributedColornstringWithArray:(NSArray*)stringArray AndColor:(UIColor*)cutcolor{
    NSMutableAttributedString * customAttributedString=[[NSMutableAttributedString alloc]initWithString:self];
    if ([stringArray isKindOfClass:[NSArray class]]) {
        for (NSString * cutnstring in stringArray) {
            NSRange curtrange= [self cutoffPostion:cutnstring];
            [customAttributedString addAttribute:NSForegroundColorAttributeName value:cutcolor range:curtrange];
        }
    }
    
    return customAttributedString;
}


/**
 *  截止nstring 的颜色
 *
 *  @param stringArray 要截止的nsstring
 *  @param cutcolor    截止的nsstring 的颜色
 *  @param font        字体
 *
 *  @return NSMutableAttributedString
 */
-(NSMutableAttributedString*)getAttributedColornstringWithArray:(NSArray*)stringArray AndColor:(UIColor*)cutcolor AndFont:(UIFont*)font{
    NSMutableAttributedString * customAttributedString= [self getAttributedColornstringWithArray:stringArray AndColor:cutcolor];
    [customAttributedString addAttribute:NSFontAttributeName value:font range:[self rangeOfString:self]];
    return customAttributedString;
}


/**
 *  截止nstring 的颜色
 *
 *  @param dicArray @param dicArray 添加 NSDictionary 要截止的nsstring key为(string) 截止的nsstring 的颜色 key为(color)
 *  @param font     字体
 *
 *  @return NSMutableAttributedString
 */
-(NSMutableAttributedString*)getAttributedColornstringWithArray:(NSArray*)dicArray AndFont:(UIFont*)font{
    NSMutableAttributedString * customAttributedString=[self getAttributedColornstringWithArray:dicArray];
    [customAttributedString addAttribute:NSFontAttributeName value:font range:[self rangeOfString:self]];
    return customAttributedString;
}


/**
 *  截止nstring 的颜色
 *
 *  @param dicArray 添加 NSDictionary 要截止的nsstring key为(string) 截止的nsstring 的颜色 key为(color) 截止的nsstring 的font key为(font)
 *
 * @return NSMutableAttributedString
 */
-(NSMutableAttributedString*)getAttributedColornstringWithArray:(NSArray*)dicArray{
    NSMutableAttributedString * customAttributedString=[[NSMutableAttributedString alloc]initWithString:self];
    
    if ([dicArray isKindOfClass:[NSArray class]]) {
        for (NSDictionary * dic in dicArray) {
            NSString * cutnstring= [dic objectForKey:@"string"];
            UIColor * curtcolor=[dic objectForKey:@"color"];
            UIFont * curtfont=[dic objectForKey:@"font"];
            NSRange curtrange= [self cutoffPostion:cutnstring];
            if ([cutnstring isKindOfClass:[NSString class]]) {
                if ([curtcolor isKindOfClass:[UIColor class]]) {
                      [customAttributedString addAttribute:NSForegroundColorAttributeName value:curtcolor range:curtrange];
                }
                if ([curtfont isKindOfClass:[UIFont class]] ) {
                     [customAttributedString addAttribute:NSFontAttributeName value:curtfont range:curtrange];
                }
            }
        }
    }
    
    return customAttributedString;
}

/**
 *  取得截止nstring cutoffPostion
 *
 *  @param cutoffnstring 截止 nstring
 *
 *  @return 截止 NSRange
 */
-(NSRange)cutoffPostion:(NSString*)cutoffnstring{
    NSRange range = [self rangeOfString:cutoffnstring];
    return range;
}

/**
 *  复制字符串到剪贴板
 */
-(void)copyStringTopasteboard{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string =self;
}




/**
 *  数字转换
 *
 *  @return 数字
 */
-(NSString*)numberconversion{
    NSString * numbverstring=self;
    
    int number=[numbverstring intValue];
    
    if (number > 100000000) {
        numbverstring=[NSString stringWithFormat:@"%d亿",(number / 100000000)];
    }else if (number > 10000){
        numbverstring=[NSString stringWithFormat:@"%d万",(number / 10000)];

    }else{
       numbverstring=[NSString stringWithFormat:@"%d",number];
    }
    return numbverstring;
}


@end
