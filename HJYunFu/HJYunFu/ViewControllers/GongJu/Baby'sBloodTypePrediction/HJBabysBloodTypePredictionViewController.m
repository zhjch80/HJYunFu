//
//  HJBabysBloodTypePredictionViewController.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-6.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJBabysBloodTypePredictionViewController.h"

@interface HJBabysBloodTypePredictionViewController ()<UIGestureRecognizerDelegate,UINavigationBarDelegate>

@end

@implementation HJBabysBloodTypePredictionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillDisappear: (BOOL)animated {
    [super viewWillDisappear: animated];
    if (![[self.navigationController viewControllers] containsObject: self]) {
        // the view has been removed from the navigation stack, back is probably the cause
        // this will be slow with a large stack however.
        NSLog(@"back!!!");
    }
    
    //代理置空，否则会闪退
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //开启iOS7的滑动返回效果
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //只有在二级页面生效
        if ([self.navigationController.viewControllers count] == 2) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kHideTabbar object:nil];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //开启滑动手势
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];

    [self loadNavBarWithTitle:@"宝宝血型查询"];
    
    UIImageView * bgImg = [[UIImageView alloc] init];
    bgImg.frame = CGRectMake(14, 15, 292, 85);
    bgImg.image = LOADIMAGE(@"gj_boyorgirl_bg_img", kImageTypePNG);
    bgImg.backgroundColor = [UIColor clearColor];
    bgImg.userInteractionEnabled = YES;
    [self.view addSubview:bgImg];
 
    NSArray * titleArr = [[NSArray alloc] initWithObjects:@"爸爸的血型:", @"妈妈的血型:", @"宝宝的血型可能为:", @"宝宝的血型不可能为:", nil];
    for (int i=0; i<2; i++) {
        UILabel * title = [[UILabel alloc] init];
        title.frame = CGRectMake(23, 21 + i*44, 220, 30);
        title.text = [titleArr objectAtIndex:i];
        title.backgroundColor = [UIColor clearColor];
        [self.view addSubview:title];
    }
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(54, 125, 207, 34);
    [button setBackgroundImage:LOADIMAGE(@"gj_kscs_btn_img", kImageTypePNG) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 101;
    [self.view addSubview:button];
    
    for (int i=0; i<2; i++) {
        UIImageView * resultsImg = [[UIImageView alloc] init];
        resultsImg.frame = CGRectMake(14, 170 + i*45, 292, 40);
        resultsImg.backgroundColor = [UIColor clearColor];
        resultsImg.image = LOADIMAGE(@"gj_babyyc_bg_img", kImageTypePNG);
        [self.view addSubview:resultsImg];
    }
    
    for (int i=0; i<2; i++) {
        UILabel * title = [[UILabel alloc] init];
        title.frame = CGRectMake(25, 176 + i*45, 200, 30);
        title.backgroundColor = [UIColor clearColor];
        title.text = [titleArr objectAtIndex:2+i];
        [self.view addSubview:title];
    }
    
    UILabel * text = [[UILabel alloc] initWithFrame:CGRectMake(8, 165, [UtilityFunc shareInstance].globleWidth - 11, 320)];
    text.backgroundColor = [UIColor clearColor];
    text.font = [UIFont systemFontOfSize:15.0];
    text.numberOfLines = 0;
    // 设置字体间每行的间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineHeightMultiple = 15.0f;
    paragraphStyle.maximumLineHeight = 15.0f;
    paragraphStyle.minimumLineHeight = 15.0f;
    paragraphStyle.lineSpacing = 15.0f;// 行间距
    NSDictionary *ats = @{
                          NSParagraphStyleAttributeName : paragraphStyle,
                          };
    text.attributedText = [[NSAttributedString alloc] initWithString:@"血型是以A、B、O、等三种遗传因子的组合而决定的，大多根据父母的血型即可判断出以后出生的小宝宝可能出现的血型。" attributes:ats];
    text.textColor = [UIColor colorWithRed:0.49 green:0.49 blue:0.49 alpha:1];
    [self.view addSubview:text];
}

- (void)buttonClick:(UIButton *)sender {
    
}

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
    leftBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBar;
    
}

- (void)backUpClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
