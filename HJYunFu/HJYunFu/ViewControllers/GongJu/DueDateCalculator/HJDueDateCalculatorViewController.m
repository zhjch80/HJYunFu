//
//  HJDueDateCalculatorViewController.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-6.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJDueDateCalculatorViewController.h"
#import "HJMCustomTextField.h"

@interface HJDueDateCalculatorViewController ()<UIGestureRecognizerDelegate,UINavigationBarDelegate>{
    UIToolbar *keyboardToolbar_;

}
@property (nonatomic, strong) UIDatePicker * datePicker_1;
@property (nonatomic, strong) UIToolbar *keyboardToolbar;

@end

@implementation HJDueDateCalculatorViewController
@synthesize datePicker_1 = _datePicker_1;

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
 剪头的tag 101
 textfield 201  时间选择 301
 tip 401 402
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];

    [self loadNavBarWithTitle:@"预产期计算器"];
    
    UIScrollView * scr = [[UIScrollView alloc] init];
    scr.frame = CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, 450);
//    scr.contentSize = CGSizeMake([UtilityFunc shareInstance].globleWidth, 450);
    scr.pagingEnabled = NO;
    scr.bounces = NO;
    [self.view addSubview:scr];
    
    for (int i=0; i<2; i++) {
        UIImageView * bgImg = [[UIImageView alloc] init];
        bgImg.frame = CGRectMake(12, 10 + i*60, 296, 39);
        bgImg.image = LOADIMAGE(@"xz_dueDate_select_img", kImageTypePNG);
        [scr addSubview:bgImg];
    }
    
    UIImageView * arrImg = [[UIImageView alloc] init];
    arrImg.frame = CGRectMake(290, 27, 7, 8);
    arrImg.tag = 101;
    arrImg.image = LOADIMAGE(@"xz_dueDate_selectArrow_img@2x", kImageTypePNG);
    [scr addSubview:arrImg];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-mm-dd"];
    NSDate* leftminDate = [formatter dateFromString:@"0001-01-01 00:00:00"];
    NSDate* leftmaxDate = [formatter dateFromString:@"4000-01-01 00:00:00"];
    
    self.datePicker_1 = [[UIDatePicker alloc]init];
    self.datePicker_1.tag = 301;
    self.datePicker_1.backgroundColor = [UIColor whiteColor];
    self.datePicker_1.minimumDate = leftminDate;
    self.datePicker_1.maximumDate = leftmaxDate;
    [self.datePicker_1 addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.datePicker_1.datePickerMode = UIDatePickerModeDate;
    
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
    
    HJMCustomTextField * SelectPromptWords_1 = [[HJMCustomTextField alloc] initWithFrame:CGRectMake(20, 10, 270, 39)];
    SelectPromptWords_1.delegate = self;
    SelectPromptWords_1.tag = 201;
    SelectPromptWords_1.backgroundColor = [UIColor clearColor];
    SelectPromptWords_1.text = @"末次月经期";
    SelectPromptWords_1.textColor = [UIColor blackColor];
    SelectPromptWords_1.font = [UIFont systemFontOfSize:16.5];
    SelectPromptWords_1.inputView = self.datePicker_1;
    SelectPromptWords_1.inputAccessoryView = self.keyboardToolbar;
    [[HJMCustomTextField appearance] setTintColor:[UIColor colorWithRed:0.98 green:0.58 blue:0.65 alpha:1]];
    [scr addSubview:SelectPromptWords_1];

    UILabel * SelectPromptWords_2 = [[UILabel alloc] init];
    SelectPromptWords_2.tag = 202;
    SelectPromptWords_2.frame = CGRectMake(20, 70, 270, 39);
    SelectPromptWords_2.text = @"预产期";
    SelectPromptWords_2.font = [UIFont systemFontOfSize:16.5];
    SelectPromptWords_2.textColor = [UIColor blackColor];
    [scr addSubview:SelectPromptWords_2];
    
    NSArray * tipArr = [[NSArray alloc] initWithObjects:@"末次月经期", @"预产期", nil];
    for (int i=0; i<2; i++) {
        UILabel * tip = [[UILabel alloc] init];
        tip.text = [tipArr objectAtIndex:i];
        tip.hidden = YES;
        tip.tag = 401+i;
        tip.textAlignment = NSTextAlignmentRight;
        tip.textColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1];
        tip.frame = CGRectMake(210, 15 + i*60, 90, 30);
        [scr addSubview:tip];
    }

    UILabel * text = [[UILabel alloc] initWithFrame:CGRectMake(8, 105, [UtilityFunc shareInstance].globleWidth - 16, 280)];
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
    text.attributedText = [[NSAttributedString alloc] initWithString:@"整个孕期约为40周，即9个月零7天左右（280天），通过末次月经时间可以推算预产期。推算方法是按末次月经时间的第一日算起，月份减3或者加9，日数加7。但是实际分娩日期与推算的预产期可能会相差1～2周，如果孕妇的末次月经期记忆不清楚或月经不准，就需要医生代为测算预产期。" attributes:ats];
    text.textColor = [UIColor colorWithRed:0.49 green:0.49 blue:0.49 alpha:1];
    [scr addSubview:text];
}

- (void)datePickerValueChanged:(UIDatePicker *)datePic {
}

- (void)cancelMethod:(id)sender {
    [(UITextField *)[self.view viewWithTag:201] resignFirstResponder];
}

- (void)doneMethod:(id)sender {
    [(UITextField *)[self.view viewWithTag:201] resignFirstResponder];
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

- (void)backUpClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.text = @"";
    textField.placeholder = @"末次月经期";
    ((UIImageView *)[self.view viewWithTag:101]).hidden = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]){
        textField.text = @"末次月经期";
        ((UIImageView *)[self.view viewWithTag:101]).hidden = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
