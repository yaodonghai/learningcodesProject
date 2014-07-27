//
//  RankViewController.m
//  appgameprivilege
//
//  Created by 姚东海 on 7/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "RankViewController.h"
#import "UIView+CustomLayer.h"
#import "AppConfig.h"
#import "NSString+Tools.h"
#import "ColorUtil.h"
#import "UIView+CustomLayer.h"
#import "SearchGamesViewController.h"
#import "Toast+UIView.h"
#define pagecount 20
@interface RankViewController ()

@end

@implementation RankViewController
@synthesize hotTableViewController;
@synthesize newsTableViewController;
@synthesize rankstate;
@synthesize segmentedPerson;
@synthesize contentScrollView;
@synthesize curtGameItem;
@synthesize describeScrollView;
@synthesize hotloading,newloading;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(refreshnewgame:) name:@"refreshnewgame" object:nil];
    [super viewWillAppear:animated];
}


/**
 *  开始加载
 */
-(void)refreshnewgame:(NSNotification *)notification{
    [newsTableViewController.tableView headerBeginRefreshing];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [hotTableViewController.tableView headerBeginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


///初始化数据
-(void)initData{
    self.rankstate=Rankinghot;
    isnewgametag=YES;
    hotloading=NO;
    newloading=NO;
}



///本地数据测试
-(void)testdata{
    NSMutableArray *_adataarray = [NSMutableArray array];
    for (int i=0; i<30; i++) {
        GameItem * item=[[GameItem alloc]init];
        item.gameIcon=@"http://a4.mzstatic.com/us/r30/Purple6/v4/fe/66/1c/fe661cad-ecd4-8279-0c36-b73c55d58bc2/mzl.pdkpqudk.175x175-75.jpg";
        item.gameName=@"罪恶之地";
        item.gameDowncount=@"下载量:30000";
        
        [_adataarray addObject:item];
    }
    [self.hotTableViewController addDataWithArray:_adataarray];
    [self.hotTableViewController reloadData];
    NSMutableArray *newdata = [NSMutableArray array];
    for (int i=0; i<30; i++) {
        GameItem * item=[[GameItem alloc]init];
        item.gameIcon=@"http://a4.mzstatic.com/us/r30/Purple6/v4/fe/66/1c/fe661cad-ecd4-8279-0c36-b73c55d58bc2/mzl.pdkpqudk.175x175-75.jpg";
        item.gameName=@"罪恶之地";
        item.gameDate=@"上线日期 :2014-10-10";
        [newdata addObject:item];
    }
    [self.newsTableViewController addDataWithArray:newdata];
    [self.newsTableViewController reloadData];
    [self.newsTableViewController.tableView setHidden:YES];

    curtGameItem=[AppConfig getdescribeGameData];

}



#pragma mark - AKSegmentedControl callbacks

- (void)segmentedControlValueChanged:(id)sender
{
    AKSegmentedControl *segmented = (AKSegmentedControl *)sender;
   // LOG(@"SegmentedControl : Selected Index %@,%d", [segmented selectedIndexes], segmented.tag);
    
    NSUInteger indexselect=[segmented selectedIndexes].firstIndex;
    [self choosebottemLineAnimation:indexselect];
   if (indexselect==(Rankingnew-1)){
     
        if (isnewgametag) {
            [self.newsTableViewController.tableView headerBeginRefreshing];
        }
    }
    [self.contentScrollView setContentOffset:CGPointMake(self.contentScrollView.frame.size.width * indexselect,  self.contentScrollView.contentOffset.y) animated:YES];
}


#pragma mark - ViewController UI

-(void)createUI{
 
    self.navigationItem.leftBarButtonItem=nil;
    UIImage * searchimage=[UIImage imageNamed:@"2-推荐-搜索_03.png"];
    UIButton * searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:searchimage forState:UIControlStateNormal];
    searchBtn.frame=CGRectMake(0, 0, searchimage.size.width, searchimage.size.height);
    [searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    temporaryRightBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem=temporaryRightBarButtonItem;
    NSArray*  segStr=[[NSArray alloc]initWithObjects:@"热门排行",@"新游期待", nil];
    segmentedPerson = [[AKSegmentedControl alloc] initWithFrame:CGRectMake(0, self.x, 320, 40)];
    [segmentedPerson addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [segmentedPerson setBackgroundColor:[UIColor whiteColor]];
    [segmentedPerson setSegmentedControlMode:AKSegmentedControlModeSticky];
    UIImage * btnbrimage=[ColorUtil imageWithColor:[UIColor whiteColor] andSize:CGSizeMake((self.view.frame.size.width/2), 40)];
    
    NSMutableArray * btns=[[NSMutableArray alloc]initWithCapacity:segStr.count];
    for (NSString * btntitle in segStr) {
        
        UIButton *  segBtn = [[UIButton alloc] init];
        [segBtn setBackgroundImage:btnbrimage forState:UIControlStateNormal];
        [segBtn setBackgroundImage:btnbrimage forState:UIControlStateHighlighted];
        [segBtn setBackgroundImage:btnbrimage forState:UIControlStateSelected];
        [segBtn setBackgroundImage:btnbrimage forState:(UIControlStateHighlighted|UIControlStateSelected)];
        [segBtn setTitle:btntitle forState:UIControlStateNormal];
        [segBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [segBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [segBtn setTitleColor:RGB(255, 47, 119) forState:UIControlStateSelected];
        [segBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0]];
        [btns addObject:segBtn];
    }
    
    
    // Setting the UIButtons used in the segmented control
    [segmentedPerson setButtonsArray:btns];
    [segmentedPerson setSelectedIndex:0];
    
    //[buttonSocial setHighlighted:YES];
    // Adding your control to the view
    [self.view addSubview:segmentedPerson];
    
    bottemlineView=[[UIView alloc]initWithFrame:CGRectMake(0, segmentedPerson.frame.origin.y+segmentedPerson.frame.size.height, self.view.frame.size.width, 0.7)];
    bottemlineView.backgroundColor=RGB(217, 217, 217);
    [self.view addSubview:bottemlineView];
    
    curtbottemlineView=[[UIView alloc]initWithFrame:CGRectMake(0, bottemlineView.frame.origin.y+bottemlineView.frame.size.height, (self.view.frame.size.width/2), 0.7)];
    curtbottemlineView.backgroundColor=[UIColor redColor];
    [self.view addSubview:curtbottemlineView];

    
    contentScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, curtbottemlineView.frame.origin.y+curtbottemlineView.frame.size.height, self.view.frame.size.width, (self.view.frame.size.height-segmentedPerson.frame.size.height))];
    contentScrollView.delegate=self;
    contentScrollView.pagingEnabled=YES;
    contentScrollView.scrollEnabled=YES;
    contentScrollView.showsVerticalScrollIndicator=NO;
    contentScrollView.showsHorizontalScrollIndicator=NO;
    CGSize contentsize=contentScrollView.contentSize;
    contentsize.width=contentScrollView.frame.size.width*2;
    contentScrollView.contentSize=contentsize;
    [self.view addSubview:contentScrollView];
    
    UITableView *     hotTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, contentScrollView.frame.size.width, contentScrollView.frame.size.height)];
    hotTableView.showsVerticalScrollIndicator=NO;
    if (IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        hotTableView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    }
    hotTableView.rowHeight=80;
    hotTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//选中时cell样式
    [self.contentScrollView addSubview:hotTableView];

    CGRect newTableFame=hotTableView.frame;
    newTableFame.origin.x=newTableFame.size.width;
    UITableView *     newTableView=[[UITableView alloc]initWithFrame:newTableFame];
    newTableView.showsVerticalScrollIndicator=NO;

    if (IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        newTableView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    }
    newTableView.rowHeight=80;
    newTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//选中时cell样式
    // giftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.contentScrollView addSubview:newTableView];
 
    __unsafe_unretained RankViewController * vc=self;
    ///热门
    hotTableViewController = [[SimpleTableViewController alloc] initWithTableViewAndRefreshWith:hotTableView];
    
    hotTableViewController.cellClassName = @"RankingCell";
  
    
    [hotTableViewController setCellBlock:^(UITableViewCell *aCell, GameItem *data, NSIndexPath *indexPath) {
        RankingCell *cell = (RankingCell*)aCell;
        cell.bottemlineColor=[UIColor grayColor];
        [cell.brView setViewLayerWithRadius:3.0 AndBorderWidth:0.6 AndBorderColor:[UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:206.0/255.0 alpha:0.7]];
        [cell.rankingIconImageView  setdefaultLayer];
        [ cell.rankingIconImageView setImageWithURL:[NSURL URLWithString:data.gameIcon] placeholderImage:[UIImage imageNamed:@"图标占位图.png"]];
        cell.rankingNameLable.text=data.gameName;
        cell.rankingtimeLable.text=[NSString stringWithFormat:@"下载量: %@",data.gameDowncount];
        [cell.rankingfocusButton setTitle:@"下载" forState:UIControlStateNormal];
        
        if (indexPath.row==0) {
              [cell.rankingNumberBrView setViewLayerWithRadius:6.0 AndBorderWidth:0.2 AndBorderColor:[UIColor whiteColor]];
            [cell.rankingNumberBrView setHidden:NO];
            cell.rankingNumberBrView.backgroundColor=RGB(241, 51, 119);
        }else if (indexPath.row==1){
              [cell.rankingNumberBrView setViewLayerWithRadius:6.0 AndBorderWidth:0.2 AndBorderColor:[UIColor whiteColor]];
            cell.rankingNumberBrView.backgroundColor=RGB(99, 186, 52);
            [cell.rankingNumberBrView setHidden:NO];

        }else if (indexPath.row==2){
              [cell.rankingNumberBrView setViewLayerWithRadius:6.0 AndBorderWidth:0.2 AndBorderColor:[UIColor whiteColor]];
            cell.rankingNumberBrView.backgroundColor=RGB(234, 157, 40);
            [cell.rankingNumberBrView setHidden:NO];

        }else{
            [cell.rankingNumberBrView setHidden:YES];
        }
        [cell.rankingNumberLable setText:[NSString stringWithFormat:@"%d",(indexPath.row+1)]];

        
        UIImage * normalbrimage=[ColorUtil imageWithColor:RGB(0, 159, 231) andSize:cell.rankingfocusButton.frame.size];
        UIImage * hightlightbrimage=[ColorUtil imageWithColor:RGB(0, 159, 183) andSize:cell.rankingfocusButton.frame.size];
        [cell.rankingfocusButton setBackgroundImage:normalbrimage forState:UIControlStateNormal];
        [cell.rankingfocusButton setBackgroundImage:hightlightbrimage forState:UIControlStateHighlighted];
        [cell.rankingfocusButton setViewLayerWithRadius:5.0 AndBorderWidth:0.6 AndBorderColor:[UIColor whiteColor]];
       
        [cell.rankingfocusButton setMenuActionWithBlock:^{
            GameDetailsViewController * gamedetailView=[[GameDetailsViewController alloc]initWithTitle:@"游戏详情"];
            gamedetailView.curtGameItem=[vc.hotTableViewController.tableData objectAtIndex:indexPath.row];
            gamedetailView.gametype=Rankinghot;
            [vc.navigationController pushViewController:gamedetailView animated:YES];
        }];
        
    }];
    
    [hotTableViewController setSelectCellBlock:^(id data, NSIndexPath *indexPath) {
        GameDetailsViewController * gamedetailView=[[GameDetailsViewController alloc]initWithTitle:@"游戏详情"];
        gamedetailView.curtGameItem=[vc.hotTableViewController.tableData objectAtIndex:indexPath.row];
        gamedetailView.gametype=Rankinghot;
        [vc.navigationController pushViewController:gamedetailView animated:YES];
        
    }];
    
    //刷新
    [hotTableViewController.tableView addHeaderWithCallback:^{
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInt:Rankinghot] , @"type",
                               nil];
        [vc.hotTableViewController requestTableViewDataWithparameter:param withisRefresh:YES withpage:pagecount withViewController:vc];
    }];
    
    //加载更多
    [hotTableViewController.tableView addFooterWithCallback:^{
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInt:Rankinghot] , @"type",
                               nil];
        [vc.hotTableViewController requestTableViewDataWithparameter:param withisRefresh:NO withpage:pagecount withViewController:vc];
    }];
    
    
     ///新游戏
    newsTableViewController = [[SimpleTableViewController alloc] initWithTableViewAndRefreshWith:newTableView];
    
    newsTableViewController.cellClassName = @"ForwardGameCell";
    
    [newsTableViewController setCellBlock:^(UITableViewCell *aCell, GameItem *data, NSIndexPath *indexPath) {
        ForwardGameCell *cell = (ForwardGameCell*)aCell;
        cell.bottemlineColor=[UIColor grayColor];
        [cell.forwardGameIconImageView setdefaultLayer];
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
        
        if (indexPath.row==0) {
            [cell.rankingNumberBrView setViewLayerWithRadius:6.0 AndBorderWidth:0.2 AndBorderColor:[UIColor whiteColor]];
            [cell.rankingNumberBrView setHidden:NO];
            cell.rankingNumberBrView.backgroundColor=RGB(241, 51, 119);
        }else if (indexPath.row==1){
            [cell.rankingNumberBrView setViewLayerWithRadius:6.0 AndBorderWidth:0.2 AndBorderColor:[UIColor whiteColor]];
            cell.rankingNumberBrView.backgroundColor=RGB(99, 186, 52);
            [cell.rankingNumberBrView setHidden:NO];
            
        }else if (indexPath.row==2){
            [cell.rankingNumberBrView setViewLayerWithRadius:6.0 AndBorderWidth:0.2 AndBorderColor:[UIColor whiteColor]];
            cell.rankingNumberBrView.backgroundColor=RGB(234, 157, 40);
            [cell.rankingNumberBrView setHidden:NO];
            
        }else{
            [cell.rankingNumberBrView setHidden:YES];
        }
        [cell.rankingNumberLable setText:[NSString stringWithFormat:@"%d",(indexPath.row+1)]];

        cell.forwardfocusLable.text=[NSString stringWithFormat:@"%@关注",[data.focuscount numberconversion]];
        cell.forwardBtn.userInteractionEnabled=NO;
   
        
    }];
    

    
    [newsTableViewController setSelectCellBlock:^(id data, NSIndexPath *indexPath) {
        GameDetailsViewController * gamedetailView=[[GameDetailsViewController alloc]initWithTitle:@"游戏详情"];
        gamedetailView.curtGameItem=[vc.newsTableViewController.tableData objectAtIndex:indexPath.row];
        gamedetailView.gametype=Rankingnew;
        [vc.navigationController pushViewController:gamedetailView animated:YES];
    }];

   
    //刷新
    [newsTableViewController.tableView addHeaderWithCallback:^{
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInt:Rankingnew] , @"type",
                               nil];
        [vc.newsTableViewController requestTableViewDataWithparameter:param withisRefresh:YES withpage:pagecount withViewController:vc];
    }];
    
    //加载更多
    [newsTableViewController.tableView addFooterWithCallback:^{
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInt:Rankingnew] , @"type",
                               nil];
        [vc.newsTableViewController requestTableViewDataWithparameter:param withisRefresh:NO withpage:pagecount withViewController:vc];
    }];
    
};


-(void)creartTableHeadView{
    UIView * headview=self.newsTableViewController.tableView.tableHeaderView;
    if (![headview isKindOfClass:[UIView class]]) {
        CGRect headFame=CGRectMake(0, 0, self.newsTableViewController.tableView.frame.size.width, 0);

        headview=[[UIView alloc]initWithFrame:headFame];
    }
    [headview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    headview.userInteractionEnabled=YES;
    describeScrollView=[[GameDescribeScrollView alloc]initWithFrame:headview.frame AndGameItem:curtGameItem];
    [describeScrollView.headview.gamezanButton addTarget:self action:@selector(praiseAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentScrollView addSubview:describeScrollView];
    [headview addSubview:describeScrollView];
    CGRect headFame=headview.frame;
    headFame.size.height=describeScrollView.contentSize.height;
    headview.frame=headFame;
    describeScrollView.frame=headview.frame;
    self.newsTableViewController.tableView.tableHeaderView=headview;

}

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
    
  
        CGPoint offset = scrollView.contentOffset;
        int page= offset.x /self.contentScrollView.frame.size.width;
        [segmentedPerson setSelectedIndex:page];
        [self choosebottemLineAnimation:page];

    if (page==(Rankingnew-1)) {
        if (isnewgametag) {
            [self.newsTableViewController.tableView headerBeginRefreshing];
        }
    }

}
#pragma mark -  class methods
-(void)praiseAction:(UIButton*)sender{

}

/**
 *  搜索
 *
 *  @param sender btn
 */
-(void)searchAction:(UIButton*)sender{
    SearchGamesViewController * searchview=[[SearchGamesViewController alloc]initWithTitle:@""];
    [self.navigationController pushViewController:searchview animated:YES];
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

    
#pragma mark - getGamedata server
    
    - (void)getDatasWithtypeParamAndRefreshview:(NSDictionary *)param {
        
        {
            GameListServerInterface *serverInterface = [GameListServerInterface serverInterface];
            SimpleTableViewController * curttableviewController;
            int type=[[param objectForKey:@"type"] intValue];
            int start=[[param objectForKey:@"page"] intValue];
            if (type==Rankinghot) {
                curttableviewController=self.hotTableViewController;

            }else{
                curttableviewController=self.newsTableViewController;

            }
            
            NSDictionary *params = @{
                                     @"page"      : [NSNumber numberWithInt:start],
                                     @"count"      : [NSNumber numberWithInt:pagecount],
                                     @"type": [NSNumber numberWithInt:type]
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
                    
                    if (type==Rankinghot) {
                        
                        [self.hotTableViewController addDataWithArray:_adataarray];

                    }else{
                        
                        isnewgametag=NO;
                        if (_adataarray.count==1&&(self.newsTableViewController.tableData.count==1||self.newsTableViewController.tableData.count==0)) {
                            curtGameItem=[_adataarray objectAtIndex:0];
                            [self getGameDetaiWithGameid:curtGameItem.gameId];
                        }else{
                              [self.newsTableViewController addDataWithArray:_adataarray];
                            self.newsTableViewController.tableView.tableHeaderView=nil;
                        }
                    }
                    
                    
                }
                
                [curttableviewController stopviewload:start];
        
            } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
                LOG(@"get activity fail: %@", responeData);
                
                NSDictionary * datadic=responeData;
                [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];
                [curttableviewController stopviewload:start];

            } loading:^(BOOL isLoading) {
                self.showLoadingView = NO;
                
            }];
            
        }
    }



#pragma mark - get GameDetai server
-(void)getGameDetaiWithGameid:(NSString*)gameid{
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
            [self creartTableHeadView];
            ///描述内容
        }
        
        
    } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
        
    } loading:^(BOOL isLoading) {
        self.showLoadingView = NO;

    }];
}



@end
