//
//  SYTableViewFoot.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-7.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "SYTableViewFoot.h"

@interface SYTableViewFoot ()
@property (nonatomic, strong) NSMutableArray * imgArr;

@end

@implementation SYTableViewFoot
@synthesize imgArr = _imgArr;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _imgArr = [[NSMutableArray alloc] initWithObjects:@"sy_score_btn_img", @"sy_share_btn_img", @"sy_feedback_btn_ing", nil];
        self.userInteractionEnabled = YES;
        [self loadView];
    }
    return self;
}

- (void)loadView {    
    UIImageView * bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, 197/2)];
    bg.backgroundColor = [UIColor clearColor];
    bg.userInteractionEnabled = YES;
    bg.image = LOADIMAGE(@"sy_btns_bg_img@2x", kImageTypePNG);
    [self addSubview:bg];
    
    for (int i=0; i<3; i++){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 101 + i;
        btn.frame = CGRectMake([UtilityFunc shareInstance].globleWidth/3 * i + 18, 11, 68, 68);
        [btn setBackgroundImage:LOADIMAGE([_imgArr objectAtIndex:i], kImageTypePNG) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setAdjustsImageWhenHighlighted:NO];
        [self addSubview:btn];
    }
}

- (void)buttonClick:(UIButton *)sender {
    [self.delegate btnsClickEvent:sender.tag];
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
