//
//  ActivityViewController.m
//  appgameprivilege
//
//  Created by 姚东海 on 7/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "ActivityViewController.h"
#import "HomeTabController.h"
#import "Toast+UIView.h"
#import "AppDelegate.h"
#import "UIView+CustomLayer.h"
#import "NSString+Tools.h"
#import "SVWebViewController.h"
#import "ColorUtil.h"
#import "Globle.h"
#define pagecount 20
@interface ActivityViewController (){
    
}

@end

@implementation ActivityViewController
@synthesize activityTableViewController,ADarray;
@synthesize loginButton;
@synthesize _info;
- (id)initWithNibName:
(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
  
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(startloaddata:) name:@"firstload" object:nil];
    //[center addObserver:self selector:@selector(startloaddata:) name:@"login" object:nil];


    [super viewWillAppear:animated];
}



-(void)viewDidDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"firstload" object:nil];
   // float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (!IOS7_SYSTEM){
        if (!first) {
            first=YES;
        }
    }
 
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self addLoginButtonAndBackButton];
    [self createUI];
    //[self  test];
    // Do any additional setup after loading the view.
}

/**
 *  开始加载
 */
-(void)startloaddata:(NSNotification *)notification{
    [activityTableViewController.tableView headerBeginRefreshing];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


///初始化数据
-(void)initData{
    ADarray=[[NSMutableArray alloc]init];

}




#pragma mark - ViewController UI

/**
 *  添加登录按扭 和活动返回按扭
 */
-(void)addLoginButtonAndBackButton{
    //登录
    loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(0, 0, 22, 22);
    [loginButton setBackgroundImage:[UIImage imageNamed:@"1-活动_登录.png"] forState:UIControlStateNormal];
    [loginButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [loginButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [loginButton setShowsTouchWhenHighlighted:YES];
    [loginButton addTarget:self action:@selector(goLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:loginButton];
    temporaryRightBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem = temporaryRightBarButtonItem;

    self.navigationItem.leftBarButtonItem=nil;

}

#pragma mark - ViewController class methods

/**
 *  登录
 *
 *  @param sender 登录 UIButton
 */
-(void)goLoginAction:(UIButton*)sender{
    
    
    if (!isLoginstate) {
        [[AppDelegate shareAppDelegate].hometabController loginActionWithLoginStateBlock:^(int state, NSString *describe) {
            [self.view makeToast:describe duration:2.0 position:@"center"];
        }];
    }else{
        [self.view makeToast:@"你已登录,不能重复登录" duration:1.0 position:@"center"];
        
    }

}


-(void)createUI{
    //设置新手引导
    CGFloat offset = 0;
    if (IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        offset = 20;
    }
 
    UITableView *     activityTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.frame.size.height)];
    activityTableView.showsVerticalScrollIndicator=NO;
    if (IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        activityTableView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    }
    activityTableView.rowHeight=86;
    activityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//选中时cell样式
    // giftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:activityTableView];

    ///添加下拉刷新
    __unsafe_unretained ActivityViewController * vc=self;
    
    ///活动
    activityTableViewController = [[SimpleTableViewController alloc] initWithTableViewAndRefreshWith:activityTableView];
    
  
    activityTableViewController.cellClassName = @"ActivityCell";
    [activityTableViewController setCellBlock:^(UITableViewCell *aCell, ActivityItem *data, NSIndexPath *indexPath) {
        ActivityCell *cell = (ActivityCell*)aCell;
       // [cell.activityHeadImageView setdefaultLayer];
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
    
    [activityTableViewController setSelectCellBlock:^(ActivityItem *  data, NSIndexPath *indexPath) {

      
        ActiviyDetailViewController * vcView=[[ActiviyDetailViewController alloc]initWithTitle:@"活动详情"];
        vcView.activityType=[vcView.curtactivityItem.activitycurttype intValue];
        vcView.curtactivityItem=[vc.activityTableViewController.tableData objectAtIndex:indexPath.row];
        if ([vcView.curtactivityItem.activitycurttype intValue]==Activitygift) {
            vcView.title=@"礼包详情";
        }
        [vc.navigationController pushViewController:vcView animated:YES];

    }];
    
   //刷新
   [activityTableViewController.tableView addHeaderWithCallback:^{
       [self getADdatasWithtype];
       [vc.activityTableViewController requestTableViewDataWithparameter:nil withisRefresh:YES withpage:pagecount withViewController:vc];
    }];
    
    //加载更多
    [activityTableViewController.tableView addFooterWithCallback:^{
           [vc.activityTableViewController requestTableViewDataWithparameter:nil withisRefresh:NO withpage:pagecount withViewController:vc];
    }];
    
}



#pragma mark - tableview Headview
/**
 *  增加广告栏
 */
-(void)creatADtablHeadView{

    UIView * headview=self.activityTableViewController.tableView.tableHeaderView;
    if (![headview isKindOfClass:[UIView class]]) {
        headview=[[UIView alloc]init];
    }
    [headview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    headview.userInteractionEnabled=YES;
    if (ADarray.count>0) {
        
        headview.backgroundColor=[UIColor colorWithRed: 214.0/255.0 green: 210.0/255.0 blue: 207.0/255.0 alpha: 1.0];
        SGFocusImageFrame *  adView=[[SGFocusImageFrame alloc]initWithFrame:CGRectMake(5, 2, (activityTableViewController.tableView.frame.size.width-10), 125)];
        [headview addSubview:adView];
        [adView setViewLayerWithRadius:4.0 AndBorderWidth:0.5 AndBorderColor:[UIColor grayColor]];
        [adView setDataSourcArray:self.ADarray setDelegate:self];
        adView.run=YES;
    }
    
    headview.frame=CGRectMake(0, 0, activityTableViewController.tableView.frame.size.width, 125);
    headview.backgroundColor=[UIColor whiteColor];

    self.activityTableViewController.tableView.tableHeaderView=headview;
    [self.activityTableViewController reloadData];
}


#pragma mark -SGFocusImageFrame callbacks
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(ArticleItem *)item andwithIndex:(int)index{
    
    ArticleItem * disitem= [ADarray objectAtIndex:index];
    GHRootViewController *    vcview = [[GHRootViewController alloc] initWithTitle:disitem.title withUrl:disitem.articleURL.description];
    [self.navigationController pushViewController:vcview animated:YES];
    vcview.isshowRefreshView=YES;
    [vcview.mainWebView loadRequest:[NSURLRequest requestWithURL:vcview.webURL]];
}




#pragma mark - getADdata server
/**
 *  加载广告栏
 */
- (void)getADdatasWithtype{
    
    AdServerInterface *serverInterface = [AdServerInterface serverInterface];

    [serverInterface getWithParams:nil success:^(AFHTTPRequestOperation *request, id resultData, id responeData) {
        [ADarray removeAllObjects];
        NSArray *commentsArray = [responeData objectForKey:@"posts"];
        if ([commentsArray isKindOfClass:[NSArray class]]) {
            for (NSDictionary *commdicictionary in commentsArray) {
                ArticleItem *aComment = [[ArticleItem alloc] initAd:commdicictionary];
                [ADarray addObject:aComment];
            }
            if (ADarray) {
                [self creatADtablHeadView];
            }
        }

    } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
        
    } loading:^(BOOL isLoading) {
        self.showLoadingView = NO;
    }];

}



#pragma mark - getGamedata server
/**
 *  活动礼包请求
 *
 *  @param param 请求参数
 */
- (void)getDatasWithtypeParamAndRefreshview:(NSDictionary *)param {
    
    {
        
        ActivityServerInterface *serverInterface = [ActivityServerInterface serverInterface];
        
        int start=[[param objectForKey:@"page"] intValue];
        int count=[[param objectForKey:@"count"] intValue];
        NSDictionary *params = @{
                                 @"page"      : [NSNumber numberWithInt:start],
                                 @"count"      : [NSNumber numberWithInt:count],
                                 @"huodongtype":@""
                                 };
        
        [serverInterface getWithParams:params success:^(AFHTTPRequestOperation *request, id resultData, id responeData) {
            LOG(@"get activity suscess: %@", resultData);
            NSArray * dataarray=resultData;
            NSMutableArray *_adataarray = [NSMutableArray array];
            
            if (dataarray!=nil&&[dataarray isKindOfClass:[NSArray class]]) {
                for (int i=0; i<dataarray.count; i++) {
                    NSDictionary * dic=[dataarray objectAtIndex:i];
                    ActivityItem * item=[[ActivityItem alloc]initActivityWithDic:dic];
                    [_adataarray addObject:item];
                }

                [self.activityTableViewController addDataWithArray:_adataarray];
                
            }
            if ([self.activityTableViewController stopviewload:start]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"firstloadend" object:nil];
            }
            
        } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
            NSDictionary * datadic=responeData;
            [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];
            [self.activityTableViewController stopviewload:start];
        } loading:^(BOOL isLoading) {
            self.showLoadingView = NO;
            
        }];
        
    }
}


@end
