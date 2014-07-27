//
//  XibViewLoader.h
//  youcoach
//
//  用于加载基于Xib制作的控件；
//
//  Created by June on 12-5-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XibViewLoader : NSObject

+ (id)loadFistViewWithName:(NSString*)name owner:(id)owner;
+ (id)loadViewWithName:(NSString*)name owner:(id)owner atIndex:(int)index;
+ (id)loadFistViewWithName:(NSString*)name owner:(id)owner replaceView:(UIView*)replaceView;

@end
