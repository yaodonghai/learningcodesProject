//
//  GHRootViewController.m
//  GHSidebarNav
//
//  Created by Greg Haines on 11/20/11.
//

#import "GHRootViewController.h"
//#import "GHPushedViewController.h"
#import "HMSideMenu.h"
#import "ColorUtil.h"
#import "global_defines.h"
#pragma mark -
#pragma mark Private Interface
@interface GHRootViewController () <UIWebViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong, readonly) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *forwardBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *refreshBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *stopBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *actionBarButtonItem;
@property (nonatomic, strong, readonly) UIActionSheet *pageActionSheet;

//@property (nonatomic, strong) UIWebView *mainWebView;
@property (nonatomic, strong) NSURL *URL;
@property (nonatomic) BOOL isHide;

//- (id)initWithAddress:(NSString*)urlString;
//- (id)initWithURL:(NSURL*)URL;

- (void)updateToolbarItems;

- (void)goBackClicked:(UIBarButtonItem *)sender;
- (void)goForwardClicked:(UIBarButtonItem *)sender;
- (void)reloadClicked:(UIBarButtonItem *)sender;
- (void)stopClicked:(UIBarButtonItem *)sender;
- (void)actionButtonClicked:(UIBarButtonItem *)sender;
- (void)goPopClicked:(UIBarButtonItem *)sender;

//- (void)pushViewController;
- (void)revealSidebar;
@end


#pragma mark -
#pragma mark Implementation
@implementation GHRootViewController
@synthesize webURL;
@synthesize activityIndicator;
@synthesize availableActions;
@synthesize isshowButtons=_isshowButtons;
@synthesize URL, mainWebView, isHide;
@synthesize isshowRefreshView=_isshowRefreshView;
@synthesize backBarButtonItem, forwardBarButtonItem, refreshBarButtonItem, stopBarButtonItem, actionBarButtonItem, pageActionSheet;
@synthesize isOperationBtns;
@synthesize refreshview=_refreshview;
#pragma mark Memory Management
- (id)initWithTitle:(NSString *)title withUrl:(NSString *)url {
    if (self = [super init]) {
		self.title = title;
        self.webURL = [NSURL URLWithString:url];
        self.URL = [NSURL URLWithString:url];
        self.availableActions = GHWebViewControllerAvailableActionsOpenInSafari | GHWebViewControllerAvailableActionsMailLink | GHWebViewControllerAvailableActionsCopyLink;
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];

        UIImage *imgBtn = [UIImage imageNamed:@"3-单个游戏-返回.png"];
        CGRect rect;
        rect = leftButton.frame;
        rect.size  = imgBtn.size;            // set button size as image size
        leftButton.frame = rect;
        [leftButton setBackgroundImage:imgBtn forState:UIControlStateNormal];
        [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [leftButton setShowsTouchWhenHighlighted:YES];
        [leftButton addTarget:self action:@selector(goPopClicked:) forControlEvents:UIControlEventTouchUpInside];
        //[leftButton setTitle:@" 后退" forState:UIControlStateNormal];
        //[leftButton.titleLabel setFont:[UIFont boldSystemFontOfSize:11]];
        
        UIBarButtonItem *temporaryLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        temporaryLeftBarButtonItem.style = UIBarButtonItemStylePlain;
        self.navigationItem.leftBarButtonItem = temporaryLeftBarButtonItem;
        
        
        UIImage * praiseimage=[UIImage imageNamed:@"Praise_normal.png"];
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(0, 0, praiseimage.size.width, praiseimage.size.height);
        [rightButton setBackgroundImage:praiseimage forState:UIControlStateNormal];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"Praise_hightlight.png"] forState:UIControlStateHighlighted];
        
        [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [rightButton setShowsTouchWhenHighlighted:YES];
        [rightButton addTarget:self action:@selector(shareClicked:) forControlEvents:UIControlEventTouchUpInside];
        // [rightButton setTitle:@"分享" forState:UIControlStateNormal];
        [rightButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15.0]];
        rightButton.titleLabel.textColor = [UIColor whiteColor];
        
        UIBarButtonItem *temporaryRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        temporaryRightBarButtonItem.style = UIBarButtonItemStylePlain;
        self.navigationItem.rightBarButtonItem = temporaryRightBarButtonItem;
    }
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
	return self;
}

- (id)initWithTitle:(NSString *)title withUrl:(NSString *)url withRevealBlock:(RevealBlock)revealBlock {
    if (self = [super init]) {
		self.title = title;
        self.webURL = [NSURL URLWithString:url];
        self.URL = [NSURL URLWithString:url];
        self.availableActions = GHWebViewControllerAvailableActionsOpenInSafari | GHWebViewControllerAvailableActionsMailLink | GHWebViewControllerAvailableActionsCopyLink;
		_revealBlock = [revealBlock copy];
        
//		self.navigationItem.leftBarButtonItem =
//			[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIButtonTypeCustom
//														  target:self
//														  action:@selector(revealSidebar)];
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //leftButton.frame = CGRectMake(0, 0, 50, 26);
        UIImage *imgBtn = [UIImage imageNamed:@"3-单个游戏-返回.png"];
        CGRect rect;
        rect = leftButton.frame;
        rect.size  = imgBtn.size;            // set button size as image size
        leftButton.frame = rect;
        [leftButton setBackgroundImage:imgBtn forState:UIControlStateNormal];
        [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [leftButton setShowsTouchWhenHighlighted:YES];
        [leftButton addTarget:self action:@selector(revealSidebar) forControlEvents:UIControlEventTouchUpInside];
        //[leftButton setTitle:@" 后退" forState:UIControlStateNormal];
        //[leftButton.titleLabel setFont:[UIFont boldSystemFontOfSize:11]];
        
        UIBarButtonItem *temporaryLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        temporaryLeftBarButtonItem.style = UIBarButtonItemStylePlain;
        self.navigationItem.leftBarButtonItem = temporaryLeftBarButtonItem;
        //[temporaryRightBarButtonItem release];

	}
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
//    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
//    [self.view addGestureRecognizer:singleTap];
//    singleTap.delegate = self;
//    singleTap.cancelsTouchesInView = NO;
//    }
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
	return self;
}

-(void)setIsshowButtons:(BOOL)aisshowButtons{
    _isshowButtons=aisshowButtons;
    if (aisshowButtons) {
        [self  creatOperationButton];
    }
}


-(void)setIsOperationBtns:(BOOL)aisOperationBtns{
    isOperationBtns=aisOperationBtns;
    if (aisOperationBtns) {
        [self creatOperationButton];
    
    }
}


-(void)setIsshowRefreshView:(BOOL)isshowRefreshView{
    _isshowRefreshView=isshowRefreshView;
    if (!_refreshview) {
       // LOG(@"----w----%f----h----%f",self.view.frame.size.width,self.view.frame.size.height);
        _refreshview= [[Refreshview alloc]initWithRefreshviewFrame:CGPointMake((self.view.frame.size.width-50),(self.view.frame.size.height-100))];
        [self.view addSubview:_refreshview];
        __unsafe_unretained GHRootViewController * vc=self;
        _refreshview.refreshwebblock=^(BOOL  state,Refreshview * refreshview){
            [vc reloadClicked];
        };
    
    }
}
/**
 *  添加操伯按扭
 */
-(void)creatOperationButton{
    //添加刷新与后退按钮
    UIView *twitterItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [twitterItem setMenuActionWithBlock:^{
        [[self mainWebView] goBack];
    }];
    UIImageView *twitterIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [twitterIcon setImage:[UIImage imageNamed:@"撤退.png"]];
    [twitterItem addSubview:twitterIcon];
    
    UIView *emailItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emailItem setMenuActionWithBlock:^{
        [[self mainWebView] goForward];
    }];
    UIImageView *emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emailIcon setImage:[UIImage imageNamed:@"前进.png"]];
    [emailItem addSubview:emailIcon];
    
    
    UIView *browserItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [browserItem setMenuActionWithBlock:^{
        [self reloadClicked];
    }];
    UIImageView *browserIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [browserIcon setImage:[UIImage imageNamed:@"刷新.png"]];
    [browserItem addSubview:browserIcon];
    
  HMSideMenu *   webSideMenu = [[HMSideMenu alloc] initWithItems:@[twitterItem, emailItem, browserItem]];
    [webSideMenu setItemSpacing:10.0f];
    [[self mainWebView] addSubview:webSideMenu];
    [webSideMenu open];
}
#pragma mark UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.view.backgroundColor = [UIColor lightGrayColor];
    [self updateToolbarItems];
    
    //添加push按钮，导航到GHPushedViewController
//	UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//	[pushButton setTitle:@"Push" forState:UIControlStateNormal];
//	[pushButton addTarget:self action:@selector(pushViewController) forControlEvents:UIControlEventTouchUpInside];
//	[pushButton sizeToFit];
	//[self.view addSubview:pushButton];
    
    //添加mywebview，显示攻略
    //NSURL *URL = [NSURL URLWithString:@"http://ol.appgame.com/mc4/"];
    //SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:self.webURL];
    
//	UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    NSURLRequest *request =[NSURLRequest requestWithURL:self.webURL];
//    [self.view addSubview: webView];
//    [webView loadRequest:request];
}


#pragma mark  share
- (void)shareClicked:(UIBarButtonItem *)sender {
    //ArticleItem *aArticleItem = (ArticleItem*)[self.appData objectAtIndex:pageIndex];
//    if (<#condition#>) {
//        <#statements#>
//    }
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:self.title
                                       defaultContent:@"这是⼀条信息"
                                                image:[ShareSDK pngImageWithImage:[UIImage imageNamed:@"Icon.png"]]
                                                title:self.title
                                                  url:self.URL.absoluteString
                                          description:@"这是⼀条信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
    
    
  }

#pragma mark Private Methods
//- (void)pushViewController {
//	NSString *vcTitle = [self.title stringByAppendingString:@" - Pushed"];
//	UIViewController *vc = [[GHPushedViewController alloc] initWithTitle:vcTitle];
//	[self.navigationController pushViewController:vc animated:YES];
//}

- (void)revealSidebar {
	_revealBlock();
}

- (void)goPopClicked:(UIBarButtonItem *)sender {
    if ([[self navigationController].viewControllers count]>1)
    {
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

#pragma mark - setters and getters

- (UIBarButtonItem *)backBarButtonItem {
    
    if (!backBarButtonItem) {
                backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SVWebViewController.bundle/iPhone/back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackClicked:)];
                backBarButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
        		backBarButtonItem.width = 18.0f;
        
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setFrame:CGRectMake(0.0f, 0.0f, 42.0f, 44.0f)];
//        backBarButtonItem.width = 42.0f;
//        
//        [button setBackgroundImage:[UIImage imageNamed:@"前进.png"] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"Advance-Touch.png"] forState:UIControlStateHighlighted];
//        
//        [button addTarget:self action:@selector(goBackClicked:) forControlEvents:UIControlEventTouchUpInside];
//        
//        backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return backBarButtonItem;
}

- (UIBarButtonItem *)forwardBarButtonItem {
    
    if (!forwardBarButtonItem) {
                forwardBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SVWebViewController.bundle/iPhone/forward"] style:UIBarButtonItemStylePlain target:self action:@selector(goForwardClicked:)];
                forwardBarButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
        		forwardBarButtonItem.width = 18.0f;
        
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setFrame:CGRectMake(0.0, 0.0f, 42.0f, 44.0f)];
//        backBarButtonItem.width = 42.0f;
//        
//        [button setBackgroundImage:[UIImage imageNamed:@"Retreat.png"] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"Retreat-Touch.png"] forState:UIControlStateHighlighted];
//        
//        [button addTarget:self action:@selector(goForwardClicked:) forControlEvents:UIControlEventTouchUpInside];
//        
//        forwardBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    return forwardBarButtonItem;
}

- (UIBarButtonItem *)refreshBarButtonItem {
    
    if (!refreshBarButtonItem) {
        refreshBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadClicked:)];
        
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setFrame:CGRectMake(0.0f, 0.0f, 42.0f, 44.0f)];
//        backBarButtonItem.width = 42.0f;
//        
//        [button setBackgroundImage:[UIImage imageNamed:@"Refresh.png"] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"Refresh-Touch.png"] forState:UIControlStateHighlighted];
//        
//        [button addTarget:self action:@selector(reloadClicked:) forControlEvents:UIControlEventTouchUpInside];
//        
//        refreshBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    return refreshBarButtonItem;
}

- (UIBarButtonItem *)stopBarButtonItem {
    
    if (!stopBarButtonItem) {
        stopBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopClicked:)];
        
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setFrame:CGRectMake(0.0f, 0.0f, 42.0f, 44.0f)];
//        backBarButtonItem.width = 42.0f;
//        
//        [button setBackgroundImage:[UIImage imageNamed:@"Close.png"] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"Close-Touch.png"] forState:UIControlStateHighlighted];
//        
//        [button addTarget:self action:@selector(stopClicked:) forControlEvents:UIControlEventTouchUpInside];
//        
//        stopBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return stopBarButtonItem;
}

- (UIBarButtonItem *)actionBarButtonItem {
    
    if (!actionBarButtonItem) {
        actionBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionButtonClicked:)];
        
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setFrame:CGRectMake(0.0f, 0.0f, 42.0f, 44.0f)];
//        backBarButtonItem.width = 42.0f;
//        
//        [button setBackgroundImage:[UIImage imageNamed:@"Share.png"] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"Share-Touch.png"] forState:UIControlStateHighlighted];
//        
//        [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        
//        actionBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
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
        
        if((self.availableActions & GHWebViewControllerAvailableActionsCopyLink) == GHWebViewControllerAvailableActionsCopyLink)
            [pageActionSheet addButtonWithTitle:NSLocalizedString(@"复制链接", @"")];
        
        if((self.availableActions & GHWebViewControllerAvailableActionsOpenInSafari) == GHWebViewControllerAvailableActionsOpenInSafari)
            [pageActionSheet addButtonWithTitle:NSLocalizedString(@"在Safari中打开", @"")];
        
        if([MFMailComposeViewController canSendMail] && (self.availableActions & GHWebViewControllerAvailableActionsMailLink) == GHWebViewControllerAvailableActionsMailLink)
            [pageActionSheet addButtonWithTitle:NSLocalizedString(@"用邮件发送", @"")];
        
        [pageActionSheet addButtonWithTitle:NSLocalizedString(@"取消", @"")];
        pageActionSheet.cancelButtonIndex = [self.pageActionSheet numberOfButtons]-1;
    }
    
    return pageActionSheet;
}

#pragma mark - UIPanGestureRecognizer

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    //        UIView *view = [gestureRecognizer view]; // 这个view是手势所属的view，也就是增加手势的那个view
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateEnded:{ // UIGestureRecognizerStateRecognized = UIGestureRecognizerStateEnded // 正常情况下只响应这个消息
            CGContextRef context = UIGraphicsGetCurrentContext();
            [UIView beginAnimations:nil context:context];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:1.0];
            if (self.isHide) {
//                [self.navigationController.navigationBar setAlpha:1.0f];
//                [self.navigationController.toolbar setAlpha:1.0f];
                
                [self.navigationController setNavigationBarHidden:NO animated:YES];
                [self.navigationController setToolbarHidden:NO animated:YES];
                self.isHide = FALSE;
            }else{
//                [self.navigationController.navigationBar setAlpha:0.0f];
//                [self.navigationController.toolbar setAlpha:0.0f];
                
                [self.navigationController setNavigationBarHidden:YES animated:YES];
                [self.navigationController setToolbarHidden:YES animated:YES];
                self.isHide = TRUE;
            }
            [UIView commitAnimations];
            
            //            NSLog(@"======UIGestureRecognizerStateEnded || UIGestureRecognizerStateRecognized");
            
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
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
}

#pragma mark - View lifecycle

- (void)loadView {
    mainWebView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    mainWebView.delegate = self;
    mainWebView.scalesPageToFit = YES;
    //[mainWebView loadRequest:[NSURLRequest requestWithURL:self.URL]];
    self.view = mainWebView;
}

//- (void)viewDidLoad {
//	[super viewDidLoad];
//    [self updateToolbarItems];
//}

- (void)viewDidUnload {
    [super viewDidUnload];
    mainWebView = nil;
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
    
    if ([mainWebView isLoading]) {
        [mainWebView stopLoading];
    }//每次切换tabbar,重新刷新默认页面
    //[mainWebView loadRequest:[NSURLRequest requestWithURL:self.URL]];
    
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //self.navigationController.toolbar.barStyle = UIBarStyleBlack;
        //[self.navigationController.toolbar setTranslucent:YES];
        //[self.navigationController.navigationBar setTranslucent:YES];
        [self.navigationController setToolbarHidden:YES animated:animated];
        //self.navigationController.toolbar.translucent = NO;
        UIImage * backimage=[ColorUtil imageWithColor:RGB(0, 159, 231) andSize:CGSizeMake(320, 44)];

        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {
            //IOS5
            [self.navigationController.navigationBar setBackgroundImage:backimage forBarMetrics:UIBarMetricsDefault];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
            
            if ([self.navigationController.toolbar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
                [self.navigationController.toolbar setBackgroundImage:backimage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
            }
        }else {//IOS4
            
            [self.navigationController.toolbar insertSubview:[[UIImageView alloc] initWithImage:backimage] atIndex:0];
        }
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //[self.navigationController.navigationBar setTranslucent:NO];
        //[self.navigationController setToolbarHidden:YES animated:animated];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES;
    
    //return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;

}

#pragma mark - Toolbar

- (void)updateToolbarItems {
    self.backBarButtonItem.enabled = self.mainWebView.canGoBack;
    self.forwardBarButtonItem.enabled = self.mainWebView.canGoForward;
    self.actionBarButtonItem.enabled = !self.mainWebView.isLoading;
//    if (self.mainWebView.isLoading) {
//        NSLog(@"isLoading");
//    }
    UIBarButtonItem *refreshStopBarButtonItem = self.mainWebView.isLoading ? self.stopBarButtonItem : self.refreshBarButtonItem;
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 5.0f;
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
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
        toolbar.barStyle = UIBarStyleBlack;

        toolbar.items = items;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:toolbar];
    }
    
    else {
        NSArray *items;
        
        if(self.availableActions == 0) {
            items = [NSArray arrayWithObjects:
                     flexibleSpace,
                     self.backBarButtonItem,
                     flexibleSpace,
                     self.forwardBarButtonItem,
                     flexibleSpace,
                     refreshStopBarButtonItem,
                     flexibleSpace,
                     nil];
        } else {
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
        
        self.toolbarItems = items;
    }
}





#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (_refreshview) {
        [_refreshview start];
    }
	//[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //创建UIActivityIndicatorView背底半透明View
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, CGRectGetHeight(self.view.bounds))];
//    [view setTag:108];
//    [view setBackgroundColor:[UIColor blackColor]];
//    [view setAlpha:0.5];
//    [self.view addSubview:view];
    
    [activityIndicator setCenter:webView.center];
    [webView addSubview:activityIndicator];

    //NSLog(@"webViewDidStartLoad:%@",self.URL.absoluteString);
    
    [activityIndicator startAnimating];
    [self updateToolbarItems];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (_refreshview) {
        [_refreshview stop];

    }
    //NSLog(@"webViewDidFinishLoad:%@",self.URL.absoluteString);// webView.request.URL.absoluteString);
	//[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    [activityIndicator stopAnimating];
//    UIView *view = (UIView*)[self.view viewWithTag:108];
    [activityIndicator removeFromSuperview];
    //self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self updateToolbarItems];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	//[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (_refreshview) {
        
        [_refreshview stop];
        
    }    [activityIndicator stopAnimating];
//    UIView *view = (UIView*)[self.view viewWithTag:108];
    [activityIndicator removeFromSuperview];
    
    [self updateToolbarItems];
}

#pragma mark - Target actions

- (void)goBackClicked:(UIBarButtonItem *)sender {
    [mainWebView goBack];
}

- (void)goForwardClicked:(UIBarButtonItem *)sender {
    [mainWebView goForward];
}

- (void)reloadClicked {
    if ([mainWebView.request.URL.absoluteString isEqualToString:@""]) {
        [mainWebView loadRequest:[NSURLRequest requestWithURL:self.URL]];
    }else {
        [mainWebView reload];
    }
}

- (void)reloadClicked:(UIBarButtonItem *)sender {
    if (mainWebView.request == nil) {
        [mainWebView loadRequest:[NSURLRequest requestWithURL:self.URL]];
    }else {
        [mainWebView reload];
    }
}

- (void)stopClicked:(UIBarButtonItem *)sender {

    if ([self.mainWebView isLoading]) {
        [self.mainWebView stopLoading];
    }
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
	[self updateToolbarItems];
}

- (void)actionButtonClicked:(id)sender {
    
    if(pageActionSheet)
        return;
	
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        [self.pageActionSheet showFromBarButtonItem:self.actionBarButtonItem animated:YES];
    else
        [self.pageActionSheet showFromToolbar:self.navigationController.toolbar];
    
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
        
		//[self presentModalViewController:mailViewController animated:YES];
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
	//[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
