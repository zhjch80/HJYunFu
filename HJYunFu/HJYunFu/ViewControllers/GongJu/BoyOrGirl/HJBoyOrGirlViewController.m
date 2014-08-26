//
//  HJBoyOrGirlViewController.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-6.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJBoyOrGirlViewController.h"
#import "HJAgeChoiceView.h"
#import "HJMonthChoiceView.h"
#import "HJPeriodSwitchDueDate.h"

@interface HJBoyOrGirlViewController ()<UIGestureRecognizerDelegate,UINavigationBarDelegate>
@property (nonatomic, copy) NSString * xusui;
@property (nonatomic, copy) NSString * yuefen;
@end

@implementation HJBoyOrGirlViewController
@synthesize xusui = _xusui,yuefen = _yuefen;

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
 button tag 101
 img_N   201 202
 选择 年龄 tag 401 402
 scr tag 501
 show tag 601 602
 predictResults tag 701
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAgeChoiceModelView) name:@"removeAgeChoiceModelView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addXuSuiMethod) name:@"addXuSuiMethod" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addYueFenMethod) name:@"addYueFenMethod" object:nil];
    
    [self loadNavBarWithTitle:@"生男生女预测"];
    
    UIScrollView * scr = [[UIScrollView alloc] init];
    scr.frame = CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, [UtilityFunc shareInstance].globleAllHeight + 49);
    scr.tag = 501;
    scr.contentSize = CGSizeMake([UtilityFunc shareInstance].globleWidth, 535);
    scr.pagingEnabled = NO;
    [self.view addSubview:scr];
    
    UIImageView * bgImg = [[UIImageView alloc] init];
    bgImg.frame = CGRectMake(14, 15, 292, 85);
    bgImg.image = LOADIMAGE(@"gj_boyorgirl_bg_img", kImageTypePNG);
    bgImg.backgroundColor = [UIColor clearColor];
    bgImg.userInteractionEnabled = YES;
    [scr addSubview:bgImg];
    
    NSArray * titleArr = [[NSArray alloc] initWithObjects:@"孕妇受孕时（18-45）虚岁:", @"孕妇受孕（排卵）农历月份:", nil];
    for (int i=0; i<2; i++) {
        UILabel * title = [[UILabel alloc] init];
        title.frame = CGRectMake(23, 21 + i*44, 220, 30);
        title.text = [titleArr objectAtIndex:i];
        title.textAlignment = NSTextAlignmentLeft;
        title.backgroundColor = [UIColor clearColor];
        [scr addSubview:title];
    }

    for (int i=0; i<2; i++) {
        UIImageView * img_N = [[UIImageView alloc] init];
        img_N.tag = 201 + i;
        img_N.frame = CGRectMake(278, 26 + i*44, 14, 20);
        img_N.image = LOADIMAGE(@"gl_select_N_bg_img", kImageTypePNG);
        [scr addSubview:img_N];
        
        UILabel * show = [[UILabel alloc] init];
        show.tag = 601 +i;
        show.frame = CGRectMake(230 + i*8, 21 + i*44, 50, 30);
        show.backgroundColor = [UIColor clearColor];
        [scr addSubview:show];
    }
    
    for (int i=0; i<2; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(260, 16+i*44, 40, 45);
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = 401+i;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [scr addSubview:btn];
    }
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(54, 125, 207, 34);
    [button setBackgroundImage:LOADIMAGE(@"gj_kscs_btn_img", kImageTypePNG) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 101;
    [scr addSubview:button];
    
    UIImageView * resultsImg = [[UIImageView alloc] init];
    resultsImg.frame = CGRectMake(15, 185, 292, 40);
    resultsImg.image = LOADIMAGE(@"gj_babyyc_bg_img", kImageTypePNG);
    resultsImg.backgroundColor = [UIColor clearColor];
    [scr addSubview:resultsImg];
    
    UILabel * results = [[UILabel alloc] init];
    results.frame = CGRectMake(25, 190, 110, 30);
    results.text = @"宝宝性别预测:";
    results.backgroundColor = [UIColor clearColor];
    results.font = [UIFont systemFontOfSize:16.0];
    [scr addSubview:results];
    
    UILabel * predictResults = [[UILabel alloc] init];
    predictResults.frame = CGRectMake(140, 190, 100, 30);
    predictResults.tag = 701;
    predictResults.backgroundColor = [UIColor clearColor];
    [scr addSubview:predictResults];
    
    UILabel * text = [[UILabel alloc] initWithFrame:CGRectMake(8, 225, [UtilityFunc shareInstance].globleWidth - 11, 320)];
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
    text.attributedText = [[NSAttributedString alloc] initWithString:@"本测试基于清宫珍藏得生男生女预测表，即《清宫表》。\n《清宫表》是民间最广为流传得一种生男生女测算法，不仅用于胎宝宝性别得猜测，也有未准妈妈根据《清宫表》来决定受孕时间。\n《清宫表》是通过“受孕的农历月份”和“孕妈妈受孕时的虚岁年龄”两个数据来判断。民间传说并无科学依据，只为准爸妈们孕愈期间休闲娱乐，不能够完全相信哦。" attributes:ats];
    text.textColor = [UIColor colorWithRed:0.49 green:0.49 blue:0.49 alpha:1];
    [scr addSubview:text];
}

#pragma mark - Method

- (void)addXuSuiMethod {
    UILabel * label = (UILabel *)[self.view viewWithTag:601];
    CUSFileStorage *storage = [CUSFileStorageManager getFileStorage:CURRENTENCRYPTFILE];
    NSString * str = [AESCrypt decrypt:[storage objectForKey:XUSUI_KEY] password:PASSWORD];
    label.text = str;
    
    NSRange range = [str rangeOfString:@"岁"];
    if (range.location != NSNotFound){
        _xusui = [str substringToIndex:range.location];
    }
}

- (void)addYueFenMethod {
    UILabel * label = (UILabel *)[self.view viewWithTag:602];
    CUSFileStorage *storage = [CUSFileStorageManager getFileStorage:CURRENTENCRYPTFILE];
    NSString * str = [AESCrypt decrypt:[storage objectForKey:PAILUANYUEFEN_KEY] password:PASSWORD];
    label.text = str;

    NSRange range = [str rangeOfString:@"月"];
    if (range.location != NSNotFound){
        _yuefen = [str substringToIndex:range.location];
    }
}

#pragma mark - 移除选择年龄 View Method

- (void)removeAgeChoiceModelView {
    for (id view in [[UIApplication sharedApplication].keyWindow subviews]) {
        if ([view isKindOfClass:[HJAgeChoiceView class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (id view in [[UIApplication sharedApplication].keyWindow subviews]) {
        if ([view isKindOfClass:[HJMonthChoiceView class]]) {
            [view removeFromSuperview];
        }
    }
}

#pragma mark - buttonClick Method

- (void)buttonClick:(UIButton *)sender {
    UIScrollView * scr = (UIScrollView *)[self.view viewWithTag:501];
    switch (sender.tag) {
        case 101:{
            UILabel * predictResults = (UILabel *)[self.view viewWithTag:701];
            predictResults.text = [HJPeriodSwitchDueDate getBoyOrGirlWithAge:_xusui WithMonth:_yuefen];
            break;
        }
        case 401:{
            if ((64 + scr.contentOffset.y) > 26.0) {
                return ;
            }
            HJAgeChoiceView * ageChoiceView = [[HJAgeChoiceView alloc] init];
            ageChoiceView.frame = CGRectMake(0, -(64 + scr.contentOffset.y), [UtilityFunc shareInstance].globleWidth, [UtilityFunc shareInstance].globleAllHeight);
            [[UIApplication sharedApplication].keyWindow addSubview:ageChoiceView];
            break;
        }
        case 402:{
            if ((64 + scr.contentOffset.y) >= 70.0){
                return ;
            }
            HJMonthChoiceView * monthChoice = [[HJMonthChoiceView alloc] init];
            monthChoice.frame = CGRectMake(0, -(64 + scr.contentOffset.y), [UtilityFunc shareInstance].globleWidth, [UtilityFunc shareInstance].globleAllHeight);
            [[UIApplication sharedApplication].keyWindow addSubview:monthChoice];
            break;
        }

        default:
            break;
    }
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
