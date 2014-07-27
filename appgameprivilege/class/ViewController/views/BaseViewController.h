//
//  BaseViewController.h
//  TestAVOSPushDemo
//
//  Created by June on 14-4-4.
//  Copyright (c) 2014年 junewong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConfigure.h"
#import "AlerViewManager.h"
@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>
{
    UIActivityIndicatorView *_loadingView;

}

@property (nonatomic) BOOL showLoadingView;
@property (nonatomic,assign)float x;
- (id)initWithDefaultNib;
- (void)createBackgroundImage;
- (void)addSwipeGestureForGoingBack;
/**
 *  增加view 的高度
 */
@property(nonatomic,assign)BOOL isAddtabBarheight;
@end
