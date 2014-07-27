//
//  HomeTabController.m
//  GameStrategys
//
//  Created by 姚东海 on 5/5/14.
//  Copyright (c) 2014年 junewong. All rights reserved.
//

#import "HomeTabController.h"
#import "UserCenterHeadView.h"
#import "Globle.h"
#import "SVWebViewController.h"
#import "HMSideMenu.h"
#import "Globle.h"
#import "AppConfig.h"
#import "CustomTabItem.h"
#import "CustomSelectionView.h"
#import "CustomBackgroundLayer.h"
#import "CustomNoiseBackgroundView.h"
#import "UIView+Positioning.h"
#import "Toast+UIView.h"
#import "NSDate-Utilities.h"
@interface HomeTabController (){
    ///ViewController标题
    NSArray  * tabitemTitles;
    
}


@end

@implementation HomeTabController
@synthesize activityViewController,rankViewController,projectViewController,usercenterViewController;
@synthesize loginstateblock=_loginstateblock;
@synthesize coachMarks,coachMarksView;
@synthesize navigation1,navigation2,navigation3,navigation4;
@synthesize tabView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
}



-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (BOOL) automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers {
    return YES;
}

- (BOOL) shouldAutomaticallyForwardRotationMethods {
    return YES;
}

- (BOOL) shouldAutomaticallyForwardAppearanceMethods {
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}

///初始化数据
-(void)initData{
    coachMarks=[[NSMutableArray alloc]init];
    
    NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSValue valueWithCGRect:CGRectMake(([Globle shareInstance].globleWidth-80), 190, 80, 230)] forKey:@"rect"];
    [dic setObject:@"领取游戏礼包和参加游戏活动！" forKey:@"caption"];
    [coachMarks addObject:dic];
    
    NSMutableDictionary * dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[NSValue valueWithCGRect:CGRectMake(([Globle shareInstance].globleWidth-75), (24+44+20), 65, 32)] forKey:@"rect"];
    [dic1 setObject:@"点击领取游戏礼包" forKey:@"caption"];
    [coachMarks addObject:dic1];
    
    NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
      [dic2 setObject:[NSValue valueWithCGRect:CGRectMake(([Globle shareInstance].globleWidth-75), (24+44+20), 65, 32)] forKey:@"rect"];
    [dic2 setObject:@"领取成功后，可以在我的礼包查看礼包码！" forKey:@"caption"];
    [coachMarks addObject:dic2];
    
    NSMutableDictionary * dic3=[[NSMutableDictionary alloc]init];
    [dic3 setObject:[NSValue valueWithCGRect:CGRectMake(0, 245, [Globle shareInstance].globleWidth, 70)] forKey:@"rect"];
    [dic3 setObject:@"查看我的礼包，需要用户登录QQ！" forKey:@"caption"];
    [coachMarks addObject:dic3];
    
    NSMutableDictionary * dic4=[[NSMutableDictionary alloc]init];
    [dic4 setObject:[NSValue valueWithCGRect:CGRectMake(([Globle shareInstance].globleWidth-40), 0, 40, 60)] forKey:@"rect"];
    [dic4 setObject:@"登录QQ后，可以查看我的礼包！" forKey:@"caption"];
    [coachMarks addObject:dic4];

    [self initQQData];
    
}

/**
 *  qq 初始化 设置
 */
-(void)initQQData{
    _permissions = [[NSMutableArray arrayWithObjects:
                     kOPEN_PERMISSION_GET_USER_INFO,
                     kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                     kOPEN_PERMISSION_ADD_ALBUM,
                     kOPEN_PERMISSION_ADD_IDOL,
                     kOPEN_PERMISSION_ADD_ONE_BLOG,
                     kOPEN_PERMISSION_ADD_PIC_T,
                     kOPEN_PERMISSION_ADD_SHARE,
                     kOPEN_PERMISSION_ADD_TOPIC,
                     kOPEN_PERMISSION_CHECK_PAGE_FANS,
                     kOPEN_PERMISSION_DEL_IDOL,
                     kOPEN_PERMISSION_DEL_T,
                     kOPEN_PERMISSION_GET_FANSLIST,
                     kOPEN_PERMISSION_GET_IDOLLIST,
                     kOPEN_PERMISSION_GET_INFO,
                     kOPEN_PERMISSION_GET_OTHER_INFO,
                     kOPEN_PERMISSION_GET_REPOST_LIST,
                     kOPEN_PERMISSION_LIST_ALBUM,
                     kOPEN_PERMISSION_UPLOAD_PIC,
                     kOPEN_PERMISSION_GET_VIP_INFO,
                     kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                     kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                     kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                     nil] copy];
    
    NSString *appid = @"222222";
	_tencentOAuth = [[TencentOAuth alloc] initWithAppId:appid
											andDelegate:self];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(startloaddataend:) name:@"firstloadend" object:nil];
 
  [self  hideExistingTabBar];
  [self addviewControllers];
    [self initData];

  [self creatUI];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - creatUIView
///清除TabBar所有UI
- (void)hideExistingTabBar
{
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
			view.hidden = YES;
			break;
		}
	}
}



///添加viewController 到容器
-(void)addviewControllers{
    ///活动
    activityViewController=[[ActivityViewController alloc]init];
    activityViewController.title=@"活动礼包";
     navigation1=  [[MDSlideNavigationViewController alloc] initWithRootViewController:activityViewController];
    ///排行榜
    rankViewController=[[RankViewController alloc]init];
    rankViewController.title=@"推荐";

     navigation2=  [[MDSlideNavigationViewController alloc] initWithRootViewController:rankViewController];
    ///主题
    projectViewController=[[ProjectViewController alloc]init];
    projectViewController.title=@"专题";

    navigation3=  [[MDSlideNavigationViewController alloc] initWithRootViewController:projectViewController];
    ///个人中心
    usercenterViewController=[[UserCenterViewController alloc]init];
    usercenterViewController.title=@"个人中心";

     navigation4=  [[MDSlideNavigationViewController alloc] initWithRootViewController:usercenterViewController];
    
    self.viewControllers=@[navigation1,navigation2,navigation3,navigation4];
    
    self.selectedIndex=0;
    self.view.backgroundColor=[UIColor redColor];
}


///自定义tabBar
-(void)creatUI{
    self.view.backgroundColor=[UIColor whiteColor];
  
     tabitemTitles=[[NSArray alloc]initWithObjects:@"活动",@"推荐",@"专题", @"个人",nil];
      self.navigationItem.title=tabitemTitles[0];
    //添加自定义tabbar条
     tabView = [[JMTabView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 44., [Globle shareInstance].globleWidth, 44.)];
    [tabView setViewtoplineColor:[UIColor grayColor]];
    tabView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [tabView setDelegate:self];
    CGFloat tabItemWidth = tabView.frame.size.width / 4;
    CGSize tabItemPadding = CGSizeMake(tabView.frame.size.width/4/2, 0);
    
    
    for (int i=0; i<tabitemTitles.count; i++) {
        
        NSString * imagenamenormal=[NSString stringWithFormat:@"按钮-未按_0%d.png",(i+2)];
       NSString * imagenamehightlight=[NSString stringWithFormat:@"按钮-按下_0%d.png",(i+2)];
        
        CustomTabItem * tabItem = [CustomTabItem tabItemWithTitle:tabitemTitles[i] icon:[UIImage imageNamed:imagenamenormal] alternateIcon:[UIImage imageNamed:imagenamehightlight]];
        tabItem.customWidth = tabItemWidth;
        tabItem.padding = tabItemPadding;
        
        [tabView addTabItem:tabItem];
       
    }
    [tabView setSelectionView:[CustomSelectionView createSelectionView]];
    [tabView setItemSpacing:1.];
    [tabView setBackgroundLayer:[[CustomBackgroundLayer alloc] init]];
    [tabView setSelectedIndex:0];
    [self.view addSubview:tabView];
    
}

/**
 *  引导view
 */
-(void)creartguideView{
    
    if (coachMarksView==nil) {
        ///添加下拉刷新
        __unsafe_unretained HomeTabController * vc=self;
        coachMarksView = [[WSCoachMarksView alloc]initWithFrame:CGRectMake(0, 0, [Globle shareInstance].globleWidth, [Globle shareInstance].globleAllHeight) coachMarks:coachMarks];
        coachMarksView.willNavigateToIndexBlock=^(WSCoachMarksView * coachMarksView,NSInteger index){
            LOG(@"willNavigateToIndexBlock");
            
        };
        coachMarksView.didNavigateToIndexBlock=^(WSCoachMarksView * coachMarksView,NSInteger index){
            LOG(@"-------%d",index);
            if (index==1) {//跳转活动详情
                for (ActivityItem * item in  vc.activityViewController.activityTableViewController.tableData) {
                    
                    if ([item.activitycurttype intValue]==Activitygift) {
                        
                        ActiviyDetailViewController * vcView=[[ActiviyDetailViewController alloc]initWithTitle:@"活动详情"];
                        vcView.activityType=Activitygift;
                        vcView.curtactivityItem=item;
                        if ([vcView.curtactivityItem.activitycurttype intValue]==Activitygift) {
                            vcView.title=@"礼包详情";
                        }
                        [vc.navigation1 pushViewController:vcView animated:YES];
                        break;
                    }
                }
 
            }else if (index==2){//领取礼包
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getgift" object:nil];

            }else if (index==3){//我的礼包
                [vc tableViewdidSelectTabAtIndex:3];

            }else if (index==4){//登录
                [vc.navigation1 popViewControllerAnimated:YES];
               [vc tableViewdidSelectTabAtIndex:0];
                
            }
  
        };
        
        coachMarksView.coachMarksViewWillCleanupBlock=^(WSCoachMarksView * coachMarksView){
            
        };
        
        coachMarksView.coachMarksViewDidCleanupBlock=^(WSCoachMarksView * coachMarksView){
            //登录
            [vc loginActionWithLoginStateBlock:^(int state, NSString *describe) {
                for (ActivityItem * item in vc.activityViewController.activityTableViewController.tableData) {
                    if ([item.activitycurttype intValue]==Activitygift) {
                            [vc gegiftCode:item.activityId];
                        break;
                    }
                }
            
           
            }];
        };
        
        [self.view addSubview:coachMarksView];
        
    }
    [coachMarksView start];
    
}


#pragma mark - SMPageControl action
- (void)spacePageControl:(SMPageControl *)sender
{
    
	NSLog(@"Current Page (SMPageControl): %i", sender.currentPage);
}


#pragma mark - classmethods
/**
 *  开始加载
 */
-(void)startloaddataend:(NSNotification *)notification{
    BOOL coachMarksShown = [[NSUserDefaults standardUserDefaults] boolForKey:@"WSCoachMarksShownHot"];
    if (coachMarksShown == NO) {//NO则只显示一次,更新后也不显示
        [self creartguideView];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"WSCoachMarksShownHot"];
        [[NSUserDefaults standardUserDefaults] synchronize];
       
    }
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



#pragma mark - FilterVie delegate

- (CGFloat )filterViewSelectionAnimationSpeed:(DMFilterView *)filterView
{
    //return the default value as example, you don't have to implement this delegate
    //if you don't want to modify the selection speed
    //Or you can return 0.0 to disable the animation totally
    return kAnimationSpeed;
}

-(void)tabView:(JMTabView *)tabView didSelectTabAtIndex:(NSUInteger)itemIndex;
{
    NSLog(@"Selected Tab Index: %d", itemIndex);
    self.selectedIndex=itemIndex;
    self.navigationItem.title=tabitemTitles[itemIndex];
    
    if (itemIndex==3) {

        [usercenterViewController viewWillAppear:YES];
    }

    
}

/**
 *  低部选中按扭
 *
 *  @param Index 当前选中
 */
-(void)tableViewdidSelectTabAtIndex:(int)Index{
    self.selectedIndex=Index;
    JMTabItem * item=[tabView.tabContainer.tabItems objectAtIndex:Index];
    [item itemTapped];

}
/**
 *  oauth 登录
 */
-(void)loginOauth{
    OauthViewController  *   oauthview=[[OauthViewController alloc]init];
    
    [self presentViewController:oauthview animated:YES completion:^{
        
    }];
}


/**
 *  登录
 */
-(void)loginAction{
    if (![[AppConfig shareInstance] isCheckLongin]) {
        [_tencentOAuth authorize:_permissions inSafari:YES];
    }else{
        [self.view makeToast:@"已登录，不用重复登录！" duration:3.0 position:@"center"];

    }

}


/**
 *  登录 返回状态
 */
-(void)loginActionWithLoginStateBlock:(OauthLoginStateBlock)block{
    if (_loginstateblock) {
        _loginstateblock=nil;
    }
    _loginstateblock=block;
    [self loginAction];
}



/**
 *  选择登录 返回状态
 */
-(void)isHaveGotoLoginWithLoginStateBlock:(OauthLoginStateBlock)block{
    if (_loginstateblock) {
        _loginstateblock=nil;
    }
    _loginstateblock=block;
    XYAlertView *alertView1 = [XYAlertView alertViewWithTitle:@"---------温馨提示--------"
                                                      message:@"你还没有登录,您要登录后才能操作下面功能！是否要登录？"
                                                      buttons:[NSArray arrayWithObjects:@"登录", @"取消", nil]
                                                 afterDismiss:^(int buttonIndex) {
                                                     if (buttonIndex==0) {
                                                         
                                                         [self loginAction];
                                                     }
                                                     
                                                 }];
    [alertView1 show];
    
}


/**
 *  选择登录
 */
-(void)isHaveGotoLogin{
    
    XYAlertView *alertView1 = [XYAlertView alertViewWithTitle:@"---------温馨提示--------"
                                                      message:@"你还没有登录,您要登录后才能操作下面功能！是否要登录？"
                                                      buttons:[NSArray arrayWithObjects:@"登录", @"取消", nil]
                                                 afterDismiss:^(int buttonIndex) {
                                                     if (buttonIndex==0) {
                                                         [self loginAction];
                                                     }

                                                 }];
    [alertView1 show];
    
}


#pragma mark - getactivitydata server
/**
 *  领取礼包 码
 *
 *  @param activityid 活动ID
 */
- (void)gegiftCode:(NSString*)activityid{
    
    GiftBagServerInterface *serverInterface = [GiftBagServerInterface serverInterface];

    NSDictionary *params = @{
                             @"huodongid"      :activityid
                             };
    
    [serverInterface getWithParams:params success:^(AFHTTPRequestOperation *request, id resultData, id responeData) {
        [self tableViewdidSelectTabAtIndex:3];
        [ self.usercenterViewController chooseAction:1];
    } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
        [self tableViewdidSelectTabAtIndex:3];
        [ self.usercenterViewController chooseAction:1];
    } loading:^(BOOL isLoading) {
        
    } error:^(AFHTTPRequestOperation *request, NSError *error) {
        
    }];
    
}

/**
 *  获取QQ 个人信息
 */
-(void)getqqUserinfo{
    if(![_tencentOAuth getUserInfo]){
        [self showInvalidTokenOrOpenIDMessage];
    }
}

- (void)showInvalidTokenOrOpenIDMessage{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"可能授权已过期，请重新获取" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


#pragma mark - QQ TencentSessionDelegate methods

/**
 * Called when the user successfully logged in.
 */
- (void)tencentDidLogin {
	// 登录成功
    if (_tencentOAuth.accessToken
        && 0 != [_tencentOAuth.accessToken length])
    {
        [AppConfig shareInstance].openId=_tencentOAuth.openId;
        [AppConfig shareInstance].access_token=_tencentOAuth.accessToken;
        [AppConfig shareInstance].localAppId=_tencentOAuth.localAppId;
        [AppConfig shareInstance].redirectURI=_tencentOAuth.redirectURI;
        [AppConfig shareInstance].expirationDate=(double)[_tencentOAuth.expirationDate timeIntervalSince1970];
        if ([[AppConfig shareInstance] isTokenOverdue]) {
            [AppConfig shareInstance].isLogin=OfflineState;
            
        }else{
            [AppConfig shareInstance].isLogin=OnlineState;
            
        }
        [[AppConfig shareInstance] saveOauthInfo];
        
        _loginstateblock(QQ_LOGIN_SUCCESSFUL,@"登录成功");
        [self getqqUserinfo];
    }
    else
    {
        _loginstateblock(-1,@"登录不成功 没有获取accesstoken");

    }
    
}

/**
 * Called when the get_user_info has response.
 */
- (void)getUserInfoResponse:(APIResponse*) response {
	if (response.retCode == URLREQUEST_SUCCEED)
	{
        
        NSDictionary * useinfo=response.jsonResponse;
        NSString * nickname= [useinfo objectForKey:@"nickname"];
        NSString * icon= [useinfo objectForKey:@"figureurl_qq_1"];
        NSString * gender= [useinfo objectForKey:@"gender"];
        [AppConfig shareInstance].user.username=nickname;
        [AppConfig shareInstance].user.icon=icon;
        [AppConfig shareInstance].user.gender=gender;
        [[AppConfig shareInstance].user saveUserinfo];
        [usercenterViewController refreshTableHeadView];
	}
	else
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%@", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
}

/**
 * Called when the user dismissed the dialog without logging in.
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
	if (cancelled){
        _loginstateblock(-1,@"用户取消登录");

	}
	else {
        _loginstateblock(-1,@"登录失败");

	}
	
}


/**
 * logout
 */
- (void)onClickLogout
{
    [_tencentOAuth logout:self];
}

/**
 * 退出登录的回调
 */
- (void)tencentDidLogout{

    LOG(@"out----");
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{

}


@end
