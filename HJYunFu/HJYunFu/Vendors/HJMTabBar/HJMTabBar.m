//
//  HJMTabBar.m
//  HJMDrawer
//
//  Created by 华晋传媒 on 14-3-13.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJMTabBar.h"
#import "UIViewController+MMDrawerController.h"

@interface HJMTabBar ()

@end

@implementation HJMTabBar{
    NSInteger count;
    NSMutableArray * btnArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideTabBar:) name:@"hideTabbar" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appearTabBar:) name:@"appearTabbar" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLeftToEmptyMethods) name:@"setLeftToEmptyMethods" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRightToEmptyMethods) name:@"setRightToEmptyMethods" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLeftSlide) name:@"setLeftSlide" object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MenuLeftBtnMethods) name:@"MenuLeftBtnMethods" object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MenuRightBtnMethods) name:@"MenuRightBtnMethods" object:nil];

        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SetTopicLeftSlide) name:@"SetTopicLeftSlide" object:nil];
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mTabSelectIndex:) name:@"mTabSelectIndex" object:nil];
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    btnArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self hideOriginalTab];
    
    self.tabBarView = [[UIView alloc]init];
    self.tabBarView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49, 320, 49);
    self.tabBarView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tabBarView];
}

- (void)backBtnClick:(NSNotification *)notif {
    [self.navigationController popViewControllerAnimated:YES];
}

//隐藏tabbar
- (void)hideTabBar:(NSNotification *)notif {
    [UIView animateWithDuration:0.2
                          delay:0.00
                        options:UIViewAnimationOptionTransitionCurlUp animations:^(void){
                            self.tabBarView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, 320, 49);
                        }completion:nil];
    
}

//显示tabbar
- (void)appearTabBar:(NSNotification *)notif {
    [UIView animateWithDuration:0.2
                          delay:0.00
                        options:UIViewAnimationOptionTransitionCurlUp animations:^(void){
                            self.tabBarView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49, 320, 49);
                        }completion:nil];
    
}

//给tabbar自定义按钮或其他控件
- (void)setTabWithArray:(NSArray *)tabArray NormalImageArray:(NSArray *)normalArray SelectedImageArray:(NSArray *)selectedArray {
    
    self.viewControllers = tabArray;
    count = [tabArray count];
    if (tabArray.count > 0) {
        
        for (int i = 0; i < [tabArray count]; i ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:[selectedArray objectAtIndex:i]] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:[normalArray objectAtIndex:i]] forState:UIControlStateNormal];
            btn.tag = i ;
            if (btn.tag == 0)
                btn.selected = YES;
            else
                btn.selected = NO;
            btn.frame = CGRectMake(320/[tabArray count]*i, 0, 320/[tabArray count], 49);
            [btn addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside];
            [self.tabBarView addSubview:btn];
            [btnArray addObject:btn];
        }
    }
}

- (void)selectTab:(UIButton *)selectBtn{
    if(selectBtn.selected == NO)
    {
        NSInteger selectTag = selectBtn.tag;
        selectBtn.selected = YES;
        UIViewController *selectVC = [self.viewControllers objectAtIndex:selectTag];
        self.selectedViewController = selectVC;
        for(int i = 0; i < count; i++)
        {
            UIButton *btn = (UIButton *)[btnArray objectAtIndex:i];
            if (btn.tag != selectTag)
                btn.selected = NO;
            else
                btn.selected = YES;
        }
    }
}

- (void)hideOriginalTab {
    NSArray *array = [self.view subviews];
    UIView *originalTabView = [array objectAtIndex:1];
    originalTabView.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height, 320, 49);
    originalTabView.backgroundColor = [UIColor clearColor];
    UIView *newTabView = [array objectAtIndex:0];
    newTabView.frame = CGRectMake(0, 0, 320,[UIScreen mainScreen].bounds.size.height);
    newTabView.backgroundColor = [UIColor clearColor];
    
}

- (void)setLeftToEmptyMethods{
    [self.mm_drawerController
     closeDrawerAnimated:YES
     completion:^(BOOL finished) {
         [self.mm_drawerController setLeftDrawerViewController:nil];
     }];
}

- (void)setRightToEmptyMethods{
    [self.mm_drawerController
     closeDrawerAnimated:YES
     completion:^(BOOL finished) {
         [self.mm_drawerController setRightDrawerViewController:nil];
     }];
}

//设置界面 的左侧滑
//-(void)setLeftSlide{
//    KJLeftPartViewController * LeftPartCtl = [[KJLeftPartViewController alloc] init];
//    UINavigationController * leftPartNav = [[UINavigationController alloc] initWithRootViewController:LeftPartCtl];
//    [self.mm_drawerController setLeftDrawerViewController:leftPartNav];
//}

-(void)MenuLeftBtnMethods{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)MenuRightBtnMethods{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
