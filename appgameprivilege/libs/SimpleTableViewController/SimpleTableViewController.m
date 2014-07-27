//
//  SimpleTableViewController.m
//  SimpleTableViewController
//
//  Created by June on 13-4-27.
//  Copyright (c) 2013年 junewong. All rights reserved.
//

#import "SimpleTableViewController.h"

@implementation SimpleTableViewController

@synthesize tableView;
@synthesize tableData;
@synthesize cellClassName;
@synthesize autoDeselected;
@synthesize isGrouped;
@synthesize is_animation=_is_animation;
@synthesize selectIndex=_selectIndex;
@synthesize isFirstLoad=_isFirstLoad;
@synthesize tableViewheader=_tableViewheader;
@synthesize isloadmore;
@synthesize isrefresh;
@synthesize tableViewFooterView=_tableViewFooterView;
- (id)initWithTableView:(UITableView*)aTableView
{
    self = [super init];
    if (self) {
        self.tableView = aTableView;
        originalFame=self.tableView.frame;
        maxhitgth=originalFame.size.height;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.isrefresh=NO;
        self.isloadmore=NO;

        [self _init];
    }
    return self;
}


/**
 *  添加 tableview 和 Refresh
 *
 *  @param TableView tableview
 *
 *  @return RefreshSimpleTableViewController
 */
-(id)initWithTableViewAndRefreshWith:(UITableView *)atableView{
    self=[self initWithTableView:atableView];
    if (self) {
     
    }
    return self;
}





- (void)_init
{
    self.tableData = [NSMutableArray array];
    self.isGrouped = NO;
    self.autoDeselected = YES;
    self.autoResizeCell = NO;
    self.useXibForCell = YES;
    self.is_animation=NO;
    _selectIndex=nil;
    _open=NO;
    _isFirstLoad=YES;
}


-(void)setIs_animation:(BOOL)is_animation{
    _is_animation=is_animation;
    if (_is_animation) {
        [self viewhidden];
    }
}



- (void)setIsGrouped:(BOOL)value
{
    isGrouped = value;
    
    self.tableView.sectionHeaderHeight = !isGrouped ? 0 : 22; //default
}

#pragma mark - block

- (void)setCellBlock:(SimpleTableViewCellBlock)block
{
    cellBlock = block;
}


- (void)setSelectCellBlock:(SimpleTableViewSelectCellBlock)block
{
    selectCellBlock = block;
}

- (void)setSectionHeaderTitleBlock:(SimpleTableViewSectionHeaderTitleBlock)block
{
    sectionHeaderTitleBlock = block;
}

- (void)setSectionHeaderViewBlock:(SimpleTableViewSectionHeaderViewBlock)block
{
    sectionHeaderViewBlock = block;
}

#pragma mark - public methods

- (void)reloadData
{
    if (self.autoResizeCell) {
        // 延迟刷新以让表格重新计算不同的单元格高度
        [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.1];
    } else {
        if ([self.tableViewFooterView isKindOfClass:[MJRefreshFooterView class]]) {
            
            if (self.tableData.count*tableView.rowHeight>=self.tableView.frame.size.height&&self.tableData.count>=20) {
                [self.tableViewFooterView setHidden:NO];
            }else{
                [self.tableViewFooterView setHidden:YES];
                
            }
        }
        [self.tableView reloadData];
     
    }
}

- (void)cleanData
{
    [self.tableData removeAllObjects];
    _selectIndex=nil;
    if (self.autoResizeCell &&  cellHeights != nil) {
        [cellHeights removeAllObjects];
        cellHeights = nil;
    }
}

- (void)addDataWithArray:(NSArray*)array
{
    [self.tableData addObjectsFromArray:array];
    
    [self getcellHight];
}

- (void)replaceDataWithArray:(NSArray*)array
{
    [self cleanData];
    [self addDataWithArray:array];
}

#pragma mark - table delegate

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isGrouped) {
        return [[self.tableData objectAtIndex:section] count];
    }
    return [self.tableData count];
}

- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isGrouped) {
        return [self.tableData count];
    }
    return 1;
}



- (UITableViewCell*)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getCellWithIndexPath:indexPath];
}



- (UITableViewCell*)getCellWithIndexPath:(NSIndexPath*)indexPath
{
    NSString *cellIdentifier = [self getCellIndentifer];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        if (self.cellClassName != nil) {
            
            cell = self.useXibForCell ?
            [XibViewLoader loadFistViewWithName:self.cellClassName owner:self]
            : [[NSClassFromString(self.cellClassName) alloc] init];
            
            if (_is_animation) {
                
                cell.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"当前状态.png"]];
                
                //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                // 设置UITableViewCell中的字体颜色时用
                ///cell.textLabel.highlightedTextColor=[UIColor **color];
            }
        } else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
    }
    
    id data = [self getDataWithIndexPath:indexPath];
    
    if (cellBlock) {
        cellBlock(cell, data, indexPath);
    }
    
    // keep cell height if need:
    if (self.autoResizeCell == YES) {
        
        if (cellHeights == nil) {
            cellHeights = [NSMutableArray arrayWithCapacity:[self.tableData count]];
        }
        
        CGFloat height = cell.frame.size.height;
        
        if (indexPath.row < [cellHeights count]) {
            [cellHeights replaceObjectAtIndex:indexPath.row withObject:@(height)];
            
        } else {
            [cellHeights addObject:@(height)];
        }
    }
    
  
    return cell;
}



- (NSString*)getCellIndentifer
{
    NSString *name = self.cellClassName != nil ? self.cellClassName : [self.description substringFromIndex:([self.description length]-8)];
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@Identifier", name];
    return cellIdentifier;
}

- (id)getDataWithIndexPath:(NSIndexPath*)indexPath
{
    if (self.isGrouped) {
        return [[self.tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    return [self.tableData objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id data = [self getDataWithIndexPath:indexPath];
    _selectIndex=indexPath;
    if (selectCellBlock) {
        selectCellBlock(data, indexPath);
    }
    
    if (self.autoDeselected) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
 
        [self resetTableViewFame];
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.autoResizeCell) {
        NSNumber *number = [cellHeights count] > indexPath.row ? [cellHeights objectAtIndex:indexPath.row] : nil;
        if (number == nil) {
            // 由于iOS会先于创建cell之前调用此方法已获取高度，所以迫不得已，以下创建cell的方法可能会被调用两次；暂时未有其他解决方法。
            UITableViewCell *cell = [self getCellWithIndexPath:indexPath];
            return cell.frame.size.height;
        }
        CGFloat height = [number floatValue];
        return height;
    }
    return self.tableView.rowHeight;
}



#pragma mark - class methods
/**
 *  停止刷新加载更多
 *
 *  @param datacount 数据页数
 */
-(BOOL)stopviewload:(int)datacount{
    if (datacount==0) {
        [self.tableView headerEndRefreshing];
        [self reloadData];
        return YES;
    }else{
        [self.tableView footerEndRefreshing];
        [self reloadData];
        return NO;
    }
}

/**
 *  列表数据请求
 *
 *  @param parameter      逻辑参数
 *  @param refresh        是否刷新
 *  @param page           分页数
 *  @param viewController 当前 viewcontroller
 */
-(void)requestTableViewDataWithparameter:(NSDictionary*)parameter withisRefresh:(BOOL)refresh withpage:(int)page withViewController:(UIViewController*)viewController{
    int start=self.tableData.count;
    if (refresh) {
        start=0;
        [self performSelectorOnMainThread:@selector(cleanData) withObject:nil waitUntilDone:NO];
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt:start],@"page",
                                  [NSNumber numberWithInt:page],@"count",
                                  nil];
    if (parameter!=nil) {
            for(NSString *key in parameter){
                [param setObject:[parameter objectForKey:key]  forKey:key];
            }
    }
    if ([viewController isKindOfClass:[UIViewController class]]) {
        [viewController performSelectorOnMainThread:@selector(getDatasWithtypeParamAndRefreshview:) withObject:param waitUntilDone:NO];
    }
}

#pragma mark - grouped

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (sectionHeaderTitleBlock == nil) {
        return nil;
    }
    
    return sectionHeaderTitleBlock(section);
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (sectionHeaderViewBlock == nil) {
        return nil;
    }
    
    return sectionHeaderViewBlock(section);
}

#pragma mark - animation

-(void)setOpen:(BOOL)aopen{
    _open=aopen;
    [self resetTableViewFame];

}

-(void)resetTableViewFame{
    if (_is_animation) {
        
        if (tableView) {
            [tableView reloadData];
        }
        if (_open) {
            [self viewshow];
        }else{
            [self viewhidden];
        }
    }
}


-(void)viewshow{
    [UIView animateWithDuration:0.3f animations:^{
        CGRect curtselfframe=self.tableView.frame;
        curtselfframe.size.height=originalFame.size.height;
        self.tableView.frame=curtselfframe;

    } completion:^(BOOL finished) {
        
    }];
}

-(void)viewhidden{
    CGRect curtselfframe=self.tableView.frame;
    curtselfframe.size.height=0.0f;
    self.tableView.frame=curtselfframe;
}

-(void)getcellHight{
    float view_h=self.tableData.count*self.tableView.rowHeight;
    if (view_h>=maxhitgth) {
        view_h=maxhitgth;
    }
    originalFame.size.height=view_h;
}



@end
