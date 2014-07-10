//
//  ColorUtil.m
//  appgameprivilege
//
//  Created by 姚东海 on 21/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "ColorUtil.h"

@implementation ColorUtil
+ (UIColor*)getColorWithIndex:(NSUInteger)index
{
    NSArray * colors=[[NSArray alloc]initWithObjects:
                      [UIColor colorWithRed:171.0/255.0 green:215.0/255 blue:70.0/255 alpha:1],
                      [UIColor colorWithRed:255.0/255.0 green:164.0/255 blue:60.0/255 alpha:1],
                      [UIColor colorWithRed:56.0/255.0 green:167.0/255 blue:209.0/255 alpha:1],
                      [UIColor colorWithRed:251.0/255.0 green:149.0/255 blue:252.0/255 alpha:1], nil];
    NSUInteger result = index % [colors count];
    return [colors objectAtIndex:result];
}


+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
