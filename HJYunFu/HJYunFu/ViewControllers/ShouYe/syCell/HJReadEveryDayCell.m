//
//  HJReadEveryDayCell.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-11.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJReadEveryDayCell.h"

@implementation HJReadEveryDayCell
@synthesize leftTitle = _leftTitle,upline = _upline, downline = _downline, yellowRound = _yellowRound, bg = _bg, mtitle = _mtitle,subtitle = _subtitle, arrowImg = _arrowImg;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 60, 60)];
        _leftTitle.text = @"每日\n必读";
        _leftTitle.userInteractionEnabled = YES;
        _leftTitle.numberOfLines = 2;
        _leftTitle.textColor = [UIColor colorWithRed:0.98 green:0.14 blue:0.33 alpha:1];
        _leftTitle.backgroundColor = [UIColor clearColor];
        _leftTitle.font = LANTING_FONT(15.5);
        [self.contentView addSubview:_leftTitle];
        
        _upline = [[UIImageView alloc] initWithFrame:CGRectMake(58, 0, 1, 27)];
        _upline.backgroundColor = [UIColor clearColor];
        _upline.userInteractionEnabled = YES;
        _upline.image = LOADIMAGE(@"sy_fgx_img@2x", kImageTypePNG);
        [self.contentView addSubview:_upline];
        
        _yellowRound = [[UIImageView alloc] initWithFrame:CGRectMake(53.8, 30, 8, 8)];
        _yellowRound.image = LOADIMAGE(@"sy_yellowRound_img@2x", kImageTypePNG);
        _yellowRound.userInteractionEnabled = YES;
        _yellowRound.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_yellowRound];
        
        _downline = [[UIImageView alloc] initWithFrame:CGRectMake(58, 42, 1, 63)];
        _downline.backgroundColor = [UIColor clearColor];
        _downline.userInteractionEnabled = YES;
        _downline.image = LOADIMAGE(@"sy_fgx_img@2x", kImageTypePNG);
        [self.contentView addSubview:_downline];
        
        _bg = [[UIImageView alloc] initWithFrame:CGRectMake(75, 20, 462/2, 176/2)];
        _bg.backgroundColor = [UIColor clearColor];
        _bg.userInteractionEnabled = YES;
        _bg.image = LOADIMAGE(@"sy_cell_bg_img@2x", kImageTypePNG);
        [self.contentView addSubview:_bg];
        
        _mtitle = [[UILabel alloc] initWithFrame:CGRectMake(85, 23, 462/2 - 30, 30)];
        _mtitle.userInteractionEnabled = YES;
        _mtitle.text = @"什么时候开始补充叶酸？";
        _mtitle.backgroundColor = [UIColor clearColor];
        _mtitle.textColor = [UIColor blackColor];
        _mtitle.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_mtitle];
        
        _subtitle = [[UILabel alloc] initWithFrame:CGRectMake(85, 45, 462/2 - 40, 60)];
        _subtitle.userInteractionEnabled = YES;
        _subtitle.textColor = [UIColor colorWithRed:0.26 green:0.24 blue:0.25 alpha:1];
        _subtitle.text = @"你可能会认为，一旦发现怀孕马上补充叶酸，全程中不中断这样应该够了吧。";
        _subtitle.numberOfLines = 0;
        _subtitle.font = [UIFont systemFontOfSize:14.0];
        _subtitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_subtitle];
        
        _arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(280, 57, 20/2, 26/2)];
        _arrowImg.image = LOADIMAGE(@"sy_cell_arrow_img@2x", kImageTypePNG);
        _arrowImg.backgroundColor = [UIColor clearColor];
        _arrowImg.userInteractionEnabled = YES;
        [self.contentView addSubview:_arrowImg];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
