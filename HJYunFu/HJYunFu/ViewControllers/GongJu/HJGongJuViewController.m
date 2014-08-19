//
//  HJGongJuViewController.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-7-14.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJGongJuViewController.h"
#import "HJGongJuTableViewCell.h"
#import "GongJu.h"                  //工具各个模块的头文件

@interface HJGongJuViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
}
@property (nonatomic, strong) NSMutableArray * cellImgArr;
@property (nonatomic, strong) NSMutableArray * cellNameArr;
@property (nonatomic, strong) NSMutableArray * cellTipArr;

@end

@implementation HJGongJuViewController
@synthesize cellImgArr = _cellImgArr;
@synthesize cellNameArr = _cellNameArr;
@synthesize cellTipArr = _cellTipArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"appearTabbar" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    
    [self loadNavBarWithTitle:@"孕期工具"];
    
    _cellImgArr = [[NSMutableArray alloc] initWithObjects:@"gj_cell_1@2x", @"gj_cell_2@2x", @"gj_cell_3@2x", @"gj_cell_4@2x", @"gj_cell_5@2x", @"gj_cell_6@2x", @"gj_cell_7@2x", nil];
    
    _cellNameArr = [[NSMutableArray alloc] initWithObjects:@"预产期计算器", @"生男生女预测", @"宝宝身高预测", @"宝宝血型查询", @"育苗接种计划", @"孕期检查", @"准爸爸必备宝典", nil];
    
    _cellTipArr = [[NSMutableArray alloc] initWithObjects:@"输入末次月经期便可计算出预产期", @"快来测测您的宝宝是男孩还是女孩", @"来测量一下宝宝的身高吧", @"看看宝宝会是什么血型", @"宝宝育苗接种很重要    快来设定计划吧", @"为您提供孕期检查详细安排表", @"在妻子怀孕期间准爸爸们需要注意的要点", nil];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, [UtilityFunc shareInstance].globleAllHeight - 49) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    UIImageView * upImg = [[UIImageView alloc] initWithFrame:CGRectMake(151, -1000, 1, 1000)];
    upImg.backgroundColor = [UIColor clearColor];
    upImg.image = LOADIMAGE(@"gj_verticalLine_img@2x", kImageTypePNG);
    [tableView addSubview:upImg];
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, 41)];
    headView.backgroundColor = [UIColor clearColor];
    tableView.tableHeaderView = headView;
    
    UIImageView * yellowCircleImg = [[UIImageView alloc] initWithFrame:CGRectMake(146, 0, 11, 41)];
    yellowCircleImg.backgroundColor = [UIColor clearColor];
    yellowCircleImg.image = LOADIMAGE(@"gj_head_img@2x", kImageTypePNG);
    [headView addSubview:yellowCircleImg];
    
    UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, 20)];
    footView.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = footView;
    
    UIImageView * downImg = [[UIImageView alloc] initWithFrame:CGRectMake(150, footView.frame.size.height, 1, 1000)];
    downImg.backgroundColor = [UIColor clearColor];
    downImg.image = LOADIMAGE(@"gj_verticalLine_img@2x", kImageTypePNG);
    [footView addSubview:downImg];
    
    UIImageView * foot_img = [[UIImageView alloc] initWithFrame:CGRectMake(150, 0, 1, 20)];
    foot_img.image = LOADIMAGE(@"gj_verticalLine_img@2x", kImageTypePNG);
    foot_img.backgroundColor = [UIColor clearColor];
    [footView addSubview:foot_img];
    
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

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSString * cellIdentifier = [NSString stringWithFormat:@"gj_cell%d",indexPath.row];
    HJGongJuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell){
        cell = [[HJGongJuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 6){
        cell.verticalImg.hidden = YES;
    }
    
    cell.headImg.image = LOADIMAGE([_cellImgArr objectAtIndex:indexPath.row], kImageTypePNG);
    cell.mtitle.text = [_cellNameArr objectAtIndex:indexPath.row];
    cell.subTitle.text = [_cellTipArr objectAtIndex:indexPath.row];
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.enabled = NO;
            }
            HJDueDateCalculatorViewController * HJDueDateCalculatorCtl = [[HJDueDateCalculatorViewController alloc] init];
            [self.navigationController pushViewController:HJDueDateCalculatorCtl animated:YES];
            //开启iOS7的滑动返回效果
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            }
            break;
        }
        case 1:{
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.enabled = NO;
            }
            HJBoyOrGirlViewController * HJBoyOrGirlCtl = [[HJBoyOrGirlViewController alloc] init];
            [self.navigationController pushViewController:HJBoyOrGirlCtl animated:YES];
            //开启iOS7的滑动返回效果
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            }
            break;
        }
        case 2:{
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.enabled = NO;
            }
            HJBabyHeightPredictionViewController * HJBabyHeightPredictionCtl = [[HJBabyHeightPredictionViewController alloc] init];
            [self.navigationController pushViewController:HJBabyHeightPredictionCtl animated:YES];
            //开启iOS7的滑动返回效果
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            }
            break;
        }
        case 3:{
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.enabled = NO;
            }
            HJBabysBloodTypePredictionViewController * HJBabysBloodTypePredictionCtl = [[HJBabysBloodTypePredictionViewController alloc] init];
            [self.navigationController pushViewController:HJBabysBloodTypePredictionCtl animated:YES];
            //开启iOS7的滑动返回效果
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            }
            break;
        }
        case 4:{
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.enabled = NO;
            }
            HJSeedlingInoculationPlanViewController * HJSeedlingInoculationPlanCtl = [[HJSeedlingInoculationPlanViewController alloc] init];
            [self.navigationController pushViewController:HJSeedlingInoculationPlanCtl animated:YES];
            //开启iOS7的滑动返回效果
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            }
            break;
        }
        case 5:{
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.enabled = NO;
            }
            HJPregnancyCheckViewController * HJPregnancyCheckCtl = [[HJPregnancyCheckViewController alloc] init];
            [self.navigationController pushViewController:HJPregnancyCheckCtl animated:YES];
            //开启iOS7的滑动返回效果
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            }
            break;
        }
            
        case 6:{
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.enabled = NO;
            }
            HJExpectantFatherRequiredViewController * HJExpectantFatherRequiredCtl = [[HJExpectantFatherRequiredViewController alloc] init];
            [self.navigationController pushViewController:HJExpectantFatherRequiredCtl animated:YES];
            //开启iOS7的滑动返回效果
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            }
            break;
        }
 
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kHideTabbar object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
