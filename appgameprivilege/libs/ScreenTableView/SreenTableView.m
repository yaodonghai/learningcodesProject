//
//  SreenTableView.m
//  GameStrategy
//
//  Created by 姚东海 on 25/4/14.
//  Copyright (c) 2014年 junewong. All rights reserved.
//
//titleStateNormalColor;
//UIColor * titleSelectColor;
//UIFont *titleFont;
#import "SreenTableView.h"

@implementation SreenTableView
@synthesize sreetableview;
@synthesize selectindex;
@synthesize strtitleArray;
@synthesize titleStateNormalColor,titleSelectColor,titleFont,titleSelectbackgroundViewColor,cellhight;
@synthesize adelegate,open=_open;
-(id)init{
    self=[super init];
    if (self) {
        selectindex=-1;
       
        self.titleStateNormalColor=[UIColor whiteColor];
        self.titleSelectColor=[UIColor greenColor];
        self.titleFont=[UIFont fontWithName:@"Helvetica" size:12.0];
        self.titleSelectbackgroundViewColor=[UIColor blackColor];
        self.cellhight=40.0f;
        self.open=NO;
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        selectindex=-1;
        self.titleStateNormalColor=[UIColor whiteColor];
        self.titleSelectColor=[UIColor greenColor];
        self.titleFont=[UIFont fontWithName:@"Helvetica" size:12.0];
        self.titleSelectbackgroundViewColor=[UIColor blackColor];
        self.cellhight=40.0f;
       //  strtitleArray=[[NSMutableArray alloc]init];
        self.backgroundColor=[UIColor colorWithHue:3.0/255 saturation:3.0/255 brightness:3.0/255 alpha:0.3];
        CGRect tableframe=CGRectMake(0, 0, frame.size.width, frame.size.height);
        sreetableview=[[UITableView alloc]initWithFrame:tableframe];
        self.clipsToBounds=YES;
        sreetableview.delegate=self;
        sreetableview.dataSource=self;
        self.sreetableview.backgroundColor=[UIColor clearColor];
        selfFrame=self.frame;
        [self addSubview:sreetableview];
        [self viewhidden];
        // Initialization code
    }
    return self;
}



-(id)initWithFame:(CGRect)frame WithDataSource:(NSMutableArray*)source{
    self = [self initWithFrame:frame];
    if (self) {
    
        self.strtitleArray=source;
        CGRect viewframe=self.frame;
        CGRect sreetableviewframe=self.sreetableview.frame;
        float view_h=self.strtitleArray.count*self.cellhight;
        float maxh=300.0f;
        if (view_h>=maxh) {
            view_h=maxh;
        }
        
        viewframe.size.height=view_h;
        sreetableviewframe.size.height=view_h;
//        self.frame=viewframe;
//        self.sreetableview.frame=sreetableviewframe;
        selfFrame=viewframe;
    }
    return self;
}

-(void)setOpen:(BOOL)aopen{
    _open=aopen;
    if (sreetableview) {
        [sreetableview reloadData];
    }
    if (_open) {
        [self viewshow];
    }else{
        [self viewhidden];
    }
}



-(void)viewshow{
    [UIView animateWithDuration:0.5f animations:^{
        CGRect curtselfframe=self.frame;
        curtselfframe.size.height=selfFrame.size.height;
        self.frame=curtselfframe;
        curtselfframe.origin.x=0;
        curtselfframe.origin.y=0;
        sreetableview.frame=curtselfframe;

    } completion:^(BOOL finished) {
        
    }];
}

-(void)viewhidden{
    CGRect curtselfframe=self.frame;
    curtselfframe.size.height=0.0f;
    self.frame=curtselfframe;
}



#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.cellhight;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    int count=0;
    if (strtitleArray) {
        count=strtitleArray.count;
    }
    
    return count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
        
        static NSString *CellIdentifier = @"sreencell";

            UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                cell.frame=CGRectMake(0, 0, self.frame.size.width, self.cellhight);
                cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                cell.backgroundColor=[UIColor colorWithHue:3.0/255 saturation:3.0/255 brightness:3.0/255 alpha:0.3];
                int view_w=self.frame.size.width-20;
                int view_h=self.cellhight-10;
                UIView * backgroundView=[[UIView alloc]initWithFrame:CGRectMake((cell.frame.size.width-view_w)*0.5, (cell.frame.size.height-view_h)*0.5, view_w, view_h)];
                backgroundView.hidden=YES;
                backgroundView.tag=10;
                backgroundView.backgroundColor=titleSelectbackgroundViewColor;
                UILabel * titleLable=[[UILabel alloc]initWithFrame:backgroundView.frame];
                titleLable.textAlignment=NSTextAlignmentCenter;
                titleLable.tag=11;
                titleLable.backgroundColor=[UIColor clearColor];
                titleLable.font=self.titleFont;
                [cell addSubview:backgroundView];
                [cell addSubview:titleLable];
            }
    NSString * title=[strtitleArray objectAtIndex:indexPath.row];
    UIView * backgroundView=(UIView*)[cell viewWithTag:10];
    UILabel * titlelable=(UILabel*)[cell viewWithTag:11];
    titlelable.text=title;
    if (self.selectindex==indexPath.row) {
       backgroundView.hidden=NO;
       titlelable.textColor=self.titleSelectColor;

    }else{
        backgroundView.hidden=YES;
        titlelable.textColor=self.titleStateNormalColor;

    }
    return cell;
  
}


#pragma mark - Table view Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (adelegate) {
        selectindex=indexPath.row;
        [self reloadData];
        self.open=NO;
        [adelegate SreenTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

-(void)reloadData{
    [sreetableview reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
