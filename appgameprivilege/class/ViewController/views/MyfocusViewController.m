//
//  MyfocusViewController.m
//  appgameprivilege
//
//  Created by 姚东海 on 13/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "MyfocusViewController.h"
#import "NSString+Tools.h"
#import "UIView+CustomLayer.h"
#import "Toast+UIView.h"
#define pagecount 20
@interface MyfocusViewController ()

@end

@implementation MyfocusViewController
@synthesize myFocusTableViewController;

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
    [center addObserver:self selector:@selector(refreshnewgame:) name:@"refreshnewgame" object:nil];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshnewgame" object:nil];
    [super viewWillDisappear:animated];
}

/**
 *  开始加载
 */
-(void)refreshnewgame:(NSNotification *)notification{
    [myFocusTableViewController.tableView headerBeginRefreshing];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self.myFocusTableViewController.tableView headerBeginRefreshing];
   // [self test];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



///初始化数据
-(void)initData{
    
    
}


/**
 *  本地数据测试
 */
-(void)test{
//    NSMutableArray *_adataarray = [NSMutableArray array];
//    for (int i=0; i<30; i++) {
//        GameItem * item=[[GameItem alloc]init];
//        item.gameIcon=@"http://a4.mzstatic.com/us/r30/Purple6/v4/fe/66/1c/fe661cad-ecd4-8279-0c36-b73c55d58bc2/mzl.pdkpqudk.175x175-75.jpg";
//        item.gameName=@"罪恶之地";
//        item.gameDowncount=@"下载量:30000";
//        item.gameDate=@"上线日期：2014-05-12";
//        [_adataarray addObject:item];
//    }
//    [self.myFocusTableViewController addDataWithArray:_adataarray];
//    [self.myFocusTableViewController reloadData];
}

#pragma mark - ViewController UI
/**
 *  初始化UI
 */
-(void)createUI{
 
    self.isAddtabBarheight=YES;
    UITableView *     tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, self.x, self.view.frame.size.width, self.view.frame.size.height)];
    if (IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        tableview.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    }
    //  giftTableView.backgroundColor=[UIColor greenColor];
    tableview.rowHeight=80;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;//选中时cell样式
    // giftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tableview];
    
    ///添加下拉刷新
    __unsafe_unretained MyfocusViewController * vc=self;
    myFocusTableViewController = [[SimpleTableViewController alloc] initWithTableViewAndRefreshWith:tableview];
    
    myFocusTableViewController.cellClassName = @"ForwardGameCell";
  
    [myFocusTableViewController setCellBlock:^(UITableViewCell *aCell, GameItem *data, NSIndexPath *indexPath) {
        ForwardGameCell *cell = (ForwardGameCell*)aCell;
        cell.bottemlineColor=[UIColor grayColor];
        [cell.forwardGameIconImageView setdefaultLayer];
        
        CGRect headimageFame=cell.forwardGameIconImageView.frame;
        CGRect nameFame=cell.forwardNameLabel.frame;
        CGRect contentFame=cell.forwardTimeLable.frame;
        int space=cell.rankingNumberBrView.frame.size.width+cell.rankingNumberBrView.frame.origin.x;
        
        headimageFame.origin.x=headimageFame.origin.x-space;
        nameFame.origin.x=nameFame.origin.x-space;
        contentFame.origin.x=contentFame.origin.x-space;
        cell.forwardGameIconImageView.frame=headimageFame;
        cell.forwardNameLabel.frame=nameFame;
        cell.forwardTimeLable.frame=contentFame;
        [ cell.forwardGameIconImageView setImageWithURL:[NSURL URLWithString:data.gameIcon] placeholderImage:[UIImage imageNamed:@"图标占位图.png"]];
        cell.forwardNameLabel.text=data.gameName;
        if ([data.gameDate isKindOfClass:[NSString class]]) {
            NSString * starttime=[NSString stringWithFormat:@"预计:%@ 上线",data.gameDate];
            NSMutableDictionary * dic1=[NSMutableDictionary dictionaryWithObject:data.gameDate forKey:@"string"];
            [dic1 setObject:[UIColor blueColor] forKey:@"color"];
            NSMutableAttributedString *  customAttributedString=[starttime getAttributedColornstringWithArray:[[NSArray alloc]initWithObjects:dic1, nil]];
            [cell.forwardTimeLable setAttributedText:customAttributedString];
        }
        if (data.gameIsfocus) {
            cell.forwardBtn.selected=YES;
        }
        
        [cell.rankingNumberLable setHidden:YES];
        [cell.rankingNumberBrView setHidden:YES];
   
        [cell.forwardBtn setImage:[cell.forwardBtn imageForState:UIControlStateSelected] forState:UIControlStateNormal];
       cell.forwardfocusLable.text=[NSString stringWithFormat:@"%@关注",[data.focuscount numberconversion]];
      [cell.forwardBtn setMenuActionWithBlock:^{
    
          XYAlertView *alertView1 = [XYAlertView alertViewWithTitle:@"---------温馨提示--------"
                                                            message:[NSString stringWithFormat:@"你确定要取消《%@》关注 ？",data.gameName]
                                                            buttons:[NSArray arrayWithObjects:@"确定", @"取消", nil]
                                                       afterDismiss:^(int buttonIndex) {
                                                           if (buttonIndex==0) {
                                                               [vc postfocusgameServer:data];
                                                           }
                                                           
                                                       }];
          [alertView1 show];
          
        
      }];
    
        
    }];
    
    
    [myFocusTableViewController setSelectCellBlock:^(id data, NSIndexPath *indexPath) {
        GameDetailsViewController * gamedetailView=[[GameDetailsViewController alloc]initWithTitle:@"游戏详情"];
        gamedetailView.curtGameItem=[vc.myFocusTableViewController.tableData objectAtIndex:indexPath.row];
        gamedetailView.gametype=Rankingnew;
        [vc.navigationController pushViewController:gamedetailView animated:YES];
    }];
    
    
    //刷新
    [myFocusTableViewController.tableView addHeaderWithCallback:^{
        [vc.myFocusTableViewController requestTableViewDataWithparameter:nil withisRefresh:YES withpage:pagecount withViewController:vc];
    }];
    
    //加载更多
    [myFocusTableViewController.tableView addFooterWithCallback:^{
        
        [vc.myFocusTableViewController requestTableViewDataWithparameter:nil withisRefresh:NO withpage:pagecount withViewController:vc];
    }];
}



#pragma mark - post focusgame server
/**
 *  取消关注新游
 */
-(void)postfocusgameServer:(GameItem*)curtGameItem{
    FocusGameServerInterface *serverInterface = [FocusGameServerInterface serverInterface];
    NSDictionary *params = @{
                   @"gameid"      : curtGameItem.gameId,
                   @"cancel"      : @"1"
                   };

    [serverInterface getWithParams:params success:^(AFHTTPRequestOperation *request, id resultData, id responeData) {
        
        NSDictionary * datadic=(NSDictionary*)responeData;
        
        if ([datadic isKindOfClass:[NSDictionary class]]) {
            int status=  [[datadic objectForKey:@"status"]intValue];
            if (status) {
             
                [self.myFocusTableViewController.tableViewheader beginRefreshing];
            }
            [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];
            
        }
        
    } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
        
        NSDictionary * datadic=(NSDictionary*)responeData;
        [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];

    } loading:^(BOOL isLoading) {
        
    }];
}



#pragma mark - getGamedata server
/**
 *  请求我关注的游戏
 *
 *  @param param 请求参数
 */
- (void)getDatasWithtypeParamAndRefreshview:(NSDictionary *)param {
    
    {
        myFocusServerInterface *serverInterface = [myFocusServerInterface serverInterface];
        int start=[[param objectForKey:@"page"] intValue];
   
        NSDictionary *params = @{
                                 @"page"      : [NSNumber numberWithInt:start],
                                 @"count"      : [NSNumber numberWithInt:pagecount]
                                 };
        
        [serverInterface getWithParams:params success:^(AFHTTPRequestOperation *request, id resultData, id responeData) {
            LOG(@"get activity suscess: %@", resultData);
            NSArray * dataarray=resultData;
            
            NSMutableArray *_adataarray = [NSMutableArray array];
            
            if (dataarray!=nil&&[dataarray isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary * dic in dataarray) {
                    
                    GameItem * item=[[GameItem alloc]initWithDic:dic];
                    [_adataarray addObject:item];
                }
                [myFocusTableViewController addDataWithArray:_adataarray];

            }
            
            [myFocusTableViewController stopviewload:start];
            
        } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
            
            NSDictionary * datadic=responeData;
            [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];
            [myFocusTableViewController stopviewload:start];
            
        } loading:^(BOOL isLoading) {
            self.showLoadingView = isLoading;
            
        }];
        
    }
}




@end
