//
//  SYTableViewHead.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-7.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "SYTableViewHead.h"

@interface SYTableViewHead ()
@property (nonatomic, strong) UIImageView * upView;
@property (nonatomic, strong) UIImageView * downView;
@property (nonatomic, copy) NSMutableArray *titleArr;

@end

@implementation SYTableViewHead
@synthesize upView = _upView, downView = _downView,titleArr = _titleArr;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        _upView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, (409 - 50)/2)];
        _upView.backgroundColor = [UIColor clearColor];
        _upView.image = LOADIMAGE(@"sy_banner_light_bg_img@2x", kImageTypePNG);
        _upView.userInteractionEnabled = YES;
        [self addSubview:_upView];
        
        _downView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _upView.frame.size.height, [UtilityFunc shareInstance].globleWidth, 94/2)];
        _downView.backgroundColor = [UIColor clearColor];
        _downView.image = LOADIMAGE(@"sy_banner_black_bg_img@2x", kImageTypePNG);
        _downView.userInteractionEnabled = YES;
        [self addSubview:_downView];
        
        if (!_titleArr){
            _titleArr = [[NSMutableArray alloc] initWithObjects:@"预产期", @"孕周", @"距生产日", nil];
        }
    
        [self loadView];
        
    }
    return self;
}

- (void)loadView {
    //前12周  没有三项数据  文字长点
    
    //有时候 2行  有时候三行
    
    //没有三行数据时候  最多4行
    
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(18, 25, 170, 70)];
    title.backgroundColor = [UIColor clearColor];
    title.numberOfLines = 0;
    title.userInteractionEnabled = YES;
    title.text = @"体重约350g、长19cm胎儿眉眼已清晰可辨,胎儿眉眼已清晰可辨";
    title.font = [UIFont systemFontOfSize:16.0];
    title.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    [_upView addSubview:title];
    
    UILabel * subTitle = [[UILabel alloc] initWithFrame:CGRectMake(18, 69, 200, 100)];
    subTitle.backgroundColor = [UIColor clearColor];
    subTitle.numberOfLines = 0;
    subTitle.userInteractionEnabled = YES;
    subTitle.text = @"双顶径：5.45 ± 0.57\n腹围：16.70 ± 2.23\n股骨长：3.82 ± 0.47";
    subTitle.textColor = [UIColor colorWithRed:0.36 green:0.35 blue:0.35 alpha:1];
    subTitle.font = [UIFont systemFontOfSize:13.5];
    [_upView addSubview:subTitle];
    
    UIImageView * rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(195, 25, 210/2, 250/2)];
    rightImg.userInteractionEnabled = YES;
    rightImg.image = LOADIMAGE(@"sy_head_bg_img@2x", kImageTypePNG);
    rightImg.backgroundColor = [UIColor clearColor];
    [_upView addSubview:rightImg];
    
    UIImageView * headImg = [[UIImageView alloc] initWithFrame:CGRectMake(205, 33, 87, 87)];
    headImg.clipsToBounds = YES;
    headImg.backgroundColor = [UIColor clearColor];
    headImg.userInteractionEnabled = YES;
    headImg.image = LOADIMAGE(@"ceshi@2x", kImageTypePNG);
    [headImg.layer setCornerRadius:87.0/2.0];
    [_upView addSubview:headImg];
    
    UILabel * headTip = [[UILabel alloc] initWithFrame:CGRectMake(223, 125, 60, 20)];
    headTip.text = @"第20周";
    headTip.textColor = [UIColor colorWithRed:0.98 green:0 blue:0.28 alpha:1];
    headTip.font = [UIFont systemFontOfSize:14.0];
    headTip.backgroundColor = [UIColor clearColor];
    [_upView addSubview:headTip];
    
    for (int i=1; i<=2; i++){
        UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(320/3 * i, 15, 1, 94/2 - 30)];
        img.backgroundColor = [UIColor clearColor];
        img.userInteractionEnabled = YES;
        img.image = LOADIMAGE(@"sy_fgx_img@2x", kImageTypePNG);
        [_downView addSubview:img];
    }
        
    for (int i=0; i<3; i++){
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0 + 320/3 * i, 5, 320/3, 20)];
        label.userInteractionEnabled = YES;
        label.text = [_titleArr objectAtIndex:i];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
        label.backgroundColor = [UIColor clearColor];
        [_downView addSubview:label];
    }
    
    for (int i=0; i<3; i++){
        NSMutableArray * arr = [[NSMutableArray alloc] initWithObjects:@"2015年3月24日", @"20周+4天", @"192", nil];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0 + 320/3 * i, 25, 320/3, 20)];
        label.userInteractionEnabled = YES;
        label.tag = 100+i;
        label.text = [arr objectAtIndex:i];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13.5];
        label.textColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
        label.backgroundColor = [UIColor clearColor];
        [_downView addSubview:label];
    }

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
