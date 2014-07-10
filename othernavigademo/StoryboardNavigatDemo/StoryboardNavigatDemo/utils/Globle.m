//
//  Globle.m
//  SlideSwitchDemo
//
//  Created by liulian on 13-4-23.
//  Copyright (c) 2013年 liulian. All rights reserved.
//

#import "Globle.h"
#import "UIImageView+WebCache.h"

@implementation Globle

@synthesize globleWidth, globleHeight, globleAllHeight;
@synthesize viewBounds;

+ (Globle *)shareInstance {
    static Globle *__singletion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __singletion=[[self alloc] init];
    });
    return __singletion;
}

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

/**
 *  一般viewConoller中view需要用到的高度
 */
- (CGRect)viewBounds
{
    return CGRectMake(0, 0, self.globleWidth, self.globleHeight);
}

+ (int)cacheSize {
    int imageChaheSize = [[SDImageCache sharedImageCache] getSize];
    
    int dataSize = 0;
    NSString* docPath = [NSHomeDirectory() stringByAppendingPathComponent: @"Documents"];
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:docPath];
    for (NSString *fileName in fileEnumerator)
    {
        NSString *filePath = [docPath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        dataSize += [attrs fileSize];
    }
    
    return imageChaheSize + dataSize;
}

+ (void)clearCache {
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDisk];
    
    NSString* docPath = [NSHomeDirectory() stringByAppendingPathComponent: @"Documents"];
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:docPath];
    for (NSString *fileName in fileEnumerator)
    {
        NSString *filePath = [docPath stringByAppendingPathComponent:fileName];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    
}

////获取文件
//-(float)GetFilePath
//{
//    //文件管理
//    NSFileManager * FileManager = [NSFileManager defaultManager];
//
//    //获取目录，遍历内容
//    NSArray * array = [FileManager contentsOfDirectoryAtPath:[self CachesDirPath] error:nil];
//    for (int i = 0; i<[array count]; i++)
//    {
//
//        //获取目录下的所有文件完整路径
//
//        NSString * AllFilePath = [[self CachesDirPath]stringByAppendingPathComponent:[array objectAtIndex:i]];
//
//        //判断该目录是否存在，存在就获得目录下所有文件的size
//        if ([FileManager fileExistsAtPath:[self CachesDirPath]])
//        {
//
//            NSDictionary * FileDictionary = [FileManager attributesOfItemAtPath:AllFilePath error:nil];
//
//            unsigned long long size = FileDictionary.fileSize;
//
//            return size/1000/10;
//        }
//    }
//}


@end
