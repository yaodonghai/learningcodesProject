//
//  ActivityItem.m
//  appgameprivilege
//
//  Created by 姚东海 on 9/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "ActivityItem.h"

@implementation ActivityItem
@synthesize gameId,activityId,activityName,activitythumbmail,activitycurttype,activityendtime,activitycontent,activitystarttime,activitysurplus,activitytotal,activitycode;
@synthesize activityshowtype;
@synthesize activityactionstate;
@synthesize gameName;
@synthesize activitydetail;
@synthesize activityintro;
@synthesize activityrule;
@synthesize isJoin;
@synthesize activityurl;
@synthesize row;
@synthesize gameDownUrl;
@synthesize gameIcon;
/**
 * @brief 解析活动实体
 *
 * @param  dic 解析的字典 .
 *
 * @return 返回  ActivityItem 对象.
 */
-(id)initActivityWithDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        if (![dic isKindOfClass:[NSDictionary class]])return nil;
        
        gameId=[dic objectForKey:@"gameid"];
        gameName=[dic objectForKey:@"gamename"];
        activityId=[dic objectForKey:@"activityid"];
        activityName=[dic objectForKey:@"name"];
        activitythumbmail=[dic objectForKey:@"thumb"];
        activitycurttype=[dic objectForKey:@"type"];
        activityendtime=[dic objectForKey:@"endtime"];
        activitystarttime=[dic objectForKey:@"begintime"];
        activitytotal=[[dic objectForKey:@"total"] intValue];
        activitysurplus=[[dic objectForKey:@"left"] intValue];
        activitycontent=[dic objectForKey:@"intro"];
       activityshowtype=[dic objectForKey:@"showtype"];
        activityactionstate=[[dic objectForKey:@"status"]intValue];
        gameDownUrl=[dic objectForKey:@"downloadurl"];
        gameIcon=[dic objectForKey:@"game_downIcon"];
        isJoin=[[dic objectForKey:@"isJoin"]intValue];
        activitycode=[[dic objectForKey:@"code"] copy];

    }
    return self;
}



/**
 *  我的礼包解析
 *
 *  @param dic 解析的字典
 *
 *  @return ActivityItem 对象
 */
-(id)initMyGiftWithDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        if (![dic isKindOfClass:[NSDictionary class]])return nil;
        
        gameId=[dic objectForKey:@"gameid"];
        activityId=[dic objectForKey:@"id"];
        activityName=[dic objectForKey:@"name"];
        
        activitythumbmail=[dic objectForKey:@"thumb"];
        activitycurttype=[dic objectForKey:@"type"];
        activityendtime=[dic objectForKey:@"endtime"];
        activitystarttime=[dic objectForKey:@"starttime"];
        activitytotal=[[dic objectForKey:@"total"]integerValue];
        activitysurplus=[[dic objectForKey:@"surplus"] integerValue];
        activitycontent=[dic objectForKey:@"content"];
        isJoin=[[dic objectForKey:@"isJoin"]intValue];
        activityactionstate=[[dic objectForKey:@"status"]intValue];
        activitycode=[[dic objectForKey:@"code"] copy];

    }
    return self;
}

-(id)initActivityDetailWithDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        if (![dic isKindOfClass:[NSDictionary class]])return nil;
        
        gameId=[dic objectForKey:@"gameid"];
        gameIcon=[dic objectForKey:@"game_downIcon"];
        gameDownUrl=[dic objectForKey:@"downloadurl"];
        gameName=[dic objectForKey:@"gamename"];
        activityId=[dic objectForKey:@"activityid"];
        activityName=[dic objectForKey:@"name"];
        activitythumbmail=[dic objectForKey:@"thumbnail"];
        activitycurttype=[dic objectForKey:@"type"];
        activityendtime=[dic objectForKey:@"endtime"];
        activitystarttime=[dic objectForKey:@"begintime"];
        activitytotal=[[dic objectForKey:@"total"]intValue];
        activitysurplus=[[dic objectForKey:@"left"] intValue];
        activitycontent=[dic objectForKey:@"code_detail"];
        activitydetail=[dic objectForKey:@"detail"];
        activityshowtype=[dic objectForKey:@"showtype"];
        activityintro=[dic objectForKey:@"intro"];
        activityactionstate=[[dic objectForKey:@"status"]intValue];
        activityrule=[dic objectForKey:@"rule"];
        activityurl=[dic objectForKey:@"url"];
        activitycode=[[dic objectForKey:@"code"] copy];
        isJoin=[[dic objectForKey:@"isJoin"]intValue];

    }
    return self;
}

@end
