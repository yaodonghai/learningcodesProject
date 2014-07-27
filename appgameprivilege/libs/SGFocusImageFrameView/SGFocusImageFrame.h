//
//  SGFocusImageFrame.h
//  SGFocusImageFrame
//
//  Created by Shane Gao on 17/6/12.
//  Copyright (c) 2012 Shane Gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
@class ArticleItem;
@class SGFocusImageFrame;

#pragma mark - SGFocusImageFrameDelegate
@protocol SGFocusImageFrameDelegate <NSObject>

- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(ArticleItem *)item andwithIndex:(int)index;

@end


@interface SGFocusImageFrame : UIView <UIGestureRecognizerDelegate, UIScrollViewDelegate>

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate focusImageItems:(ArticleItem *)items, ... NS_REQUIRES_NIL_TERMINATION;
-(void)setDataSourcArray:(NSMutableArray*)imageItems setDelegate:(id<SGFocusImageFrameDelegate>)çç;
@property (nonatomic, assign) id<SGFocusImageFrameDelegate> delegate;
-(void)clickPageImage:(UIButton *)sender;
@property(nonatomic,assign)BOOL run;
@end

