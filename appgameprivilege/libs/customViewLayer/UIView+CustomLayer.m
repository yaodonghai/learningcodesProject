//
//  UIView+CustomLayer.m
//  appgameprivilege
//
//  Created by 姚东海 on 21/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "UIView+CustomLayer.h"

@implementation UIView (CustomLayer)
/**
 *  边框
 *
 *  @param radius      幅度
 *  @param borderWidth 大小
 *  @param borderColor 颜色
 */
-(void)setViewLayerWithRadius:(CGFloat)radius AndBorderWidth:(CGFloat)borderWidth AndBorderColor:(UIColor*)borderColor{
    self.layer.cornerRadius=radius;
    self.layer.masksToBounds=YES;
    self.layer.borderWidth=borderWidth;
    self.layer.borderColor=borderColor.CGColor;
}

-(void)setdefaultLayer{
    self.layer.cornerRadius=8.0;
    self.layer.masksToBounds=YES;
    self.layer.borderWidth=0.5;
    self.layer.borderColor=[UIColor grayColor].CGColor;
}
/**
 *  添加低线
 *
 *  @param abottemlineColor 颜色
 */
-(void)setViewbottemlineColor:(UIColor *)abottemlineColor{

      UIView * bottemViewline=[[UIView alloc]initWithFrame:CGRectMake(0, (self.frame.size.height-1), self.frame.size.width, 0.4)];
        bottemViewline.clipsToBounds=YES;
        [bottemViewline setAlpha:0.4];
        bottemViewline.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:bottemViewline];
    bottemViewline.backgroundColor=abottemlineColor;
}


/**
 *  添加top 线
 *
 *  @param color 颜色
 */
-(void)setViewtoplineColor:(UIColor*)color{
    UIView * bottemViewline=[[UIView alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width, 0.5)];
    bottemViewline.clipsToBounds=YES;
    [self addSubview:bottemViewline];
    bottemViewline.backgroundColor=color;
}
@end
