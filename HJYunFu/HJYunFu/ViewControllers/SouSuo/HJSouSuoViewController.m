//
//  HJSouSuoViewController.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-7-14.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJSouSuoViewController.h"

@interface HJSouSuoViewController ()

@end

@implementation HJSouSuoViewController

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
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];

    
    [self loadNavBarWithTitle:@"搜索"];
    
    [self loadRequest];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    addButton.layer.borderWidth = 2.0;
    addButton.layer.cornerRadius = 10.0;
    addButton.titleLabel.font = [UIFont systemFontOfSize:54.0];
    addButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [addButton sizeToFit];
    [addButton setTitleEdgeInsets:UIEdgeInsetsMake(-10.0, 0.0, 0.0, 0.0)];
    [addButton setFrame:CGRectMake(0.0, 5.0, 60.0, 60.0)];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton addTarget:self
                  action:@selector(addAction:)
        forControlEvents:UIControlEventTouchUpInside];

    
}

#pragma mark - 导航 NavBar

- (void)loadNavBarWithTitle:(NSString *)title {
//    self.navigationItem.title = title;
    [self setTitle:title];

//    NSShadow *shadow = [[NSShadow alloc] init];
//    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
//    shadow.shadowOffset = CGSizeMake(0, 0.0);
//    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
//                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
//                                                           shadow, NSShadowAttributeName, LANTING_FONT(24.0)
//                                                           , NSFontAttributeName, nil]];
}

- (void)addAction:(UIButton *)sender {
    NSLog(@"addAction");
}

- (void)loadRequest {
    NSLog(@"laodRequest...");
    /*
     By default, AFJSONRequestOperation accepts only "text/json", "application/json" or "text/javascript" content-types from server, but you are getting "text/html".
     */
    
    NSString * str = @"http://115.29.102.31:8011/Istaff.do?m=Login?username=18701107843&password=202cb962ac59075b964b07152d234b70";
    
    //http://app.food.ttys5.com/api/food/suijitui
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject: @"text/html"];
    [manager POST:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
    }];


    /*
     
     回太原办的事
     档案 管理  人才市场  孔莉
     转户口
     党员转正
     
     
     */

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
