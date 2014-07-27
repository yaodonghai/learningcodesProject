//
//  BaseViewController.m
//  TestAVOSPushDemo
//
//  Created by June on 14-4-4.
//  Copyright (c) 2014年 junewong. All rights reserved.
//

#import "BaseViewController.h"
#import "Globle.h"
#import "ColorUtil.h"
@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize isAddtabBarheight;
@synthesize x=_x;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self fixViewHeight];

    [self createBackButton];
    [self addSwipeGestureForGoingBack];
}

// 如果是带xib视图的子类，可调用此初始化方法，自动加载同名的xib，如没有同名xib则加载父类的xib视图；
- (id)initWithDefaultNib
{
    NSString *xibName = [self getXibName];
    NSLog(@"load xib: %@", xibName);
    return [self initWithNibName:xibName bundle:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //[self.navigationController.navigationBar setTranslucent:NO];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {
        
        //IOS5
        UIImage * backimage=[ColorUtil imageWithColor:RGB(0, 159, 231) andSize:CGSizeMake(320, 44)];
        [self.navigationController.navigationBar setBackgroundImage:backimage forBarMetrics:UIBarMetricsDefault];
        //self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
        //self.navigationController.navigationBar.tintColor = [UIColor clearColor];
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor] ,UITextAttributeTextColor,[UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0], UITextAttributeFont,nil];
    }
    self.navigationItem.title=self.title;

}


#pragma mark - UI

- (void)fixViewHeight
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    if (window == nil) {
        return;
    }
    
    CGRect frame = window.frame;
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    frame.size.height -= statusBarHeight;
    
    frame.origin.y += statusBarHeight;
    
    UINavigationController *navContrlloer =self.navigationController;
    if (navContrlloer != nil && [navContrlloer navigationBar] != nil && [navContrlloer navigationBar].hidden == NO) {
        
        CGFloat navigationBarHeight = navContrlloer.navigationBar.frame.size.height;
        frame.size.height -= navigationBarHeight;
        frame.origin.y += navigationBarHeight;
//        CGFloat navigationBarHeight = navContrlloer.navigationBar.frame.size.height;
//        if (!IOS7_SYSTEM) {
//            frame.size.height -= navigationBarHeight;
//
//        }
//        frame.origin.y += navigationBarHeight;
        
    }
    
    float view_h=[Globle shareInstance].globleHeight-44-40;
    float view_y=0;
    _x=0.0;
    CGRect homeframe=CGRectMake(0, view_y, [Globle shareInstance].globleWidth, view_h);
    self.view.frame=homeframe;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
   self.view.backgroundColor=[UIColor whiteColor];
    LOG(@"curt---viewframe--x---%f---y--%f---w---%f--h--%f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height)

}



-(void)setIsAddtabBarheight:(BOOL)AisAddtabBarheight{
    isAddtabBarheight=AisAddtabBarheight;
    if (AisAddtabBarheight) {
        CGRect curtviewFrame=self.view.frame;
        curtviewFrame.size.height=curtviewFrame.size.height+44;
        self.view.frame=curtviewFrame;
    }
}


- (void)createBackButton
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *imgBtn = [UIImage imageNamed:@"3-单个游戏-返回.png"];
    CGRect rect;
    rect = leftButton.frame;
    rect.size  = imgBtn.size;
    leftButton.frame = rect;
    
    [leftButton setBackgroundImage:imgBtn forState:UIControlStateNormal];
    [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftButton setShowsTouchWhenHighlighted:YES];
    [leftButton addTarget:self action:@selector(clickGoBackButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *temporaryLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    temporaryLeftBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = temporaryLeftBarButtonItem;
}

/**
    增加滑动返回上一页面的手势
 */
- (void)addSwipeGestureForGoingBack
{
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGesture:)];
    swipeGesture.delegate = self;
    [swipeGesture setDirection:(UISwipeGestureRecognizerDirectionRight)];
    swipeGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:swipeGesture];
}

#pragma mark - optional UI

- (void)createBackgroundImage
{
//    UIImage *image = [UIImage imageNamed:@"i4-背景图.png"];
//    if (IPhone5) {
//        image = [UIImage imageNamed:@"i5-背景图.png"];
//    }
//    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:image];
//    
//    [self.view addSubview:backgroundImage];
//    [self.view sendSubviewToBack:backgroundImage];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setShowLoadingView:(BOOL)isLoaing
{
    _showLoadingView = isLoaing;
    
    if (_loadingView != nil) {
        [_loadingView stopAnimating];
        [_loadingView removeFromSuperview];
    }
    
    if (isLoaing == YES) {
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        CGPoint center = [self.view convertPoint:mainWindow.center fromView:mainWindow];
        _loadingView.center = center;
        [self.view addSubview:_loadingView];
        [self.view bringSubviewToFront:_loadingView];
        [_loadingView startAnimating];
    }
    
}

#pragma mark - UI

// 获取xib文件名；
- (NSString*)getXibName
{
    // 查找跟当前类名同名的xib文件
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    NSString *xibName = [self getXibNameWithClassName:className];
    
    // 如果找不到，用父类的名字继续查找
    if ([self existXibFileWithName:xibName] == NO) {
        className = [NSString stringWithUTF8String:object_getClassName(self.superclass)];
        xibName = [self getXibNameWithClassName:className];
    }
    
    return xibName;
}

// 如果是4寸屏幕，优先查找“-568h”后缀的xib文件；
- (NSString*)getXibNameWithClassName:(NSString*)className
{
    if (IPhone5) {
        NSString *xibName = [NSString stringWithFormat:@"%@-568h", className];
        // if has 4-inch xib file:
        if ([self existXibFileWithName:xibName]) {
            return xibName;
        }
    }
    return className;
}

- (BOOL)existXibFileWithName:(NSString*)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"nib"];
    return (path != nil);
}


#pragma mark - override

/**
    根据当前的应用导航结构，需要改为获取AppDelegate中得navigationController对象；
 */
- (UINavigationController*)navigationController
{
    if (super.navigationController != nil) {
        return super.navigationController;
    }
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    if ([window.rootViewController isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController*)window.rootViewController;
    }
    
    return nil;
}

#pragma mark - gesture delegate

- (void) swipGesture:(id)sender
{
    [self goBack];
}

- (void)clickGoBackButton:(id)sender
{
    [self goBack];
}

- (void)goBack
{
    if ([self.navigationController.viewControllers count] > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}




@end