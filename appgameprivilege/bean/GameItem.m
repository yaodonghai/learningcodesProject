//
//  GameItem.m
//  appgameprivilege
//
//  Created by 姚东海 on 8/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//
/**
 游戏实体
 */
#import "GameItem.h"
@implementation GameItem
@synthesize gameId,gameName,gameIcon,gameDowncount,gameSize,gameScore,gameDate,gameVersion,gameIscollection,gameIsfocus,praise,gameDowurl,gamedescribe;
@synthesize screenshots;
@synthesize gameURLschemes;
@synthesize gamedownIconIcon;
@synthesize focuscount;
@synthesize curtgametype;
@synthesize ishot,isnew;
/**
 * @brief 解析游戏实体
 *
 * @param  dic 解析的字典 .
 *
 * @return 返回  GameItem 对象.
 */
-(id)initWithDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        if (![dic isKindOfClass:[NSDictionary class]])return nil;
        
        gameId=[dic objectForKey:@"gameid"];
        gameIcon=[dic objectForKey:@"icon"];
        gameDowncount=[dic objectForKey:@"downcount"];
        gameName=[dic objectForKey:@"gamename"];
        gameSize=[dic objectForKey:@"size"];
        gameScore=[dic objectForKey:@"score"];
        gameDate=[dic objectForKey:@"date"];
        gameVersion=[dic objectForKey:@"version"];
        gameIscollection=[[dic objectForKey:@"collection"]intValue];
        gameIsfocus=[[dic objectForKey:@"isFocus"]intValue];
        praise=[dic objectForKey:@"praise"];
        gameDowurl=[dic objectForKey:@"downloadurl"];
       gameURLschemes=[dic objectForKey:@"downloadurl"];
        gameDate=[dic objectForKey:@"date"];
        focuscount=[dic objectForKey:@"focus"];
        isnew=[[dic objectForKey:@"is_new"]intValue];
        ishot=[[dic objectForKey:@"is_hot"]intValue];

    }
    return self;
}


/**
 *
 *
 *  @param dic 游戏详情内容
 *
 *  @return GameItem
 */
-(id)initWithGameDetailDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        gameId=[dic objectForKey:@"gameid"];
        gameIcon=[dic objectForKey:@"icon"];
        gameDowncount=[dic objectForKey:@"downcount"];
        gameName=[dic objectForKey:@"gamename"];
        gameSize=[dic objectForKey:@"size"];
        gameScore=[dic objectForKey:@"score"];
        gameDate=[dic objectForKey:@"date"];
        gameVersion=[dic objectForKey:@"version"];
        gameIscollection=[[dic objectForKey:@"collection"]intValue];
        gameIsfocus=[[dic objectForKey:@"isFocus"]intValue];
        praise=[dic objectForKey:@"praise"];
        gameDowurl=[dic objectForKey:@"downloadurl"];
        focuscount=[dic objectForKey:@"focus"];
        gameURLschemes=[dic objectForKey:@"schemes"];
        gamedescribe=[dic objectForKey:@"intro"];
        gamedownIconIcon=[dic objectForKey:@"downIcon"];
        NSString * imagestring=[dic objectForKey:@"images"];
        isnew=[[dic objectForKey:@"is_new"]intValue];
        ishot=[[dic objectForKey:@"is_hot"]intValue];
        screenshots=[[NSMutableArray alloc]init];
        if ([imagestring isKindOfClass:[NSString class]]&&![imagestring isEqualToString:@""]) {
            NSArray *imamges = [imagestring componentsSeparatedByString:@","];
            if ([imamges isKindOfClass:[NSArray class]]&&imamges.count>0) {
                [screenshots addObjectsFromArray:imamges];
            }
        }
     
      
    }
    return self;
}

/**
 *
 *
 *  @param dic 更多应用
 *
 *  @return GameItem
 */
-(id)initWithMoreAppDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        //gameId=[dic objectForKey:@"gameid"];
        gameIcon=[dic objectForKey:@"icon"];
        gameDowncount=[dic objectForKey:@"downcount"];
        gameName=[dic objectForKey:@"name"];
        gameSize=[dic objectForKey:@"size"];
        gameDowurl=[dic objectForKey:@"downloadurl"];
        gamedescribe=[dic objectForKey:@"intro"];
            }
    return self;
}
@end
