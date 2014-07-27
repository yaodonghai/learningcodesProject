//
//  OauthViewController.m
//  appgameprivilege
//
//  Created by 姚东海 on 14/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "OauthViewController.h"
#import "Globle.h"
#import "config.h"
#import "UserData.h"
#import "UserInfoServerInterface.h"
#import "ColorUtil.h"

@interface OauthViewController ()

@end

@implementation OauthViewController
@synthesize oauthrequestWebView;
@synthesize topView;
@synthesize oauthContentView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatUI];
    // Do any additional setup after loading the view.
}


#pragma mark - ViewController UI
-(void)creatUI{
    //self.view.backgroundColor=[UIColor blackColor];
    CGRect frame=CGRectMake(0, 0, [Globle shareInstance].globleWidth, [Globle shareInstance].globleHeight);
    self.view.frame=frame;
    self.oauthContentView=[[UIView alloc]initWithFrame:self.view.frame];
    
    if (IOS7_SYSTEM) {
        self.automaticallyAdjustsScrollViewInsets=NO;
        [oauthContentView setClipsToBounds:YES];
        CGRect IOS7ContentViewFame=oauthContentView.frame;
        IOS7ContentViewFame.origin.y=IOS7ContentViewFame.origin.y+20;
      //  IOS7ContentViewFame.size.height=IOS7ContentViewFame.size.height-20;
        [self.oauthContentView setFrame:IOS7ContentViewFame];
    }
    
    [self.view addSubview:self.oauthContentView];
    [self addTopBarView];
    oauthrequestWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, (topView.frame.origin.y+topView.frame.size.height), self.oauthContentView.frame.size.width, self.oauthContentView.frame.size.height-topView.frame.size.height)];
    oauthrequestWebView.backgroundColor=[UIColor whiteColor];
    oauthrequestWebView.scalesPageToFit =YES;
    oauthrequestWebView.delegate =self;
    [self.oauthContentView addSubview:self.oauthrequestWebView];
    [self OauthClient];
    
//    UIButton * loadBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    loadBtn.frame=CGRectMake(100, (oauthrequestWebView.frame.origin.y+oauthrequestWebView.frame.size.height+10), 60, 40);
//    [loadBtn setTitle:@"开始请求用户信息" forState:UIControlStateNormal];
//    [loadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [loadBtn addTarget:self action:@selector(loadAction:) forControlEvents:UIControlEventTouchUpInside];
//    [oauthContentView addSubview:loadBtn];
    
}

-(void)loadAction:(UIButton*)sender{

    
    if ([[AppConfig shareInstance].access_token isKindOfClass:[NSString class]]&&![[AppConfig shareInstance].access_token isEqualToString:@""]) {
        [self getUserinformation];

    }
    
}


/**
 *  添加顶部UI
 */
-(void)addTopBarView{
    UIImage * backimage=[ColorUtil imageWithColor:RGB(0, 159, 231) andSize:CGSizeMake(320, 44)];
    topView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [Globle shareInstance].globleWidth, 44)];
    topView.userInteractionEnabled=YES;
    topView.image=backimage;
    [self.oauthContentView addSubview:topView];
    
    UIImage *imgBtn = [UIImage imageNamed:@"3-单个游戏-返回.png"];

    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect rect;
    rect = leftButton.frame;
    rect.size  = imgBtn.size;
    rect.origin.x=10;
    rect.origin.y=(topView.frame.size.height-imgBtn.size.height)*0.5;
    leftButton.frame = rect;
    [leftButton setBackgroundImage:imgBtn forState:UIControlStateNormal];
    
    [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftButton setShowsTouchWhenHighlighted:YES];
    [leftButton addTarget:self action:@selector(clickGoBackButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topView addSubview:leftButton];
    UILabel * oauthTitleLable=[[UILabel alloc]initWithFrame:CGRectMake((self.topView.frame.size.width-200)*0.5, 0, 200, self.topView.frame.size.height)];
    oauthTitleLable.backgroundColor=[UIColor clearColor];
    oauthTitleLable.textColor=[UIColor whiteColor];
    oauthTitleLable.textAlignment=NSTextAlignmentCenter;
    oauthTitleLable.font=Font(18);
    oauthTitleLable.text=@"任玩堂登录中心";
    [self.topView addSubview:oauthTitleLable];
}

-(void)clickGoBackButton:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/**
 *  取得用户信息
 */
-(void)getUserinformation{
    UserInfoServerInterface * jsonuserClient=[UserInfoServerInterface serverInterface];
    
    NSDictionary *params = @{
                             TOKEN_PATH          : [AppConfig shareInstance].access_token
                             };
    
    
    
    [jsonuserClient getWithParams:params success:^(AFHTTPRequestOperation *request, id resultData, id responeData) {
        
        
    } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
        
        
    } loading:^(BOOL isLoading) {
       
        
    }];
}

/**
 *  取得token
 *
 *  @param codestring code
 */
-(void)getUserToken:(NSString*)codestring{

    
    AFOAuth2Client * jsonapiOAuthClient=[AFOAuth2Client clientWithBaseURL:[NSURL URLWithString:SEVER_API_Oauth] clientID:OAUTH_CLIENT_ID secret:@"test"];
    [jsonapiOAuthClient authenticateUsingOAuthWithPath:TOKEN_PATH code:codestring redirectURI:OAUTH_REDIRECT_URI success:^(AFOAuthCredential *credential) {
        [AppConfig shareInstance].access_token=credential.accessToken;
        //LOG(@"token--%@",credential.accessToken);
        LOG(@"tokenType--%@",credential.tokenType);
        LOG(@"refreshToken--%@",credential.refreshToken);

    } failure:^(NSError *error) {
        
    }];
    
    

}


/**
 *  筛选出URL 中的参数值
 *
 *  @param key    参数key
 *  @param source url 资源
 *  @param screenurl 筛选url
 *
 *  @return 参数的值
 */
-(NSString*)getParameterWithkey:(NSString*)key  Andsourch:(NSString*)sourceurl  Andscreen:(NSString*)screenurl{
    NSString * param=nil;
    NSRange range = [sourceurl rangeOfString:screenurl];
    int leight = range.length;
    if (leight>0) {
        NSString * suburl=[sourceurl substringFromIndex:(leight+1)];
        NSArray *aArray = [suburl componentsSeparatedByString:@"&"];
        if ([aArray isKindOfClass:[NSArray class]]&&aArray.count>0) {
            for (NSString * keystring in aArray) {
                NSRange range = [keystring rangeOfString:[NSString stringWithFormat:@"%@=",key]];
                //int location = range.location;
                int leight = range.length;
                if (leight>0) {
                    param= [keystring substringFromIndex:leight];
                    break;
                }
            }
            
        }
        
    }
    
    return param;
}

/**
 *  Oauth 链接
 */
-(void)OauthClient{

     NSString * oauthUrl=[NSString stringWithFormat:@"%@/%@?client_id=%@&redirect_uri=%@&response_type=code&scope=username",SEVER_API_Oauth,AUTHORIZE_PATH,OAUTH_CLIENT_ID,OAUTH_REDIRECT_URI];
    
     //NSString * oauthUrl=@"http://www.hao123.com/";
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:oauthUrl]];
    
    [self.oauthrequestWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if (inType==UIWebViewNavigationTypeFormSubmitted) {
        if (inType==UIWebViewNavigationTypeFormSubmitted) {
            NSString *url = inRequest.URL.absoluteString;
           // NSLog(@"URL---%@",url);
            NSString * keyv= [self getParameterWithkey:CODE Andsourch:url Andscreen:OAUTH_REDIRECT_URI];
            if (keyv) {
                code=keyv;
                [self getUserToken:code];

            }
    }

}
   return YES;
}

-(void)getToken:(NSString*)codeing{
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
   // NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
    
   // NSString *HTMLSource = [webView stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];
    
   // NSLog(@"%@",HTMLSource);
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
