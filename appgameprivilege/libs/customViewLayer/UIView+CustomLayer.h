//
//  UIView+CustomLayer.h
//  appgameprivilege
//
//  Created by 姚东海 on 21/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CustomLayer)
/**
 *  边框
 *
 *  @param radius      幅度
 *  @param borderWidth 大小
 *  @param borderColor 颜色
 */
-(void)setViewLayerWithRadius:(CGFloat)radius AndBorderWidth:(CGFloat)borderWidth AndBorderColor:(UIColor*)borderColor;

/**
 *  添加低线
 *
 *  @param abottemlineColor 颜色
 */
-(void)setViewbottemlineColor:(UIColor *)abottemlineColor;
/**
 *  默认边框颜色
 */
-(void)setdefaultLayer;

/**
 *  添加top 线
 *
 *  @param color 颜色
 */
-(void)setViewtoplineColor:(UIColor*)color;
@end
