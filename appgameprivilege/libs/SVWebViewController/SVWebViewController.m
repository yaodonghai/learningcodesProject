//
//  SVWebViewController.m
//
//  Created by Sam Vermette on 08.11.10.
//  Copyright 2010 Sam Vermette. All rights reserved.
//
//  https://github.com/samvermette/SVWebViewController

#import "SVWebViewController.h"
#import "AFHTTPClient.h"
#import "AFXMLRequestOperation.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "GlobalConfigure.h"
#import "GHRootViewController.h"
#import "ColorUtil.h"
@interface SVWebViewController () <UIWebViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>
@property (nonatomic, strong, readonly) UIBarButtonItem *popBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *likeButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *favoriteBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *forwardBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *refreshBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *stopBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *actionBarButtonItem;
@property (nonatomic, strong, readonly) UIActionSheet *pageActionSheet;

@property (nonatomic, strong, readonly) UIButton *favoriteBarButton;
@property (nonatomic, strong, readonly) UIButton *textViewBarButton;
@property (nonatomic, strong, readonly) UIButton *shareBarButton;

@property (strong, nonatomic) NSString *textView;

@property (nonatomic, strong) NSURL *URL;
@property (nonatomic) BOOL isHide;
@property (nonatomic, strong) ArticleItem *htmlString;
@property (strong, nonatomic) NSMutableArray *articles;//收藏文章数据源
@property (nonatomic, strong) AlerViewManager *alerViewManager;

- (id)initWithHTMLString:(ArticleItem*)htmlString URL:(NSURL*)pageURL;
- (id)initWithAddress:(NSString*)urlString;
- (id)initWithURL:(NSURL*)URL;

- (void)updateToolbarItems;

- (void)goPopClicked:(UIBarButtonItem *)sender;
- (void)goBackClicked:(UIBarButtonItem *)sender;
- (void)goForwardClicked:(UIBarButtonItem *)sender;
- (void)reloadClicked:(UIBarButtonItem *)sender;
- (void)stopClicked:(UIBarButtonItem *)sender;

- (void)goFavoriteClicked:(UIButton *)sender;
- (void)goCommentClicked:(UIButton *)sender;
- (void)goTextViewClicked:(UIButton *)sender;
- (void)shareClicked:(UIButton *)sender;

@end


@implementation SVWebViewController
@synthesize refreshview=_refreshview;
@synthesize availableActions;
@synthesize isshowRefreshView=_isshowRefreshView;
@synthesize URL, mainWebView, isHide, textView;
@synthesize popBarButtonItem,likeButtonItem, favoriteBarButtonItem, backBarButtonItem, forwardBarButtonItem, refreshBarButtonItem, stopBarButtonItem, actionBarButtonItem, pageActionSheet, favoriteBarButton, textViewBarButton, shareBarButton;

#pragma mark - setters and getters
- (UIBarButtonItem *)popBarButtonItem {
    
    if (!popBarButtonItem) {
        popBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Message-Box-Short.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goTextViewClicked:)];
       // [popBarButtonItem setTitle:@"说点什么吧..."];
        //[rightButton setTitle:@"1000评论" forState:UIControlStateNormal];// 添加文字
        //[rightButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
        //[rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //[rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        //popBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"留言..." style:UIBarButtonItemStylePlain target:self action:@selector(goTextViewClicked:)];
        //popBarButtonItem.image = [UIImage imageNamed:@"Message-Box-Short.png"];
        //[popBarButtonItem.title sizeWithFont:[UIFont fontWithName:@"Helvetica" size:12.0] constrainedToSize:CGSizeMake(166.0f,33.0f)];

        popBarButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
		popBarButtonItem.width = 166.0f;
    }
    return popBarButtonItem;
}

- (UIBarButtonItem *)likeButtonItem {
    
    if (!likeButtonItem) {
        likeButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Praise.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goTextViewClicked:)];
        likeButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
		likeButtonItem.width = 18.0f;
    }
    return likeButtonItem;
}

- (UIBarButtonItem *)favoriteBarButtonItem {
    
    if (!favoriteBarButtonItem) {
        favoriteBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:favoriteBarButton];
        favoriteBarButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
		favoriteBarButtonItem.width = 18.0f;
    }
    return favoriteBarButtonItem;
}


- (UIBarButtonItem *)backBarButtonItem {
    
    if (!backBarButtonItem) {
        backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SVWebViewController.bundle/iPhone/back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackClicked:)];
        backBarButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
		backBarButtonItem.width = 18.0f;
    }
    return backBarButtonItem;
}

- (UIBarButtonItem *)forwardBarButtonItem {
    
    if (!forwardBarButtonItem) {
        forwardBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SVWebViewController.bundle/iPhone/forward"] style:UIBarButtonItemStylePlain target:self action:@selector(goForwardClicked:)];
        forwardBarButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
		forwardBarButtonItem.width = 18.0f;
    }
    return forwardBarButtonItem;
}

- (UIBarButtonItem *)refreshBarButtonItem {
    
    if (!refreshBarButtonItem) {
        refreshBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadClicked:)];
    }
    
    return refreshBarButtonItem;
}

- (UIBarButtonItem *)stopBarButtonItem {
    
    if (!stopBarButtonItem) {
        stopBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopClicked:)];
    }
    return stopBarButtonItem;
}

- (UIBarButtonItem *)actionBarButtonItem {
    
    if (!actionBarButtonItem) {
        actionBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareClicked:)];
    }
    return actionBarButtonItem;
}

- (UIActionSheet *)pageActionSheet {
    
    if(!pageActionSheet) {
        pageActionSheet = [[UIActionSheet alloc]
                           initWithTitle:self.mainWebView.request.URL.absoluteString
                           delegate:self
                           cancelButtonTitle:nil
                           destructiveButtonTitle:nil
                           otherButtonTitles:nil];
        
        if((self.availableActions & SVWebViewControllerAvailableActionsCopyLink) == SVWebViewControllerAvailableActionsCopyLink)
            [pageActionSheet addButtonWithTitle:NSLocalizedString(@"复制链接", @"")];
        
        if((self.availableActions & SVWebViewControllerAvailableActionsOpenInSafari) == SVWebViewControllerAvailableActionsOpenInSafari)
            [pageActionSheet addButtonWithTitle:NSLocalizedString(@"在Safari中打开", @"")];
        
        if([MFMailComposeViewController canSendMail] && (self.availableActions & SVWebViewControllerAvailableActionsMailLink) == SVWebViewControllerAvailableActionsMailLink)
            [pageActionSheet addButtonWithTitle:NSLocalizedString(@"用邮件发送", @"")];
        
        [pageActionSheet addButtonWithTitle:NSLocalizedString(@"取消", @"")];
        pageActionSheet.cancelButtonIndex = [self.pageActionSheet numberOfButtons]-1;
    }
    
    return pageActionSheet;
}

#pragma mark - Initialization

- (id)initWithHTMLString:(ArticleItem*)htmlString URL:(NSURL*)pageURL {
    self.htmlString = htmlString;
    return [self initWithURL:pageURL];
}
- (id)initWithAddress:(NSString *)urlString {
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (id)initWithURL:(NSURL*)pageURL {
    
    if(self = [super init]) {
        self.URL = pageURL;
        self.availableActions = SVWebViewControllerAvailableActionsOpenInSafari | SVWebViewControllerAvailableActionsMailLink | SVWebViewControllerAvailableActionsCopyLink;
    }
    NSLog(@"initWithURL:%@",self.URL);
//    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
//    [self.view addGestureRecognizer:singleTap];
//    singleTap.delegate = self;
//    singleTap.cancelsTouchesInView = NO;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handlePanGesture:)];
    //panGesture.delegate = self;
    panGesture.cancelsTouchesInView = NO;
    //[self.view addGestureRecognizer:panGesture];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(goPopClicked:)];
    swipeGesture.delegate = self;
    [swipeGesture setDirection:(UISwipeGestureRecognizerDirectionRight)];
    swipeGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:swipeGesture];
    
    //[panGesture requireGestureRecognizerToFail:swipeGesture];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 21, 21);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"3-单个游戏-返回.png"] forState:UIControlStateNormal];
    [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftButton setShowsTouchWhenHighlighted:YES];
    [leftButton addTarget:self action:@selector(goPopClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [leftButton setTitle:@" 后退" forState:UIControlStateNormal];
//    [leftButton.titleLabel setFont:[UIFont boldSystemFontOfSize:11]];
//    leftButton.titleLabel.textColor = [UIColor yellowColor];
    
    UIBarButtonItem *temporaryLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    temporaryLeftBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = temporaryLeftBarButtonItem;
    
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightButton.frame = CGRectMake(0, 0, 52, 52);
//    //[rightButton setBackgroundImage:[UIImage imageNamed:@"Share-right.png"] forState:UIControlStateNormal];
//    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [rightButton setShowsTouchWhenHighlighted:YES];
//    [rightButton addTarget:self action:@selector(shareClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [rightButton setTitle:@"分享" forState:UIControlStateNormal];
//    [rightButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15.0]];
//    rightButton.titleLabel.textColor = [UIColor whiteColor];
//    
//    UIBarButtonItem *temporaryRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    temporaryRightBarButtonItem.style = UIBarButtonItemStylePlain;
//    self.navigationItem.rightBarButtonItem = temporaryRightBarButtonItem;
    
    self.title = @"任玩堂";
    
    return self;
}

#pragma mark - UIPanGestureRecognizer
- (void)handleSwipeGesture:(UISwipeGestureRecognizer *)gestureRecognizer
{
    //向右横扫返回上一层
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateEnded:{ //UIGestureRecognizerStateRecognized正常情况下只响应这个消息
            if (gestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight) {
                [[self navigationController] popViewControllerAnimated:YES];
                [self.view removeGestureRecognizer:gestureRecognizer];
            }
            break;
        }
        case UIGestureRecognizerStateFailed:{ //
            //NSLog(@"======UIGestureRecognizerStateFailed");
            break;
        }
        case UIGestureRecognizerStatePossible:{ //
            //NSLog(@"======UIGestureRecognizerStatePossible");
            break;
        }
        default:{
            break;
        }
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    //NSLog(@"======handlePanGesture");
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateEnded:{ //UIGestureRecognizerStateRecognized正常情况下只响应这个消息
            //[self.view removeGestureRecognizer:gestureRecognizer];
            break;
        }
        case UIGestureRecognizerStateFailed:{ //
            //NSLog(@"======UIGestureRecognizerStateFailed");
            break;
        }
        case UIGestureRecognizerStatePossible:{ //
            //NSLog(@"======UIGestureRecognizerStatePossible");
            break;
        }
        default:{
            break;
        }
    }
}

- (void)handleGesture:(UITapGestureRecognizer *)gestureRecognizer
{
    //点击显示或隐藏工具栏
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateEnded:{//正常情况下只响应这个消息
            
            if (self.isHide) {
                [self.navigationController setToolbarHidden:NO animated:YES];
                self.isHide = FALSE;
            }else{
                [self.navigationController setToolbarHidden:YES animated:YES];
                self.isHide = TRUE;
            }
            break;
        }
        case UIGestureRecognizerStateFailed:{ //
            //NSLog(@"======UIGestureRecognizerStateFailed");
            break;
        }
        case UIGestureRecognizerStatePossible:{ //
            //NSLog(@"======UIGestureRecognizerStatePossible");
            break;
        }
        default:{
            break;
        }
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    //NSLog(@"handle touch");
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //NSLog(@"1");
    return YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //NSLog(@"2");
    return YES;
}

#pragma mark - Memory management

- (void)dealloc {
    mainWebView.delegate = nil;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - View lifecycle

- (void)loadView {
    NSLog(@"initWithURL:%@",self.URL);
    mainWebView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    mainWebView.delegate = self;
    mainWebView.scalesPageToFit = YES;
    if (self.htmlString != nil) {
        [mainWebView loadHTMLString:self.htmlString.content baseURL:self.URL];
    }else {
        [mainWebView loadRequest:[NSURLRequest requestWithURL:self.URL]];
    }
    self.view = mainWebView;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    self.alerViewManager = [[AlerViewManager alloc] init];

    [self updateToolbarItems];
    self.view.backgroundColor = [UIColor whiteColor];
    //self.view.backgroundColor = [UIColor colorWithRed:234.0/255 green:234.0/255 blue:234.0/255 alpha:1.0];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    mainWebView = nil;
    popBarButtonItem = nil;
    likeButtonItem = nil;
    favoriteBarButton = nil;
    favoriteBarButtonItem = nil;
    backBarButtonItem = nil;
    forwardBarButtonItem = nil;
    refreshBarButtonItem = nil;
    stopBarButtonItem = nil;
    actionBarButtonItem = nil;
    pageActionSheet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    NSAssert(self.navigationController, @"SVWebViewController needs to be contained in a UINavigationController. If you are presenting SVWebViewController modally, use SVModalWebViewController instead.",nil);
    
	[super viewWillAppear:animated];
    UIImage * backimage=[ColorUtil imageWithColor:RGB(0, 159, 231) andSize:CGSizeMake(320, 44)];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //[self.navigationController.navigationBar setAlpha:0.0f];
        //[self.navigationController setNavigationBarHidden:YES animated:YES];
        [self.navigationController setToolbarHidden:YES animated:animated];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {
            //IOS5
            [self.navigationController.navigationBar setBackgroundImage:backimage forBarMetrics:UIBarMetricsDefault];
            
            if ([self.navigationController.toolbar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
                [self.navigationController.toolbar setBackgroundImage:backimage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
            }
        }else {//IOS4
            
            [self.navigationController.toolbar insertSubview:[[UIImageView alloc] initWithImage:backimage] atIndex:0];
        }
    }
    
    //自定义toolbar按钮
    textViewBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    textViewBarButton.frame =CGRectMake(15, 5, 210, 33);
    [textViewBarButton setBackgroundImage:[UIImage imageNamed:@"Message-Box-in-long.png"] forState:UIControlStateNormal];
    [textViewBarButton addTarget: self action: @selector(goTextViewClicked:) forControlEvents: UIControlEventTouchUpInside];
    [self.navigationController.toolbar addSubview:textViewBarButton];
    
    shareBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBarButton.frame =CGRectMake(320-20-20, 12, 20, 20);
    [shareBarButton setBackgroundImage:[UIImage imageNamed:@"Praise.png"] forState:UIControlStateNormal];
    [shareBarButton addTarget: self action: @selector(shareClicked:) forControlEvents: UIControlEventTouchUpInside];
    [self.navigationController.toolbar addSubview:shareBarButton];
    [self.navigationController.navigationBar addSubview:shareBarButton];
    
    favoriteBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    favoriteBarButton.frame = CGRectMake(15+210+15, 12, 20, 20);
    [favoriteBarButton setBackgroundImage:[UIImage imageNamed:@"Collection-Hollow.png"] forState:UIControlStateNormal];
    [favoriteBarButton addTarget:self action:@selector(goFavoriteClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //从standardDefaults中读取收藏列表
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    NSData *udObject = [standardDefaults objectForKey:@"Favorites"];
    if (udObject != nil) {
        NSArray *udData = [NSKeyedUnarchiver unarchiveObjectWithData:udObject];// reverseObjectEnumerator] allObjects];
        self.articles = [NSMutableArray arrayWithArray:udData];
        //如果收藏列表里已经有,表示已经收藏
        if ([self.articles containsObject:self.htmlString]) {
            [self.favoriteBarButton setBackgroundImage:[UIImage imageNamed:@"Collection-Solid.png"] forState:UIControlStateNormal];
        }else {//没有收藏
            [self.favoriteBarButton setBackgroundImage:[UIImage imageNamed:@"Collection-Hollow.png"] forState:UIControlStateNormal];
        }
    }
    
    [self.navigationController.toolbar addSubview:favoriteBarButton];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //[self.navigationController.navigationBar setAlpha:1.0f];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.navigationController setToolbarHidden:YES animated:animated];
    }
    [textViewBarButton removeFromSuperview];
    [shareBarButton removeFromSuperview];
    [favoriteBarButton removeFromSuperview];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES;
    
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark - Toolbar

- (void)updateToolbarItems {
    self.popBarButtonItem.enabled = YES;
    self.likeButtonItem.enabled = YES;
    self.favoriteBarButtonItem.enabled = YES;
    self.favoriteBarButton.enabled = YES;
    [self.favoriteBarButton setShowsTouchWhenHighlighted:YES];
    self.backBarButtonItem.enabled = self.mainWebView.canGoBack;
    self.forwardBarButtonItem.enabled = self.mainWebView.canGoForward;
    self.actionBarButtonItem.enabled = YES;//!self.mainWebView.isLoading;卡在刷新的bug
    
    //UIBarButtonItem *refreshStopBarButtonItem = self.mainWebView.isLoading ? self.stopBarButtonItem : self.refreshBarButtonItem;
    UIBarButtonItem *refreshStopBarButtonItem = self.refreshBarButtonItem;
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 5.0f;
    UIBarButtonItem *fixedSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceItem.width = 40.0f;
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];//UIBarButtonSystemItemFlexibleSpace
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        NSArray *items;
        CGFloat toolbarWidth = 250.0f;
        
        if(self.availableActions == 0) {
            toolbarWidth = 200.0f;
            items = [NSArray arrayWithObjects:
                     fixedSpace,
                     refreshStopBarButtonItem,
                     flexibleSpace,
                     self.backBarButtonItem,
                     flexibleSpace,
                     self.forwardBarButtonItem,
                     fixedSpace,
                     nil];
        } else {
            items = [NSArray arrayWithObjects:
                     fixedSpace,
                     refreshStopBarButtonItem,
                     flexibleSpace,
                     self.backBarButtonItem,
                     flexibleSpace,
                     self.forwardBarButtonItem,
                     flexibleSpace,
                     self.actionBarButtonItem,
                     fixedSpace,
                     nil];
        }
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, toolbarWidth, 44.0f)];
        toolbar.items = items;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:toolbar];
    }
    
    else {//iphone
        NSArray *items;
        
        if(self.availableActions == 0) {
            if (self.htmlString != nil) {
                items = [NSArray arrayWithObjects:
                         fixedSpace,
                         self.popBarButtonItem,
                         flexibleSpace,
                         fixedSpace,
                         flexibleSpace,
                         fixedSpaceItem,
                         flexibleSpace,
                         nil];
            }
            else {
                items = [NSArray arrayWithObjects:
                         flexibleSpace,
                         self.backBarButtonItem,
                         flexibleSpace,
                         self.forwardBarButtonItem,
                         flexibleSpace,
                         refreshStopBarButtonItem,
                         flexibleSpace,
                         nil];
            }
        } else {//有分享按钮到这里
            if (self.htmlString != nil) {
                items = [NSArray arrayWithObjects:
                         fixedSpace,
                         self.popBarButtonItem,
                         flexibleSpace,
                         self.likeButtonItem,
                         flexibleSpace,
                         self.favoriteBarButtonItem,
                         flexibleSpace,
                         self.actionBarButtonItem,
                         fixedSpace,
                         nil];
            }
            else {
                items = [NSArray arrayWithObjects:
                         fixedSpace,
                         self.backBarButtonItem,
                         flexibleSpace,
                         self.forwardBarButtonItem,
                         flexibleSpace,
                         refreshStopBarButtonItem,
                         flexibleSpace,
                         self.actionBarButtonItem,
                         fixedSpace,
                         nil];
            }
        }
        
        //self.toolbarItems = items;
        //[self.navigationController.toolbar addSubview:favoriteBarButton];
    }
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    //处理不同的URL
    if (inType == UIWebViewNavigationTypeLinkClicked) {
        //[[UIApplication sharedApplication] openURL:[inRequest URL]];
        //NSLog(@"host:%@\npath:%@",[[inRequest URL] host],[[inRequest URL] path]);
        if ([[[inRequest URL] host] rangeOfString:@".appgame.com"].location != NSNotFound) {
            NSString *host = [[inRequest URL] host];
            NSString *absolute = [[inRequest URL] absoluteString];
            if ([[[inRequest URL] host] rangeOfString:@"bbs.appgame.com"].location != NSNotFound || absolute.length - host.length < 9) {
                GHRootViewController * viewController= [[GHRootViewController alloc] initWithTitle:@"论坛" withUrl:inRequest.URL.absoluteString];
                [viewController.mainWebView loadRequest:[NSURLRequest requestWithURL:viewController.webURL]];
                [self.navigationController pushViewController:viewController animated:YES];
                return NO;//对论坛站或者主页面直接用网页打开self.mainWebView.request.URL.absoluteString
            }
            NSLog(@"站内页面");
            AFHTTPClient *jsonapiClient = [AFHTTPClient clientWithBaseURL:[inRequest URL]];
            
            NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                        @"1", @"json",
                                        @"attachments", @"exclude",
                                        nil];
            
            [jsonapiClient getPath:@""
                        parameters:parameters
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               
                               __block NSString *jsonString = operation.responseString;
                               
                               //过滤掉w3tc缓存附加在json数据后面的
                               NSError *error;
                               //(.|\\s)*或([\\s\\S]*)可以匹配包括换行在内的任意字符
                               NSRegularExpression *regexW3tc = [NSRegularExpression
                                                                 regularExpressionWithPattern:@"<!-- W3 Total Cache:([\\s\\S]*)-->"
                                                                 options:NSRegularExpressionCaseInsensitive
                                                                 error:&error];
                               [regexW3tc enumerateMatchesInString:jsonString
                                                           options:0
                                                             range:NSMakeRange(0, jsonString.length)
                                                        usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                                            jsonString = [jsonString stringByReplacingOccurrencesOfString:[jsonString substringWithRange:result.range] withString:@""];
                                                        }];
                               
                               jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                               
                               NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                               // fetch the json response to a dictionary
                               NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                               // pass it to the block
                               // check the code (success is 0)
                               NSString *code = [responseDictionary objectForKey:@"status"];
                               
                               if (![code isEqualToString:@"ok"]) {   // there's an error
                                   NSLog(@"获取文章json异常:%@",inRequest.URL);
                               }else {
                                   
                                   NSLog(@"isPage=%d",[[responseDictionary objectForKey:@"page"] count]);
                                   if ([[responseDictionary objectForKey:@"page"] count] > 0) {
                                       NSLog(@"是一个页面");
                                       GHRootViewController *vc = [[GHRootViewController alloc] initWithTitle:@"任玩堂" withUrl:inRequest.URL.absoluteString];
                                       [self.navigationController pushViewController:vc animated:YES];
                                   }
                                   
                                   NSLog(@"isPosts=%d",[[responseDictionary objectForKey:@"posts"] count]);
                                   if ([[responseDictionary objectForKey:@"posts"] count] > 0) {
                                       NSLog(@"是一个列表");
//                                       HomeViewController *viewController = [[HomeViewController alloc] initWithTitle:@"新闻" withUrl:inRequest.URL.absoluteString];
//                                       [self.navigationController pushViewController:viewController animated:YES];
                                       //return NO;
                                   }
                                   
                                   NSLog(@"isPost=%d",[[responseDictionary objectForKey:@"post"] count]);
                                   if ([[responseDictionary objectForKey:@"post"] count] > 0) {
                                       NSLog(@"是一篇文章");
                                       
                                       ArticleItem *aArticle = [[ArticleItem alloc] init];
                                       aArticle.articleURL = inRequest.URL;
                                       aArticle.title = [[responseDictionary objectForKey:@"post"] objectForKey:@"title"];
                                       aArticle.creator = [[[responseDictionary objectForKey:@"post"] objectForKey:@"author"] objectForKey:@"nickname"];
                                       
                                       aArticle.articleIconURL = [NSURL URLWithString:[[[responseDictionary objectForKey:@"post"] objectForKey:@"thumbnail"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                                       
                                       aArticle.description = [[responseDictionary objectForKey:@"post"] objectForKey:@"excerpt"];
                                       
                                       aArticle.content = [[responseDictionary objectForKey:@"post"] objectForKey:@"content"];
                                       NSDateFormatter *df = [[NSDateFormatter alloc] init];
                                       NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
                                       [df setLocale:locale];
                                       [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                       
                                       aArticle.pubDate = [df dateFromString:[[[responseDictionary objectForKey:@"post"] objectForKey:@"date"] stringByReplacingOccurrencesOfString:@"T" withString:@" "]];
                                       
                                       if (aArticle.content != nil) {
                                           NSString *htmlFilePath = [[NSBundle mainBundle] pathForResource:@"appgame" ofType:@"html"];
                                           NSString *htmlString = [NSString stringWithContentsOfFile:htmlFilePath encoding:NSUTF8StringEncoding error:nil];
                                           NSString *contentHtml = @"";
                                           NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                           [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
                                           contentHtml = [contentHtml stringByAppendingFormat:htmlString,
                                                          aArticle.title, aArticle.creator, [dateFormatter stringFromDate:aArticle.pubDate]];
                                           contentHtml = [contentHtml stringByReplacingOccurrencesOfString:@"<!--content-->" withString:aArticle.content];
                                           aArticle.content = contentHtml;
                                           
                                           SVWebViewController *vc = [[SVWebViewController alloc] initWithHTMLString:aArticle URL:aArticle.articleURL];
                                           
                                           //NSLog(@"didSelectArticle:%@",aArticle.content);
                                           [self.navigationController pushViewController:vc animated:YES];
                                       }
                                   }
                               }
                           }
                           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               // pass error to the block
                               NSLog(@"获取文章json失败:%@",error);
                           }];
            
//            SVWebViewController *viewController = [[SVWebViewController alloc] initWithURL:[inRequest URL]];
//            [self.navigationController pushViewController:viewController animated:YES];
        }else {
            NSLog(@"站外链接:%@",inRequest.URL);
            return YES;
        }
        return YES;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self updateToolbarItems];
    if (_refreshview) {
        [_refreshview start];
    }
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (_refreshview) {
        [_refreshview stop];
    }
    //self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    [self updateToolbarItems];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateToolbarItems];
    if (_refreshview) {
        [_refreshview stop];
    }
}

-(void)setIsshowRefreshView:(BOOL)aisshowRefreshView{
    _isshowRefreshView=aisshowRefreshView;
    if (!_refreshview&&aisshowRefreshView) {
        // LOG(@"----w----%f----h----%f",self.view.frame.size.width,self.view.frame.size.height);
        _refreshview= [[Refreshview alloc]initWithRefreshviewFrame:CGPointMake((self.view.frame.size.width-50),(self.view.frame.size.height-50))];
        [self.view addSubview:_refreshview];
        __unsafe_unretained SVWebViewController * vc=self;
        _refreshview.refreshwebblock=^(BOOL  state,Refreshview * refreshview){
            [vc.mainWebView reload];
        };
        
    }
}


#pragma mark - Target actions

- (void)goPopClicked:(UIBarButtonItem *)sender {
    if ([[self navigationController].viewControllers count]>1)
    {
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

- (void)goTextViewClicked:(UIButton *)sender {
}

- (void)goFavoriteClicked:(UIButton *)sender {
    //从standardDefaults中读取收藏列表
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    //    NSData *udObject = [standardDefaults objectForKey:@"Favorites"];
    //    NSArray *udData = [NSKeyedUnarchiver unarchiveObjectWithData:udObject];
    //    self.articles = [NSMutableArray arrayWithArray:udData];
    
    //如果收藏列表里已经有,表示已经收藏,则取消收藏
    if ([self.articles containsObject:self.htmlString]) {
        [self.articles removeObject:self.htmlString];
        [self.favoriteBarButton setBackgroundImage:[UIImage imageNamed:@"Collection-Hollow.png"] forState:UIControlStateNormal];
        [self updateToolbarItems];
        [self.alerViewManager showOnlyMessage:@"取消收藏" inView:self.view];
    }else {//没有收藏,添加
        [self.articles addObject:self.htmlString];
        [self.favoriteBarButton setBackgroundImage:[UIImage imageNamed:@"Collection-Solid.png"] forState:UIControlStateNormal];
        [self updateToolbarItems];
        [self.alerViewManager showOnlyMessage:@"收藏成功" inView:self.view];
        
    }
    NSData *dObject = [NSKeyedArchiver archivedDataWithRootObject:self.articles];
    [standardDefaults setObject:dObject forKey:@"Favorites"];
    [standardDefaults synchronize];
    
    //[self updateToolbarItems];
}

- (void)goBackClicked:(UIBarButtonItem *)sender {
    [mainWebView goBack];
}

- (void)goForwardClicked:(UIBarButtonItem *)sender {
    [mainWebView goForward];
}

- (void)reloadClicked:(UIBarButtonItem *)sender {
    [mainWebView reload];
}

- (void)stopClicked:(UIBarButtonItem *)sender {
    [mainWebView stopLoading];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[self updateToolbarItems];
}

- (void)goCommentClicked:(id)sender {
}

- (void)shareClicked:(UIButton *)sender {
    
    
    ArticleItem *aArticleItem = (ArticleItem*)self.htmlString;
	NSString *shareString =  [NSString stringWithFormat:@"%@\r\n%@\r\n---任玩堂", aArticleItem.title, aArticleItem.articleURL];
    
    if (self.htmlString == nil) {
        shareString =  [NSString stringWithFormat:@"%@\r\n%@\r\n---任玩堂", [self.mainWebView stringByEvaluatingJavaScriptFromString:@"document.title"], self.mainWebView.request.URL.absoluteString];
    }
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        id<ISSContainer> container = [ShareSDK container];
//        [container setIPadContainerWithView:self.navigationItem.rightBarButtonItem.customView arrowDirect:UIPopoverArrowDirectionUp];
//        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"logoshare" ofType:@"jpg"];
//        //构造分享内容
//        id<ISSContent> publishContent = [ShareSDK content:shareString
//                                           defaultContent:@"默认分享内容,没内容时显示"
//                                                    image:[ShareSDK imageWithPath:imagePath]
//                                                    title:@"任玩堂" url:@"http://www.appgame.com" description:@"这是⼀条信息" mediaType:SSPublishContentMediaTypeNews];
//        
//        NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeSinaWeibo, ShareTypeTencentWeibo, ShareTypeMail, nil];//ShareTypeSMS, ShareTypeAirPrint, ShareTypeCopy
//        [ShareSDK showShareActionSheet:container shareList:shareList
//                               content:publishContent
//                         statusBarTips:YES
//                           authOptions:[ShareSDK authOptionsWithAutoAuth:YES
//                                                           allowCallback:NO
//                                                           authViewStyle:SSAuthViewStyleModal
//                                                            viewDelegate:nil
//                                                 authManagerViewDelegate:nil]
//                          shareOptions:[ShareSDK defaultShareOptionsWithTitle:@"分享"
//                                                              oneKeyShareList:shareList
//                                                               qqButtonHidden:YES
//                                                        wxSessionButtonHidden:YES
//                                                       wxTimelineButtonHidden:YES
//                                                         showKeyboardOnAppear:NO
//                                                            shareViewDelegate:nil
//                                                          friendsViewDelegate:nil
//                                                        picViewerViewDelegate:nil]
//                                result:^(ShareType type, SSPublishContentState state,
//                                         id<ISSStatusInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                    if (state == SSPublishContentStateSuccess)
//                                    {
//                                        NSLog(@"分享成功");
//                                    }
//                                    else if (state == SSPublishContentStateFail) {
//                                        NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
//                                    } }];
//        
//        //[self.pageActionSheet showFromBarButtonItem:self.actionBarButtonItem animated:YES];
//    }else {
//        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"logoshare" ofType:@"jpg"];
//        //构造分享内容
//        id<ISSContent> publishContent = [ShareSDK content:shareString
//                                           defaultContent:@"默认分享内容,没内容时显示"
//                                                    image:[ShareSDK imageWithPath:imagePath]
//                                                    title:@"任玩堂" url:@"http://www.appgame.com" description:@"这是⼀条信息" mediaType:SSPublishContentMediaTypeNews];
//        
//        NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeSinaWeibo, ShareTypeTencentWeibo, ShareTypeMail, nil];//ShareTypeSMS, ShareTypeAirPrint, ShareTypeCopy
//        [ShareSDK showShareActionSheet:nil shareList:shareList
//                               content:publishContent
//                         statusBarTips:YES
//                           authOptions:[ShareSDK authOptionsWithAutoAuth:YES
//                                                           allowCallback:NO
//                                                           authViewStyle:SSAuthViewStyleModal
//                                                            viewDelegate:nil
//                                                 authManagerViewDelegate:nil]
//                          shareOptions:[ShareSDK defaultShareOptionsWithTitle:@"分享"
//                                                              oneKeyShareList:shareList
//                                                               qqButtonHidden:YES
//                                                        wxSessionButtonHidden:YES
//                                                       wxTimelineButtonHidden:YES
//                                                         showKeyboardOnAppear:NO
//                                                            shareViewDelegate:nil
//                                                          friendsViewDelegate:nil
//                                                        picViewerViewDelegate:nil]
//                                result:^(ShareType type, SSPublishContentState state,
//                                         id<ISSStatusInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                    if (state == SSPublishContentStateSuccess)
//                                    {
//                                        NSLog(@"分享成功");
//                                    }
//                                    else if (state == SSPublishContentStateFail) {
//                                        NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
//                                    } }];
//    }
}


- (void)doneButtonClicked:(id)sender {
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    
	if([title isEqualToString:NSLocalizedString(@"在Safari中打开", @"")])
        [[UIApplication sharedApplication] openURL:self.mainWebView.request.URL];
    
    if([title isEqualToString:NSLocalizedString(@"复制链接", @"")]) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.mainWebView.request.URL.absoluteString;
    }
    
    else if([title isEqualToString:NSLocalizedString(@"用邮件发送", @"")]) {
        
		MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        
		mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:[self.mainWebView stringByEvaluatingJavaScriptFromString:@"document.title"]];
  		[mailViewController setMessageBody:self.mainWebView.request.URL.absoluteString isHTML:NO];
		mailViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        
        [self presentViewController:mailViewController animated:YES completion:nil];
	}
    
    pageActionSheet = nil;
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
