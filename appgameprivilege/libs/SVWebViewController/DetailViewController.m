//
//  DetailViewController.m
//  VerticalSwipeArticles
//
//  Created by Peter Boctor on 12/26/10.
//
// Copyright (c) 2011 Peter Boctor
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE
//

#import "DetailViewController.h"
#import "ArticleItem.h"
#import "AppConfig.h"
#import "ColorUtil.h"
#import <ShareSDK/ShareSDK.h>//v2.1
#import "SVWebViewController.h"
#import "AFHTTPClient.h"
#import "AFXMLRequestOperation.h"
#import "GlobalConfigure.h"
#import "Globle.h"

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

@interface DetailViewController (PrivateMethods)
-(void)hideGradientBackground:(UIView*)theView;
-(UIWebView*) createWebViewForIndex:(NSUInteger)index;
- (void)shareClicked:(UIBarButtonItem *)sender;
- (void)goPopClicked:(UIBarButtonItem *)sender;
@end

@implementation DetailViewController

@synthesize headerView, headerImageView, headerLabel;
@synthesize footerView, footerImageView, footerLabel;
@synthesize verticalSwipeScrollView, appData, startIndex, pageIndex;
@synthesize previousPage, nextPage, currentPage;

- (id)initWithTitle:(NSString *)title
{
    self = [super initWithNibName:nil bundle:nil];
    if (self != nil)
    {
        // Further initialization if needed
    }
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
    
    self.title = title;
    return self;
}

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor clearColor];
    //self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    //self.view.backgroundColor = [UIColor colorWithRed:211.0f/255.0f green:214.0f/255.0f blue:219.0f/255.0f alpha:1.0f];
    
    //self.view.frame = CGRectMake(0, 0, [Globle shareInstance].globleWidth, [Globle shareInstance].globleHeight);
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background-2.png"]];
//    UIImage *image = [UIImage imageNamed:@"i4-背景图.png"];
//    if (IPhone5) {
//        image = [UIImage imageNamed:@"i5-背景图.png"];
//    }
    //UIImageView *bg = [[UIImageView alloc] initWithImage:image];
   // bg.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
  //  bg.alpha = 0.5f;
   // [self.view addSubview:bg];
    
    self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(59, 13, 241, 21)];
    self.headerLabel.backgroundColor = [UIColor clearColor];
    self.footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(59, 13, 241, 21)];
    self.footerLabel.backgroundColor = [UIColor clearColor];
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 4, 21, 39)];
    [self.headerImageView setContentMode:UIViewContentModeScaleToFill];
    [self.headerImageView setBackgroundColor:[UIColor clearColor]];
    self.headerImageView.image = [UIImage imageNamed:@"PullArrow.png"];
    
    self.footerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 4, 21, 39)];
    [self.footerImageView setContentMode:UIViewContentModeScaleToFill];
    [self.footerImageView setBackgroundColor:[UIColor clearColor]];
    self.footerImageView.image = [UIImage imageNamed:@"PullArrow.png"];
    
    self.headerImageView.transform = CGAffineTransformMakeRotation(DegreesToRadians(180));
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
    self.headerView.backgroundColor = [UIColor clearColor];
    self.headerView.backgroundColor = [UIColor colorWithRed:211.0f/255.0f green:214.0f/255.0f blue:219.0f/255.0f alpha:0.7f];
    self.footerView.backgroundColor = [UIColor clearColor];
    self.footerView.backgroundColor = [UIColor colorWithRed:211.0f/255.0f green:214.0f/255.0f blue:219.0f/255.0f alpha:0.7f];
    self.headerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.footerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    [self.headerView addSubview:self.headerImageView];
    [self.headerView addSubview:self.headerLabel];
    [self.footerView addSubview:self.footerImageView];
    [self.footerView addSubview:self.footerLabel];
    
    self.verticalSwipeScrollView = [[VerticalSwipeScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-44-20) headerView:self.headerView footerView:self.footerView startingAt:startIndex delegate:self];
    //self.verticalSwipeScrollView.externalDelegate = self;
    [self.view addSubview:self.verticalSwipeScrollView];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(goPopClicked:)];
    swipeGesture.delegate = self;
    [swipeGesture setDirection:(UISwipeGestureRecognizerDirectionRight)];
    swipeGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:swipeGesture];
}

- (void)viewWillAppear:(BOOL)animated {
    //NSLog(@"viewWillAppear");
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController setToolbarHidden:YES animated:animated];
    UIImage * backimage=[ColorUtil imageWithColor:RGB(0, 159, 231) andSize:CGSizeMake(320, 44)];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {

        //IOS5
        [self.navigationController.navigationBar setBackgroundImage:backimage forBarMetrics:UIBarMetricsDefault];
        
        if ([self.navigationController.toolbar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
            [self.navigationController.toolbar setBackgroundImage:backimage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
        }
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    }else {//IOS4
        
        [self.navigationController.toolbar insertSubview:[[UIImageView alloc] initWithImage:backimage] atIndex:0];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
    return NO;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}

- (void)goPopClicked:(UIBarButtonItem *)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)shareClicked:(UIBarButtonItem *)sender {
        ArticleItem *aArticleItem = (ArticleItem*)[self.appData objectAtIndex:pageIndex];

    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:aArticleItem.title
                                       defaultContent:@"这是⼀条信息"
                                                image:[ShareSDK pngImageWithImage:[UIImage imageNamed:@"Icon.png"]]
                                                title:aArticleItem.title
                                                  url:aArticleItem.articleURL.absoluteString
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
    
    
//    ArticleItem *aArticleItem = (ArticleItem*)[self.appData objectAtIndex:pageIndex];
//	NSString *shareString =  [NSString stringWithFormat:@"%@\r\n%@\r\n---任玩堂", aArticleItem.title, aArticleItem.articleURL];
//    
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
//        NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeSinaWeibo, ShareTypeTencentWeibo, ShareTypeMail,nil];// ShareTypeSMS, ShareTypeAirPrint, ShareTypeCopy
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






- (void) rotateImageView:(UIImageView*)imageView angle:(CGFloat)angle
{
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.2];
  imageView.transform = CGAffineTransformMakeRotation(DegreesToRadians(angle));
  [UIView commitAnimations];
}

# pragma mark VerticalSwipeScrollViewDelegate

-(void) headerLoadedInScrollView:(VerticalSwipeScrollView*)scrollView
{
  [self rotateImageView:headerImageView angle:0];
}

-(void) headerUnloadedInScrollView:(VerticalSwipeScrollView*)scrollView
{
  [self rotateImageView:headerImageView angle:180];
}

-(void) footerLoadedInScrollView:(VerticalSwipeScrollView*)scrollView
{
  [self rotateImageView:footerImageView angle:180];
}

-(void) footerUnloadedInScrollView:(VerticalSwipeScrollView*)scrollView
{
  [self rotateImageView:footerImageView angle:0];
}

-(UIView*) viewForScrollView:(VerticalSwipeScrollView*)scrollView atPage:(NSUInteger)page
{
    //UIWebView* webView = nil;

    if (page < scrollView.currentPageIndex)
    currentPage = previousPage;
    else if (page > scrollView.currentPageIndex)
    currentPage = nextPage;

    if (!currentPage)
    currentPage = [self createWebViewForIndex:page];
    
    //NSLog(@"createwebviewindex:%d",page);
    self.previousPage = (page > 0 && page < appData.count) ? [self createWebViewForIndex:page-1] : nil;
    self.nextPage = (page == (appData.count-1)) ? nil : [self createWebViewForIndex:page+1];
    ArticleItem *hArticle, *fArticle;
    if (page > 0 && page < appData.count)
        hArticle = [appData objectAtIndex:page-1];
        headerLabel.text = hArticle.title;
    if (page < appData.count-1)
        fArticle = [appData objectAtIndex:page+1];
        footerLabel.text = fArticle.title;

    pageIndex = page;
    currentPage.delegate = self;
    previousPage.delegate = self;
    nextPage.delegate = self;
    
    return currentPage;
}

-(NSUInteger) pageCount
{
  return appData.count;
}

-(UIWebView*) createWebViewForIndex:(NSUInteger)index
{
    CGRect webFrame = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20-44);
    UIWebView* webView = [[UIWebView alloc] initWithFrame:webFrame];    
    webView.opaque = NO;
    //webView.alpha = 0.6f;
    [webView setBackgroundColor:[UIColor clearColor]];
    [webView setBackgroundColor:[UIColor grayColor]];
    webView.scalesPageToFit = YES;
    //[webView setBackgroundColor:[UIColor colorWithWhite:111.0/256.0 alpha:0.7f]];
    [self hideGradientBackground:webView];

    ArticleItem *aArticle = [appData objectAtIndex:index];
    [webView loadHTMLString:aArticle.content baseURL:aArticle.articleURL];
    
  return webView;
}

- (void) hideGradientBackground:(UIView*)theView
{
  for (UIView * subview in theView.subviews)
  {
    if ([subview isKindOfClass:[UIImageView class]])
      subview.hidden = YES;

    [self hideGradientBackground:subview];
  }
}

- (void)viewDidUnload
{
  self.headerView = nil;
  self.headerImageView = nil;
  self.headerLabel = nil;

  self.footerView = nil;
  self.footerImageView = nil;
  self.footerLabel = nil;
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    //处理不同的URL
    if (inType == UIWebViewNavigationTypeLinkClicked) {
        //[[UIApplication sharedApplication] openURL:[inRequest URL]];
        //NSLog(@"host:%@\npath:%@",[[inRequest URL] host],[[inRequest URL] path]);
        if ([[[inRequest URL] host] rangeOfString:@".appgame.com"].location != NSNotFound) {
            //if (self.htmlString != nil) {
            NSLog(@"站内页面");
            AFHTTPClient *jsonapiClient = [AFHTTPClient clientWithBaseURL:[inRequest URL]];
            
            NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                        @"get_post", @"json",
                                        nil];
            
            [jsonapiClient getPath:@""
                        parameters:parameters
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               
                               __block NSString *jsonString = operation.responseString;
                               
                               //过滤掉w3tc缓存附加在json数据后面的
                               /*
                                <!-- W3 Total Cache: Page cache debug info:
                                Engine:             memcached
                                Cache key:          4e14f98a5d7a178df9c7d3251ace098d
                                Caching:            enabled
                                Status:             not cached
                                Creation Time:      2.143s
                                Header info:
                                X-Powered-By:        PHP/5.4.14-1~precise+1
                                X-W3TC-Minify:       On
                                Last-Modified:       Sun, 12 May 2013 16:17:48 GMT
                                Vary:
                                X-Pingback:           http://www.appgame.com/xmlrpc.php
                                Content-Type:         application/json; charset=UTF-8
                                -->
                                */
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
                                       vc.isshowRefreshView=YES;
                                       //NSLog(@"didSelectArticle:%@",aArticle.content);
                                       [self.navigationController pushViewController:vc animated:YES];
                                   }
                               }
                           }
                           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               // pass error to the block
                               NSLog(@"获取文章json失败:%@",error);
                           }];
            
            
            //            SVWebViewController *viewController = [[SVWebViewController alloc] initWithURL:[inRequest URL]];
            //            [self.navigationController pushViewController:viewController animated:YES];
        }else if([[[inRequest URL] host] rangeOfString:@"itunes.apple.com"].location != NSNotFound){
            NSLog(@"站外链接:%@",inRequest.URL);
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@", @"586743861"]]];
            [[UIApplication sharedApplication] openURL:inRequest.URL];
        }
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
