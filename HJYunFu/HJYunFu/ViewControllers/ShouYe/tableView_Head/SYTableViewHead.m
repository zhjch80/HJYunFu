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

@end

@implementation SYTableViewHead
@synthesize upView = _upView, downView = _downView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        _upView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UtilityFunc shareInstance].globleWidth, 409/2)];
        _upView.backgroundColor = [UIColor clearColor];
        _upView.image = LOADIMAGE(@"sy_banner_light_bg_img@2x", kImageTypePNG);
        _upView.userInteractionEnabled = YES;
        [self addSubview:_upView];
        
        _downView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _upView.frame.size.height, [UtilityFunc shareInstance].globleWidth, 94/2)];
        _downView.backgroundColor = [UIColor clearColor];
        _downView.image = LOADIMAGE(@"sy_banner_black_bg_img@2x", kImageTypePNG);
        _downView.userInteractionEnabled = YES;
        [self addSubview:_downView];
        
    }
    return self;
}

- (void)loadView {

    
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
