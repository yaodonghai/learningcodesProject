//
//  ArticleItem.h
//  AppGame
//
//  Created by 姚东海 on 13-3-2.
//  Copyright (c) 2013年  姚东海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleItem : NSObject {
@private
    
    NSString *_strTitle;                //文章标题    
    NSString *_strCategory;             //文章分类 type
    NSDate   *_strPubDate;              //发布日期
    NSDate   *_stAsDate;              //截止日期
    
    NSURL    *_strArticleURL;           //文章url
    NSURL    *_strArticleIconURL;       //文章缩略图url
    NSString *_strDescription;          //文章描述
    NSString *_strContent;              //文章正文
    NSNumber *_strcommentCount;             //文章评论数
    
    NSString *_strCreator;              //文章作者
    NSURL    *_strIconURL;              //作者头像url
    NSNumber *_strUserID;               //关注与粉丝列表中的用户ID,既文章作者ID
    
    NSString *_strTag;                  //文章标签 app_xxx
    NSURL    *_strFirstPicURL;          //文章第一张附件图url
    /**
     *  跳转类型
     */
    int actiontype;
}
@property (nonatomic, assign) int actiontype;
@property (nonatomic, strong) NSURL *articleURL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSURL *iconURL;
@property (nonatomic, strong) NSURL *articleIconURL;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, strong) NSDate *pubDate;
@property (nonatomic, strong) NSDate *AsDate;
@property (nonatomic, copy) NSString *creator;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSNumber *userID;
@property (nonatomic, strong) NSNumber *commentCount;

@property (nonatomic, copy) NSString *tag;
@property (nonatomic, strong) NSURL *firstPicURL;
- (BOOL)isEqual:(id)anObject;
-(id)initParsingDic:(NSDictionary*)dictionary;
-(id)initSearchParsingDic:(NSDictionary*)dictionary;
/**
 *  广告
 *
 *  @param dictionary dic
 *
 *  @return ADITEM
 */
-(id)initAd:(NSDictionary*)dictionary;
/**
 * 主题 文章
 *
 *  @param commentDictionary dic
 *
 *  @return DIC
 */
-(id)initAricleItem:(NSDictionary*)commentDictionary;

/**
 *  游戏文章
 *
 *  @param commentDictionary dic
 *
 *  @return DIC
 */
-(id)initGameAricleItem:(NSDictionary*)commentDictionary;
@end
