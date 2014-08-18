//
//  HJForbiddenToEatCell.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-11.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJForbiddenToEatCell.h"

@implementation HJForbiddenToEatCell
@synthesize leftTitle = _leftTitle,upline = _upline, downline = _downline, yellowRound = _yellowRound;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 60, 60)];
        _leftTitle.text = @"孕妇\n禁吃";
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
        _yellowRound.image = LOADIMAGE(@"sy_ yellowRound_img@2x", kImageTypePNG);
        _yellowRound.userInteractionEnabled = YES;
        _yellowRound.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_yellowRound];
        
        _downline = [[UIImageView alloc] initWithFrame:CGRectMake(58, 42, 1, 138)];
        _downline.backgroundColor = [UIColor clearColor];
        _downline.userInteractionEnabled = YES;
        _downline.image = LOADIMAGE(@"sy_fgx_img@2x", kImageTypePNG);
        [self.contentView addSubview:_downline];

        
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
