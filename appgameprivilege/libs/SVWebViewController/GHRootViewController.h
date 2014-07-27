//
//  GHRootViewController.h
//  GHSidebarNav
//
//  Created by Greg Haines on 11/20/11.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "Refreshview.h"
#import "BaseViewController.h"
#import <ShareSDK/ShareSDK.h>//v2.1

enum {
    GHWebViewControllerAvailableActionsNone             = 0,
    GHWebViewControllerAvailableActionsOpenInSafari     = 1 << 0,
    GHWebViewControllerAvailableActionsMailLink         = 1 << 1,
    GHWebViewControllerAvailableActionsCopyLink         = 1 << 2
};

typedef NSUInteger GHWebViewControllerAvailableActions;


typedef void (^RevealBlock)();
//UIViewController
@interface GHRootViewController :  BaseViewController<UIWebViewDelegate,UIGestureRecognizerDelegate>{
    UIWebView *mainWebView;
    NSURL *webURL;
    BOOL _isshowButtons;
    UIActivityIndicatorView *activityIndicator;
    /**
     *  操作buttons
     */
    BOOL isOperationBtns;
    Refreshview * refreshview;
    
@private
	RevealBlock _revealBlock;
}

@property (nonatomic, strong) NSURL *webURL;
/**
 *  是否添加操作按扭
 */
@property(nonatomic,assign)BOOL isshowButtons;
/**
 *  刷新view
 */
@property(nonatomic,assign)BOOL isshowRefreshView;
@property (nonatomic, strong) UIWebView *mainWebView;
@property (nonatomic, strong) Refreshview * refreshview;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, readwrite) GHWebViewControllerAvailableActions availableActions;
/**
 *  操作buttons
 */
@property (nonatomic, assign)BOOL isOperationBtns;
- (id)initWithTitle:(NSString *)title withUrl:(NSString *)url withRevealBlock:(RevealBlock)revealBlock;
- (id)initWithTitle:(NSString *)title withUrl:(NSString *)url;
- (void)reloadClicked;

@end
