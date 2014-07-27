//
//  MoreAppsViewController.m
//  appgameprivilege
//
//  Created by 姚东海 on 14/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "MoreAppsViewController.h"
#import "Globle.h"
#import "HMSideMenu.h"
#import "Toast+UIView.h"
#import "NSString+Tools.h"
#import "UIView+CustomLayer.h"
#import "ColorUtil.h"
#define pagecount 20
@interface MoreAppsViewController ()

@end

@implementation MoreAppsViewController
@synthesize moreAppTableviewController;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
    [self.moreAppTableviewController.tableView headerBeginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
 
    self.view.backgroundColor=[UIColor whiteColor];
    
    UITableView *     tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, self.x, self.view.frame.size.width, self.view.frame.size.height)];
    if (IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        tableview.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    }
    //  giftTableView.backgroundColor=[UIColor greenColor];
    tableview.rowHeight=60;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;//选中时cell样式
    // giftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tableview];
    
    ///添加下拉刷新
    __unsafe_unretained MoreAppsViewController * vc=self;
    moreAppTableviewController = [[SimpleTableViewController alloc] initWithTableViewAndRefreshWith:tableview];
    moreAppTableviewController.cellClassName = @"MoreAppCell";
    
    [moreAppTableviewController setCellBlock:^(UITableViewCell *aCell, GameItem *data, NSIndexPath *indexPath) {
        MoreAppCell *cell = (MoreAppCell*)aCell;
        [cell.moreAppIconImageView setdefaultLayer];
        [cell setBottemlineColor:[UIColor grayColor]];
        [cell.moreAppIconImageView setImageWithURL:[NSURL URLWithString:data.gameIcon] placeholderImage:[UIImage imageNamed:@"图标占位图.png"]];
        
        cell.moreAppNameLable.text=data.gameName;
       // [ColorUtil imageWithColor: si]
    UIImage * imagenormal=[ColorUtil imageWithColor:RGB(48, 211, 68) andSize:cell.moreAppOperationButton.frame.size];

    UIImage * imagehightlight=[ColorUtil imageWithColor:RGB(0, 143, 29) andSize:cell.moreAppOperationButton.frame.size];
        [cell.moreAppOperationButton setBackgroundImage:imagenormal forState:UIControlStateNormal];
        [cell.moreAppOperationButton setBackgroundImage:imagehightlight forState:UIControlStateHighlighted];
        [cell.moreAppOperationButton  setTitle:@"下载" forState:UIControlStateNormal];
        [cell.moreAppOperationButton setViewLayerWithRadius:6.0 AndBorderWidth:1.0 AndBorderColor:[UIColor whiteColor]];
      [cell setMenuActionWithBlock:^{
          if ([data.gameDowurl isKindOfClass:[NSString class]]) {
              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data.gameDowurl]];
          }
      }];
        
    }];
    
    [moreAppTableviewController setSelectCellBlock:^(GameItem *data, NSIndexPath *indexPath) {
        
        if ([data.gameDowurl isKindOfClass:[NSString class]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data.gameDowurl]];
        }
    }];

    
    //刷新
    [moreAppTableviewController.tableView addHeaderWithCallback:^{
        [vc.moreAppTableviewController requestTableViewDataWithparameter:nil withisRefresh:YES withpage:pagecount withViewController:vc];
    }];
    
    //加载更多
    [moreAppTableviewController.tableView addFooterWithCallback:^{
        
        [vc.moreAppTableviewController requestTableViewDataWithparameter:nil withisRefresh:NO withpage:pagecount withViewController:vc];
    }];
    
}




#pragma mark - getGamedata server
/**
 *  更多APP 请求
 *
 *  @param param 请求参数
 */
- (void)getDatasWithtypeParamAndRefreshview:(NSDictionary *)param {
    
    {
        
        MoreAppsServerInterface *serverInterface = [MoreAppsServerInterface serverInterface];
        int start=[[param objectForKey:@"page"] intValue];
        int count=[[param objectForKey:@"count"] intValue];
        
        NSDictionary *params = @{
                                 @"page"      : [NSNumber numberWithInt:start],
                                 @"count"      : [NSNumber numberWithInt:count]
                                 };
        
        [serverInterface getWithParams:params success:^(AFHTTPRequestOperation *request, id resultData, id responeData) {
            
            NSArray * dataarray=resultData;
            NSMutableArray *_adataarray = [NSMutableArray array];
            //LOG(@"count=------: %d", dataarray.count);

            if (dataarray!=nil&&[dataarray isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary * dic in dataarray) {
                    
                    GameItem * item=[[GameItem alloc]initWithMoreAppDic:dic];
                    [_adataarray addObject:item];
                    
                }
                [self.moreAppTableviewController addDataWithArray:_adataarray];
                
            }
            [moreAppTableviewController stopviewload:start];
        } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
            NSDictionary * datadic=responeData;
            [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];
            [moreAppTableviewController stopviewload:start];
        } loading:^(BOOL isLoading) {
            self.showLoadingView = NO;
            
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

@end
