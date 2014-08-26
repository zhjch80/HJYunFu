//
//  HJBabysBloodTypePredictionViewController.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-6.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJBabysBloodTypePredictionViewController.h"
#import "HJMCustomTextField.h"
#import "HJPeriodSwitchDueDate.h"

@interface HJBabysBloodTypePredictionViewController ()<UIGestureRecognizerDelegate,UINavigationBarDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIToolbar *keyboardToolbar;

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

/**
 button.tag 101
 HJMCustomTextField 201 202
 displayResults 301 302
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];

    [self loadNavBarWithTitle:@"宝宝血型查询"];
    
    UIImageView * bgImg = [[UIImageView alloc] init];
    bgImg.frame = CGRectMake(14, 75, 292, 85);
    bgImg.image = LOADIMAGE(@"gj_boyorgirl_bg_img", kImageTypePNG);
    bgImg.backgroundColor = [UIColor clearColor];
    bgImg.userInteractionEnabled = YES;
    [self.view addSubview:bgImg];
 
    NSArray * titleArr = [[NSArray alloc] initWithObjects:@"爸爸的血型:", @"妈妈的血型:", @"宝宝的血型可能为:", @"宝宝的血型不可能为:", nil];
    for (int i=0; i<2; i++) {
        UILabel * title = [[UILabel alloc] init];
        title.frame = CGRectMake(23, 80 + i*44, 220, 30);
        title.text = [titleArr objectAtIndex:i];
        title.backgroundColor = [UIColor clearColor];
        [self.view addSubview:title];
    }
    
    // Keyboard toolbar
    if (self.keyboardToolbar == nil) {
        self.keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 38.0f)];
        self.keyboardToolbar.backgroundColor = [UIColor whiteColor];
        self.keyboardToolbar.barTintColor = [UIColor whiteColor];
        
        UIBarButtonItem *cancelBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"取消", @"")
                                                                          style:UIBarButtonItemStyleBordered
                                                                         target:self
                                                                         action:@selector(cancelMethod:)];
        [cancelBarItem setTintColor:[UIColor colorWithRed:0.99 green:0.24 blue:0.38 alpha:1]];
        
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:nil
                                                                                      action:nil];
        
        UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:self
                                                                       action:@selector(doneMethod:)];
        [doneBarItem setTintColor:[UIColor colorWithRed:0.99 green:0.24 blue:0.38 alpha:1]];
        
        [self.keyboardToolbar setItems:[NSArray arrayWithObjects:cancelBarItem, spaceBarItem, doneBarItem, nil]];
    }

    for (int i=0; i<2; i++) {
        HJMCustomTextField * textField = [[HJMCustomTextField alloc] init];
        textField.frame = CGRectMake(120, 82 + i*41, 160, 30);
        textField.delegate = self;
        textField.tag = 201 + i;
        textField.backgroundColor = [UIColor clearColor];
        textField.placeholder = @"请输入血型";
        textField.text = @"";
        textField.textColor = [UIColor blackColor];
        textField.font = [UIFont systemFontOfSize:16.5];
        textField.inputAccessoryView = self.keyboardToolbar;
        textField.keyboardType =  UIKeyboardTypeDefault;
        [[HJMCustomTextField appearance] setTintColor:[UIColor colorWithRed:0.98 green:0.58 blue:0.65 alpha:1]];
        [self.view addSubview:textField];
    }
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(54, 175, 207, 34);
    [button setBackgroundImage:LOADIMAGE(@"gj_kscs_btn_img", kImageTypePNG) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 101;
    [self.view addSubview:button];
    
    for (int i=0; i<2; i++) {
        UIImageView * resultsImg = [[UIImageView alloc] init];
        resultsImg.frame = CGRectMake(14, 220 + i*45, 292, 40);
        resultsImg.backgroundColor = [UIColor clearColor];
        resultsImg.image = LOADIMAGE(@"gj_babyyc_bg_img", kImageTypePNG);
        [self.view addSubview:resultsImg];
    }
    
    for (int i=0; i<2; i++) {
        UILabel * title = [[UILabel alloc] init];
        title.frame = CGRectMake(25, 226 + i*45, 200, 30);
        title.backgroundColor = [UIColor clearColor];
        title.text = [titleArr objectAtIndex:2+i];
        [self.view addSubview:title];
    }
    
    for (int i=0; i<2; i++) {
        UILabel * displayResults = [[UILabel alloc] init];
        displayResults.tag = 301 + i;
        displayResults.frame = CGRectMake(170 + i*16, 226 + i*45, 140 - i*16, 30);
        displayResults.backgroundColor = [UIColor clearColor];
        [self.view addSubview:displayResults];
    }
    
    UILabel * text = [[UILabel alloc] initWithFrame:CGRectMake(8, 205, [UtilityFunc shareInstance].globleWidth - 11, 320)];
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

- (void)cancelMethod:(id)sender {
    for (int i=0; i<2; i++) {
        [((HJMCustomTextField *)[self.view viewWithTag:201 +i]) resignFirstResponder];
    }
}

- (void)doneMethod:(id)sender {
    for (int i=0; i<2; i++) {
        [((HJMCustomTextField *)[self.view viewWithTag:201 +i]) resignFirstResponder];
    }
}

- (void)buttonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 101:{
            if ([[[HJPeriodSwitchDueDate getBabyBloodTypeWithFatherType:((HJMCustomTextField *)[self.view viewWithTag:201]).text WithMotherType:((HJMCustomTextField *)[self.view viewWithTag:202]).text] objectForKey:@"impossibility"] isEqualToString:@"-1"] || [[[HJPeriodSwitchDueDate getBabyBloodTypeWithFatherType:((HJMCustomTextField *)[self.view viewWithTag:201]).text WithMotherType:((HJMCustomTextField *)[self.view viewWithTag:202]).text] objectForKey:@"maybe"] isEqualToString:@"-1"]) {
                
                NSLog(@"用户输入的血型有误");
                return ;
            }
            
            ((UILabel *)[self.view viewWithTag:301]).text = [[HJPeriodSwitchDueDate getBabyBloodTypeWithFatherType:((HJMCustomTextField *)[self.view viewWithTag:201]).text WithMotherType:((HJMCustomTextField *)[self.view viewWithTag:202]).text] objectForKey:@"maybe"];
            
            ((UILabel *)[self.view viewWithTag:302]).text = [[HJPeriodSwitchDueDate getBabyBloodTypeWithFatherType:((HJMCustomTextField *)[self.view viewWithTag:201]).text WithMotherType:((HJMCustomTextField *)[self.view viewWithTag:202]).text] objectForKey:@"impossibility"];
            break;
        }
            
        default:
            break;
    }
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
