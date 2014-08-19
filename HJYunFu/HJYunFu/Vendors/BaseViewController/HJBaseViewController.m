//
//  HJBaseViewController.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-6.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJBaseViewController.h"

@interface HJBaseViewController ()

@end

@implementation HJBaseViewController

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
    self.navigationController.navigationBar.translucent = YES;
    
    
    UIImage * searchBackImage = [UIImage imageNamed:@"xz_top_img"];
    searchBackImage = [searchBackImage stretchableImageWithLeftCapWidth:1 topCapHeight:10];
    UIImageView * searchBackView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    searchBackView.image = searchBackImage;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackgroundImage:searchBackView.image forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor clearColor]];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"xz_top_img@2x"] forBarMetrics:UIBarMetricsDefault];
}

- (void)setTitle:(NSString *) title {
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    titleView.textAlignment = NSTextAlignmentCenter;
    if(!titleView){
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = LANTING_FONT(24.0);
        titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        titleView.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
