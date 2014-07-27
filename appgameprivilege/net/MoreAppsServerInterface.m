//
//  MoreAppsServerInterface.m
//  appgameprivilege
//
//  Created by 姚东海 on 9/6/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "MoreAppsServerInterface.h"

@implementation MoreAppsServerInterface
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiUrl = SEVER_URL;
        self.apiPath = @"app_admin.php?g=Api&a=Api&f=moreapp";
    }
    return self;
}
@end
