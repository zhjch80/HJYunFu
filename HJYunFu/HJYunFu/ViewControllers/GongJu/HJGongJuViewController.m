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
@property (nonatomic, strong)NSMutableArray * cellImgArr;
@end

@implementation HJGongJuViewController
@synthesize cellImgArr = _cellImgArr;

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
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, [UtilityFunc shareInstance].globleAllHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
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
    
    UIImageView * foot_img = [[UIImageView alloc] initWithFrame:CGRectMake(150, 0, 1, 20)];
    foot_img.image = LOADIMAGE(@"gj_verticalLine_img@2x", kImageTypePNG);
    foot_img.backgroundColor = [UIColor clearColor];
    [footView addSubview:foot_img];
    
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
    
    //自定义返回
    //    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back_btn.png"]];
    //    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back_btn.png"]];
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
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            HJDueDateCalculatorViewController * HJDueDateCalculatorCtl = [[HJDueDateCalculatorViewController alloc] init];
            [self.navigationController pushViewController:HJDueDateCalculatorCtl animated:YES];
            break;
        }
        case 1:{
            HJBoyOrGirlViewController * HJBoyOrGirlCtl = [[HJBoyOrGirlViewController alloc] init];
            [self.navigationController pushViewController:HJBoyOrGirlCtl animated:YES];
            break;
        }
        case 2:{
            HJBabyHeightPredictionViewController * HJBabyHeightPredictionCtl = [[HJBabyHeightPredictionViewController alloc] init];
            [self.navigationController pushViewController:HJBabyHeightPredictionCtl animated:YES];
            break;
        }
        case 3:{
            HJBabysBloodTypePredictionViewController * HJBabysBloodTypePredictionCtl = [[HJBabysBloodTypePredictionViewController alloc] init];
            [self.navigationController pushViewController:HJBabysBloodTypePredictionCtl animated:YES];
            break;
        }
        case 4:{
            HJSeedlingInoculationPlanViewController * HJSeedlingInoculationPlanCtl = [[HJSeedlingInoculationPlanViewController alloc] init];
            [self.navigationController pushViewController:HJSeedlingInoculationPlanCtl animated:YES];
            break;
        }
        case 5:{
            HJPregnancyCheckViewController * HJPregnancyCheckCtl = [[HJPregnancyCheckViewController alloc] init];
            [self.navigationController pushViewController:HJPregnancyCheckCtl animated:YES];
            break;
        }
            
        case 6:{
            HJExpectantFatherRequiredViewController * HJExpectantFatherRequiredCtl = [[HJExpectantFatherRequiredViewController alloc] init];
            [self.navigationController pushViewController:HJExpectantFatherRequiredCtl animated:YES];
            break;
        }
 
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabbar" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
