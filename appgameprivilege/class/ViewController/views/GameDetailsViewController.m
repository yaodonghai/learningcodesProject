//
//  GameDetailsViewController.m
//  appgameprivilege
//
//  Created by 姚东海 on 12/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "GameDetailsViewController.h"
#import "UIView+CustomLayer.h"
#import "AppConfig.h"
#import "Toast+UIView.h"
#import "NSString+Tools.h"
#import "Toast+UIView.h"
#import "ColorUtil.h"
#import "AppDelegate.h"
#import "testcell.h"
#import "NSDate-Utilities.h"

//#import <ShareSDK/ShareSDK.h>
//#import <QuartzCore/QuartzCore.h>
#define pagecount 20
@interface GameDetailsViewController ()

@end

@implementation GameDetailsViewController
@synthesize activityTableViewController,gamedetailScrollView;
@synthesize reviewsScreenTableViewController;
@synthesize classbtns;
@synthesize reviewsableViewControllerArray;
@synthesize curtreviewstate=_curtreviewstate;
@synthesize ScreenTitleArray;
@synthesize curtGameItem;
@synthesize describeScrollView;
@synthesize orderAppView;
@synthesize gametype;
#pragma mark - class init methods
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
        self.navigationController.navigationItem.title=self.title;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self loadalldata];
    [self testdata];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


///初始化数据
-(void)initData{
    isAllreviewsFirst=YES;
    self.reviewsableViewControllerArray=[[NSMutableArray alloc]init];
    ScreenTitleArray=[[NSMutableArray alloc]initWithObjects:@"全部",@"新闻",@"攻略",@"评测",@"视频", nil];
    isreviewstate=NO;
    curtstate=DetailsDescribe;
    curtreviewstate=Reviewstrategy;
    firstreviewload=YES;
    firstactivityload=YES;
}
/**
 *  请求网络数据
 */
-(void)loadalldata{
    [self getGameDetaiInfo];

}
///本地数据测试
-(void)testdata{

 
}

-(void)setGametype:(int)agametype{
    gametype=agametype;
}
#pragma mark - class methods
/**
 *  当选到评测模块时 筛选列表隐藏
 */
-(void)selectedReviewState:(int)pageindex{
    
    if (pageindex==DetailsDescribe) {
        [checkttagImageView setHighlighted:NO];
        [self closereviewsScreenTableview];
        
    }else if (pageindex==DetailsReview){
        [checkttagImageView setHighlighted:YES];
        if (isreviewstate) {
            BOOL open=reviewsScreenTableViewController.open;
            reviewsScreenTableViewController.open=!open;

        }
        isreviewstate=YES;
        if (isAllreviewsFirst) {
       SimpleTableViewController * firstreviewTableController=[self.reviewsableViewControllerArray objectAtIndex:0];
        [firstreviewTableController.tableView headerBeginRefreshing];
        firstreviewTableController.isFirstLoad=YES;
         isAllreviewsFirst=NO;
        }
        
    }else if (pageindex==DetailsActivity){
        [checkttagImageView setHighlighted:NO];
        [self closereviewsScreenTableview];
        if (self.activityTableViewController) {
            if (activityTableViewController.isFirstLoad) {
                [activityTableViewController.tableView headerBeginRefreshing];
                activityTableViewController.isFirstLoad=NO;
            }
            
        }
        
    }
}

/**
 *  提交预约
 *
 *  @param sender button
 */
-(void)orderAppViewAction:(UIButton*)sender{
    orderAppView.isinput=NO;
    if (orderAppView.orderemmailField.text.length==0) {
        [self.view makeToast:@"邮箱不能为空！" duration:2.0 position:@"top"];
        return ;
    }
    
    if (orderAppView.orderqqField.text.length==0) {
        [self.view makeToast:@"qq不能为空！" duration:2.0 position:@"top"];
        return ;
    }
    
    if (![orderAppView.orderemmailField.text validateEmail]) {
        [self.view makeToast:@"请输入正确的邮箱格式！" duration:2.0 position:@"top"];
        
        return ;
    }
    
    if (![orderAppView.orderqqField.text  isPureInt]) {
        [self.view makeToast:@"qq 请输入数字！" duration:2.0 position:@"top"];
        return ;
    }
    
    [self submitGameOrderApp];
}

/**
 *  键盘消失
 *
 *  @param selectindex 当前选中
 */
-(void)operationKeyboad:(int)selectindex{
    if (selectindex!=2) {
        if (orderAppView&&!orderAppView.hidden) {
            orderAppView.isinput=NO;
        }
    }
}

/**
 *  关筛选tableview
 */
-(void)closereviewsScreenTableview{
    isreviewstate=NO;
    reviewsScreenTableViewController.open=NO;
}

/**
 *  操作
 *
 *  @param sender 操作 按扭
 */
-(void)operationAction:(UIButton*)sender{

    [self operationMethods];

}

-(void)operationMethods{
    if (gametype==Rankingnew) {
        if (!isLoginstate) {
            
            [[AppDelegate shareAppDelegate].hometabController
             isHaveGotoLoginWithLoginStateBlock:^(int state, NSString *describe) {
                 if (curtGameItem.gameIsfocus) {
                     [self postfocusgameServer:YES];
                 }else{
                     [self postfocusgameServer:NO];
                 }
                 
             }];

        }else{
            
            if (curtGameItem.gameIsfocus) {
                [self postfocusgameServer:YES];
            }else{
                [self postfocusgameServer:NO];
            }
        }
       
    }else if (gametype==Rankinghot){
        
        if ([curtGameItem.gameDowurl isKindOfClass:[NSString class]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:curtGameItem.gameDowurl]];
        }
        
    }
}


/**
 *  分享
 */
- (void)shareClicked:(UIBarButtonItem *)sender {
    //ArticleItem *aArticleItem = (ArticleItem*)[self.appData objectAtIndex:pageIndex];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:curtGameItem.gameName
                                       defaultContent:curtGameItem.gameName
                                                image:[ShareSDK pngImageWithImage:[UIImage imageNamed:@"Icon.png"]]
                                                title:curtGameItem.gameName
                                                  url:self.curtGameItem.gameDowurl
                                          description:curtGameItem.gameName
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



-(UIImage *)getImageFromView:(UIView *)orgView{
    UIGraphicsBeginImageContext(orgView.bounds.size);
    [orgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - AKSegmentedControl callbacks

- (void)segmentedControlValueChanged:(id)sender
{
    AKSegmentedControl *segmented = (AKSegmentedControl *)sender;
    int index=[segmented selectedIndexes].firstIndex;
       [gamedetailScrollView setContentOffset:CGPointMake(gamedetailScrollView.frame.size.width * index,  gamedetailScrollView.contentOffset.y) animated:YES];
    [self selectedReviewState:index];
    
    [self choosebottemLineAnimation:index];
    [self operationKeyboad:index];
    
}




#pragma mark - ViewController UI

-(void)createUI{
 
   //模块分类view
    [self creatClassView];
    
  /// 全部内容 容器
    [self creatContentContainer];

    
    if (gametype==Rankinghot||gametype==Rakingsearch) {
        ///活动礼包 tableview
        [self creartActivityTableview];
        
    }
    
    ///游戏评测
    [self creartReviewsTableConroller];
    ///评测筛选 tableview
    [self creatreviewscreenTableview];
  
    [self creartscreenTableview];
};

///评测筛选条件 tableview
-(void)creartscreenTableview{
    NSMutableArray *_adataarray3 = [NSMutableArray array];
    [_adataarray3 addObject:@"全部"];
    [_adataarray3 addObject:@"新闻"];
    [_adataarray3 addObject:@"攻略"];
    [_adataarray3 addObject:@"评测"];
    [_adataarray3 addObject:@"视频"];
    [self.reviewsScreenTableViewController addDataWithArray:_adataarray3];
    [self.reviewsScreenTableViewController reloadData];
}

/**
 *  全部内容 容器
 */
-(void)creatContentContainer{
    gamedetailScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, (segmentedPerson.frame.origin.y+segmentedPerson.frame.size.height), self.view.frame.size.width, (self.view.frame.size.height-segmentedPerson.frame.size.height))];
    gamedetailScrollView.backgroundColor=[UIColor whiteColor];
    gamedetailScrollView.delegate=self;
    gamedetailScrollView.pagingEnabled=YES;
    gamedetailScrollView.scrollEnabled=YES;
    gamedetailScrollView.showsVerticalScrollIndicator=NO;
    gamedetailScrollView.showsHorizontalScrollIndicator=NO;
    CGSize contentsize=gamedetailScrollView.contentSize;
    contentsize.width=gamedetailScrollView.frame.size.width*gourData.count;
    gamedetailScrollView.contentSize=contentsize;
    [self.view addSubview:gamedetailScrollView];
    
    UITableView *     tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, gamedetailScrollView.frame.size.height)];
    if (IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        tableview.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    }
    //  giftTableView.backgroundColor=[UIColor greenColor];
    tableview.rowHeight=80;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;//选中时cell样式
    // giftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [gamedetailScrollView addSubview:tableview];

    
}

/**
 *  模块分类 view
 */
-(void)creatClassView{
    
//    UIImage * praiseimage=[UIImage imageNamed:@"Praise_normal.png"];
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightButton.frame = CGRectMake(0, 0, praiseimage.size.width, praiseimage.size.height);
//    [rightButton setBackgroundImage:praiseimage forState:UIControlStateNormal];
//    [rightButton setBackgroundImage:[UIImage imageNamed:@"Praise_hightlight.png"] forState:UIControlStateHighlighted];
//    
//    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [rightButton setShowsTouchWhenHighlighted:YES];
//    [rightButton addTarget:self action:@selector(shareClicked:) forControlEvents:UIControlEventTouchUpInside];
//    // [rightButton setTitle:@"分享" forState:UIControlStateNormal];
//    [rightButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15.0]];
//    rightButton.titleLabel.textColor = [UIColor whiteColor];
//    
//    UIBarButtonItem *temporaryRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    temporaryRightBarButtonItem.style = UIBarButtonItemStylePlain;
//    self.navigationItem.rightBarButtonItem = temporaryRightBarButtonItem;
    NSString  * segtitle=[NSString stringWithFormat:@"%@评测",[ScreenTitleArray objectAtIndex:0]];
  //  NSArray*  segStr=[[NSArray alloc]initWithObjects:@"游戏描述",segtitle,@"活动礼包", nil];
  
     gourData=[[NSMutableArray alloc]init];
    [gourData addObject:@"游戏描述"];
    [gourData addObject:segtitle];
    if (gametype==Rankinghot||gametype==Rakingsearch) {
        [gourData addObject:@"活动礼包"];

    }
    //添加选项卡
    //UIImageView *segBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"segmented-bg.png"]];
  
    segmentedPerson = [[AKSegmentedControl alloc] initWithFrame:CGRectMake(0, self.x, 320, 40)];
    segmentedPerson.isElection=YES;
    [segmentedPerson addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    // Setting the resizable background image
    //UIImage *backgroundImage = [UIImage imageNamed:@"Subcategories.png"];
    //[segmentedPerson setBackgroundImage:backgroundImage];
    [segmentedPerson setBackgroundColor:[UIColor whiteColor]];
    // Setting the behavior mode of the control
    [segmentedPerson setSegmentedControlMode:AKSegmentedControlModeSticky];

    float btn_w=self.view.frame.size.width/gourData.count;
    UIImage * btnbrimage=[ColorUtil imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(btn_w, 40)];


    classbtns=[[NSMutableArray alloc]init];
    for (NSString * btntitle in gourData) {
        
        UIButton *  segBtn = [[UIButton alloc] init];
        [segBtn setBackgroundImage:[btnbrimage copy] forState:UIControlStateNormal];
        [segBtn setBackgroundImage:[btnbrimage copy] forState:UIControlStateHighlighted];
        [segBtn setBackgroundImage:[btnbrimage copy] forState:UIControlStateSelected];
        [segBtn setBackgroundImage:[btnbrimage copy] forState:(UIControlStateHighlighted|UIControlStateSelected)];
        [segBtn setTitle:btntitle forState:UIControlStateNormal];
        [segBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [segBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [segBtn setTitleColor:RGB(255, 47, 119) forState:UIControlStateSelected];
        [segBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0]];
        [classbtns addObject:segBtn];
    }
    
    // Setting the UIButtons used in the segmented control
    [segmentedPerson setButtonsArray:classbtns];
    [segmentedPerson setSelectedIndex:0];
    //[buttonSocial setHighlighted:YES];
    // Adding your control to the view
    [self.view addSubview:segmentedPerson];
    
    bottemlineView=[[UIView alloc]initWithFrame:CGRectMake(0, 39, self.view.frame.size.width, 0.7)];
    bottemlineView.backgroundColor=RGB(217, 217, 217);
    [self.view addSubview:bottemlineView];
    
    curtbottemlineView=[[UIView alloc]initWithFrame:CGRectMake(0, 39, btn_w, 0.7)];
    curtbottemlineView.backgroundColor=[UIColor redColor];
    [self.view addSubview:curtbottemlineView];
}

/**
 *  游戏描述UI
 */
-(void)creartGameDescribeView{
    describeScrollView=[[GameDescribeScrollView alloc]initWithFrame:CGRectMake(0, 0, gamedetailScrollView.frame.size.width, gamedetailScrollView.frame.size.height) AndGameItem:curtGameItem];
    [describeScrollView.headview.gamezanButton addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [gamedetailScrollView addSubview:describeScrollView];
    [self bandheaddata];
}

/**
 *  绑定数据
 */
-(void)bandheaddata{
    if (gametype==Rankingnew) {
        if (curtGameItem.gameIsfocus) {
            [describeScrollView.headview.gamezanButton setTitle:@"预约中" forState:UIControlStateNormal];
            [describeScrollView.headview.gamezanButton setTitle:@"预约中" forState:UIControlStateHighlighted];
        }else{
            [describeScrollView.headview.gamezanButton setTitle:@"关注" forState:UIControlStateNormal];
            [describeScrollView.headview.gamezanButton setTitle:@"关注" forState:UIControlStateHighlighted];
        }
        
    }else if (gametype==Rankinghot){
        [describeScrollView.headview.gamezanButton setTitle:@"下载" forState:UIControlStateNormal];
        [describeScrollView.headview.gamezanButton setTitle:@"下载" forState:UIControlStateHighlighted];
    }
}


/**
 *  添加评测筛选列表
 */
-(void)creatreviewscreenTableview{
    __unsafe_unretained GameDetailsViewController * vc=self;
    float x_w=(self.view.frame.size.width/gourData.count)+1;
    float screen_w=90.0;
    float curt_x=(x_w-screen_w)*0.5+x_w;
    
    UITableView *     screenTableview=[[UITableView alloc]initWithFrame:CGRectMake(curt_x, (segmentedPerson.frame.origin.y+segmentedPerson.frame.size.height), screen_w, (self.view.frame.size.height-segmentedPerson.frame.size.height))];
    
    if (IOS7_SYSTEM) {
        screenTableview.backgroundColor = [UIColor colorWithRed:127.0/225.0 green:127.0/225.0 blue:127.0/225.0 alpha:0.6];
    }
    screenTableview.layer.borderColor = [[UIColor blackColor] CGColor];
    screenTableview.layer.cornerRadius = 6;
    screenTableview.layer.masksToBounds = YES;
    screenTableview.layer.borderWidth=1.0f;
    screenTableview.rowHeight=30;
    screenTableview.separatorStyle = UITableViewCellSeparatorStyleNone;//选中时cell样式
    [self.view addSubview:screenTableview];
    
    /**
     *  下拉图标
     */
    UIImage * tagimagenormal=[UIImage imageNamed:@"3-单个游戏-下拉.png"];
    UIImage * tagimagehightlight=[UIImage imageNamed:@"3-2-攻略咨询_三角.png"];
    float tag_x=x_w+(x_w-tagimagenormal.size.width-x_w/7);
     checkttagImageView=[[UIImageView alloc]initWithFrame:CGRectMake(tag_x, (segmentedPerson.frame.size.height-tagimagenormal.size.height)*0.5, tagimagenormal.size.width, tagimagenormal.size.height)];
    checkttagImageView.image=tagimagenormal;
    checkttagImageView.highlightedImage=tagimagehightlight;
    [segmentedPerson addSubview:checkttagImageView];
    
    reviewsScreenTableViewController=[[SimpleTableViewController alloc]initWithTableView:screenTableview];
    reviewsScreenTableViewController.is_animation=YES;
    reviewsScreenTableViewController.selectIndex=[NSIndexPath indexPathForRow:0 inSection:0];
    reviewsScreenTableViewController.cellClassName = @"ScreenCell";
    
    [reviewsScreenTableViewController setCellBlock:^(UITableViewCell *aCell,  NSString*data, NSIndexPath *indexPath) {
        ScreenCell *cell = (ScreenCell*)aCell;
        if (vc.reviewsScreenTableViewController.selectIndex!=nil&&vc.reviewsScreenTableViewController.selectIndex.row==indexPath.row) {
            cell.screenTitleLable.textColor=[UIColor blackColor];
        }else{
            cell.screenTitleLable.textColor=[UIColor whiteColor];
            
        }
        
        cell.screenTitleLable.text=data;

    }];
    
    [reviewsScreenTableViewController setSelectCellBlock:^(id data, NSIndexPath *indexPath) {
        //BOOL isopen=vc.reviewsScreenTableViewController.open;
        vc.reviewsScreenTableViewController.open=NO;
        [vc.reviewsScreenTableViewController reloadData];
        UIButton * classbtn=[vc.classbtns objectAtIndex:1];
        NSString  * btntitle=[NSString stringWithFormat:@"%@评测",[vc.ScreenTitleArray objectAtIndex:indexPath.row]];
        [classbtn setTitle:btntitle forState:UIControlStateNormal];
        [classbtn setTitle:btntitle forState:UIControlStateSelected];
        for (int i=0;i<vc.reviewsableViewControllerArray.count;i++) {
            SimpleTableViewController *  tableviewController=[vc.reviewsableViewControllerArray objectAtIndex:i];
            if (indexPath.row==i) {
                UITableView * curttableview=tableviewController.tableView;
                [curttableview setHidden:NO];
                if (tableviewController.isFirstLoad) {
                    [tableviewController.tableView headerBeginRefreshing];
            
                    tableviewController.isFirstLoad=NO;
                }
            }else{
                UITableView * curttableview=tableviewController.tableView;
                [curttableview setHidden:YES];
            }
        }
        
    }];
}

/**
 *  添加活动礼包列表
 */
-(void)creartActivityTableview{
    
    ///活动礼包 tableview
    __unsafe_unretained GameDetailsViewController * vc=self;
    
    CGRect activityFame=CGRectMake((gamedetailScrollView.frame.size.width*2), 0, self.view.frame.size.width, gamedetailScrollView.frame.size.height);
    
    UITableView *     activityTableView=[[UITableView alloc]initWithFrame:activityFame];
    if (IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        activityTableView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    }
    activityTableView.rowHeight=95;
    activityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//选中时cell样式
    [gamedetailScrollView addSubview:activityTableView];
    activityTableViewController = [[SimpleTableViewController alloc] initWithTableViewAndRefreshWith:activityTableView];
    
    activityTableViewController.cellClassName = @"ActivityCell";
    
    [activityTableViewController setCellBlock:^(UITableViewCell *aCell,  ActivityItem*data, NSIndexPath *indexPath) {
        ActivityCell *cell = (ActivityCell*)aCell;
        [cell.activityHeadImageView setdefaultLayer];
        cell.bottemlineColor=[UIColor grayColor];
        [cell.brView setViewLayerWithRadius:3.0 AndBorderWidth:0.6 AndBorderColor:[UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:206.0/255.0 alpha:0.7]];
        [ cell.activityHeadImageView setImageWithURL:[NSURL URLWithString:data.activitythumbmail] placeholderImage:[UIImage imageNamed:@"图标占位图.png"]];
        NSString * titlestirng=@"";
        if ([data.activitycurttype intValue]==Activityactivity) {
            titlestirng=[NSString stringWithFormat:@"%@",data.activityName];
            [cell.activityInButton setTitle:@"参加活动" forState:UIControlStateNormal];
            [cell.activityInButton setTitle:@"参加活动" forState:UIControlStateHighlighted];
            
            cell.activityLable1.text=@"开放时间 :";
            cell.activityLable2.text=[NSString stringWithFormat:@"%@至%@",data.activitystarttime,data.activityendtime];
            if (!data.activityactionstate) {
                cell.activityactiontagLable.hidden=NO;
                cell.activityactiontagLable.text=@"已结束>";
            }else{
                cell.activityactiontagLable.hidden=YES;
                
            }
            
            
        }else if ([data.activitycurttype intValue]==Activitygift){
            titlestirng=[NSString stringWithFormat:@"%@礼包",data.activityName];
            [cell.activityInButton setTitle:@"领取礼包" forState:UIControlStateNormal];
            [cell.activityInButton setTitle:@"领取礼包" forState:UIControlStateHighlighted];
            cell.activityLable1.text=@"  剩    余 :";
            if (!data.activitysurplus) {
                cell.activityactiontagLable.hidden=NO;
                cell.activityactiontagLable.text=@"已领完>";
            }else{
                cell.activityactiontagLable.hidden=YES;
                
            }
            
            cell.activityLable2.text=[NSString stringWithFormat:@"%d 个",data.activitysurplus];
        }
        cell.activityTitleLable.text=titlestirng;
        cell.activityDescLable.text=data.activitycontent;
        [cell.activityInButton setMenuActionWithBlock:^{
            ActiviyDetailViewController * vcView=[[ActiviyDetailViewController alloc]initWithTitle:@"活动详情"];
            vcView.curtactivityItem=[vc.activityTableViewController.tableData objectAtIndex:indexPath.row];
            if ([vcView.curtactivityItem.activitycurttype integerValue]==Activitygift) {
                vcView.title=@"礼包详情";
            }
            [vc.navigationController pushViewController:vcView animated:YES];
        }];
        
        UIImage * normalbrimage=[ColorUtil imageWithColor:RGB(0, 159, 231) andSize:cell.activityInButton.frame.size];
        UIImage * hightlightbrimage=[ColorUtil imageWithColor:RGB(0, 159, 183) andSize:cell.activityInButton.frame.size];
        [cell.activityInButton setBackgroundImage:normalbrimage forState:UIControlStateNormal];
        [cell.activityInButton setBackgroundImage:hightlightbrimage forState:UIControlStateHighlighted];
        [cell.activityInButton setViewLayerWithRadius:5.0 AndBorderWidth:0.6 AndBorderColor:[UIColor whiteColor]];
    }];
    
    [activityTableViewController setSelectCellBlock:^(id data, NSIndexPath *indexPath) {
        ActiviyDetailViewController * vcView=[[ActiviyDetailViewController alloc]initWithTitle:@"活动详情"];
        vcView.curtactivityItem=[vc.activityTableViewController.tableData objectAtIndex:indexPath.row];
        if ([vcView.curtactivityItem.activitycurttype integerValue]==Activitygift) {
            vcView.title=@"礼包详情";
        }
        [vc.navigationController pushViewController:vcView animated:YES];
    }];
    
    //刷新
    [activityTableViewController.tableView addHeaderWithCallback:^{
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInt:-1] , @"action",
                               nil];
        [vc.activityTableViewController requestTableViewDataWithparameter:param withisRefresh:YES withpage:pagecount withViewController:vc];
    }];
    
    //加载更多
    [activityTableViewController.tableView addFooterWithCallback:^{
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInt:-1] , @"action",
                               nil];
        [vc.activityTableViewController requestTableViewDataWithparameter:param withisRefresh:NO withpage:pagecount withViewController:vc];
    }];
}

/**
 *  预约 view
 */
-(void)creartorderAppView{
        CGRect gameOrderFame=CGRectMake((gamedetailScrollView.frame.size.width*2), 0, self.view.frame.size.width, gamedetailScrollView.frame.size.height);
    
    orderAppView=[[GameOrderAppView alloc]initWithFrame:gameOrderFame];
    [orderAppView.ordersubmitButton addTarget:self action:@selector(orderAppViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [gamedetailScrollView addSubview:orderAppView];
  
}


/**
 *  筛选分组
 */
-(void)creartReviewsTableConroller{
      __unsafe_unretained GameDetailsViewController * vc=self;
    
    for (int i=0; i<ScreenTitleArray.count; i++) {
        
        UITableView *     reviewTableView=[[UITableView alloc]initWithFrame:CGRectMake(gamedetailScrollView.frame.size.width, 0, self.view.frame.size.width, gamedetailScrollView.frame.size.height)];
        if (IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            reviewTableView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
        }
        //  giftTableView.backgroundColor=[UIColor greenColor];
        reviewTableView.rowHeight=80;
        reviewTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//选中时cell样式
        [gamedetailScrollView addSubview:reviewTableView];
        
        if (i==0) {
            [reviewTableView setHidden:NO];
        }else{
            [reviewTableView setHidden:YES];

        }
       SimpleTableViewController *   curtTableViewController = [[SimpleTableViewController alloc] initWithTableViewAndRefreshWith:reviewTableView];
        [reviewsableViewControllerArray addObject:curtTableViewController];

        curtTableViewController.cellClassName = @"ReviewCell";
       //ActivityItem
        [curtTableViewController setCellBlock:^(UITableViewCell *aCell, ArticleItem *data, NSIndexPath *indexPath) {
            ReviewCell *cell = (ReviewCell*)aCell;
            cell.bottemlineColor=[UIColor grayColor];
            [cell.reviewHeadImageView setImageWithURL:data.articleIconURL placeholderImage:[UIImage imageNamed:@"图标占位图.png"]];
            cell.reviewTitleLable.text=data.title;
            cell.reviewDescribeLable.text=[data.pubDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
            cell.reviewTypeLable.text=data.category;
            cell.typeColor=[UIColor grayColor];
            
        }];
        
        [curtTableViewController setSelectCellBlock:^(ArticleItem *data, NSIndexPath *indexPath) {
        
            if (data.actiontype==1) {
                DetailViewController *vcview = [[DetailViewController alloc] initWithTitle:data.title];
                SimpleTableViewController *   pushTableViewController=[vc.reviewsableViewControllerArray objectAtIndex:i];
                vcview.appData=pushTableViewController.tableData;
                vcview.startIndex = indexPath.row;
                [vc.navigationController pushViewController:vcview animated:YES];
            }else{
                GHRootViewController *    vcview = [[GHRootViewController alloc] initWithTitle:data.title withUrl:data.articleURL.absoluteString];
                [vc.navigationController pushViewController:vcview animated:YES];
                vcview.isshowRefreshView=YES;
                
                [vcview.mainWebView loadRequest:[NSURLRequest requestWithURL:vcview.webURL]];
            }
        
        }];

    //刷新
    [curtTableViewController.tableView addHeaderWithCallback:^{
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInt:i] , @"type",
                               nil];
        [curtTableViewController requestTableViewDataWithparameter:param withisRefresh:YES withpage:pagecount withViewController:vc];
    }];
    
    //加载更多
    [curtTableViewController.tableView addFooterWithCallback:^{
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInt:i] , @"type",
                               nil];
        [curtTableViewController requestTableViewDataWithparameter:param withisRefresh:NO withpage:pagecount withViewController:vc];
    }];

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

#pragma mark - animation
/**
 *  低线动画
 *
 *  @param select 当前选中
 */
-(void)choosebottemLineAnimation:(int)select{
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect bottemlineframe=curtbottemlineView.frame;
        bottemlineframe.origin.x=select*bottemlineframe.size.width;
        curtbottemlineView.frame=bottemlineframe;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView==gamedetailScrollView){
        CGPoint offset = scrollView.contentOffset;
        int page= offset.x /gamedetailScrollView.frame.size.width;
        [self selectedReviewState:page];
        [segmentedPerson setSelectedIndex:page];
        [self choosebottemLineAnimation:page];
        [self operationKeyboad:page];
        
    }
    
}


#pragma mark - submit GameOrderApp server
-(void)submitGameOrderApp{
    GameDetaiServerInterface *serverInterface = [GameDetaiServerInterface serverInterface];
    //f=gameDetail&gameid=1&time=当前请求的时间戳
    NSDictionary *params = @{
                             @"f"      : @"gameDetail",
                             @"gameid"      : curtGameItem.gameId
                             };
    [serverInterface getWithParams:params success:^(AFHTTPRequestOperation *request, id resultData, id responeData) {
        
    } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
        NSDictionary * datadic=responeData;
        [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];
  
    } loading:^(BOOL isLoading) {
        self.showLoadingView = isLoading;

    }];
}



#pragma mark - get GameDetai server
-(void)getGameDetaiInfo{
    GameDetaiServerInterface *serverInterface = [GameDetaiServerInterface serverInterface];
    //f=gameDetail&gameid=1&time=当前请求的时间戳
    //curtGameItem.gameId
    NSDictionary *params = @{
                             @"gameid"      : curtGameItem.gameId
                             };
    [serverInterface getWithParams:params success:^(AFHTTPRequestOperation *request, id resultData, id responeData) {
        NSDictionary * dic=resultData;
        if ([dic isKindOfClass:[NSDictionary class]]) {
            curtGameItem=[[GameItem alloc]initWithGameDetailDic:resultData];
            curtGameItem.curtgametype=gametype;
            ///描述内容
            [self creartGameDescribeView];
            
        }
        
        
    } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
        NSDictionary * datadic=responeData;
        [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];

    } loading:^(BOOL isLoading) {
        self.showLoadingView = isLoading;

    }];
}


#pragma mark - post focusgame server
/**
 *  关注 取消关注新游
 */
-(void)postfocusgameServer:(BOOL)iscancelfocus{
    FocusGameServerInterface *serverInterface = [FocusGameServerInterface serverInterface];
    NSDictionary *params=nil;
    if (iscancelfocus) {
        params = @{
                   @"gameid"      : curtGameItem.gameId,
                   @"cancel"      : @"1"
                   };
    }else{
        params = @{
                   @"gameid"      : curtGameItem.gameId
                   };
    }
    
    [serverInterface getWithParams:params success:^(AFHTTPRequestOperation *request, id resultData, id responeData) {
 
        NSDictionary * datadic=(NSDictionary*)responeData;
        
        if ([datadic isKindOfClass:[NSDictionary class]]) {
          int status=  [[datadic objectForKey:@"status"]intValue];
            if (status) {

                if (iscancelfocus) {
                    curtGameItem.gameIsfocus=0;

                }else{
                    curtGameItem.gameIsfocus=1;

                }
                [self bandheaddata];
             }
            [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];

        }
        LOG(@"responeData----%@",responeData);
        
    } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
        NSDictionary * datadic=responeData;
        [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];

    } loading:^(BOOL isLoading) {
        self.showLoadingView = isLoading;

    }];
}


#pragma mark - get Activitydata server

- (void)getDatasWithtypeParamAndRefreshview:(NSDictionary *)param {
    
    {
        int action=[[param objectForKey:@"action"]intValue];
        if (action!=-1) {
            [self getReviewDataWithtypeParamAndRefreshview:param];
            return;
        }
        ActivityServerInterface *serverInterface = [ActivityServerInterface serverInterface];
        int start=[[param objectForKey:@"page"] intValue];
        int count=[[param objectForKey:@"count"] intValue];

        NSDictionary *params = @{
                                 @"page"      : [NSNumber numberWithInt:start],
                                 @"count"      : [NSNumber numberWithInt:count],
                                 @"gameid"      : curtGameItem.gameId

                                 };
        
        [serverInterface getWithParams:params success:^(AFHTTPRequestOperation *request, id resultData, id responeData) {
            LOG(@"get activity suscess: %@", resultData);
            NSArray * dataarray=resultData;
            NSMutableArray *_adataarray = [NSMutableArray array];
            
            if (dataarray!=nil&&[dataarray isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary * dic in dataarray) {
                    ActivityItem * item=[[ActivityItem alloc]initActivityWithDic:dic];
                    [_adataarray addObject:item];
                    
                }
                
                [self.activityTableViewController addDataWithArray:_adataarray];
                
                
            }
            firstactivityload=NO;
            [activityTableViewController stopviewload:start];
            
        } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
            LOG(@"get activity fail: %@", responeData);
            NSDictionary * datadic=responeData;
            
            [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];

            [activityTableViewController stopviewload:start];
        } loading:^(BOOL isLoading) {
            self.showLoadingView = NO;
            
        }];
        
    }
}




#pragma mark - get ReviewData server
/**
 *  游戏资讯
 *
 *  @param param DIC
 */
- (void)getReviewDataWithtypeParamAndRefreshview:(NSDictionary *)param {
    
    {
        
        InformationServerInterface *serverInterface = [InformationServerInterface serverInterface];
        int type=[[param objectForKey:@"type"] intValue];

        int start=[[param objectForKey:@"page"] intValue];
        int count=[[param objectForKey:@"count"] intValue];
        NSString * typestirng=[NSString stringWithFormat:@"%d",type];
        if (type==0) {
            typestirng=@"";
        }
        SimpleTableViewController *reviewTableViewContoller=[reviewsableViewControllerArray objectAtIndex:type];

        NSDictionary *params = @{
                                 @"page"      : [NSNumber numberWithInt:start],
                                 @"count"      : [NSNumber numberWithInt:count],
                                 @"gameid"      : curtGameItem.gameId,
                                 @"type"      : typestirng
                                 };
        
        [serverInterface getWithParams:params success:^(AFHTTPRequestOperation *request, id resultData, id responeData) {
            LOG(@"get activity suscess: %@", resultData);
            NSArray * dataarray=resultData;
            
            NSMutableArray *arry = [[NSMutableArray alloc]init];
            
            if (arry!=nil&&[arry isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary * dic in dataarray) {
                    
                    ArticleItem  * item=[[ArticleItem alloc]initGameAricleItem:dic];
                    //ProjectItem * item=[[ProjectItem alloc]initDic:dic];
                    [arry addObject:item];
                    
//                ProjectItem * item=[[ProjectItem alloc]initGameinformationDic:dic];
//                  [arry addObject:item];
                    
                }
                
                [reviewTableViewContoller addDataWithArray:arry];
                
            }
            
            [reviewTableViewContoller stopviewload:start];
            
        } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
            LOG(@"get activity fail: %@", responeData);
            
            NSDictionary * datadic=responeData;
            [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];

            [reviewTableViewContoller stopviewload:start];

        } loading:^(BOOL isLoading) {
            self.showLoadingView = NO;
            
        }];
        
    }
}





@end
