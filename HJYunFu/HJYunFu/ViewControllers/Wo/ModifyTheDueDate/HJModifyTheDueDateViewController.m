//
//  HJModifyTheDueDateViewController.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-20.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJModifyTheDueDateViewController.h"

@interface HJModifyTheDueDateViewController ()

@end

@implementation HJModifyTheDueDateViewController

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
    [self loadNavBarWithTitle:@"修改预产期"];
    
}

#pragma mark - 导航栏

- (void)loadNavBarWithTitle:(NSString *)title {
    self.navigationItem.title = title;
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 0.0);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName, LANTING_FONT(24.0)
                                                           , NSFontAttributeName, nil]];
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithImage:LOADIMAGE(@"back", kImageTypePNG) style:UIBarButtonItemStylePlain target:self action:@selector(backUpClick) ];
    leftBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftBar;
}

- (void)backUpClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
