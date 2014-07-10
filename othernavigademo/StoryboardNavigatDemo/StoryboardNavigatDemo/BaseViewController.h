//
//  BaseViewController.h
//  TestAVOSPushDemo
//
//  Created by June on 14-4-4.
//  Copyright (c) 2014年 junewong. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "GlobalConfigure.h"
#define IPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>
{
    UIActivityIndicatorView *_loadingView;
}

@property (nonatomic) BOOL showLoadingView;

//- (void)createBackgroundImage;
- (void)addSwipeGestureForGoingBack;

@end
