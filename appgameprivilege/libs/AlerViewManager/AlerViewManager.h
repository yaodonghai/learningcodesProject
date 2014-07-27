//
//  AlerViewManager.h
//  ThreeKingdomsProject
//
//  Created by niko on 11-9-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlerViewManager : NSObject 
{
    UIView                  *_progressTintView;
    UIView                  *_contentView;
    NSTimer                 *_timer;
}

//+ (AlerViewManager*)shareInstance；

- (void)showOnlyWhiteIndicatorinView:(UIView*)rootView;
- (void)showOnlyGrayIndicatorinView:(UIView*)rootView;
- (void)showOnlyWhiteLargeIndicatorinView:(UIView*)rootView;
- (void)showWebMessageSendStateWithMessage:(NSString*)mes inView:(UIView*)rootView;

- (void)showMessage:(NSString*)mes inView:(UIView*)rootView;
- (void)showWebMessageLoadState:(UIView*)rootView;
- (void)dismissMessageView:(UIView*)rootView;

- (void)showOnlyMessage:(NSString*)mes inView:(UIView*)rootView;
- (void)dismissOnlyMessageView;

- (void)dismissOnlyViewAction:(id)sender;

@end
