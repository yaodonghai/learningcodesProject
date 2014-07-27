//
//  ProjectViewController.m
//  appgameprivilege
//
//  Created by 姚东海 on 7/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "ProjectViewController.h"
#import "Toast+UIView.h"
#import "ArticleItem.h"
#define pagecount 20

@interface ProjectViewController ()

@end

@implementation ProjectViewController
@synthesize projectTableViewController;
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
    [self initData];
    [self createUI];
   // [self test];
    //[projectTableViewheader beginRefreshing];
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

///本地数据测试
-(void)test{
    NSMutableArray *_adataarray = [NSMutableArray array];
    for (int i=0; i<30; i++) {
        
        ProjectItem * item=[[ProjectItem alloc]init];
        item.projectTitle=@"攻略title";
        item.projectFirstThumbmail=@"http://www.appgame.com/wp-content/uploads/2013/04/31-300x225.jpg";
        item.projectUrl=@"http://www.appgame.com/";
        item.projectType=@"视频";
        [_adataarray addObject:item];
    }
    [self.projectTableViewController addDataWithArray:_adataarray];
    [self.projectTableViewController reloadData];
}

#pragma mark - ViewController UI

-(void)createUI{
 
    self.navigationItem.leftBarButtonItem=nil;
    UITableView *     tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, self.x, self.view.frame.size.width, self.view.frame.size.height)];
    if (IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        tableview.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    }
    //  giftTableView.backgroundColor=[UIColor greenColor];
    tableview.rowHeight=165;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;//选中时cell样式
    [self.view addSubview:tableview];
    tableview.showsHorizontalScrollIndicator=NO;
    tableview.showsVerticalScrollIndicator=NO;
    ///添加下拉刷新
    __unsafe_unretained ProjectViewController * vc=self;
    projectTableViewController = [[SimpleTableViewController alloc] initWithTableViewAndRefreshWith:tableview];
    
    projectTableViewController.cellClassName = @"ProjectCell";
   
    [projectTableViewController setCellBlock:^(UITableViewCell *aCell, ArticleItem *data, NSIndexPath *indexPath) {
        ProjectCell *cell = (ProjectCell*)aCell;
        cell.bottemlineColor=[UIColor grayColor];
        [cell.projectHeadImageView setImageWithURL:data.articleIconURL placeholderImage:[UIImage imageNamed:@"图标占位图1.png"]];
        cell.projectTitleLable.text=[NSString stringWithFormat:@"· %@",data.title];
        
    }];
    
    [projectTableViewController setSelectCellBlock:^(id data, NSIndexPath *indexPath) {
        ArticleItem * item=(ArticleItem*)data;
//              GHRootViewController *    vcview = [[GHRootViewController alloc] initWithTitle:item.projectTitle withUrl:item.projectUrl];
//                vcview.isshowRefreshView=YES;
//
//                [vc.navigationController pushViewController:vcview animated:YES];
//        [vcview.mainWebView loadRequest:[NSURLRequest requestWithURL:vcview.webURL]];
//        
//        
//        
        
        DetailViewController *vcview = [[DetailViewController alloc] initWithTitle:item.title];
        vcview.appData=vc.projectTableViewController.tableData;
        vcview.startIndex = indexPath.row;
        [vc.navigationController pushViewController:vcview animated:YES];
    }];

    //刷新
    [projectTableViewController.tableView addHeaderWithCallback:^{
        [vc.projectTableViewController requestTableViewDataWithparameter:nil withisRefresh:YES withpage:pagecount withViewController:vc];
    }];
    
    //加载更多
    [projectTableViewController.tableView addFooterWithCallback:^{
    
        [vc.projectTableViewController requestTableViewDataWithparameter:nil withisRefresh:NO withpage:pagecount withViewController:vc];
    }];
    
    
    [self.projectTableViewController.tableView headerBeginRefreshing];
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
        
        ProjectServerInterface *serverInterface = [ProjectServerInterface serverInterface];
        int start=[[param objectForKey:@"page"] intValue];
        int count=[[param objectForKey:@"count"] intValue];
        
        NSDictionary *params = @{
                                 @"page"      : [NSNumber numberWithInt:start],
                                 @"count"      : [NSNumber numberWithInt:count],
                                 @"json"      : @"1"
                                 };
        
        [serverInterface getWithParams:params success:^(AFHTTPRequestOperation *request, id resultData, id responeData) {
            LOG(@"get activity suscess: %@", resultData);
            NSArray * dataarray=resultData;
            
            NSMutableArray *_adataarray = [NSMutableArray array];
            
            if (dataarray!=nil&&[dataarray isKindOfClass:[NSArray class]]) {
                
                
                
                for (NSDictionary * dic in dataarray) {
                    
                    ArticleItem  * item=[[ArticleItem alloc]initAricleItem:dic];
                    //ProjectItem * item=[[ProjectItem alloc]initDic:dic];
                    [_adataarray addObject:item];
                    
                }
                
                [self.projectTableViewController addDataWithArray:_adataarray];
               
            }
            
            [projectTableViewController stopviewload:start];
        } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
            LOG(@"get activity fail: %@", responeData);
            
            NSDictionary * datadic=responeData;
            [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];
            [projectTableViewController stopviewload:start];

        } loading:^(BOOL isLoading) {
            self.showLoadingView = NO;
            
        }];
        
    }
}



@end
