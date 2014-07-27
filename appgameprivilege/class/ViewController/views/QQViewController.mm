//
//  QQViewController.m
//  WGFrameworkDemo
//
//  Created by fly chen on 2/22/13.
//  Copyright (c) 2013 tencent.com. All rights reserved.
//

#import "QQViewController.h"
//#import "testViewController.h"


#ifdef FRAMEWORK_RESOURCE
#import "WGPlatform.h"
#import "WGInterface.h"
#import "WGPublicDefine.h"

#else
#import <WGPlatform/WGInterface.h>
#import <WGPlatform/WGPlatform.h>
#import <WGPlatform/WGPublicDefine.h>
#endif

#import "QQViewController.h"


#import "MyObserver.h"

#define PayPayitem       "1";
#define PayProductid  "com.tencent.pay.test5"

#define PayZoneid  "1"
#define PayVarItem       "is me  come back";

@interface QQViewController ()

@end

@implementation QQViewController
@synthesize lbLog=_lbLog;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    WGPlatform* plat = WGPlatform::GetInstance();
    plat->WGEnableCrashReport(true, false); //开启RDM crash记录
    
    //测试crash统计
    //    NSString *test;
    //    int a = [test length];
    //    NSLog(@"test crash report  %@",test);
    NSLog(@"iphone QQ version = %d",plat->WGGetIphoneQQVersion());
    plat->WGOpenMSDKLog(true);
    NSLog(@"sdk version: %s", plat->WGGetVersion().c_str());
    plat->WGLogPlatformSDKVersion();
    
    
    int x=5;
    int y=5;
    int height = 40;
    int width = 100;
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.backgroundColor = [UIColor blueColor];
    button.frame = CGRectMake(5,5,width,height);
    [button setTitle:@"QQ验证" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClickQQAuth:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton* buttonRecord = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonRecord.backgroundColor = [UIColor blueColor];
    buttonRecord.frame = CGRectMake(5,50,width,height);
    [buttonRecord setTitle:@"record" forState:UIControlStateNormal];
    [buttonRecord addTarget:self action:@selector(getrecord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonRecord];
    
    
    UIButton* button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.backgroundColor = [UIColor blueColor];
    button1.frame = CGRectMake(110,5,width,height);
    [button1 setTitle:@"分享Qzone" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(onClickQQShare:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton* button11 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button11.backgroundColor = [UIColor blueColor];
    button11.frame = CGRectMake(110,50,width,height);
    [button11 setTitle:@"分享个人" forState:UIControlStateNormal];
    [button11 addTarget:self action:@selector(onClickQQShare2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button11];
    
    UIButton* button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.backgroundColor = [UIColor blueColor];
    button2.frame = CGRectMake(215,5,width,height);
    [button2 setTitle:@"图片Qzone" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(onClickQQPhotoShare:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton* button22 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button22.backgroundColor = [UIColor blueColor];
    button22.frame = CGRectMake(215,50,width,height);
    [button22 setTitle:@"图片个人" forState:UIControlStateNormal];
    [button22 addTarget:self action:@selector(onClickQQPhotoShare2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button22];
    
    
    UIButton* button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button3.backgroundColor = [UIColor blueColor];
    button3.frame = CGRectMake(5,95,width,height);
    [button3 setTitle:@"微信验证" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(onClickWXAuth:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    
    UIButton* button4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button4.backgroundColor = [UIColor blueColor];
    button4.frame = CGRectMake(110,95,width,height);
    [button4 setTitle:@"分享到微信" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(onClickWXShare:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
//    UIButton* button44 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    button44.backgroundColor = [UIColor blueColor];
//    button44.frame = CGRectMake(110,140,width,height);
//    [button44 setTitle:@"分享好友圈" forState:UIControlStateNormal];
//    [button44 addTarget:self action:@selector(onClickWXShare2:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button44];
    
    UIButton* button5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button5.backgroundColor = [UIColor blueColor];
    button5.frame = CGRectMake(215,95,width,height);
    [button5 setTitle:@"分享图片微信" forState:UIControlStateNormal];
    [button5 addTarget:self action:@selector(onClickWXSharePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    UIButton* button55 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button55.backgroundColor = [UIColor blueColor];
    button55.frame = CGRectMake(215,140,width,height);
    [button55 setTitle:@"图片好友圈" forState:UIControlStateNormal];
    [button55 addTarget:self action:@selector(onClickWXSharePhoto2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button55];
    
    
    UIButton* button6 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button6.backgroundColor = [UIColor blueColor];
    button6.frame = CGRectMake(5,190,width,height);
    [button6 setTitle:@"上报事件" forState:UIControlStateNormal];
    [button6 addTarget:self action:@selector(onClickEvt:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button6];
    
    UIButton* button7 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button7.backgroundColor = [UIColor blueColor];
    button7.frame = CGRectMake(110,190,width,height);
    [button7 setTitle:@"删除纪录" forState:UIControlStateNormal];
    [button7 addTarget:self action:@selector(onClickClean:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button7];
    
    UIButton* button8 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button8.backgroundColor = [UIColor blueColor];
    button8.frame = CGRectMake(215,190,width,height);
    [button8 setTitle:@"微信刷新" forState:UIControlStateNormal];
    [button8 addTarget:self action:@selector(onClickWXRefreshToken:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button8];
    
    UIButton* button9 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button9.backgroundColor = [UIColor blueColor];
    button9.frame = CGRectMake(5,240,width,height);
    [button9 setTitle:@"Pay" forState:UIControlStateNormal];
    [button9 addTarget:self action:@selector(onClickWGPay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button9];
    
    UIButton* button10 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button10.backgroundColor = [UIColor blueColor];
    button10.frame = CGRectMake(110,240,width,height);
    [button10 setTitle:@"注销支付" forState:UIControlStateNormal];
    [button10 addTarget:self action:@selector(onClickReStoregoods:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button10];
    
    UIButton* button111 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button111.backgroundColor = [UIColor blueColor];
    button111.frame = CGRectMake(215,240,width,height);
    [button111 setTitle:@"拉取" forState:UIControlStateNormal];
    [button111 addTarget:self action:@selector(onClickLaunch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button111];
    
//    UIButton* buttonCrash = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    buttonCrash.backgroundColor = [UIColor blueColor];
//    buttonCrash.frame = CGRectMake(5,285,width,height);
//    [buttonCrash setTitle:@"Crash" forState:UIControlStateNormal];
//    [buttonCrash addTarget:self action:@selector(crashTest) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:buttonCrash];
    
    UIButton* button100 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button100.backgroundColor = [UIColor blueColor];
    button100.frame = CGRectMake(110,285,width,height);
    [button100 setTitle:@"register" forState:UIControlStateNormal];
    [button100 addTarget:self action:@selector(onClickregisterPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button100];
    
    UIButton* button110 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button110.backgroundColor = [UIColor blueColor];
    button110.frame = CGRectMake(215,285,width,height);
    [button110 setTitle:@"offerId" forState:UIControlStateNormal];
    [button110 addTarget:self action:@selector(payOtherOfferId) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button110];

    UILabel* lb = [[UILabel alloc] init];
    lb.textColor = [UIColor redColor];
    lb.backgroundColor = [UIColor whiteColor];
    
    lb.frame = CGRectMake(10,420,300,50);
    self.lbLog = lb;
    [self.view addSubview:lb];
}
- (void)setLogInfo:(NSString *)string
{
    [_lbLog setText:string];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    return YES;
}

-(void)onClickQQAuth:(id)sender
{
    WGPlatform* plat = WGPlatform::GetInstance();
    //拉起平台选择
    MyObserver* ob = new MyObserver();
    ob->setViewcontroller(self);
    plat->WGSetObserver(ob);
    plat->WGSetPermission(eOPEN_ALL);
    plat->WGLogin(ePlatform_QQ);
}
- (void)getrecord
{
    WGPlatform *plat = WGPlatform::GetInstance();
    LoginRet ret;
    ePlatform platform = (ePlatform)plat->WGGetLoginRecord(ret);
    NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!ret.flag = %d",ret.flag);
    NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!platform = %d",platform);
}
- (void)logOut
{
    WGPlatform *plat = WGPlatform::GetInstance();
    plat->WGLogout();
}

-(void)onClickQQShare:(id)sender
{
    WGPlatform* plat = WGPlatform::GetInstance();
    MyObserver* ob = new MyObserver();
    ob->setViewcontroller(self);
    plat->WGSetObserver(ob);
    NSString* gameid=@"微胖";
    NSString* question=@"问题时什么，动不动啊";
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"188.png"];//news.jpg
    NSData* data = [NSData dataWithContentsOfFile:path];
    plat->WGSendToQQ(1,(unsigned char*)[gameid UTF8String] ,(unsigned char*)[question UTF8String], (unsigned char*)"http://gamecenter.qq.com/gcjump?plat=qq&appid=100703379&pf=invite", (unsigned char*)[data bytes], [data length]);
}

-(void)onClickQQShare2:(id)sender
{
    WGPlatform* plat = WGPlatform::GetInstance();
    MyObserver* ob = new MyObserver();
    ob->setViewcontroller(self);
    plat->WGSetObserver(ob);
    NSString* gameid=@"微胖";
    NSString* question=@"问题时什么，动不动啊";
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"188.png"];//news.jpg
    NSData* data = [NSData dataWithContentsOfFile:path];
    plat->WGSendToQQ(2,(unsigned char*)[gameid UTF8String] ,(unsigned char*)[question UTF8String], (unsigned char*)"http://gamecenter.qq.com/gcjump?plat=qq&appid=100703379&pf=invite&custom=SDDFADSFDSAFSADFSA", (unsigned char*)[data bytes], [data length]);
}

-(void)onClickQQPhotoShare:(id)sender
{
    WGPlatform* plat = WGPlatform::GetInstance();
    MyObserver* ob = new MyObserver();
    ob->setViewcontroller(self);
    plat->WGSetObserver(ob);
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"422.png"];//news.jpg
    NSData* data = [NSData dataWithContentsOfFile:path];
    plat->WGSendToQQWithPhoto(1,(unsigned char*)[data bytes], [data length]);
}

-(void)onClickQQPhotoShare2:(id)sender
{
    WGPlatform* plat = WGPlatform::GetInstance();
    if( 1 ) //无需票据校验
    {
        MyObserver* ob = new MyObserver();
        ob->setViewcontroller(self);
        plat->WGSetObserver(ob);
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"422.png"];//news.jpg
        NSData* data = [NSData dataWithContentsOfFile:path];
        plat->WGSendToQQWithPhoto(2,(unsigned char*)[data bytes], [data length]);
    }
}

-(void)onClickWXAuth:(id)sender
{
    WGPlatform* plat = WGPlatform::GetInstance();
    //拉起平台选择
    MyObserver* ob = new MyObserver();
    ob->setViewcontroller(self);
    plat->WGSetObserver(ob);
    plat->WGLogin(ePlatform_Weixin);
}

-(void)onClickWXShare:(id)sender
{
    WGPlatform* plat = WGPlatform::GetInstance();
    MyObserver* ob = new MyObserver();
    ob->setViewcontroller(self);
    plat->WGSetObserver(ob);
    NSString* title=@"分享标题";
    NSString* desc=@"分享内容";
    char*  url= "";
    char*  mediaTag = "MSG_INVITE";
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"29.jpg"];
    NSData* data = [NSData dataWithContentsOfFile:path];
    //    PermisionRet permissionRet;
    plat->WGSendToWeixin(0, (unsigned char*)[title UTF8String], (unsigned char*)[desc UTF8String], (unsigned char*)url, (unsigned char*)mediaTag, (unsigned char*)[data bytes], [data length]);  //最后参数0表示分享到好友,参数1表示分享到好友圈
}

-(void)onClickWXShare2:(id)sender
{
    WGPlatform* plat = WGPlatform::GetInstance();
    MyObserver* ob = new MyObserver();
    ob->setViewcontroller(self);
    plat->WGSetObserver(ob);
    NSString* title=@"分享标题";
    NSString* desc=@"分享内容";
    char*  url= "http://www.qq.com";
    char*  mediaTag = "MSG_INVITE";
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"29.jpg"];
    NSData* data = [NSData dataWithContentsOfFile:path];
    //    PermisionRet permissionRet;
    plat->WGSendToWeixin(1, (unsigned char*)[title UTF8String], (unsigned char*)[desc UTF8String], (unsigned char*)"", (unsigned char*)mediaTag, (unsigned char*)[data bytes], [data length]);  //最后参数0表示分享到好友,参数1表示分享到好友圈
}

-(void)onClickWXSharePhoto:(id)sender
{
    WGPlatform* plat = WGPlatform::GetInstance();
    MyObserver* ob = new MyObserver();
    ob->setViewcontroller(self);
    plat->WGSetObserver(ob);
    char* mediaTag = "mediaTag";
    UIImage *image = [UIImage imageNamed:@"356.png"];
    NSData *data = UIImagePNGRepresentation(image);
    
    plat->WGSendToWeixinWithPhoto(0, (unsigned char*)mediaTag, (unsigned char*)[data bytes], [data length]);//最后参数0表示分享到好友,参数1表示分享到好友圈
}

-(void)onClickWXSharePhoto2:(id)sender
{
    WGPlatform* plat = WGPlatform::GetInstance();
    MyObserver* ob = new MyObserver();
    ob->setViewcontroller(self);
    plat->WGSetObserver(ob);
    char* mediaTag = "mediaTag";
    UIImage *image = [UIImage imageNamed:@"356.png"];
    NSData *data = UIImagePNGRepresentation(image);
    
    plat->WGSendToWeixinWithPhoto(1, (unsigned char*)mediaTag, (unsigned char*)[data bytes], [data length]);//最后参数0表示分享到好友,参数1表示分享到好友圈
}

-(void)onClickEvt:(id)sender
{
    WGPlatform* plat = WGPlatform::GetInstance();
//    //测试用的
    plat->WGReportEvent((unsigned char*)"wegame_evt",(unsigned char*)"wegame_evt_body",false);
}
-(void)onClickClean:(id)sender
{
    WGPlatform* plat = WGPlatform::GetInstance();
    plat->WGLogout();
    
    self.lbLog.text = [NSString stringWithFormat:@"登录记录已删除"];
}
-(void)onClickWXRefreshToken:(id)sender{
    WGPlatform* plat = WGPlatform::GetInstance();
    plat->WGRefreshWXToken();
   }
- (void)payOtherOfferId
{
    WGPlatform* plat = WGPlatform::GetInstance();
    if (!plat->WGIsSupprotIapPay())
    {
        NSLog(@"不支持iap支付");
        return;
    }
    
    
    LoginRet ret;
    int retCode = plat->WGGetLoginRecord(ret);
    std::string openid = ret.open_id;
    std::string paytoken;
    
    std::string sessionId;
    std::string sessionType;
    
    if(retCode == ePlatform_QQ)
    {
        for(int i=0;i<ret.token.size();i++)
        {
            TokenRet* pToken = &ret.token[i];
            if(pToken->type == eToken_QQ_Pay)
            {
                paytoken = pToken->value;
                break;
            }
        }
        
        sessionId = "openid";
        sessionType = "kp_actoken";
    }
    else if (retCode == ePlatform_Weixin)
    {
        for(int i=0;i<ret.token.size();i++)
        {
            TokenRet* pToken = &ret.token[i];
            if(pToken->type == eToken_WX_Access)
            {
                paytoken = pToken->value;
                break;
            }
        }
        sessionId = "wechatid";
        sessionType = "wc_actoken";
    }
    
    std::string pf = plat->WGGetPf();
    std::string pfKey = plat->WGGetPfKey();
    
    
    unsigned char * payItem = (unsigned char*)PayPayitem;
    unsigned char * productId = (unsigned char*)"com.tencent.pay.test3";
    
    bool isDepositGameCoin = true;
    uint32_t productType = 0;
    uint32_t quantity = 1;
    unsigned char * zoneId = (unsigned char*)"1";
    unsigned char * varItem = (unsigned char*)"com.lightspeed.weshoothd.600*1";
    
    MyObserver* ob = new MyObserver();
    plat->WGSetObserver(ob);
    
    plat->WGSetIapEnalbeLog(false);
    plat->WGPay(((unsigned char*)"1450000508"),(unsigned char *)openid.c_str(), (unsigned char *)paytoken.c_str(), (unsigned char *)sessionId.c_str(), (unsigned char *)sessionType.c_str(), payItem, productId, (unsigned char*)pf.c_str(), (unsigned char*)pfKey.c_str(), isDepositGameCoin, productType, quantity, zoneId, varItem);
}
- (void)onClickregisterPay//支付前需要先调用此方法注册支付，如果有已下单但尚未成功的交易，调用此方法后会自动完成交易。
{
    WGPlatform* plat = WGPlatform::GetInstance();
    if (!plat->WGIsSupprotIapPay())
    {
        NSLog(@"不支持iap支付");
        return;
    }
    
    LoginRet ret;
    int retCode = plat->WGGetLoginRecord(ret);
    //    plat->WGRegisterPay();
    std::string openid = ret.open_id;
    std::string paytoken;
    
    std::string sessionId;
    std::string sessionType;
    
    if(retCode == ePlatform_QQ)
    {
        for(int i=0;i<ret.token.size();i++)
        {
            TokenRet* pToken = &ret.token[i];
            if(pToken->type == eToken_QQ_Pay)
            {
                paytoken = pToken->value;
                break;
            }
        }
        
        sessionId = "openid";
        sessionType = "kp_actoken";
    }
    else if (retCode == ePlatform_Weixin)
    {
        for(int i=0;i<ret.token.size();i++)
        {
            TokenRet* pToken = &ret.token[i];
            if(pToken->type == eToken_WX_Access)
            {
                paytoken = pToken->value;
                break;
            }
        }
        sessionId = "wechatid";
        sessionType = "wc_actoken";
    }
    
    std::string pf = plat->WGGetPf();
    std::string pfKey = plat->WGGetPfKey();
    
    plat->WGRegisterPay(
                        ((unsigned char*)"1450000495"),
                        (unsigned char *)openid.c_str(),
                        (unsigned char *)paytoken.c_str(),
                        (unsigned char *)sessionId.c_str(),
                        (unsigned char *)sessionType.c_str(),
                        (unsigned char*)pf.c_str(),
                        (unsigned char*)pfKey.c_str()
                        );
}
- (void)onClickWGPay:(id)sender//确保已调用WGRegisterPay
{
    WGPlatform* plat = WGPlatform::GetInstance();
    if (!plat->WGIsSupprotIapPay())
    {
        NSLog(@"不支持iap支付");
        return;
    }
    LoginRet ret;
    int retCode = plat->WGGetLoginRecord(ret);
//    plat->WGRegisterPay();
    std::string openid = ret.open_id;
    std::string paytoken;
    
    std::string sessionId;
    std::string sessionType;
    
    if(retCode == ePlatform_QQ)
    {
        for(int i=0;i<ret.token.size();i++)
        {
            TokenRet* pToken = &ret.token[i];
            if(pToken->type == eToken_QQ_Pay)
            {
                paytoken = pToken->value;
                break;
            }
        }
        
        sessionId = "openid";
        sessionType = "kp_actoken";
    }
    else if (retCode == ePlatform_Weixin)
    {
        for(int i=0;i<ret.token.size();i++)
        {
            TokenRet* pToken = &ret.token[i];
            if(pToken->type == eToken_WX_Access)
            {
                paytoken = pToken->value;
                break;
            }
        }
        sessionId = "wechatid";
        sessionType = "wc_actoken";
    }

    std::string pf = plat->WGGetPf();//
    std::string pfKey = plat->WGGetPfKey();
    
    plat->WGSetIapEnvirenment((unsigned char*)"test");
    
    
    
    unsigned char * payItem = (unsigned char*)PayPayitem;
    unsigned char * productId = (unsigned char*)PayProductid;
    
    bool isDepositGameCoin = true;
    uint32_t productType = 0;
    uint32_t quantity = 1;
    unsigned char * zoneId = (unsigned char*)"1";
    unsigned char * varItem = (unsigned char*)"com.lightspeed.weshoothd.600*1";
    
    
    
    MyObserver* ob = new MyObserver();
    plat->WGSetObserver(ob);
    
    plat->WGSetIapEnalbeLog(false);
    
    plat->WGPay(
                ((unsigned char*)"1450000495"),
                (unsigned char *)openid.c_str(),
                (unsigned char *)paytoken.c_str(),
                (unsigned char *)sessionId.c_str(),
                (unsigned char *)sessionType.c_str(),
                payItem, productId,
                (unsigned char*)pf.c_str(),
                (unsigned char*)pfKey.c_str(),
                isDepositGameCoin,
                productType,
                quantity,
                zoneId,
                varItem
                );
}
-(void)onClickReStoregoods:(id)sender{//确保已调用WGRegisterPay
    WGPlatform *plat = WGPlatform::GetInstance();
    plat->WGDipose();
}
-(void)onClickLaunch:(id)sender{
    WGPlatform* plat = WGPlatform::GetInstance();
    LoginRet ret;
    int retCode = plat->WGGetLoginRecord(ret);
    std::string openid = ret.open_id;
    std::string paytoken;
    
    std::string sessionId;
    std::string sessionType;
    
    if(retCode == ePlatform_QQ)
    {
        for(int i=0;i<ret.token.size();i++)
        {
            TokenRet* pToken = &ret.token[i];
            if(pToken->type == eToken_QQ_Pay)
            {
                paytoken = pToken->value;
                break;
            }
        }
        sessionId = "openid";
        sessionType = "kp_actoken";
    }
    else if (retCode == ePlatform_Weixin)
    {
        for(int i=0;i<ret.token.size();i++)
        {
            TokenRet* pToken = &ret.token[i];
            if(pToken->type == eToken_WX_Access)
            {
                paytoken = pToken->value;
                break;
            }
        }
        sessionId = "wechatid";
        sessionType = "wc_actoken";
    }
    unsigned char * payItem = (unsigned char*)PayPayitem;
    unsigned char * productId = (unsigned char*)PayProductid;
    std::string pf = plat->WGGetPf();
    std::string pfKey = plat->WGGetPfKey();
    bool isDepositGameCoin = true;
    uint32_t productType = 0;
    uint32_t quantity = 1;
    unsigned char * zoneId = (unsigned char*)"1";
    unsigned char * varItem = (unsigned char*)"is me  come back";
    
    MyObserver* ob = new MyObserver();
    plat->WGSetObserver(ob);
    
    plat->WGIAPLaunchMpInfo(((unsigned char*)"1450000495"),
                            (unsigned char *)openid.c_str(),
                            (unsigned char *)paytoken.c_str(),
                            (unsigned char *)sessionId.c_str(),
                            (unsigned char *)sessionType.c_str(),
                            (unsigned char*)pf.c_str(),
                            (unsigned char*)pfKey.c_str(),
                            payItem,
                            productId,
                            isDepositGameCoin,
                            productType,
                            quantity,
                            zoneId,
                            varItem);
}

- (void)crashTest
{
    WGPlatform* plat = WGPlatform::GetInstance();
    LoginRet ret;
    int retCode = plat->WGGetLoginRecord(ret);
    std::string openid = ret.open_id;
    std::string paytoken;
    
    std::string sessionId;
    std::string sessionType;
    
    if(retCode == ePlatform_QQ)
    {
        for(int i=0;i<ret.token.size();i++)
        {
            TokenRet* pToken = &ret.token[i];
            if(pToken->type == eToken_QQ_Pay)
            {
                paytoken = pToken->value;
                break;
            }
        }
        sessionId = "openid";
        sessionType = "kp_actoken";
    }
    else if (retCode == ePlatform_Weixin)
    {
        for(int i=0;i<ret.token.size();i++)
        {
            TokenRet* pToken = &ret.token[i];
            if(pToken->type == eToken_WX_Access)
            {
                paytoken = pToken->value;
                break;
            }
        }
        sessionId = "wechatid";
        sessionType = "wc_actoken";
    }
    unsigned char * payItem = (unsigned char*)PayPayitem;
    unsigned char * productId = (unsigned char*)PayProductid;
    std::string pf = plat->WGGetPf();
    std::string pfKey = plat->WGGetPfKey();
    bool isDepositGameCoin = true;
    uint32_t productType = 0;
    uint32_t quantity = 1;
    unsigned char * zoneId = (unsigned char*)"1";
    unsigned char * varItem = (unsigned char*)"is me  come back";
    plat->WGIAPRestoreCompletedTransactions(((unsigned char*)"1450000495"),
                                            (unsigned char *)openid.c_str(),
                                            (unsigned char *)paytoken.c_str(),
                                            (unsigned char *)sessionId.c_str(),
                                            (unsigned char *)sessionType.c_str(),
                                            (unsigned char*)pf.c_str(),
                                            (unsigned char*)pfKey.c_str(),
                                            payItem,
                                            productId,
                                            isDepositGameCoin,
                                            productType,
                                            quantity,
                                            zoneId,
                                            varItem);
//    return;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"11" forKey:@"22"];
    [dict setObject:@"22" forKey:@"44"];
}


#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==verifyView){
        [verifyView resignFirstResponder];
    }
    
    return YES;
}



@end
