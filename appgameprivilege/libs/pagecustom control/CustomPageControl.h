//
//  CustomPageControl.h
//  appgameprivilege
//
//  Created by 姚东海 on 30/6/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  图片 自定义PageControl
 */
@interface CustomPageControl : UIView{
    int selectedpage;
    NSMutableArray * imageViews;
    UIImage * selectedimage;
    NSArray * images;

}
@property(nonatomic,assign)int selectedpage;
@property(nonatomic,strong)NSMutableArray *  imageViews;
@property(nonatomic,strong)UIImage *  selectedimage;
@property(nonatomic,strong)NSArray * images;

/**
 *  自定义PageControl
 *
 *  @param frame     frame
 *  @param images    图片组
 *  @param curtimage 选中的图片
 *
 *  @return CustomPageControl
 */
-(id)initWithFrame:(CGRect)frame AddImageArray:(NSArray*)images Withcurtimage:(UIImage*)curtimage;

@end
