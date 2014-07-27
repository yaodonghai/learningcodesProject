//
//  SreenTableView.h
//  GameStrategy
//
//  Created by 姚东海 on 25/4/14.
//  Copyright (c) 2014年 junewong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SreenTableView;
@protocol SreenTableViewDelegate<NSObject>
- (void)SreenTableView:(SreenTableView *)sreentableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface SreenTableView : UIView<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView * sreetableview;
    int selectindex;
    UIColor * titleStateNormalColor;
    UIColor * titleSelectColor;
    UIFont *titleFont;
    UIColor * titleSelectbackgroundViewColor;
    float  cellhight;
    CGRect selfFrame;
    BOOL open;//显示
}
@property(nonatomic,strong)UITableView * sreetableview;
@property(nonatomic,assign)int  selectindex;//当前选中的item
@property(nonatomic,strong)NSMutableArray * strtitleArray;//数据源 string 类型
@property(nonatomic,strong)UIColor * titleStateNormalColor;//没选中的item title 颜色
@property(nonatomic,strong)UIColor * titleSelectColor;//选中的item title 颜色
@property(nonatomic,strong)UIColor * titleSelectbackgroundViewColor;//选中的item 背景view 颜色
@property(nonatomic,strong)UIFont *titleFont;//title Font
@property(nonatomic,assign)float cellhight;//cell 高度
@property(nonatomic,assign)BOOL open;//显示
@property (nonatomic, assign)   id <SreenTableViewDelegate>   adelegate;
-(id)initWithFame:(CGRect)frame WithDataSource:(NSMutableArray*)source;
-(void)viewhidden;
-(void)viewshow;
-(void)reloadData;
@end
