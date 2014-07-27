//
//  ArticleItem.m
//  AppGame
//
//  Created by 计 炜 on 13-3-2.
//  Copyright (c) 2013年 计 炜. All rights reserved.
//

#import "ArticleItem.h"
#import "NSString+Tools.h"
#import "NSDate-Utilities.h"
@implementation ArticleItem

@synthesize articleURL = _strArticleURL;
@synthesize title = _strTitle;
@synthesize iconURL = _strIconURL;
@synthesize category = _strCategory;
@synthesize pubDate = _strPubDate;
@synthesize AsDate = _stAsDate;
@synthesize creator = _strCreator;
@synthesize description = _strDescription;
@synthesize content = _strContent;
@synthesize userID = _strUserID;
@synthesize articleIconURL = _strArticleIconURL;
@synthesize commentCount = _strCommentCount;
@synthesize actiontype;
@synthesize tag = _strTag;
@synthesize firstPicURL = _strFirstPicURL;

- (BOOL)isEqual:(id)anObject {
    if (![anObject isKindOfClass:[ArticleItem class]]) return NO;
    ArticleItem *otherObject = (ArticleItem *)anObject;
    return [self.title isEqual:otherObject.title] && [self.iconURL isEqual:otherObject.iconURL] && [self.articleURL isEqual:otherObject.articleURL];
}

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.title = [coder decodeObjectForKey:@"title"];
        self.iconURL = [coder decodeObjectForKey:@"iconURL"];
        self.articleURL = [coder decodeObjectForKey:@"articleURL"];
        self.category = [coder decodeObjectForKey:@"category"];
        self.pubDate = [coder decodeObjectForKey:@"pubDate"];
        self.creator = [coder decodeObjectForKey:@"creator"];
        self.description = [coder decodeObjectForKey:@"description"];
        self.content = [coder decodeObjectForKey:@"content"];
        self.userID = [coder decodeObjectForKey:@"userID"];
        self.articleIconURL = [coder decodeObjectForKey:@"articleIconURL"];
        self.commentCount = [coder decodeObjectForKey:@"commentCount"];
        
        self.tag = [coder decodeObjectForKey:@"tag"];
        self.firstPicURL = [coder decodeObjectForKey:@"firstPicURL"];
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.iconURL forKey:@"iconURL"];
    [coder encodeObject:self.articleURL forKey:@"articleURL"];
    [coder encodeObject:self.category forKey:@"category"];
    [coder encodeObject:self.pubDate forKey:@"pubDate"];
    [coder encodeObject:self.creator forKey:@"creator"];
    [coder encodeObject:self.description forKey:@"description"];
    [coder encodeObject:self.content forKey:@"content"];
    [coder encodeObject:self.userID forKey:@"userID"];
    [coder encodeObject:self.articleIconURL forKey:@"articleIconURL"];
    [coder encodeObject:self.commentCount forKey:@"commentCount"];
    
    [coder encodeObject:self.tag forKey:@"tag"];
    [coder encodeObject:self.firstPicURL forKey:@"firstPicURL"];
}

-(id)initParsingDic:(NSDictionary*)dictionary{
    self=[super init];
    if (self) {
        if (![dictionary isKindOfClass:[NSDictionary class]])return self;
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [df setLocale:locale];
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.tag=[dictionary objectForKey:@"id"];
        self.title=[dictionary objectForKey:@"title"];
       self.description=[dictionary objectForKey:@"desc"];
        self.articleIconURL=[NSURL URLWithString:[dictionary objectForKey:@"image"]];
        self.articleURL=[NSURL URLWithString:[dictionary objectForKey:@"url"]];
      self.pubDate=[df dateFromString:[[dictionary objectForKey:@"time"] stringByReplacingOccurrencesOfString:@"T" withString:@" "]];
      self.AsDate=[df dateFromString:[[dictionary objectForKey:@"ctime"] stringByReplacingOccurrencesOfString:@"T" withString:@" "]];

    }
    return self;
}

-(id)initSearchParsingDic:(NSDictionary*)dictionary{
    self=[super init];
    if (self) {
        if (![dictionary isKindOfClass:[NSDictionary class]])return self;
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [df setLocale:locale];
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.tag=[dictionary objectForKey:@"id"];
        self.title=[dictionary objectForKey:@"title"];
        self.description=[dictionary objectForKey:@"desc"];
        self.articleIconURL=[NSURL URLWithString:[dictionary objectForKey:@"thumbnail"]];
        self.articleURL=[NSURL URLWithString:[dictionary objectForKey:@"url"]];
        self.pubDate=[df dateFromString:[[dictionary objectForKey:@"time"] stringByReplacingOccurrencesOfString:@"T" withString:@" "]];
        self.AsDate=[df dateFromString:[[dictionary objectForKey:@"ctime"] stringByReplacingOccurrencesOfString:@"T" withString:@" "]];
        
    }
    return self;
}


-(id)initAd:(NSDictionary*)dictionary{
    self=[super init];
    if (self) {
        if (![dictionary isKindOfClass:[NSDictionary class]])return self;
        self.tag=[dictionary objectForKey:@"ID"];
        self.title=[dictionary objectForKey:@"post_title"];
        self.description=[dictionary objectForKey:@"categories"];
        self.articleIconURL=[NSURL URLWithString:[dictionary objectForKey:@"custom-thumbnail"]];
        self.articleURL=[NSURL URLWithString:[dictionary objectForKey:@"url"]];
        self.pubDate=[dictionary objectForKey:@"post_date"];

    }
    return self;
}



/**
 *  游戏文章
 *
 *  @param commentDictionary dic
 *
 *  @return DIC
 */
-(id)initGameAricleItem:(NSDictionary*)commentDictionary{

    self=[super init];
    if (self) {
        if (![commentDictionary isKindOfClass:[NSDictionary class]])return self;
        id urlStr = [commentDictionary objectForKey:@"thumb"];
        if (!urlStr)
            urlStr = @"";
        else if (![urlStr isKindOfClass: [NSString class]])
            urlStr = [urlStr description];
        self.articleIconURL = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSDate * pdate=[NSDate dateWithFormat:@"yyyy-MM-dd HH:mm" dateString:[commentDictionary objectForKey:@"add_time"]];
        self.pubDate=pdate;
        self.category=[commentDictionary objectForKey:@"typeName"];
        self.description = [commentDictionary objectForKey:@"intro"];
        //NSString *regEx_html = [commentDictionary objectForKey:@"excerpt"];
        self.title = [commentDictionary objectForKey:@"title"];
        self.actiontype=[[commentDictionary objectForKey:@"isOriginal"]intValue];
       // self.description= [self.description filtration:regEx_html];
        
        
        if (self.description != nil) {
            
            NSDictionary * repladic=@{@"&#038;": @"&",@"继续阅读": @"",@"&rarr;": @""};
            self.description= [self.description replacingDictionary:repladic];
        }
        
        if (self.title != nil) {
            NSDictionary * repladic=@{@"&#038;": @"&",@"继续阅读": @"",@"&rarr;": @"",@"&#8217;":@"'",@"&#8211;":@"–",@"&#8230;":@"…",@"&#8482;":@"™"};
            self.title= [self.title replacingDictionary:repladic];
        }
        
        self.content = [commentDictionary objectForKey:@"detail"];
        self.articleURL = [NSURL URLWithString:[[commentDictionary objectForKey:@"url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        self.creator = [commentDictionary objectForKey:@"author"];
        
        if (self.content != nil) {
            NSString *htmlFilePath = [[NSBundle mainBundle] pathForResource:@"appgame" ofType:@"html"];
            NSString *htmlString = [NSString stringWithContentsOfFile:htmlFilePath encoding:NSUTF8StringEncoding error:nil];
            NSString *contentHtml = @"";
            //            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //            [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
            contentHtml = [contentHtml stringByAppendingFormat:htmlString,
                           self.title, self.creator, [self.pubDate stringWithFormat:@"yyyy-MM-dd HH:mm"]];
            contentHtml = [contentHtml stringByReplacingOccurrencesOfString:@"<!--content-->" withString:self.content];
            LOG(@"content---iii=---%@",contentHtml);
            self.content = contentHtml;
        }
        
    }
    return self;
}




/**
 *  主题文章
 *
 *  @param commentDictionary dic
 *
 *  @return DIC
 */
-(id)initAricleItem:(NSDictionary*)commentDictionary{
    self=[super init];
    if (self) {
        if (![commentDictionary isKindOfClass:[NSDictionary class]])return self;
        id urlStr = [commentDictionary objectForKey:@"thumbnail"];
        if (!urlStr)
            urlStr = @"";
        else if (![urlStr isKindOfClass: [NSString class]])
            urlStr = [urlStr description];
      //  NSDateFormatter *df = [[NSDateFormatter alloc] init];
        self.articleIconURL = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        self.pubDate = [commentDictionary objectForKey:@"date"];
        
        self.description = [commentDictionary objectForKey:@"excerpt"];
        NSString *regEx_html = [commentDictionary objectForKey:@"excerpt"];
        self.title = [commentDictionary objectForKey:@"title"];
        
        self.description= [self.description filtration:regEx_html];
        
        
        if (self.description != nil) {
            
            NSDictionary * repladic=@{@"&#038;": @"&",@"继续阅读": @"",@"&rarr;": @""};
            self.description= [self.description replacingDictionary:repladic];
        }
        
        if (self.title != nil) {
            NSDictionary * repladic=@{@"&#038;": @"&",@"继续阅读": @"",@"&rarr;": @"",@"&#8217;":@"'",@"&#8211;":@"–",@"&#8230;":@"…",@"&#8482;":@"™"};
            self.title= [self.title replacingDictionary:repladic];
        }
        
        self.content = [commentDictionary objectForKey:@"content"];
        self.articleURL = [NSURL URLWithString:[[commentDictionary objectForKey:@"url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        self.creator = [[commentDictionary objectForKey:@"author"] objectForKey:@"nickname"];
        
        if (self.content != nil) {
            NSString *htmlFilePath = [[NSBundle mainBundle] pathForResource:@"appgame" ofType:@"html"];
            NSString *htmlString = [NSString stringWithContentsOfFile:htmlFilePath encoding:NSUTF8StringEncoding error:nil];
            NSString *contentHtml = @"";
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
            contentHtml = [contentHtml stringByAppendingFormat:htmlString,
                           self.title, self.creator, self.pubDate];
            contentHtml = [contentHtml stringByReplacingOccurrencesOfString:@"<!--content-->" withString:self.content];
            LOG(@"content---iii=---%@",contentHtml);
            self.content = contentHtml;
        }
        
    }
    return self;
}
@end