//
//  MCPagerView.h
//  MCPagerView
//
//  Created by Baglan on 7/20/12.
//  Copyright (c) 2012 MobileCreators. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MCPAGERVIEW_DID_UPDATE_NOTIFICATION @"MCPageViewDidUpdate"

@class MCPagerView;
typedef void(^MCPagerViewdidUpdateToPageBlock) (MCPagerView * pageView, NSInteger newPage);

@interface MCPagerView : UIView{
    MCPagerViewdidUpdateToPageBlock  didUpdateToPageBlock;
}

- (void)setImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage forKey:(NSString *)key;

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,readonly) NSInteger numberOfPages;
@property (nonatomic,copy) NSString *pattern;
- (void)setdidUpdateToPageBlock:(MCPagerViewdidUpdateToPageBlock)block;
@end
