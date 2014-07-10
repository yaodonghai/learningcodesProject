//
//  ColorUtil.h
//  appgameprivilege
//
//  Created by 姚东海 on 21/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorUtil : NSObject
+ (UIColor*)getColorWithIndex:(NSUInteger)index;
/**
 *  颜色生成图片
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
@end
