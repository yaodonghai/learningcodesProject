//
//  HomeTabController.h
//  GameStrategys
//
//  Created by 姚东海 on 5/5/14.
//  Copyright (c) 2014年 junewong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMTabView.h"


/**
 最外层的容器
 */
@interface HomeTabController : UITabBarController<JMTabViewDelegate>{
    
    /**
     *  低部导航
     */
    JMTabView * tabView;
  
}

@property(nonatomic,strong)JMTabView * tabView;


@end
