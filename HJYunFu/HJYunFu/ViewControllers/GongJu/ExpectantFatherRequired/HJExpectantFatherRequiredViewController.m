//
//  HJExpectantFatherRequiredViewController.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-6.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJExpectantFatherRequiredViewController.h"
#import "HJExpectantFatherRequiredCell.h"

@interface HJExpectantFatherRequiredViewController ()<UIGestureRecognizerDelegate,UINavigationBarDelegate,UITableViewDataSource,UITableViewDelegate> {
    
    NSMutableArray * dataArr;
}

@end

@implementation HJExpectantFatherRequiredViewController

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
    [self loadNavBarWithTitle:@"准爸爸必备宝典"];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"DadMustRead" ofType:@"plist"];
    dataArr = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, [UtilityFunc shareInstance].globleAllHeight + 49) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource   UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 37;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier = [NSString stringWithFormat:@"expectcell%d",indexPath.row];
    HJExpectantFatherRequiredCell * cell = (HJExpectantFatherRequiredCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[HJExpectantFatherRequiredCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.mtitle.text = [NSString stringWithFormat:@"%d周",indexPath.row + 4];
    if (indexPath.row == 0) {
        cell.upImg.frame = CGRectMake(55, -500, 1, 525);
    }

    if (indexPath.row == [dataArr count] - 1) {
        cell.downImg.frame = CGRectMake(55, 45, 1, [UtilityFunc boundingRectWithSize:CGSizeMake(225, 0) font:LANTING_FONT(14.0) text:[dataArr objectAtIndex:indexPath.row]].height + 500);
    }else {
        cell.downImg.frame = CGRectMake(55, 45, 1, [UtilityFunc boundingRectWithSize:CGSizeMake(225, 0) font:LANTING_FONT(14.0) text:[dataArr objectAtIndex:indexPath.row]].height - 5);
    }
    cell.bgView.frame = CGRectMake(70, 10, 240, [UtilityFunc boundingRectWithSize:CGSizeMake(225, 0) font:LANTING_FONT(14.0) text:[dataArr objectAtIndex:indexPath.row]].height + 20);
    cell.content.frame = CGRectMake(80, 20, 225, [UtilityFunc boundingRectWithSize:CGSizeMake(225, 0) font:LANTING_FONT(14.0) text:[dataArr objectAtIndex:indexPath.row]].height);
    cell.content.text = [dataArr objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilityFunc boundingRectWithSize:CGSizeMake(225, 0) font:LANTING_FONT(14.0) text:[dataArr objectAtIndex:indexPath.row]].height + 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithImage:LOADIMAGE(@"back", kImageTypePNG) style:UIBarButtonItemStylePlain target:self action:@selector(backUpClick)];
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
