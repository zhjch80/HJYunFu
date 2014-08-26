//
//  HJBabyHeightPredictionViewController.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-6.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJBabyHeightPredictionViewController.h"
#import "HJMCustomTextField.h"
#import "HJPeriodSwitchDueDate.h"

@interface HJBabyHeightPredictionViewController ()<UIGestureRecognizerDelegate,UINavigationBarDelegate,UITextFieldDelegate> {
    BOOL isSelectBoy;
    BOOL isSelectGirl;
    
    NSInteger sexValue;  // 1为男孩  2为女孩  0没有选
}
@property (nonatomic, strong) UIToolbar *keyboardToolbar;

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
 scr 101
textField tag 201
 button 501
 img tag 301 302
 性别选择 button 401 402
 displayResults tag 601
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];

    [self loadNavBarWithTitle:@"宝宝身高预测"];
    
    isSelectBoy = NO;
    isSelectGirl = NO;
    sexValue = 0;
    
    UIScrollView * scr = [[UIScrollView alloc] init];
    scr.userInteractionEnabled = YES;
    scr.tag = 101;
    scr.frame = CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, [UtilityFunc shareInstance].globleAllHeight + 49);
    scr.contentSize = CGSizeMake([UtilityFunc shareInstance].globleWidth, 490);
    scr.pagingEnabled = NO;
    [self.view addSubview:scr];
    
    UIImageView * bgImg = [[UIImageView alloc] init];
    bgImg.frame = CGRectMake(14, 15, 292, 125);
    bgImg.image = LOADIMAGE(@"gj_babysgyc_bg_img", kImageTypePNG);
    bgImg.userInteractionEnabled = YES;
    bgImg.backgroundColor = [UIColor clearColor];
    [scr addSubview:bgImg];
    
    NSArray * titleArr = [[NSArray alloc] initWithObjects:@"父亲身高:", @"母亲身高:", @"孩子性别:", @"厘米(cm)", nil];
    for (int i=0; i<3; i++) {
        UILabel * title = [[UILabel alloc] init];
        title.frame = CGRectMake(23, 21 + i*41, 80, 30);
        title.text = [titleArr objectAtIndex:i];
        title.userInteractionEnabled = YES;
        title.backgroundColor = [UIColor clearColor];
        [scr addSubview:title];
    }
    
    for (int i=0; i<2; i++) {
        UILabel * title = [[UILabel alloc] init];
        title.frame = CGRectMake(230, 21 + i*41, 80, 30);
        title.text = [titleArr objectAtIndex:3];
        title.userInteractionEnabled = YES;
        title.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1];
        title.backgroundColor = [UIColor clearColor];
        [scr addSubview:title];
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
        textField.frame = CGRectMake(100, 21 + i*41, 110, 30);
        textField.delegate = self;
        textField.tag = 201 + i;
        textField.backgroundColor = [UIColor clearColor];
        textField.placeholder = @"请输入身高";
        textField.text = @"";
        textField.textColor = [UIColor blackColor];
        textField.font = [UIFont systemFontOfSize:16.5];
        textField.inputAccessoryView = self.keyboardToolbar;
        textField.keyboardType =  UIKeyboardTypeDecimalPad;
        [[HJMCustomTextField appearance] setTintColor:[UIColor colorWithRed:0.98 green:0.58 blue:0.65 alpha:1]];
        [scr addSubview:textField];
    }
    
    NSArray * arr = [[NSArray alloc] initWithObjects:@"男", @"女", nil];
    for (int i=0; i<2; i++) {
        UIImageView * img = [[UIImageView alloc] init];
        img.userInteractionEnabled = YES;
        img.frame = CGRectMake(120 + i*80, 110, 15, 15);
        img.tag = 301 + i;
        img.image = LOADIMAGE(@"gj_anniu_white_img", kImageTypePNG);
        img.backgroundColor = [UIColor clearColor];
        img.userInteractionEnabled = YES;
        [scr addSubview:img];
        
        UILabel * label = [[UILabel alloc] init];
        label.userInteractionEnabled = YES;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1];
        label.frame = CGRectMake(150 + i*80, 102, 30, 30);
        label.text = [arr objectAtIndex:i];
        [scr addSubview:label];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(110 + i*90, 98, 90, 40);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 401 +i;
        button.backgroundColor = [UIColor clearColor];
        [scr addSubview:button];
    }
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(55, 160, 207, 34);
    [button setBackgroundImage:LOADIMAGE(@"gj_kscs_btn_img", kImageTypePNG) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 501;
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
    
    UILabel * displayResults = [[UILabel alloc] init];
    displayResults.frame = CGRectMake(145, 215, 200, 30);
    displayResults.tag = 601;
    displayResults.backgroundColor = [UIColor clearColor];
    displayResults.font = [UIFont systemFontOfSize:16.0];
    [scr addSubview:displayResults];
    
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

- (void)cancelMethod:(id)sender {
    for (int i=0; i<2; i++) {
        [((HJMCustomTextField *)[self.view viewWithTag:201 +i]) resignFirstResponder];
    }
}

- (void)doneMethod:(id)sender {
    for (int i=0; i<2; i++) {
        [((HJMCustomTextField *)[self.view viewWithTag:201 +i]) resignFirstResponder];
    }
    
    //判断输入内容格式的正确性
}
/**
 判断条件
 1.身高上限240.0,下限100； 2. 并且不多于两个点  3判断空
 */
- (void)buttonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 501:{
            NSString * sexStr = [[NSString alloc] init];
            
            if (sexValue == 0){
                NSLog(@"没有选");
                return ;
            }else if (sexValue == 1){
                NSLog(@"boy");
                sexStr = @"男";
            }else if (sexValue == 2){
                NSLog(@"girl");
                sexStr = @"女";
            }
            
            if ([((HJMCustomTextField *)[self.view viewWithTag:201]).text isEqualToString:@""]) {
                NSLog(@"没有选身高 1");
                return ;
            }
            
            if ([((HJMCustomTextField *)[self.view viewWithTag:202]).text isEqualToString:@""]) {
                NSLog(@"没有选身高 2");
                return ;
            }

            if ([self rangesOfString:@"." inString:((HJMCustomTextField *)[self.view viewWithTag:201]).text] >= 2){
                NSLog(@"身高1 格式不正确");
                return ;
            }else{
                NSLog(@"1格式正确");
            }
            
            if ([self rangesOfString:@"." inString:((HJMCustomTextField *)[self.view viewWithTag:202]).text] >= 2){
                NSLog(@"身高2 格式不正确");
                return ;
            }else{
                NSLog(@"2格式正确");
            }
             
            if (((HJMCustomTextField *)[self.view viewWithTag:201]).text.integerValue >= 100.0 && ((HJMCustomTextField *)[self.view viewWithTag:201]).text.integerValue <= 240.0){
                NSLog(@"text1 符合范围");
            }else{
                NSLog(@"text1 不符合范围");
                return ;
            }
            
            if (((HJMCustomTextField *)[self.view viewWithTag:202]).text.integerValue >= 100.0 && ((HJMCustomTextField *)[self.view viewWithTag:202]).text.integerValue <= 240.0){
                NSLog(@"text2 符合范围");
            }else{
                NSLog(@"text2 不符合范围");
                return;
            }
            
            NSString * Min_H = [NSString stringWithFormat:@"%@",[[HJPeriodSwitchDueDate getBabyHeightWithFatherHeight:((HJMCustomTextField *)[self.view viewWithTag:201]).text WithMotherHeight:((HJMCustomTextField *)[self.view viewWithTag:202]).text WithGender:sexStr] objectForKey:@"babyHeight_MIN"]];
            
            NSString * Max_H = [NSString stringWithFormat:@"%@",[[HJPeriodSwitchDueDate getBabyHeightWithFatherHeight:((HJMCustomTextField *)[self.view viewWithTag:201]).text WithMotherHeight:((HJMCustomTextField *)[self.view viewWithTag:202]).text WithGender:sexStr] objectForKey:@"babyHeight_MAX"]];
            
            Min_H = [Min_H substringToIndex:5];
            
            Max_H = [Max_H substringToIndex:5];

            NSString * displayResults = [NSString stringWithFormat:@"在%@和%@之间",Min_H,Max_H];
            
            ((UILabel *)[self.view viewWithTag:601]).text = displayResults;
            break;
        }
        case 401:{
            UIImageView * image_boy = (UIImageView *)[(UIScrollView *)[self.view viewWithTag:101] viewWithTag:301];
            UIImageView * image_girl = (UIImageView *)[(UIScrollView *)[self.view viewWithTag:101] viewWithTag:302];

            if (isSelectBoy){
                image_boy.image = LOADIMAGE(@"gj_anniu_white_img", kImageTypePNG);
                image_girl.image = LOADIMAGE(@"gj_anniu_red_img", kImageTypePNG);

                isSelectBoy = NO;
                isSelectGirl = YES;
                sexValue = 2;
            }else{
                image_boy.image = LOADIMAGE(@"gj_anniu_red_img", kImageTypePNG);
                image_girl.image = LOADIMAGE(@"gj_anniu_white_img", kImageTypePNG);
                isSelectBoy = YES;
                isSelectGirl = NO;
                sexValue = 1;
            }
            break;
        }
        case 402:{
            UIImageView * image_boy = (UIImageView *)[(UIScrollView *)[self.view viewWithTag:101] viewWithTag:301];
            UIImageView * image_girl = (UIImageView *)[(UIScrollView *)[self.view viewWithTag:101] viewWithTag:302];

            if (isSelectGirl){
                image_girl.image = LOADIMAGE(@"gj_anniu_white_img", kImageTypePNG);
                image_boy.image = LOADIMAGE(@"gj_anniu_red_img", kImageTypePNG);
                isSelectBoy = YES;
                isSelectGirl = NO;
                sexValue = 1;
            }else{
                image_girl.image = LOADIMAGE(@"gj_anniu_red_img", kImageTypePNG);
                image_boy.image = LOADIMAGE(@"gj_anniu_white_img", kImageTypePNG);
                isSelectBoy = NO;
                isSelectGirl = YES;
                sexValue = 2;
            }
            break;
        }
            
        default:
            break;
    }
}

/**
 判断“.” 在字符串中出现的次数 results 对象是“.” 在str的位置
 */
- (NSInteger)rangesOfString:(NSString *)searchString inString:(NSString *)str {
    NSMutableArray *results = [NSMutableArray array];
    NSRange searchRange = NSMakeRange(0, [str length]);
    NSRange range;
    while ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        [results addObject:[NSValue valueWithRange:range]];
        searchRange = NSMakeRange(NSMaxRange(range), [str length] - NSMaxRange(range));
    }
    return [results count];
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
