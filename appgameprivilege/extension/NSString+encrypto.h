//
//  NSString+encrypto.h
//  TamingMonster
//
//  Created by June on 14-4-16.
//  Copyright (c) 2014年 junewong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (encrypto)
- (NSString *) md5;
- (NSString *) sha1;

@end
