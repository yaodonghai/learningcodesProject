//
//  MyGiftViewController.m
//  appgameprivilege
//
//  Created by 姚东海 on 13/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "MyGiftViewController.h"
#import "Toast+UIView.h"
#import "NSString+Tools.h"
#import "ColorUtil.h"
#import "UIView+CustomLayer.h"
#import "Toast+UIView.h"
#import "ActiviyDetailViewController.h"
#define pagecount 20
@interface MyGiftViewController (){
    
}

@end

@implementation MyGiftViewController
@synthesize myGiftTableViewController;


#pragma mark - ViewController init
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
    [self initData];
    [self createUI];
    [self.myGiftTableViewController.tableView headerBeginRefreshing];
    //[self test];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


///初始化数据
-(void)initData{
  
    
}


/**
 *  本地数据测试
 */
-(void)test{
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
    tableview.rowHeight=85;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;//选中时cell样式
    // giftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tableview];
    ///添加下拉刷新
    __unsafe_unretained MyGiftViewController * vc=self;
    myGiftTableViewController = [[SimpleTableViewController alloc] initWithTableViewAndRefreshWith:tableview];
    
    myGiftTableViewController.cellClassName = @"MyGiftCell";
    
    [myGiftTableViewController setCellBlock:^(UITableViewCell *aCell, ActivityItem *data, NSIndexPath *indexPath) {
        MyGiftCell *cell = (MyGiftCell*)aCell;
        [cell  setBottemlineColor:[UIColor grayColor]];
       // [cell.giftheadImageView setdefaultLayer];
        [cell.giftheadImageView setImageWithURL:[NSURL URLWithString:data.activitythumbmail] placeholderImage:[UIImage imageNamed:@"图标占位图.png"]];
        cell.giftNameLable.text=data.activityName;
        NSString * contentnstrong=[NSString stringWithFormat:@"兑换码:%@", data.activitycode];
        
        NSMutableDictionary * dic1=[NSMutableDictionary dictionaryWithObject:@"兑换码:" forKey:@"string"];
        [dic1 setObject:[UIColor grayColor] forKey:@"color"];
        [dic1 setObject:[UIFont fontWithName:@"Arial" size:12.0] forKey:@"font"];
        NSMutableDictionary * dic2=[NSMutableDictionary dictionaryWithObject:data.activitycode forKey:@"string"];
        [dic2 setObject:RGB(0, 202, 253) forKey:@"color"];
        [dic2 setObject:[UIFont fontWithName:@"Arial" size:12.0] forKey:@"font"];
        NSMutableAttributedString *  customAttributedString=[contentnstrong getAttributedColornstringWithArray:[[NSArray alloc]initWithObjects:dic1,dic2, nil]];
        [cell.giftcodeLable setAttributedText:customAttributedString];
        
        UIImage * brimagenormal=[ColorUtil imageWithColor:RGB(0, 159, 231) andSize:cell.giftCopyButton.frame.size];
        UIImage * brimagehightlight=[ColorUtil imageWithColor:RGB(0, 159, 222) andSize:cell.giftCopyButton.frame.size];
        [cell.giftCopyButton setBackgroundImage:brimagenormal forState:UIControlStateNormal];
        [cell.giftCopyButton setBackgroundImage:brimagehightlight forState:UIControlStateNormal];

        [cell.giftCopyButton setMenuActionWithBlock:^{
            
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = data.activitycode;
            [vc.view makeToast:@"已复制礼包码到剪贴板" duration:2.0 position:@"center"];

    
        }];
     
    }];
    
    [myGiftTableViewController setSelectCellBlock:^(ActivityItem *data, NSIndexPath *indexPath) {
        ActiviyDetailViewController * vcView=[[ActiviyDetailViewController alloc]initWithTitle:@"礼包详情"];
        vcView.curtactivityItem=data;
        if ([vcView.curtactivityItem.activitycurttype integerValue]==Activitygift) {
            vcView.title=@"礼包详情";
        }
        [vc.navigationController pushViewController:vcView animated:YES];
    }];
    
    //刷新
    [myGiftTableViewController.tableView addHeaderWithCallback:^{
        [vc.myGiftTableViewController requestTableViewDataWithparameter:nil withisRefresh:YES withpage:pagecount withViewController:vc];
    }];
    
    //加载更多
    [myGiftTableViewController.tableView addFooterWithCallback:^{
        
        [vc.myGiftTableViewController requestTableViewDataWithparameter:nil withisRefresh:NO withpage:pagecount withViewController:vc];
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
            
            MyGiftPagsServerInterface *serverInterface = [MyGiftPagsServerInterface serverInterface];
            int start=[[param objectForKey:@"page"] intValue];
            int count=[[param objectForKey:@"count"] intValue];

            NSDictionary *params = @{
                                     @"page"      : [NSNumber numberWithInt:start],
                                     @"count"      : [NSNumber numberWithInt:count]
                                     };
            
            [serverInterface getWithParams:params success:^(AFHTTPRequestOperation *request, id resultData, id responeData) {
                LOG(@"get activity suscess: %@", resultData);
                NSArray * dataarray=resultData;
                LOG(@"cout----%d",dataarray.count);
                NSMutableArray *_adataarray = [NSMutableArray array];
                
                if (dataarray!=nil&&[dataarray isKindOfClass:[NSArray class]]) {
                    
                    for (NSDictionary * dic in dataarray) {
                        ActivityItem * item=[[ActivityItem alloc]initMyGiftWithDic:dic];
                        [_adataarray addObject:item];
                        
                    }
                    [self.myGiftTableViewController addDataWithArray:_adataarray];
                    
                }
                [myGiftTableViewController stopviewload:start];
                
            } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
                NSDictionary * datadic=responeData;
                [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];
                [myGiftTableViewController stopviewload:start];
            } loading:^(BOOL isLoading) {
                self.showLoadingView = NO;
                
            }];
            
        }
    }


@end
