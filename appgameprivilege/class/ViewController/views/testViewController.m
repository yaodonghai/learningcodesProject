//
//  testViewController.m
//  appgameprivilege
//
//  Created by 姚东海 on 28/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "testViewController.h"
#import "NSString+Tools.h"
@interface testViewController ()

@end

@implementation testViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creartui];
    // Do any additional setup after loading the view.
}


-(void)creartui{
    NSString *original = @"今天你还好吗？还有其他的很多的属性，可以自己去看苹果的API，这里不再详述,实现类似iPhone手机发短信的功能，包括气泡显示文字信息，输入框可以根据输入的长度自动调整大小，手指往下滑动输入框从而隐藏输入框等等功能。还可以自定义很多参数，包括对话列表的外观样式、对话时是否加入头像、是否时间戳等等。效果截图显示了两种对话列表的外观，以及加入头像和不加头像的样式。";
    
   
//    NSMutableAttributedString * customAttributedString=[original getAttributedColornstringWithArray:[[NSArray alloc]initWithObjects:@"你还好吗？",@"看苹果的API",@"看苹果的API",@"截图显示了两种对话列表", nil] AndColor: [UIColor redColor]];
//
//    
    NSMutableDictionary * dic1=[NSMutableDictionary dictionaryWithObject:@"你还好吗？" forKey:@"string"];
    [dic1 setObject:[UIColor redColor] forKey:@"color"];
    NSMutableDictionary * dic2=[NSMutableDictionary dictionaryWithObject:@"看苹果的API" forKey:@"string"];
    [dic2 setObject:[UIColor blueColor] forKey:@"color"];
    NSMutableDictionary * dic3=[NSMutableDictionary dictionaryWithObject:@"截图显示了两种对话列表" forKey:@"string"];
    [dic3 setObject:[UIColor greenColor] forKey:@"color"];
    
     NSMutableAttributedString *  customAttributedString=[original getAttributedColornstringWithArray:[[NSArray alloc]initWithObjects:dic1,dic2,dic3, nil]];
    
    
    UITextView *label = [[UITextView alloc] init];
    label.frame = CGRectMake(0, 0, 320, 400);
    
    [label setAttributedText:customAttributedString];
    
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
