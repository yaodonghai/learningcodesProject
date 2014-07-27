//
//  OauthServerInterface.h
//  appgameprivilege
//
//  Created by 姚东海 on 14/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "ServerInterface.h"

@interface OauthServerInterface : ServerInterface
-(void)getOauth:(NSDictionary*)params;
@end
