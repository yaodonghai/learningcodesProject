//
//  GameListServerInterface.m
//  appgameprivilege
//
//  Created by 姚东海 on 27/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "GameListServerInterface.h"

@implementation GameListServerInterface
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiUrl = SEVER_URL;
        self.apiPath = @"app_admin.php?g=Api&a=Api&f=gameRanking";
    }
    return self;
}
@end
