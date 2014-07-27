//
//  XibViewLoader.m
//  youcoach
//
//  Created by June on 12-5-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "XibViewLoader.h"
@implementation XibViewLoader

+ (id)loadFistViewWithName:(NSString*)name owner:(id)owner
{
	return [XibViewLoader loadViewWithName:name owner:owner atIndex:0];
}

// 加载指定的xib文件上的组件，通过index选择加载该xib文件上的第几个组件。不过通常都是只有一个。
+ (id)loadViewWithName:(NSString*)name owner:(id)owner atIndex:(int)index
{

 return [[[NSBundle mainBundle] loadNibNamed:name owner:owner options:nil] objectAtIndex:index];
 
 
}

// 加载组件，同时替换掉replceView。替换之前将把replaceView的所有基本属性都复制过来。
// 如果一个页面的xib文件上放了一个组件，而该组件需要用此类进来，重新初始化，那么这种情况需要调用此方法，替换掉该IBOunlet指向的已有组件；
+ (id)loadFistViewWithName:(NSString*)name owner:(id)owner replaceView:(UIView*)replaceView
{
    UIView *xibView = [[self class] loadFistViewWithName:name owner:owner];
    
    xibView.autoresizingMask = replaceView.autoresizingMask;
    
    UIView *parentView = replaceView.superview;
    CGRect rect = replaceView.frame;
    
    [replaceView removeFromSuperview];
    replaceView = nil;
    
    xibView.frame = rect;
    
    [parentView addSubview:xibView];
    
    replaceView = xibView;
    
    return xibView;
}

@end
