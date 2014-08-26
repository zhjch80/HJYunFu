//
//  HJWoViewController.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-7-14.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJWoViewController.h"
#import "HJModifyTheDueDateViewController.h"                //修改预产期
#import "HJMyCollectionViewController.h"                    //我的收藏

@interface HJWoViewController ()

@end

@implementation HJWoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:kAppearTabbar object:nil];
}

/**
 button tag 101 102
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];

    [self loadNavBarWithTitle:@"个人信息"];
    
    NSArray * titleArr = [[NSArray alloc] initWithObjects:@"修改预产期", @"我的收藏", nil];
    for (int i=0; i<2; i++) {
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80 + i*50, [UtilityFunc shareInstance].globleWidth - 40, 40)];
        image.backgroundColor = [UIColor clearColor];
        image.userInteractionEnabled = YES;
        image.image = LOADIMAGE(@"me_cellbg_img", kImageTypePNG);
        [self.view addSubview:image];
        
        UIImageView * arrowImg = [[UIImageView alloc] init];
        arrowImg.frame = CGRectMake(270, 95 + i*50, 7, 8);
        arrowImg.backgroundColor = [UIColor clearColor];
        arrowImg.userInteractionEnabled = YES;
        arrowImg.image = LOADIMAGE(@"me_arrow_img", kImageTypePNG);
        [self.view addSubview:arrowImg];
        
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(40, 80 + i*50, [UtilityFunc shareInstance].globleWidth - 60, 40)];
        title.userInteractionEnabled = YES;
        title.backgroundColor = [UIColor clearColor];
        title.text = [titleArr objectAtIndex:i];
        title.font = LANTING_FONT(19.0);
        title.textColor = [UIColor colorWithRed:0.36 green:0.36 blue:0.36 alpha:1];
        [self.view addSubview:title];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, 80+i*50, [UtilityFunc shareInstance].globleWidth - 40, 40);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 101+i;
        [self.view addSubview:button];
    }
}

- (void)buttonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 101:{
            HJModifyTheDueDateViewController * HJModifyTheDueDateCtl = [[HJModifyTheDueDateViewController alloc] init];
            [self.navigationController pushViewController:HJModifyTheDueDateCtl animated:YES];
            break;
        }
        case 102:{
            HJMyCollectionViewController * HJMyCollectionCtl = [[HJMyCollectionViewController alloc] init];
            [self.navigationController pushViewController:HJMyCollectionCtl animated:YES];
            break;
        }

        default:
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kHideTabbar object:nil];
    
}

#pragma mark - 导航 NavBar

- (void)loadNavBarWithTitle:(NSString *)title {
    self.navigationItem.title = title;

    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 0.0);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName, LANTING_FONT(24.0)
                                                           , NSFontAttributeName, nil]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
