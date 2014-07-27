//
//  HomeServerInterface.m
//  appgameprivilege
//
//  Created by 姚东海 on 8/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "HomeServerInterface.h"


@implementation HomeServerInterface

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
