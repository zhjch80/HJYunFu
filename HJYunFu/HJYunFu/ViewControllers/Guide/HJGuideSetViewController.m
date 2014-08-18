//
//  HJGuideSetViewController.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-4.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJGuideSetViewController.h"
#import "HJMCustomTextField.h"
#import "HJPeriodSwitchDueDate.h"

#define SelectPromptWords_1_TAG                 101
#define SelectPromptWords_2_TAG                 102
#define datePicker_1_TAG                        103
#define datePicker_2_TAG                        104
#define arrowImg_1_TAG                          105
#define arrowImg_2_TAG                          106
#define successTip_1_TAG                        107
#define successTip_2_TAG                        108
#define nextBtn_TAG                             109

#define lastMenstrualPeriodFirstResponder       @"lastMenstrualPeriod"
#define dueDateFromFirstResponder               @"dueDate"

@interface HJGuideSetViewController (){
    UIToolbar *keyboardToolbar_;

}
@property (nonatomic, strong) NSString * firstResponderType;
@property (nonatomic, strong) UIToolbar *keyboardToolbar;
@property (nonatomic, strong) UIDatePicker * datePicker_1;
@property (nonatomic, strong) UIDatePicker * datePicker_2;

@end

@implementation HJGuideSetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kFirstLaunch];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    
    UIImageView * topImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, 64)];
    topImg.backgroundColor = [UIColor clearColor];
    topImg.image = LOADIMAGE(@"xz_top_img@2x", kImageTypePNG);
    [self.view addSubview:topImg];
    
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, [UtilityFunc shareInstance].globleWidth, 44)];
    title.backgroundColor = [UIColor clearColor];
    title.text = @"预产期设置";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.font = LANTING_FONT(22);
    [topImg addSubview:title];
    
    UIImageView * selectImg_1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 593/2, 78/2)];
    selectImg_1.image = LOADIMAGE(@"xz_dueDate_select_img@2x", kImageTypePNG);
    [self.view addSubview:selectImg_1];

    UIImageView * arrowImg_1 = [[UIImageView alloc] initWithFrame:CGRectMake(290, 95, 14/2, 16/2)];
    arrowImg_1.tag = arrowImg_1_TAG;
    arrowImg_1.image = LOADIMAGE(@"xz_dueDate_selectArrow_img@2x", kImageTypePNG);
    [self.view addSubview:arrowImg_1];
    
    UILabel * successTip_1 = [[UILabel alloc] initWithFrame:CGRectMake(210, 85, 90, 30)];
    successTip_1.tag = successTip_1_TAG;
    successTip_1.hidden = YES;
    successTip_1.backgroundColor = [UIColor clearColor];
    successTip_1.text = @"末次月经期";
    successTip_1.textAlignment = NSTextAlignmentRight;
    successTip_1.font = [UIFont systemFontOfSize:16.5];//LANTING_FONT(15.0);
    successTip_1.textColor = [UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1];
    [self.view addSubview:successTip_1];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-mm-dd"];
    NSDate* leftminDate = [formatter dateFromString:@"0001-01-01 00:00:00"];
    NSDate* leftmaxDate = [formatter dateFromString:@"4000-01-01 00:00:00"];
    
    self.datePicker_1 = [[UIDatePicker alloc]init];
    self.datePicker_1.tag = datePicker_1_TAG;
    self.datePicker_1.backgroundColor = [UIColor whiteColor];
    self.datePicker_1.minimumDate = leftminDate;
    self.datePicker_1.maximumDate = leftmaxDate;
    [self.datePicker_1 addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.datePicker_1.datePickerMode = UIDatePickerModeDate;
    
    self.datePicker_2 = [[UIDatePicker alloc]init];
    self.datePicker_2.tag = datePicker_2_TAG;
    self.datePicker_2.backgroundColor = [UIColor whiteColor];
    self.datePicker_2.minimumDate = leftminDate;
    self.datePicker_2.maximumDate = leftmaxDate;
    [self.datePicker_2 addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.datePicker_2.datePickerMode = UIDatePickerModeDate;
    
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
    
    HJMCustomTextField * SelectPromptWords_1 = [[HJMCustomTextField alloc] initWithFrame:CGRectMake(20, 80, 270, 78/2)];
    SelectPromptWords_1.delegate = self;
    SelectPromptWords_1.tag = SelectPromptWords_1_TAG;
    SelectPromptWords_1.backgroundColor = [UIColor clearColor];
    SelectPromptWords_1.text = @"末次月经期";
    SelectPromptWords_1.textColor = [UIColor blackColor];
    SelectPromptWords_1.font = [UIFont systemFontOfSize:16.5];//LANTING_FONT(20);
    SelectPromptWords_1.inputView = self.datePicker_1;
    SelectPromptWords_1.inputAccessoryView = self.keyboardToolbar;
    [[HJMCustomTextField appearance] setTintColor:[UIColor colorWithRed:0.98 green:0.58 blue:0.65 alpha:1]];
    [self.view addSubview:SelectPromptWords_1];
    
    UILabel * tip = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 593/2, 78/2)];
    tip.backgroundColor = [UIColor clearColor];
    tip.text = @"如果您不记得末次月经期，请在下面输入框中输入您的预产期";
    tip.font = LANTING_FONT(14.0);
    tip.numberOfLines = 2;
    tip.textColor = [UIColor colorWithRed:0.69 green:0.69 blue:0.69 alpha:1];
    [self.view addSubview:tip];

    UIImageView * selectImg_2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 170, 593/2, 78/2)];
    selectImg_2.image = LOADIMAGE(@"xz_dueDate_select_img@2x", kImageTypePNG);
    [self.view addSubview:selectImg_2];
    
    UIImageView * arrowImg_2 = [[UIImageView alloc] initWithFrame:CGRectMake(290, 185, 14/2, 16/2)];
    arrowImg_2.tag = arrowImg_2_TAG;
    arrowImg_2.image = LOADIMAGE(@"xz_dueDate_selectArrow_img@2x", kImageTypePNG);
    [self.view addSubview:arrowImg_2];
    
    UILabel * successTip_2 = [[UILabel alloc] initWithFrame:CGRectMake(220, 175, 80, 30)];
    successTip_2.tag = successTip_2_TAG;
    successTip_2.hidden = YES;
    successTip_2.backgroundColor = [UIColor clearColor];
    successTip_2.text = @"预产期";
    successTip_2.textAlignment = NSTextAlignmentRight;
    successTip_2.font = [UIFont systemFontOfSize:16.5];//LANTING_FONT(15.0);
    successTip_2.textColor = [UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1];
    [self.view addSubview:successTip_2];
    
    HJMCustomTextField * SelectPromptWords_2 = [[HJMCustomTextField alloc] initWithFrame:CGRectMake(20, 170, 270, 78/2)];
    SelectPromptWords_2.delegate = self;
    SelectPromptWords_2.tag = SelectPromptWords_2_TAG;
    SelectPromptWords_2.backgroundColor = [UIColor clearColor];
    SelectPromptWords_2.text = @"预产期";
    SelectPromptWords_2.textColor = [UIColor blackColor];
    SelectPromptWords_2.font = [UIFont systemFontOfSize:16.5];//LANTING_FONT(20);
    SelectPromptWords_2.inputView = self.datePicker_2;
    SelectPromptWords_2.inputAccessoryView = self.keyboardToolbar;
    [[HJMCustomTextField appearance] setTintColor:[UIColor colorWithRed:0.98 green:0.58 blue:0.65 alpha:1]];
    [self.view addSubview:SelectPromptWords_2];
    
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.hidden = YES;
    nextBtn.frame = CGRectMake(55, 240, 204, 34);
    [nextBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.tag = nextBtn_TAG;
    [nextBtn setBackgroundImage:LOADIMAGE(@"xz_nextBtn_img", kImageTypePNG) forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
    
}

- (void)buttonClick:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SwitchoverRootViewControllerMethod" object:nil];
}

- (void)datePickerValueChanged:(UIDatePicker *)datePic {
//    NSDate * _date = datePic.date;
//    NSString * dateStr = [[NSString stringWithFormat:@"%@",_date] substringToIndex:10];
//    
//    switch (datePic.tag) {
//        case datePicker_1_TAG:{
//            HJMCustomTextField * SelectPromptWords_1 = (HJMCustomTextField *)[self.view viewWithTag:SelectPromptWords_1_TAG];
//            HJMCustomTextField * SelectPromptWords_2 = (HJMCustomTextField *)[self.view viewWithTag:SelectPromptWords_2_TAG];
//            
//            SelectPromptWords_1.text = dateStr;
//            SelectPromptWords_2.text = [HJPeriodSwitchDueDate dueDateFromLastMenstrualPeriod:dateStr];
//            break;
//        }
//        case datePicker_2_TAG:{
//            HJMCustomTextField * SelectPromptWords_1 = (HJMCustomTextField *)[self.view viewWithTag:SelectPromptWords_1_TAG];
//            HJMCustomTextField * SelectPromptWords_2 = (HJMCustomTextField *)[self.view viewWithTag:SelectPromptWords_2_TAG];
//            
//            SelectPromptWords_1.text = [HJPeriodSwitchDueDate lastMenstrualPeriodFromDueDate:dateStr];
//            SelectPromptWords_2.text = dateStr;
//            break;
//        }
//            
//        default:
//            break;
//    }
//    [self rightMarkSwitch];
}

#pragma mark - keyboardToolbar Method

- (void)cancelMethod:(id)sender {
    for (int i=1; i<=2; i++){
        UITextField * textfield = (UITextField *)[self.view viewWithTag:100+i];
        [textfield resignFirstResponder];
    }
    
    if ([((UITextField *)[self.view viewWithTag:101]).text isEqualToString:@"末次月经期"]){
        ((UIImageView *)[self.view viewWithTag:arrowImg_1_TAG]).hidden = NO;
        ((UIImageView *)[self.view viewWithTag:arrowImg_2_TAG]).hidden = NO;
    }
    
    if ([((UITextField *)[self.view viewWithTag:102]).text isEqualToString:@"预产期"]){
        ((UIImageView *)[self.view viewWithTag:arrowImg_1_TAG]).hidden = NO;
        ((UIImageView *)[self.view viewWithTag:arrowImg_2_TAG]).hidden = NO;
    }
}

- (void)doneMethod:(id)sender {
    for (int i=1; i<=2; i++){
        UITextField * textfield = (UITextField *)[self.view viewWithTag:100+i];
        [textfield resignFirstResponder];
    }
    HJMCustomTextField * SelectPromptWords_1 = (HJMCustomTextField *)[self.view viewWithTag:SelectPromptWords_1_TAG];
    HJMCustomTextField * SelectPromptWords_2 = (HJMCustomTextField *)[self.view viewWithTag:SelectPromptWords_2_TAG];

    if ([self.firstResponderType isEqualToString:lastMenstrualPeriodFirstResponder]){
        NSDate * _date = self.datePicker_1.date;
        NSString * dateStr = [[NSString stringWithFormat:@"%@",_date] substringToIndex:10];
        SelectPromptWords_1.text = dateStr;
        SelectPromptWords_2.text = [HJPeriodSwitchDueDate dueDateFromLastMenstrualPeriod:dateStr];
        [self rightMarkSwitch];
    }else{
        NSDate * _date = self.datePicker_2.date;
        NSString * dateStr = [[NSString stringWithFormat:@"%@",_date] substringToIndex:10];
        SelectPromptWords_1.text = [HJPeriodSwitchDueDate lastMenstrualPeriodFromDueDate:dateStr];
        SelectPromptWords_2.text = dateStr;
        [self rightMarkSwitch];
    }
    
    CUSFileStorage *storage = [CUSFileStorageManager getFileStorage:CURRENTENCRYPTFILE];
    [storage beginUpdates];
    NSString * str_1 = [AESCrypt encrypt:SelectPromptWords_1.text password:PASSWORD];
    NSString * str_2 = [AESCrypt encrypt:SelectPromptWords_2.text password:PASSWORD];
    [storage setObject:str_1 forKey:MOCIYUEJINGQI_KEY];
    [storage setObject:str_2 forKey:YUCHANQI_KEY];
    [storage endUpdates];
}

#pragma mark - 切换

- (void)rightMarkSwitch {
    ((UIImageView *)[self.view viewWithTag:arrowImg_1_TAG]).hidden = YES;
    ((UIImageView *)[self.view viewWithTag:arrowImg_2_TAG]).hidden = YES;
    ((UILabel *)[self.view viewWithTag:successTip_1_TAG]).hidden = NO;
    ((UILabel *)[self.view viewWithTag:successTip_2_TAG]).hidden = NO;
    ((UIButton *)[self.view viewWithTag:nextBtn_TAG]).hidden = NO;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == SelectPromptWords_1_TAG){
        self.firstResponderType = lastMenstrualPeriodFirstResponder;
        if ([textField.text isEqualToString:@"末次月经期"]){
            textField.text = @"";
            textField.placeholder = @"末次月经期";
            UIImageView * arrowImg_1 = (UIImageView *)[self.view viewWithTag:arrowImg_1_TAG];
            UIImageView * arrowImg_2 = (UIImageView *)[self.view viewWithTag:arrowImg_2_TAG];
            arrowImg_1.hidden = YES;
            arrowImg_2.hidden = NO;
        }
    }else if (textField.tag == SelectPromptWords_2_TAG){
        self.firstResponderType = dueDateFromFirstResponder;
        if ([textField.text isEqualToString:@"预产期"]){
            textField.text = @"";
            textField.placeholder = @"预产期";
            UIImageView * arrowImg_1 = (UIImageView *)[self.view viewWithTag:arrowImg_1_TAG];
            UIImageView * arrowImg_2 = (UIImageView *)[self.view viewWithTag:arrowImg_2_TAG];
            arrowImg_1.hidden = NO;
            arrowImg_2.hidden = YES;
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == SelectPromptWords_1_TAG){
        if ([textField.text isEqualToString:@""]){
            textField.text = @"末次月经期";
        }
    }else if (textField.tag == SelectPromptWords_2_TAG){
        if ([textField.text isEqualToString:@""]){
            textField.text = @"预产期";
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
