//
//  HJBabyHeightPredictionViewController.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-6.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJBabyHeightPredictionViewController.h"

@interface HJBabyHeightPredictionViewController ()<UIGestureRecognizerDelegate,UINavigationBarDelegate>

@end

@implementation HJBabyHeightPredictionViewController

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

/**
 button 101
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];

    [self loadNavBarWithTitle:@"宝宝身高预测"];
    
    UIScrollView * scr = [[UIScrollView alloc] init];
    scr.frame = CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, [UtilityFunc shareInstance].globleHeight + 5);
    scr.contentSize = CGSizeMake([UtilityFunc shareInstance].globleWidth, 490);
    scr.pagingEnabled = NO;
    [self.view addSubview:scr];
    
    UIImageView * bgImg = [[UIImageView alloc] init];
    bgImg.frame = CGRectMake(14, 15, 292, 125);
    bgImg.image = LOADIMAGE(@"gj_babysgyc_bg_img", kImageTypePNG);
    bgImg.userInteractionEnabled = YES;
    bgImg.backgroundColor = [UIColor clearColor];
    [scr addSubview:bgImg];
    
    NSArray * titleArr = [[NSArray alloc] initWithObjects:@"父亲身高:\t\t\t\t\t厘米(cm)", @"母亲身高:\t\t\t\t\t厘米(cm)", @"孩子性别:", nil];
    for (int i=0; i<3; i++) {
        UILabel * title = [[UILabel alloc] init];
        title.frame = CGRectMake(23, 21 + i*41, 290, 30);
        title.text = [titleArr objectAtIndex:i];
        title.backgroundColor = [UIColor clearColor];
        [scr addSubview:title];
    }
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(55, 160, 207, 34);
    [button setBackgroundImage:LOADIMAGE(@"gj_kscs_btn_img", kImageTypePNG) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 101;
    [scr addSubview:button];
    
    UIImageView * selectImg = [[UIImageView alloc] init];
    selectImg.frame = CGRectMake(15, 210, 292, 40);
    selectImg.backgroundColor = [UIColor clearColor];
    selectImg.userInteractionEnabled = YES;
    selectImg.image = LOADIMAGE(@"gj_babyyc_bg_img", kImageTypePNG);
    [scr addSubview:selectImg];
    
    UILabel * results = [[UILabel alloc] init];
    results.frame = CGRectMake(25, 215, 130, 30);
    results.text = @"宝宝身高预测值:";
    results.backgroundColor = [UIColor clearColor];
    results.font = [UIFont systemFontOfSize:16.0];
    [scr addSubview:results];
    
    UILabel * text = [[UILabel alloc] initWithFrame:CGRectMake(8, 215, [UtilityFunc shareInstance].globleWidth - 11, 320)];
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
    text.attributedText = [[NSAttributedString alloc] initWithString:@"人的身高与遗传有很大关系，根据爸爸妈妈的身高，可以一定程度上预测出宝宝未来所能达到的高度范围。但需要注意的是，遗传因素对宝宝身高的影响不是绝对的，在遗传学上身高的遗传度为0.72，意思是说子女的身高有72%受遗传影响，但最终身高还受到其他后天因素的影响。" attributes:ats];
    text.textColor = [UIColor colorWithRed:0.49 green:0.49 blue:0.49 alpha:1];
    [scr addSubview:text];
    
}

- (void)buttonClick:(UIButton *)sender {
    
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
