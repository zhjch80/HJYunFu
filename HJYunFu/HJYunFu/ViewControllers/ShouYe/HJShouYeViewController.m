//
//  HJShouYeViewController.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-7-14.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJShouYeViewController.h"
#import "SYTableViewHead.h"
#import "SYTableViewFoot.h"
#import "HJPeriodSwitchDueDate.h"
#import "HJShouYeCell.h"                                //cell 相关头文件
#import "HJBabyDetailsViewController.h"                 //宝宝发育详情
#import "HJUserFeedbackViewController.h"                //用户反馈

@interface HJShouYeViewController ()<UITableViewDataSource,UITableViewDelegate,BtnsClickEventDelegate>

@end

@implementation HJShouYeViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    [self loadNavBarWithTitle:@"健康孕期"];
    
    CUSFileStorage *storage = [CUSFileStorageManager getFileStorage:CURRENTENCRYPTFILE];
    NSString * str_1 = [AESCrypt decrypt:[storage objectForKey:MOCIYUEJINGQI_KEY] password:PASSWORD];
    NSString * str_2 = [AESCrypt decrypt:[storage objectForKey:YUCHANQI_KEY] password:PASSWORD];
    NSLog(@"末次月经期:%@ 预产期:%@",str_1,str_2);
    
    //以下都是根据末次月经期计算得出：
    NSLog(@"孕周:%@,天数:%@.",[[HJPeriodSwitchDueDate gestationalAgeFromLastMenstrualPeriod:@"2014-01-10"] objectForKey:@"AfterTheWeeks"],[[HJPeriodSwitchDueDate gestationalAgeFromLastMenstrualPeriod:@"2014-01-10"] objectForKey:@"AfterTheDays"]);
    
    NSLog(@"孕月:%@",[HJPeriodSwitchDueDate monthOfPregnancyFromGestationalAge:[[[HJPeriodSwitchDueDate gestationalAgeFromLastMenstrualPeriod:@"2014-01-10"] objectForKey:@"AfterTheWeeks"] integerValue]]);
    
    NSLog(@"距生产日:%@",[HJPeriodSwitchDueDate howManyDaysInTotalFromLastMenstrualPeriod:[[[HJPeriodSwitchDueDate gestationalAgeFromLastMenstrualPeriod:@"2014-01-10"] objectForKey:@"totalDays"] integerValue]]);


    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, [UtilityFunc shareInstance].globleAllHeight - 49) style:UITableViewStylePlain];
    tableView.bounces = NO;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];

    SYTableViewHead * SYHeadView = [[SYTableViewHead alloc] initWithFrame:CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, (409 - 50 + 94)/2)];
    tableView.tableHeaderView = SYHeadView;
    
    SYTableViewFoot * SYFootView = [[SYTableViewFoot alloc] initWithFrame:CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, 197/2)];
    SYFootView.delegate = self;
    tableView.tableFooterView = SYFootView;

    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [SYHeadView addGestureRecognizer:recognizer];
    
    /*
     
    前12周  没有三项数据  文字长点
     
    head clik to 发育页面
     
    list data  妈 变化 必读根据孕周
     
    本月  是根据 孕月

    */
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    HJBabyDetailsViewController *HJBabyDetailsCtl = [[HJBabyDetailsViewController alloc] init];
    [self.navigationController pushViewController:HJBabyDetailsCtl animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kHideTabbar object:nil];
    //开启iOS7的滑动返回效果
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

#pragma mark - BtnsClickEventDelegate
- (void)btnsClickEvent:(NSInteger)value {
    switch (value) {
        case 101:{
            NSLog(@"评分");
            break;
        }
        case 102:{
            NSLog(@"分享");
            break;
        }
        case 103:{
            HJUserFeedbackViewController *HJUserFeedbackCtl = [[HJUserFeedbackViewController alloc] init];
            [self.navigationController pushViewController:HJUserFeedbackCtl animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:kHideTabbar object:nil];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - 导航 NavBar

- (void)loadNavBarWithTitle:(NSString *)title {
//    self.navigationItem.title = title;

    
    [self setTitle:title];

//    UIImage * searchBackImage = [UIImage imageNamed:@"xz_top_img"];
//    searchBackImage = [searchBackImage stretchableImageWithLeftCapWidth:1 topCapHeight:64];
//    UIImageView * searchBackView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
//    searchBackView.image = searchBackImage;
//    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
//    [self.navigationController.navigationBar setBackgroundImage:searchBackView.image forBarMetrics:UIBarMetricsDefault];

   
    
    
    
    
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"xz_top_img@2x"] forBarMetrics:UIBarMetricsDefault];
    
//    NSShadow *shadow = [[NSShadow alloc] init];
//    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
//    shadow.shadowOffset = CGSizeMake(0, 0.0);
//    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
//                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
//                                                           shadow, NSShadowAttributeName, LANTING_FONT(24.0)
//                                                           , NSFontAttributeName, nil]];
}

//- (void)setTitle:(NSString *) title {
//    [super setTitle:title];
//    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
//    titleView.textAlignment = NSTextAlignmentCenter;
//    if(!titleView){
//        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
//        titleView.backgroundColor = [UIColor clearColor];
//        titleView.font = LANTING_FONT(24.0);
//        titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.2];
//        titleView.textColor = [UIColor whiteColor];
//        self.navigationItem.titleView = titleView;
//    }
//    titleView.text = title;
//    [titleView sizeToFit];
//}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0){
        NSString * cellIdentifier = [NSString stringWithFormat:@"sycell%d",indexPath.row];
        HJMotherChangeCell * cell = (HJMotherChangeCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell){
            cell = [[HJMotherChangeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        
        return cell;
    }else if (indexPath.row == 1){
        NSString * cellIdentifier = [NSString stringWithFormat:@"sycell%d",indexPath.row];
        HJReadEveryDayCell * cell = (HJReadEveryDayCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell){
            cell = [[HJReadEveryDayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        
        return cell;
    }else if (indexPath.row == 2){
        NSString * cellIdentifier = [NSString stringWithFormat:@"sycell%d",indexPath.row];
        HJNutritionCell * cell = (HJNutritionCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell){
            cell = [[HJNutritionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        
        return cell;
    }else if (indexPath.row == 3){
        NSString * cellIdentifier = [NSString stringWithFormat:@"sycell%d",indexPath.row];
        HJMoreCell * cell = (HJMoreCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell){
            cell = [[HJMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        return cell;
    }else if (indexPath.row == 4){
        NSString * cellIdentifier = [NSString stringWithFormat:@"sycell%d",indexPath.row];
        HJForbiddenToEatCell * cell = (HJForbiddenToEatCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell){
            cell = [[HJForbiddenToEatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        return cell;
    }else if (indexPath.row == 5){
        NSString * cellIdentifier = [NSString stringWithFormat:@"sycell%d",indexPath.row];
        HJMoreCell * cell = (HJMoreCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell){
            cell = [[HJMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2){
        return 140;
    }else if (indexPath.row == 3){
        return 40;
    }else if (indexPath.row == 4){
        return 140;
    }else if (indexPath.row == 5) {
        return 40;
    }else {
        return 105;
    }
}

#pragma mark -

- (void)buttonClick:(UIButton *)sender {
    NSString *shareText = @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。 http://www.umeng.com/social";             //分享内嵌文字
    UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];          //分享内嵌图片
    
    //如果得到分享完成回调，需要设置delegate为self
    [UMSocialSnsService presentSnsIconSheetView:self appKey:UMENG_APPKEY shareText:shareText shareImage:shareImage shareToSnsNames:nil delegate:self];
}

#pragma mark - UMeng

////下面可以设置根据点击不同的分享平台，设置不同的分享文字
//-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
//{
//    if ([platformName isEqualToString:UMShareToSina]) {
//        socialData.shareText = @"分享到新浪微博";
//    }
//    else{
//        socialData.shareText = @"分享内嵌文字";
//    }
//}

-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType
{
    NSLog(@"didClose is %d",fromViewControllerType);
}

//下面得到分享完成的回调
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"didFinishGetUMSocialDataInViewController with response is %@",response);
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
