//
//  BaseViewController.m
//  StoryboardNavigatDemo
//
//  Created by 姚东海 on 9/7/14.
//  Copyright (c) 2014年 zebra. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

-(void)viewDidLoad{
    
//    float version=[[[UIDevice currentDevice] systemVersion] floatValue];
//
//    if (version>=7.0) {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        //视图控制器，四条边不指定
//        self.extendedLayoutIncludesOpaqueBars = NO;
//        //不透明的操作栏
//        self.modalPresentationCapturesStatusBarAppearance = NO;
//    
//    }
    //[self fixViewHeight];
    [self createBackButton];
    [super viewDidLoad];
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
    
    UINavigationController *navContrlloer = (UINavigationController*)[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if (navContrlloer != nil && [navContrlloer navigationBar] != nil && [navContrlloer navigationBar].hidden == NO) {
        CGFloat navigationBarHeight = navContrlloer.navigationBar.frame.size.height;
        frame.size.height -= navigationBarHeight;
        frame.origin.y += navigationBarHeight;
    }
    
    
    self.view.frame = frame;
}

- (void)createBackButton
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *imgBtn = [UIImage imageNamed:@"返回.png"];
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
