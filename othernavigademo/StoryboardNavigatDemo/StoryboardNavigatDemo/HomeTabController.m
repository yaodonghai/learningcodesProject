//
//  HomeTabController.m
//  GameStrategys
//
//  Created by 姚东海 on 5/5/14.
//  Copyright (c) 2014年 junewong. All rights reserved.
//

#import "HomeTabController.h"

@interface HomeTabController (){
    ///ViewController标题
    NSArray  * tabitemTitles;
    
}


@end

@implementation HomeTabController
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
    
}

/**
 *  qq 初始化 设置
 */
-(void)initQQData{
    
}

- (void)viewDidLoad
{
  [super viewDidLoad];
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
//    activityViewController=[[ActivityViewController alloc]init];
//    activityViewController.title=@"活动礼包";
//     navigation1=  [[MDSlideNavigationViewController alloc] initWithRootViewController:activityViewController];
//    ///排行榜
//    rankViewController=[[RankViewController alloc]init];
//    rankViewController.title=@"推荐";
//
//     navigation2=  [[MDSlideNavigationViewController alloc] initWithRootViewController:rankViewController];
//    ///主题
//    projectViewController=[[ProjectViewController alloc]init];
//    projectViewController.title=@"专题";
//
//    navigation3=  [[MDSlideNavigationViewController alloc] initWithRootViewController:projectViewController];
//    ///个人中心
//    usercenterViewController=[[UserCenterViewController alloc]init];
//    usercenterViewController.title=@"个人中心";
//
//     navigation4=  [[MDSlideNavigationViewController alloc] initWithRootViewController:usercenterViewController];
//    
//    self.viewControllers=@[navigation1,navigation2,navigation3,navigation4];
//    
//    self.selectedIndex=0;
//    self.view.backgroundColor=[UIColor redColor];
}


///自定义tabBar
-(void)creatUI{
    self.view.backgroundColor=[UIColor whiteColor];
  
     tabitemTitles=[[NSArray alloc]initWithObjects:@"活动",@"推荐",nil];
      self.navigationItem.title=tabitemTitles[0];
    //添加自定义tabbar条
     tabView = [[JMTabView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 44., self.view.frame.size.width, 44.)];
    tabView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [tabView setDelegate:self];
    CGFloat tabItemWidth = tabView.frame.size.width / 2;
    CGSize tabItemPadding = CGSizeMake(tabView.frame.size.width/2/2, 0);
    
    
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
    
    
}




#pragma mark - classmethods
/**
 *  开始加载
 */
-(void)startloaddataend:(NSNotification *)notification{

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




-(void)tabView:(JMTabView *)tabView didSelectTabAtIndex:(NSUInteger)itemIndex;
{
    NSLog(@"Selected Tab Index: %d", itemIndex);
    self.selectedIndex=itemIndex;
    self.navigationItem.title=tabitemTitles[itemIndex];
    

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



@end
