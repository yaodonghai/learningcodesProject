//
//  NSString+Tools.h
//  MiniXiyou
//
//  Created by 姚东海 on 16/4/14.
//  Copyright (c) 2014年 junewong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Tools)
//key 要替换的  value 替换成什么
-(NSString*)replacingDictionary:(NSDictionary*)replacedic;
-(NSDictionary*)getResponseDictionary;
-(NSString*)filtration:(NSString*)regEx_html;


    

/**
 *  安装APP
 */
-(void)installApp;
/**
 *   是否装有APP
 *
 *  @return 是否
 */
-(BOOL)isInstallationApp;


/**
 *  检测是否为邮箱
 *  @return 是否是
 */
- (BOOL) validateEmail;

/**
 *  是否为数字
 *  @return 是否是
 */
-(BOOL)isPureInt;

/**
 *  是否有中文
 *  @return 是否是
 */
-(BOOL)isChineseWord;

/**
 *  需要过滤的特殊字符
 *  @return 是否是
 */
-(BOOL)isIncludeSpecialCharact;

/**
 *  取得截止nstring cutoffPostion
 *
 *  @param cutoffnstring 截止 nstring
 *
 *  @return 截止 NSRange
 */
-(NSRange)cutoffPostion:(NSString*)cutoffnstring;

/**
 *  截止nstring 的颜色
 *
 *  @param nstringArray 要截止的nsstring
 *  @param cutcolor     截止的nsstring 的颜色
 */

-(NSMutableAttributedString*)getAttributedColornstringWithArray:(NSArray*)stringArray AndColor:(UIColor*)cutcolor;

/**
 *  截止nstring 的颜色
 *
 *  @param dicArray 添加 NSDictionary 要截止的nsstring key为(string) 截止的nsstring 的颜色 key为(color) 截止的nsstring 的font key为(font)
 *
 */
-(NSMutableAttributedString*)getAttributedColornstringWithArray:(NSArray*)dicArray;

/**
 *  截止nstring 的颜色
 *
 *  @param dicArray @param dicArray 添加 NSDictionary 要截止的nsstring key为(string) 截止的nsstring 的颜色 key为(color)
 *  @param font     字体
 *
 *  @return NSMutableAttributedString
 */
-(NSMutableAttributedString*)getAttributedColornstringWithArray:(NSArray*)dicArray AndFont:(UIFont*)font;
/**
 *  截止nstring 的颜色
 *
 *  @param stringArray 要截止的nsstring
 *  @param cutcolor    截止的nsstring 的颜色
 *  @param font        字体
 *
 *  @return NSMutableAttributedString
 */
-(NSMutableAttributedString*)getAttributedColornstringWithArray:(NSArray*)stringArray AndColor:(UIColor*)cutcolor AndFont:(UIFont*)font;
/**
 *  复制字符串到剪贴板
 */
-(void)copyStringTopasteboard;

/**
 *  数字转换
 *
 *  @return 数字
 */
-(NSString*)numberconversion;
@end
