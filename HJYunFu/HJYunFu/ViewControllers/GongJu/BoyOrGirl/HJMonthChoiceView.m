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
        
        if (!_monthArr) {
            _monthArr = [[NSMutableArray alloc] initWithObjects:@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月", nil];
        }
        self.userInteractionEnabled = YES;
        [self loadView];
        
    }
    return self;
}

- (void)loadView {
    UIImageView * bgView = [[UIImageView alloc] init];
    bgView.frame = CGRectMake(163, 110, 151, 248);
    bgView.userInteractionEnabled = YES;
    bgView.backgroundColor = [UIColor clearColor];
    bgView.image = LOADIMAGE(@"gj_ageChoice_bg_img", kImageTypePNG);
    [self addSubview:bgView];
    
    UIImageView * image = [[UIImageView alloc] init];
    image.frame = CGRectMake(276, 87, 17, 23);
    image.backgroundColor = [UIColor clearColor];
    image.userInteractionEnabled = YES;
    image.image = LOADIMAGE(@"gl_select_Y_bg_img", kImageTypePNG);
    [self addSubview:image];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(260, 77, 45, 35);
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    [self addSubview:button];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(3, 8, 151-6, 248-15) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.backgroundColor = [UIColor whiteColor];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
