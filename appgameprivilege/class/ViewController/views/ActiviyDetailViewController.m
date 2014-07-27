//
//  ActiviyDetailViewController.m
//  appgameprivilege
//
//  Created by 姚东海 on 13/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "ActiviyDetailViewController.h"
#import "HMSideMenu.h"
#import "Toast+UIView.h"
#import "NSString+Tools.h"
#import "UIView+CustomLayer.h"
#import "ColorUtil.h"
#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>//v2.1
#define viewWidth 310
@interface ActiviyDetailViewController ()

@end

@implementation ActiviyDetailViewController
@synthesize headView,bottemButton,boyView,content;
@synthesize toastInputView;
@synthesize curtactivityItem;
@synthesize activityType;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithTitle:(NSString*)title{
    self=[self initWithNibName:nil bundle:nil];
    if (self) {
        self.title = title;
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(getgift:) name:@"getgift" object:nil];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"getgift" object:nil];

    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
    [self creatToastView];
    [self getactivityActivity];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  初始化数据
 */
-(void)initData{
    
}

/**
 *  本地数据测试
 */
-(void)test{
 
    
}

#pragma mark - ViewController UI

-(void)createUI{
    //分享按扭
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

    self.view.backgroundColor=[UIColor whiteColor];
    self.headView=[[ActivityDetailHeadView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-viewWidth)*0.5, 0, viewWidth, 80)];
    self.headView=[XibViewLoader loadViewWithName:@"ActivityDetailHeadView" owner:self atIndex:0];
    [headView setViewbottemlineColor:[UIColor grayColor]];
    [self.view addSubview:self.headView];
    [headView.acticityActionButton addTarget:self action:@selector(activityHeadViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //[headView.headiconImageView setViewLayerWithRadius:4.0 AndBorderWidth:0.5 AndBorderColor:[UIColor grayColor]];
    [headView.headiconImageView setImageWithURL:[NSURL URLWithString:curtactivityItem.activitythumbmail] placeholderImage:[UIImage imageNamed:@"图标占位图.png"]];
    
    self.boyView=[[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-viewWidth)*0.5, (self.headView.frame.origin.y+self.headView.frame.size.height+10), viewWidth, self.view.frame.size.height-(self.headView.frame.origin.y+self.headView.frame.size.height+10+5))];
    self.boyView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.boyView];
    //游戏名称
    headView.title1.text=curtactivityItem.gameName;
    self.content.showsVerticalScrollIndicator=NO;
    self.content.showsHorizontalScrollIndicator=NO;
    self.content=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.boyView.frame.size.width, self.boyView.frame.size.height)];
    self.content.textColor = [UIColor grayColor];//设置textview里面的字体颜色
    self.content.backgroundColor = [UIColor clearColor];//设置它的背景颜色
  
  //设置它显示的内容
    self.content.scrollEnabled = YES;//是否可以拖动
    self.content.editable=NO;
    [self.boyView addSubview:self.content];
    //活动礼包数据转换
   // [self encapsulationData];
    
    [self  bangheadviewdata];
 
}




/**
 *  活动礼包标题转换
 */
-(void)encapsulationTitle{
    headView.title1.text=curtactivityItem.gameName;

    if ([curtactivityItem.activitycurttype intValue]==Activitygift) {
        
        if (curtactivityItem.isJoin) {
            
            if (curtactivityItem.activitycode!=nil&&[curtactivityItem.activitycode isKindOfClass:[NSString class]]) {
                [self banggifttextUI:curtactivityItem.activitycode];

            }
        }else{
            NSString * activitycontent=[NSString stringWithFormat:@"%@\n剩余个数:%d",curtactivityItem.activityName,curtactivityItem.activitysurplus];
            headView.title2.textColor=[UIColor blackColor];
            NSString * surplus=[NSString stringWithFormat:@"%d",curtactivityItem.activitysurplus];
            NSMutableDictionary * titledic=[NSMutableDictionary dictionaryWithObject:surplus forKey:@"string"];
            [titledic setValue:[UIColor blueColor] forKey:@"color"];
            NSMutableAttributedString * muconten= [activitycontent getAttributedColornstringWithArray:[NSArray arrayWithObject:titledic] AndFont:[UIFont fontWithName:@"Arial" size:12.0]];
            //描述
            [headView.title2 setAttributedText:muconten];
        }
        
    }else if ([curtactivityItem.activitycurttype intValue]==Activityactivity){
        //描述
        headView.title2.text=curtactivityItem.activityName;
        headView.title2.textColor=[UIColor grayColor];
    }
}

/**
 *  礼包码
 *
 *  @param codestirng 礼包码
 */
-(void)banggifttextUI:(NSString*)codestirng{
    [headView.acticityActionButton setTitle:@"复制" forState:UIControlStateNormal];
    [headView.acticityActionButton setTitle:@"复制" forState:UIControlStateHighlighted];
   
    NSString * activitycontent=[NSString stringWithFormat:@"卡号 :%@",codestirng];
    headView.title2.textColor=[UIColor grayColor];
    NSString * surplus=[NSString stringWithFormat:@"%@",codestirng];
    NSMutableDictionary * titledic=[NSMutableDictionary dictionaryWithObject:surplus forKey:@"string"];
    [titledic setValue:RGB(0, 202, 253) forKey:@"color"];
    NSMutableAttributedString * muconten= [activitycontent getAttributedColornstringWithArray:[NSArray arrayWithObject:titledic] AndFont:[UIFont fontWithName:@"Arial" size:10.0]];
    //描述
    [headView.title2 setAttributedText:muconten];
}

/**
 *  绑定headview 数据
 */
-(void)bangheadviewdata{
    
    if ([curtactivityItem.activitycurttype intValue]==Activitygift) {
        [headView.acticityActionButton setTitle:@"领取" forState:UIControlStateNormal];
        [headView.acticityActionButton setTitle:@"领取" forState:UIControlStateHighlighted];

    }else if ([curtactivityItem.activitycurttype intValue]==Activityactivity){
        if (curtactivityItem.isJoin) {
            [headView.acticityActionButton setTitle:@"已参加" forState:UIControlStateNormal];
            [headView.acticityActionButton setTitle:@"已参加" forState:UIControlStateHighlighted];
        }else{
            [headView.acticityActionButton setTitle:@"参加" forState:UIControlStateNormal];
            [headView.acticityActionButton setTitle:@"参加" forState:UIControlStateHighlighted];
        }
       
    }
    
}

/**
 *  活动礼包数据转换
 */
-(void)encapsulationData{
    self.content.textColor=[UIColor grayColor];

    if ([curtactivityItem.activitycurttype intValue]==Activityactivity) {
        if (![curtactivityItem.activityrule isKindOfClass:[NSString class]]&&curtactivityItem.activityrule==nil) {
            curtactivityItem.activityrule=@"";
        }
        //活动全部内容
        NSString * contentnstrong=[NSString stringWithFormat:@"%@\n\n奖励内容 :\n\n%@\n\n活动时间 :\n\n%@至%@\n\n活动规则 :\n\n\n%@\n",curtactivityItem.activitydetail,curtactivityItem.activitycontent,curtactivityItem.activitystarttime,curtactivityItem.activityendtime,curtactivityItem.activityrule];
        NSMutableDictionary * dic1=[NSMutableDictionary dictionaryWithObject:@"奖励内容 :" forKey:@"string"];
        [dic1 setObject:RGB(0, 202, 253) forKey:@"color"];
        [dic1 setObject:[UIFont fontWithName:@"Arial" size:13.0] forKey:@"font"];
        NSMutableDictionary * dic2=[NSMutableDictionary dictionaryWithObject:@"活动时间 :" forKey:@"string"];
        [dic2 setObject:RGB(0, 202, 253) forKey:@"color"];
        [dic2 setObject:[UIFont fontWithName:@"Arial" size:13.0] forKey:@"font"];
        NSMutableDictionary * dic3=[NSMutableDictionary dictionaryWithObject:@"活动规则 :" forKey:@"string"];
        [dic3 setObject:RGB(0, 202, 253) forKey:@"color"];
        [dic3 setObject:[UIFont fontWithName:@"Arial" size:13.0] forKey:@"font"];
        
        NSMutableDictionary * dic4=[NSMutableDictionary dictionaryWithObject:curtactivityItem.activitycontent forKey:@"string"];
        [dic4 setObject:[UIColor redColor] forKey:@"color"];
        [dic4 setObject:[UIFont fontWithName:@"Arial" size:13.0] forKey:@"font"];
        
        NSMutableDictionary * dic5=[NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@至%@",curtactivityItem.activitystarttime,curtactivityItem.activityendtime] forKey:@"string"];
        [dic5 setObject:[UIColor redColor] forKey:@"color"];
        [dic5 setObject:[UIFont fontWithName:@"Arial" size:13.0] forKey:@"font"];
        
        NSMutableDictionary * dic6=[NSMutableDictionary dictionaryWithObject:curtactivityItem.activityrule forKey:@"string"];
        [dic6 setObject:[UIColor redColor] forKey:@"color"];
        [dic6 setObject:[UIFont fontWithName:@"Arial" size:13.0] forKey:@"font"];
        NSMutableAttributedString *  customAttributedString=[contentnstrong getAttributedColornstringWithArray:[[NSArray alloc]initWithObjects:dic1,dic2,dic3,dic4,dic5,dic6, nil]];
        
        [self.content setAttributedText:customAttributedString];

    }else if ([curtactivityItem.activitycurttype intValue]==Activitygift){
        if (![curtactivityItem.activitydetail isKindOfClass:[NSString class]]&&curtactivityItem.activitydetail==nil) {
            curtactivityItem.activitydetail=@"";
        }
        //礼包全部内容
        NSString * contentnstrong=[NSString stringWithFormat:@"礼包详情 :\n\n%@\n\n使用说明 :\n\n%@\n\n",curtactivityItem.activitydetail,curtactivityItem.activitycontent];
        NSMutableDictionary * dic1=[NSMutableDictionary dictionaryWithObject:@"礼包详情 :" forKey:@"string"];
        [dic1 setObject:RGB(0, 202, 253) forKey:@"color"];
        [dic1 setObject:[UIFont fontWithName:@"Arial" size:13.0] forKey:@"font"];
        NSMutableDictionary * dic2=[NSMutableDictionary dictionaryWithObject:@"使用说明 :" forKey:@"string"];
        [dic2 setObject:RGB(0, 202, 253) forKey:@"color"];
        [dic2 setObject:[UIFont fontWithName:@"Arial" size:13.0] forKey:@"font"];
        NSMutableDictionary * dic3=[NSMutableDictionary dictionaryWithObject:curtactivityItem.activitydetail forKey:@"string"];
        [dic3 setObject:[UIColor redColor] forKey:@"color"];
        [dic3 setObject:[UIFont fontWithName:@"Arial" size:13.0] forKey:@"font"];
        NSMutableDictionary * dic4=[NSMutableDictionary dictionaryWithObject:curtactivityItem.activitycontent forKey:@"string"];
        [dic4 setObject:[UIColor redColor] forKey:@"color"];
        [dic4 setObject:[UIFont fontWithName:@"Arial" size:13.0] forKey:@"font"];
        NSMutableAttributedString *  customAttributedString=[contentnstrong getAttributedColornstringWithArray:[[NSArray alloc]initWithObjects:dic1,dic2,dic3,dic4, nil]];
        [self.content setAttributedText:customAttributedString];

    }
    
}


/**
 *  添加弹出框
 */
-(void)creatToastView{
    
    self.toastInputView=[[ToastInputDataView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-230)*0.5, -160, 230, 160)];
    self.toastInputView=[XibViewLoader loadViewWithName:@"ToastInputDataView" owner:self atIndex:0];
    [self.toastInputView setViewLayerWithRadius:6.0 AndBorderWidth:2.0 AndBorderColor:RGB(0, 202, 253)];
    
    [self.toastInputView.qqText setViewLayerWithRadius:5.0 AndBorderWidth:1.0 AndBorderColor:RGB(0, 202, 253)];
        [self.toastInputView.emailText setViewLayerWithRadius:5.0 AndBorderWidth:1.0 AndBorderColor:RGB(0, 202, 253)];
    UIImage * brimagenormal=[ColorUtil imageWithColor:RGB(0, 202, 253) andSize:self.toastInputView.submitBtn.frame.size];
    UIImage * brimagehgithlight=[ColorUtil imageWithColor:RGB(0, 202, 230) andSize:self.toastInputView.submitBtn.frame.size];
    [self.toastInputView.submitBtn setBackgroundImage:brimagenormal forState:UIControlStateNormal];
    [self.toastInputView.submitBtn setBackgroundImage:brimagehgithlight forState:UIControlStateNormal];
    [self.toastInputView.submitBtn setViewLayerWithRadius:6.0 AndBorderWidth:2 AndBorderColor:[UIColor whiteColor]];
    [self.toastInputView.cancelBtn setBackgroundImage:brimagenormal forState:UIControlStateNormal];
    [self.toastInputView.cancelBtn setBackgroundImage:brimagehgithlight forState:UIControlStateNormal];
    [self.toastInputView.cancelBtn setViewLayerWithRadius:6.0 AndBorderWidth:2 AndBorderColor:[UIColor whiteColor]];
    [self.toastInputView AddToastViewSubFatherView:self.view];
    
    [self.toastInputView.submitBtn setMenuActionWithBlock:^{
        if ([self validate]) {
            [self.toastInputView hiddenView];
            [self PostParticipateActivity];
        }
    
    }];
    
    [self.toastInputView.cancelBtn setMenuActionWithBlock:^{
        [self.toastInputView hiddenView];
        self.toastInputView.emailText.text=@"";
        self.toastInputView.qqText.text=@"";
    }];
}
#pragma mark - class methods 


- (void)shareClicked:(UIBarButtonItem *)sender {
    

    //构造分享 游戏下载地址
    id<ISSContent> publishContent = [ShareSDK content:curtactivityItem.activitycontent
                                       defaultContent:curtactivityItem.activityName
                                                image:[ShareSDK imageWithUrl:curtactivityItem.gameIcon]
                                                title:curtactivityItem.gameName
                                                  url:curtactivityItem.gameDownUrl
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



-(void)bottemBtnAction:(UIButton*)sender{
    [self.toastInputView showView];
}

-(void)getgift:(NSNotification *)notification{
    [headView.acticityActionButton setTitle:@"复制" forState:UIControlStateNormal];
    [headView.acticityActionButton setTitle:@"复制" forState:UIControlStateHighlighted];
}
/**
 *  领取 参加活动
 *
 *  @param sender btn
 */
-(void)activityHeadViewButtonAction:(UIButton*)sender{
    if ([curtactivityItem.activityshowtype intValue]==1) {
        GHRootViewController *    vcview = [[GHRootViewController alloc] initWithTitle:curtactivityItem.activityName withUrl:curtactivityItem.activityurl];
            vcview.isshowRefreshView=YES;
            [self.navigationController pushViewController:vcview animated:YES];
    [vcview.mainWebView loadRequest:[NSURLRequest requestWithURL:vcview.webURL]];
        
    }else{
        
        if ([curtactivityItem.activitycurttype intValue]==Activitygift) {
            
            if (!isLoginstate) {
                
                [[AppDelegate shareAppDelegate].hometabController isHaveGotoLoginWithLoginStateBlock:^(int state, NSString *describe) {
                    if (state==QQ_LOGIN_SUCCESSFUL) {
                        
                        if (curtactivityItem.isJoin&&[curtactivityItem.activitycode isKindOfClass:[NSString class]]) {
                            
                            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                            pasteboard.string = curtactivityItem.activitycode;
                            
                            [self.view makeToast:@"已复制礼包码到剪贴板" duration:2.0 position:@"center"];
                            
                        }else{
                            
                            [self gegiftCode];
                        }
                        
                    }
                    
                    [self.view makeToast:describe duration:1.0 position:@"center"];
                    
                }];
                
            }else{
                if (curtactivityItem.isJoin&&[curtactivityItem.activitycode isKindOfClass:[NSString class]]) {
                    
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    pasteboard.string = curtactivityItem.activitycode;
                    
                    [self.view makeToast:@"已复制礼包码到剪贴板" duration:2.0 position:@"center"];
                    
                }else{
                    [self gegiftCode];
                    
                }
            }
            
        }else if ([curtactivityItem.activitycurttype intValue]==Activityactivity){
            if (!isLoginstate) {
                [[AppDelegate shareAppDelegate].hometabController isHaveGotoLoginWithLoginStateBlock:^(int state, NSString *describe) {
                    if (state==QQ_LOGIN_SUCCESSFUL) {
                        if (!curtactivityItem.isJoin) {
                            [self.toastInputView showView];
                        }
                    }
                    
                    [self.view makeToast:describe duration:1.0 position:@"center"];
                    
                }];
            }else{
                if (!curtactivityItem.isJoin) {
                    [self.toastInputView showView];
                    
                }
            }
            
        }

    }
    
}

/**
 *  检测数据格式
 */
-(BOOL)validate{
    
    if (self.toastInputView.emailText.text.length==0) {
        [self.view makeToast:@"邮箱不能为空！" duration:2.0 position:@"top"];
        return NO;
    }
    
    if (self.toastInputView.qqText.text.length==0) {
        [self.view makeToast:@"qq不能为空！" duration:2.0 position:@"top"];
        return NO;
    }
    
    if (![self.toastInputView.emailText.text validateEmail]) {
        [self.view makeToast:@"请输入正确的邮箱格式！" duration:2.0 position:@"top"];
        
        return NO;
    }
    
    if (![self.toastInputView.qqText.text  isPureInt]) {
        [self.view makeToast:@"qq 请输入数字！" duration:2.0 position:@"top"];
        
        return NO;
    }
    return YES;
}


#pragma mark - postactivity server
/**
 *  参加活动
 */
- (void)PostParticipateActivity{

        JoinActicityServerInterface *serverInterface = [JoinActicityServerInterface serverInterface];

        NSDictionary *params = @{
                                 @"email"   : self.toastInputView.emailText.text,
                                 @"qq"      : self.toastInputView.qqText.text,
                                 @"huodongid"      :curtactivityItem.activityId
                                 };
        
        [serverInterface postWithParams:params success:^(AFHTTPRequestOperation *request, id resultData, id responeData) {
            LOG(@"get activity suscess: %@", resultData);
            self.toastInputView.emailText.text=@"";
            self.toastInputView.qqText.text=@"";
            NSDictionary * datadic=(NSDictionary*)responeData;
            curtactivityItem.isJoin=YES;
            if (curtactivityItem.isJoin) {
                [headView.acticityActionButton setTitle:@"已参加" forState:UIControlStateNormal];
                [headView.acticityActionButton setTitle:@"已参加" forState:UIControlStateHighlighted];
            }else{
                [headView.acticityActionButton setTitle:@"参加" forState:UIControlStateNormal];
                [headView.acticityActionButton setTitle:@"参加" forState:UIControlStateHighlighted];
            }
            if ([datadic isKindOfClass:[NSDictionary class]]) {
               // int status=  [[datadic objectForKey:@"status"]intValue];
                [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];
                
            }
            
        } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
            NSDictionary * datadic=(NSDictionary*)responeData;

            [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];

        } loading:^(BOOL isLoading) {
            self.showLoadingView = isLoading;

        } error:^(AFHTTPRequestOperation *request, NSError *error) {
            [self.view makeToast:@"提交失败！" duration:2.0 position:@"center"];

        }];

}


#pragma mark - getactivitydata server
/**
 *  活动礼包详情
 */
- (void)getactivityActivity{
    
    GiftActivityDetaiServerInterface *serverInterface = [GiftActivityDetaiServerInterface serverInterface];
    
    NSDictionary *params = @{
                             @"huodongid"      :curtactivityItem.activityId
                             };
    
    [serverInterface getWithParams:params success:^(AFHTTPRequestOperation *request, id resultData, id responeData) {
        LOG(@"get activity suscess: %@", resultData);
        NSDictionary * datadic=(NSDictionary*)resultData;
        
        curtactivityItem=[[ActivityItem alloc]initActivityDetailWithDic:datadic];
   
        [self encapsulationTitle];
        //活动礼包数据转换
        [self encapsulationData];
        
    } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
        NSDictionary * datadic=responeData;
        [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];

    } loading:^(BOOL isLoading) {
        self.showLoadingView = isLoading;
        
    } error:^(AFHTTPRequestOperation *request, NSError *error) {
       // [UIAlertViewUtil showAlertErrorTipWithMessage:@"提交失败！"];
        
    }];
    
}



#pragma mark - getactivitydata server
/**
 *  领取礼包 码
 */
- (void)gegiftCode{
    
    GiftBagServerInterface *serverInterface = [GiftBagServerInterface serverInterface];
    
    NSDictionary *params = @{
                             @"huodongid"      :curtactivityItem.activityId
                             };
    
    [serverInterface getWithParams:params success:^(AFHTTPRequestOperation *request, id resultData, id responeData) {
        LOG(@"get activity suscess: %@", responeData);
        NSDictionary * datadic=(NSDictionary*)responeData;
        int status=[[datadic objectForKey:@"status"]intValue];
        if (status) {
            NSString * giftcode=[datadic objectForKey:@"code"];
            
            curtactivityItem.activitycode=giftcode;
            curtactivityItem.isJoin=YES;
            [self banggifttextUI:curtactivityItem.activitycode];
            
        }else{
            
            [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];

        }

    } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
        NSDictionary * datadic=(NSDictionary*)responeData;
            [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];

    } loading:^(BOOL isLoading) {
        self.showLoadingView = isLoading;
        
    } error:^(AFHTTPRequestOperation *request, NSError *error) {
        // [UIAlertViewUtil showAlertErrorTipWithMessage:@"提交失败！"];
        
    }];
    
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
