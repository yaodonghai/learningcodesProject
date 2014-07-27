//
//  SearchGamesViewController.m
//  appgameprivilege
//
//  Created by 姚东海 on 5/6/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "SearchGamesViewController.h"
#import "HomeTabController.h"
#import "Toast+UIView.h"
#import "AppDelegate.h"
#import "UIView+CustomLayer.h"
#import "NSString+Tools.h"
#import "SVWebViewController.h"
#import "ColorUtil.h"
#define pagecount 20
@interface SearchGamesViewController ()

@end

@implementation SearchGamesViewController
@synthesize searchBar,searchStr,searchTableViewController;
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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createUI{

    //float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    searchBar=[[UISearchBar alloc] initWithFrame: CGRectMake(0, 0, 180,40)];
    
    self.navigationItem.titleView=searchBar;
    searchBar.delegate=self;
    searchBar.placeholder=@"输入关键字";
    searchBar.delegate = self;
    searchBar.showsCancelButton = NO;
    searchBar.barStyle=UIBarStyleDefault;
    searchBar.keyboardType=UIKeyboardTypeNamePhonePad;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [searchBar becomeFirstResponder];
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
    {
        //        if ([_searchBar respondsToSelector:@selector(barTintColor)]) {
        //            [_searchBar setBarTintColor:[UIColor iOS7lightGrayColor]];//for ios7
        //        }
    }else {//ios7以下系统
        searchBar.backgroundColor=[UIColor clearColor];
        [[searchBar.subviews objectAtIndex:0]removeFromSuperview];
    }
    
    [self addUIToolbar];
    UITableView *     searchTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.x, self.view.frame.size.width, (self.view.frame.size.height))];
    if (IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        searchTableView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    }
    searchTableView.showsVerticalScrollIndicator=NO;

    searchTableView.rowHeight=80;
    searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//选中时cell样式
    // giftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
   [self.view addSubview:searchTableView];
    
    ///添加下拉刷新
    __unsafe_unretained SearchGamesViewController * vc=self;
    
    ///搜索
    searchTableViewController = [[SimpleTableViewController alloc] initWithTableViewAndRefreshWith:searchTableView];
    searchTableViewController.cellClassName = @"HomeGameCell";
    [searchTableViewController setCellBlock:^(UITableViewCell *aCell, GameItem *data, NSIndexPath *indexPath) {
        HomeGameCell *cell = (HomeGameCell*)aCell;
        cell.bottemlineColor=[UIColor grayColor];
        [cell.gameIconImageView setdefaultLayer];
        //cell.gamedownButton
        cell.bottemlineColor=[UIColor grayColor];
        [ cell.gameIconImageView setImageWithURL:[NSURL URLWithString:data.gameIcon] placeholderImage:[UIImage imageNamed:@"图标占位图.png"]];
        cell.gameNameLable.text=data.gameName;
        cell.gamedowncountLable.text=[NSString stringWithFormat:@"下载量: %@",data.gameDowncount];
        
        [cell.gamedownButton setTitle:@"下载" forState:UIControlStateNormal];
        [cell.gamedownButton setMenuActionWithBlock:^{
            GameDetailsViewController * gamedetailView=[[GameDetailsViewController alloc]initWithTitle:@"游戏详情"];
            gamedetailView.curtGameItem=[vc.searchTableViewController.tableData objectAtIndex:indexPath.row];
            gamedetailView.gametype=Rankinghot;
            [vc.navigationController pushViewController:gamedetailView animated:YES];
        }];
        
        UIImage * normalbrimage=[ColorUtil imageWithColor:RGB(0, 159, 231) andSize:cell.gamedownButton.frame.size];
        UIImage * hightlightbrimage=[ColorUtil imageWithColor:RGB(0, 159, 183) andSize:cell.gamedownButton.frame.size];
        [cell.gamedownButton setBackgroundImage:normalbrimage forState:UIControlStateNormal];
        [cell.gamedownButton setBackgroundImage:hightlightbrimage forState:UIControlStateHighlighted];
        [cell.gamedownButton setViewLayerWithRadius:5.0 AndBorderWidth:0.6 AndBorderColor:[UIColor whiteColor]];
    }];
    
    [searchTableViewController setSelectCellBlock:^(id data, NSIndexPath *indexPath) {
        
        GameDetailsViewController * gamedetailView=[[GameDetailsViewController alloc]initWithTitle:@"游戏详情"];
        gamedetailView.curtGameItem=[vc.searchTableViewController.tableData objectAtIndex:indexPath.row];
        gamedetailView.gametype=Rankinghot;
        [vc.navigationController pushViewController:gamedetailView animated:YES];
    }];
    
    //刷新
    [searchTableViewController.tableView addHeaderWithCallback:^{
        [vc.searchTableViewController requestTableViewDataWithparameter:nil withisRefresh:YES withpage:pagecount withViewController:vc];
    }];
    
    //加载更多
    [searchTableViewController.tableView addFooterWithCallback:^{
        [vc.searchTableViewController requestTableViewDataWithparameter:nil withisRefresh:NO withpage:pagecount withViewController:vc];
    }];
    [searchTableViewController reloadData];
}


#pragma mark -
#pragma mark searchbar Delegate
- (void)doSearch:(UISearchBar *)asearchBar{
    //取消UISearchBar调用的键盘
    [asearchBar resignFirstResponder];
    //[searchView setHidden:NO];
    //ifNeedFristLoading = YES;
    //[searchArray removeAllObjects];
    //start = 0;
    self.searchStr=asearchBar.text;
    [self.searchTableViewController.tableView headerBeginRefreshing];
    
}

/*取消按钮*/
- (void)searchBarCancelButtonClicked:(UISearchBar *)asearchBar{
    //取消UISearchBar调用的键盘
    [self clearSearchData];
    [searchBar resignFirstResponder];
    //[searchView setHidden:YES];
    //[self.RootScrollView setContentOffset:CGPointMake((userSelectedChannelID-100)*320, 0) animated:YES];
}


/*键盘搜索按钮*/
- (void)searchBarSearchButtonClicked:(UISearchBar *)asearchBar{
    
    [self doSearch:asearchBar];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)asearchBar {
    
    NSLog(@"searchBarShouldBeginEditing");
    asearchBar.showsCancelButton = YES;
    //改变UISearchBar取消按钮字体
    for(id cc in [asearchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            //btn.buttonType = UIButtonTypeCustom;
            //btn.frame = CGRectMake(0, 0, 55, 30);
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTintColor:[UIColor colorWithRed:(35.0f/255.0f) green:(127.0f/255.0f) blue:(187.0f/255.0f) alpha:1.0f]];
            //[btn setBackgroundImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
            //[btn setBackgroundImage:[UIImage imageNamed:@"Cancel-gray.png"] forState:UIControlStateHighlighted];
        }
    }
    return YES;
}

/**
 *  添加缩下键盘
 */
-(void)addUIToolbar{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"收起键盘" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    [searchBar setInputAccessoryView:topView];
}

/**
 *缩下
 */
-(void)dismissKeyBoard
{
    [searchBar resignFirstResponder];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)asearchBar {
    NSLog(@"searchBarShouldEndEditing");
    asearchBar.showsCancelButton = NO;
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"searchBarTextDidBeginEditing");
    //itunesAppnamesTableView.frame = CGRectMake(0, 40, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-40-20-44);
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"searchBarTextDidEndEditing");
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //NSLog(@"textDidChange:%@", searchText);
    self.searchStr = searchText;
    
    
}


#pragma mark - ViewController class methods
/**
 *  清空搜索数据
 */
-(void)clearSearchData{
    [self.searchTableViewController cleanData];
    [self.searchTableViewController reloadData];
    self.searchStr=@"";
    self.searchBar.text=@"";
}

#pragma mark - getGamedata server
/**
 *  游戏搜索请求
 *
 *  @param param 请求参数
 */
- (void)getDatasWithtypeParamAndRefreshview:(NSDictionary *)param {
    
    {
        GameListServerInterface *serverInterface = [GameListServerInterface serverInterface];
        int start=[[param objectForKey:@"page"] intValue];
        int count=[[param objectForKey:@"count"] intValue];
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSData *data = [self.searchStr dataUsingEncoding: enc];
        NSString *searchStrcode = [[NSString alloc] initWithData:data encoding:enc];
        NSDictionary *params = @{
                                 @"page"      : [NSNumber numberWithInt:start],
                                 @"count"      : [NSNumber numberWithInt:count],
                                 @"keyword":searchStrcode,
                                 @"type": [NSNumber numberWithInt:Rakingsearch]
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
                
                [self.searchTableViewController addDataWithArray:_adataarray];
             
            }
            [searchTableViewController stopviewload:start];
            
        } fail:^(AFHTTPRequestOperation *request, NSString *code, id responeData) {
            LOG(@"get activity fail: %@", responeData);
            
            NSDictionary * datadic=responeData;
            [self.view makeToast:[datadic objectForKey:@"msg"] duration:2.0 position:@"center"];
            [searchTableViewController stopviewload:start];
            
        } loading:^(BOOL isLoading) {
            self.showLoadingView = NO;
            
        }];
        
    }
}


@end
