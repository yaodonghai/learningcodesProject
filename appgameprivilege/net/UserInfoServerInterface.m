//
//  UserInfoServerInterface.m
//  appgameprivilege
//
//  Created by 姚东海 on 19/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "UserInfoServerInterface.h"

@implementation UserInfoServerInterface
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiUrl = SEVER_API_USER;
        self.apiPath = USER_PATH;
    }
    return self;
}
@end
