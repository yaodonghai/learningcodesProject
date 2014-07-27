//
//  JoinActicityServerInterface.m
//  appgameprivilege
//
//  Created by 姚东海 on 6/6/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "JoinActicityServerInterface.h"

@implementation JoinActicityServerInterface
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiUrl = SEVER_URL;
        self.apiPath = @"app_admin.php?g=Api&a=Api&f=join";
    }
    return self;
}
@end
