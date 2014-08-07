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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    
    CUSFileStorage *storage = [CUSFileStorageManager getFileStorage:CURRENTENCRYPTFILE];
    NSString * str_1 = [AESCrypt decrypt:[storage objectForKey:MOCIYUEJINGQI_KEY] password:PASSWORD];
    NSString * str_2 = [AESCrypt decrypt:[storage objectForKey:YUCHANQI_KEY] password:PASSWORD];
    NSLog(@"末次月经期:%@ 预产期:%@",str_1,str_2);
    
    
    /*
    
    孕周计算方法：
    从末次月经开始的第一天算起，每7天为一周
     
     
    孕月：
    孕1月（孕0-4周）、孕2月（孕5-8周）、孕3月（孕9-12周）、孕4月（孕13-16周）、孕5月（孕17-20周）、孕6月（孕21-24周）、孕7月（孕25-28周）、孕8月（孕29-32周）、孕9月（孕33-36周）、孕10月（孕37-40周）
     
     
    出生日计算方法：
    孕期共280天，用280天减去怀孕的天数
    
    
     */
    
    
    
    [self loadNavBarWithTitle:@"健康孕期"];

    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, [UtilityFunc shareInstance].globleAllHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];

    SYTableViewFoot * SYFootView = [[SYTableViewFoot alloc] initWithFrame:CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, 197/2)];
    SYFootView.delegate = self;
    tableView.tableFooterView = SYFootView;
    
    SYTableViewHead * SYHeadView = [[SYTableViewHead alloc] initWithFrame:CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, 503/2)];
    tableView.tableHeaderView = SYHeadView;
    
    
    /*
     
    前12周  没有三项数据  文字长点
     
    孕周算法  距生产日算法  
     
     head clik to 发育页面
     
     list data  妈 变化 必读根据孕周
     
     本月  是根据 孕月
     
     */
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
            NSLog(@"反馈");
            break;
        }
            
        default:
            break;
    }
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

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier = [NSString stringWithFormat:@"sycell%d",indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = @"cell";
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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
