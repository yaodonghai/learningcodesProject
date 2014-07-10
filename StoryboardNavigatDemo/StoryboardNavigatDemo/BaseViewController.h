//
//  BaseViewController.h
//  StoryboardNavigatDemo
//
//  Created by 姚东海 on 9/7/14.
//  Copyright (c) 2014年 zebra. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>{
    
}
- (void)createBackgroundImage;
- (void)addSwipeGestureForGoingBack;
@end
