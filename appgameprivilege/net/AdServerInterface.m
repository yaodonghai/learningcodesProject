//
//  AdServerInterface.m
//  appgameprivilege
//
//  Created by 姚东海 on 13/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "AdServerInterface.h"

@implementation AdServerInterface
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiUrl = AD_URL;
        self.apiPath = @"";
    }
    return self;
}
@end
