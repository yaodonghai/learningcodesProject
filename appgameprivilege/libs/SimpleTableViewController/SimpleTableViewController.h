//
//  SimpleTableViewController.h
//  SimpleTableViewController
//
//  对UITableView的封装，可简化代码。支持XibViewLoader加载对应Cell；支持单个表单或者分组表单；支持单元格的动态高度；
//
//  Created by June on 13-4-27.
//  Copyright (c) 2013年 junewong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XibViewLoader.h"
#import "MJRefresh.h"
#import "MJRefreshHeaderView.h"
#import "MJRefreshFooterView.h"
typedef void(^SimpleTableViewCellBlock) (UITableViewCell *aCell, id data, NSIndexPath *indexPath);
typedef void(^SimpleTableViewSelectCellBlock) (id data, NSIndexPath *indexPath);
typedef NSString*(^SimpleTableViewSectionHeaderTitleBlock) (NSUInteger section);
typedef UIView*(^SimpleTableViewSectionHeaderViewBlock) (NSUInteger section);

@interface SimpleTableViewController : NSObject<UITableViewDataSource, UITableViewDelegate>
{
    SimpleTableViewCellBlock cellBlock;
    SimpleTableViewSelectCellBlock selectCellBlock;
    SimpleTableViewSectionHeaderTitleBlock sectionHeaderTitleBlock;
    SimpleTableViewSectionHeaderViewBlock sectionHeaderViewBlock;
    NSMutableArray *cellHeights;
    /**
     *  原始fame
     */
    CGRect originalFame;
    float maxhitgth;
    NSIndexPath *  _selectIndex;//当前选定
    BOOL _open;//显示
    /**
     *  是否要用动画
     */
    BOOL _is_animation;
    
    /**
     *  第一资加载
     */
    BOOL isFirstLoad;
    
    /**
     *  刷新headview
     */
    MJRefreshHeaderView * tableViewheader;
    
    /**
     *  加载更多FooterView
     */
    MJRefreshFooterView * tableViewFooterView;
    /**
     *  正在刷新
     */
    BOOL isrefresh;
    /**
     *  正在加载更多
     */
    BOOL isloadmore;
}

@property (nonatomic, unsafe_unretained) UITableView *tableView;
@property (nonatomic) NSMutableArray *tableData; //当isGrouped为YES时，是二维数组；当为NO时时一维数组；
@property (nonatomic) NSString *cellClassName;
@property (nonatomic) BOOL useXibForCell;

@property (nonatomic) BOOL autoDeselected;
@property (nonatomic) BOOL autoResizeCell;
// grouped
@property (nonatomic) BOOL isGrouped;

//=======动画====
/**
 *  动画开关
 */
@property(nonatomic,assign)BOOL open;

/**
 *  第一资加载
 */
@property(nonatomic,assign)BOOL isFirstLoad;

/**
 *  当前选定
 */
@property(nonatomic,strong)  NSIndexPath *  selectIndex;

/**
 *  是否要用动画
 */
@property(nonatomic,assign)BOOL is_animation;

/**
 *  正在刷新
 */
@property(nonatomic,assign)BOOL isrefresh;
/**
 *  正在加载更多
 */
@property(nonatomic,assign)BOOL isloadmore;
/**
 *  刷新headview
 */
@property(nonatomic,strong)MJRefreshHeaderView * tableViewheader;

/**
 *  加载更多FooterView
 */
@property(nonatomic,strong)MJRefreshFooterView * tableViewFooterView;
- (void)setCellBlock:(SimpleTableViewCellBlock)block;
- (void)setSelectCellBlock:(SimpleTableViewSelectCellBlock)block;
- (void)setSectionHeaderTitleBlock:(SimpleTableViewSectionHeaderTitleBlock)block;
- (void)setSectionHeaderViewBlock:(SimpleTableViewSectionHeaderViewBlock)block;

- (id)initWithTableView:(UITableView*)aTableView;
/**
 *  添加 tableview 和 Refresh
 *
 *  @param TableView tableview
 *
 *  @return RefreshSimpleTableViewController
 */
-(id)initWithTableViewAndRefreshWith:(UITableView *)atableView;
- (void)reloadData;
- (void)cleanData;
- (void)addDataWithArray:(NSArray*)array;
- (void)replaceDataWithArray:(NSArray*)array;
/**
 *  停止刷新加载更多
 *
 *  @param datacount 数据页数
 */
-(BOOL)stopviewload:(int)datacount;
/**
 *  列表数据请求
 *
 *  @param parameter      逻辑参数
 *  @param refresh        是否刷新
 *  @param page           分页数
 *  @param viewController 当前 viewcontroller
 */
-(void)requestTableViewDataWithparameter:(NSDictionary*)parameter withisRefresh:(BOOL)refresh withpage:(int)page withViewController:(UIViewController*)viewController;
@end
