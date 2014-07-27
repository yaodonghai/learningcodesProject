//
//  GiftBagServerInterface.m
//  appgameprivilege
//
//  Created by 姚东海 on 3/6/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "GiftBagServerInterface.h"

@implementation GiftBagServerInterface
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiUrl = SEVER_URL;
        self.apiPath = @"app_admin.php?g=Api&a=Api&f=getcode";
    }
    return self;
}
@end
