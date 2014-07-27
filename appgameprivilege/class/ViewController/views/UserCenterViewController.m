//
//  UserCenterViewController.m
//  appgameprivilege
//
//  Created by 姚东海 on 12/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "UserCenterViewController.h"
#import "Globle.h"
#define Titletag @"titlekey"
#define Imagetag @"imagekey"
#import "XibViewLoader.h"
#import "testViewController.h"
#import "config.h"
#import "AppConfig.h"
#import "global_defines.h"
#import "AppDelegate.h"
#import "Toast+UIView.h"
#import "XGPush.h"
#import "ColorUtil.h"
#import "UIView+CustomLayer.h"
@interface UserCenterViewController ()

@end

@implementation UserCenterViewController
@synthesize userTableview,datatitleArray;
@synthesize exitButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    if ([exitButton isMemberOfClass:[UIButton class]]) {
        [self changeBottemButton];
    }
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self createUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


///初始化数据
-(void)initData{
  
    datatitleArray=[[NSMutableArray alloc]init];
    ///我的关注
    NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
    [data setObject:@"5-个人_关注" forKey:Imagetag];
    [data setObject:@"我的关注" forKey:Titletag];
    [datatitleArray addObject:data];
    
    /**
     *  我的礼包
     */
    NSMutableDictionary * data4=[[NSMutableDictionary alloc]init];
    [data4 setObject:@"5-个人_礼包" forKey:Imagetag];
    [data4 setObject:@"我的礼包" forKey:Titletag];
    [datatitleArray addObject:data4];
    
    ///消息推送
    NSMutableDictionary * data1=[[NSMutableDictionary alloc]init];
    [data1 setObject:@"5-个人_消息" forKey:Imagetag];
    [data1 setObject:@"消息推送" forKey:Titletag];
    [datatitleArray addObject:data1];
    
    ///更多应用
    NSMutableDictionary * data2=[[NSMutableDictionary alloc]init];
    [data2 setObject:@"5-个人_更多" forKey:Imagetag];
    [data2 setObject:@"更多应用" forKey:Titletag];
    [datatitleArray addObject:data2];

    
    
}

///本地数据测试
-(void)testdata{

    
}

/**
 *  推送开关
 *
 *  @param sender 推送开关
 */
- (void) switchAction:(UISwitch*)sender{
    BOOL on = sender.on;
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];

    [standardDefaults setBool:!on forKey:kPushDefault];
    [[AppDelegate shareAppDelegate]registerNofitication];

}

#pragma mark - ViewController UI

-(void)createUI{
  
    self.navigationItem.leftBarButtonItem=nil;
    userTableview=[[UITableView alloc]initWithFrame:CGRectMake(0, self.x, self.view.frame.size.width, self.view.frame.size.height)];
    userTableview.showsVerticalScrollIndicator=NO;
    if (IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        userTableview.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    }
    userTableview.rowHeight=70;
    userTableview.delegate=self;
    userTableview.dataSource=self;
    userTableview.separatorStyle = UITableViewCellSeparatorStyleNone;//选中时cell样式
    userTableview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:userTableview];
    [userTableview reloadData];
    
    [self creatUserHeadView];
    [self creartUserOut];
};


/**
 *  个人中心头像View
 */
-(void)creatUserHeadView{
    UserCenterHeadView * userHeadview=[[UserCenterHeadView alloc]initWithFrame:CGRectMake(0, 0, userTableview.frame.size.width, 112)];
    userHeadview=[XibViewLoader loadViewWithName:@"UserCenterHeadView" owner:self atIndex:0];
       userHeadview.isBorder=YES;
    [userHeadview bangUserData];
    userTableview.tableHeaderView=userHeadview;
    
}

/**
 *  刷新
 */
-(void)refreshTableHeadView{
    UserCenterHeadView * userHeadview=(UserCenterHeadView*)userTableview.tableHeaderView;
    if ([userHeadview isKindOfClass:[UserCenterHeadView class]]) {
        [userHeadview bangUserData];
    }
}
/**
 *  退出按扭
 */
-(void)creartUserOut{
    UIView * exitView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, userTableview.frame.size.width, 50)];
    exitView.backgroundColor=[UIColor clearColor];
    exitButton=[UIButton buttonWithType:UIButtonTypeCustom];
    exitButton.frame=CGRectMake((exitView.frame.size.width-310)*0.5, (exitView.frame.size.height-45)*0.5, 310, 45);
    [self changeBottemButton];
    [exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    exitButton.titleLabel.font=Font(15);
    [exitButton setViewLayerWithRadius:7.0 AndBorderWidth:3.0 AndBorderColor:[UIColor clearColor]];
    [exitButton setBackgroundImage:[ColorUtil imageWithColor:RGB(235, 68, 62) andSize:exitButton.frame.size] forState:UIControlStateNormal];
     [exitButton setBackgroundImage:[ColorUtil imageWithColor:RGB(227, 34, 42) andSize:exitButton.frame.size] forState:UIControlStateHighlighted];
    __unsafe_unretained UserCenterViewController * vc=self;

       [exitButton setMenuActionWithBlock:^{
    
        if (!isLoginstate) {
        [[AppDelegate shareAppDelegate].hometabController
         loginActionWithLoginStateBlock:^(int state, NSString *describe) {
             if (state==QQ_LOGIN_SUCCESSFUL) {
                 [vc changeBottemButton];
             }
            [vc.view makeToast:describe duration:1.0 position:@"center"];
        
         }];
        }else{
               [[AppConfig shareInstance] cancellation];
               [vc refreshTableHeadView];
               [[AppDelegate shareAppDelegate].hometabController onClickLogout];
               [vc changeBottemButton];
        }
           
       }];
    [exitView addSubview:exitButton];
    userTableview.tableFooterView=exitView;
}

/**
 *  改变低部按扭状态
 */
-(void)changeBottemButton{
    if (!isLoginstate){
        [exitButton setTitle:@"登录" forState:UIControlStateNormal];
        
    }else{
        [exitButton setTitle:@"退出" forState:UIControlStateNormal];
        
    }
    

}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return datatitleArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UserCentersCell";
    NSMutableDictionary * dic=[datatitleArray objectAtIndex:indexPath.row];

        UserCentersCell *cell = (UserCentersCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
           cell = [[UserCentersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

            cell=[[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
            [cell setBottemlineColor:[UIColor grayColor]];
            if ([[dic objectForKey:Titletag] isEqualToString:@"消息推送"]) {
                if (!pushSwitch) {
                    pushSwitch=[[ UISwitch alloc]initWithFrame:CGRectMake(230.0,cell.titleLable.frame.origin.y,80,25)];
                    [pushSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
                    [cell.righttagimageview setHidden:YES];
                    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
                     BOOL isopen=[[standardDefaults objectForKey:kPushDefault] boolValue];
                    pushSwitch.on=!isopen;
                }
                [cell addSubview:pushSwitch];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

            }else{
                cell.selectionStyle = UITableViewCellSelectionStyleGray;

            }
            
        }

    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.titleLable.text=[dic objectForKey:Titletag];
     cell.headImageView.image= [UIImage imageNamed:[dic objectForKey:Imagetag]];

    cell.headImageView.highlightedImage= [UIImage imageNamed:[NSString stringWithFormat:@"%@_choose",[dic objectForKey:Imagetag]]];

    return cell;
}




#pragma mark - Table view data Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row!=2&&indexPath.row!=3) {
        if (!isLoginstate) {
            [[AppDelegate shareAppDelegate].hometabController isHaveGotoLoginWithLoginStateBlock:^(int state, NSString *describe) {
                if (state==QQ_LOGIN_SUCCESSFUL) {
                    [self chooseAction:indexPath.row];
                }
                [self.view makeToast:describe duration:1.0 position:@"center"];

            }];
        }else{
            [self chooseAction:indexPath.row];
        }
    }else if (indexPath.row==3){
        [self chooseAction:indexPath.row];

    }
}



/**
 *  选择动作
 *
 *  @param actionid ID
 */
-(void)chooseAction:(int)actionid{
    
    switch (actionid) {
        case 0:{//我的关注
               MyfocusViewController * vc=[[MyfocusViewController alloc]initWithTitle:@"我的关注"];
                [self.navigationController pushViewController:vc animated:YES];
             }
            break;
        case 1:{//我的礼包
            
        MyGiftViewController * vc=[[MyGiftViewController alloc]initWithTitle:@"我的礼包"];
        [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 3:{//更多
            MoreAppsViewController * moreview=[[MoreAppsViewController alloc]initWithTitle:@"更多应用"];
            [self.navigationController pushViewController:moreview animated:YES];
        }
            break;
        default:
            break;
    }
}




@end
