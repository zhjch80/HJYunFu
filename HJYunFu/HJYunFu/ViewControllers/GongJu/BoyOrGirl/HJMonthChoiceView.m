//
//  HJMonthChoiceView.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-19.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJMonthChoiceView.h"
#import "HJAgeChoiceCell.h"

@interface HJMonthChoiceView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, copy) NSMutableArray * monthArr;

@end

@implementation HJMonthChoiceView
@synthesize monthArr = _monthArr;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImageView * bgImg = [[UIImageView alloc] init];
        bgImg.frame = CGRectMake(0, -500, [UtilityFunc shareInstance].globleWidth, [UtilityFunc shareInstance].globleAllHeight + 1500);
        bgImg.image = LOADIMAGE(@"gj_transparent_bg_img@2x", kImageTypePNG);
        bgImg.userInteractionEnabled = YES;
        bgImg.backgroundColor = [UIColor clearColor];
        [self addSubview:bgImg];
        
        if (!_monthArr) {
            _monthArr = [[NSMutableArray alloc] initWithObjects:@"1月", @"2月", @"3月", @"4月", @"5月", @"6月", @"7月", @"8月", @"9月", @"10月", @"11月", @"12月", nil];
        }
        self.userInteractionEnabled = YES;
        [self loadView];
        
    }
    return self;
}

- (void)loadView {
    UIImageView * bgView = [[UIImageView alloc] init];
    bgView.frame = CGRectMake(163, 155, 151, 248);
    bgView.userInteractionEnabled = YES;
    bgView.backgroundColor = [UIColor clearColor];
    bgView.image = LOADIMAGE(@"gj_ageChoice_bg_img", kImageTypePNG);
    [self addSubview:bgView];
    
    UIImageView * image = [[UIImageView alloc] init];
    image.frame = CGRectMake(276, 132, 17, 23);
    image.backgroundColor = [UIColor clearColor];
    image.userInteractionEnabled = YES;
    image.image = LOADIMAGE(@"gl_select_Y_bg_img", kImageTypePNG);
    [self addSubview:image];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(260, 122, 45, 35);
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    [self addSubview:button];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(3, 8, 151-6, 248-15) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    tableView.alpha = 0.9;
    [bgView addSubview:tableView];
}

#pragma mark - buttonClick Method

- (void)buttonClick:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeAgeChoiceModelView" object:nil];
}

#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier = [NSString stringWithFormat:@"szcell%d",indexPath.row];
    HJAgeChoiceCell * cell = (HJAgeChoiceCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[HJAgeChoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.mtitle.text = [_monthArr objectAtIndex:indexPath.row];
    cell.leftImg.image = LOADIMAGE(@"gj_anniu_white_img", kImageTypePNG);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CUSFileStorage *storage = [CUSFileStorageManager getFileStorage:CURRENTENCRYPTFILE];
    [storage beginUpdates];
    NSString * str = [AESCrypt encrypt:[_monthArr objectAtIndex:indexPath.row] password:PASSWORD];
    [storage setObject:str forKey:PAILUANYUEFEN_KEY];
    [storage endUpdates];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addYueFenMethod" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removeAgeChoiceModelView" object:nil];
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
