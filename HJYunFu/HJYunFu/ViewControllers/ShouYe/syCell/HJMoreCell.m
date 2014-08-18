//
//  HJMoreCell.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-11.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJMoreCell.h"

@implementation HJMoreCell
@synthesize moreView = _moreView, button = _button,mtitle = _mtitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _moreView = [[UIImageView alloc] initWithFrame:CGRectMake(([UtilityFunc shareInstance].globleWidth - 230)/2.0 + 28, 5, 230, 26)];
        _moreView.backgroundColor = [UIColor whiteColor];
        _moreView.userInteractionEnabled = YES;
        [self.contentView addSubview:_moreView];
        
        _mtitle = [[UILabel alloc] initWithFrame:CGRectMake(([UtilityFunc shareInstance].globleWidth - 230)/2.0 + 28, 5, 230, 26)];
        _mtitle.text = @"更    多";
        _mtitle.textColor = [UIColor colorWithRed:0.96 green:0.68 blue:0.07 alpha:1];
        _mtitle.backgroundColor = [UIColor clearColor];
        _mtitle.textAlignment = NSTextAlignmentCenter;
        _mtitle.font = LANTING_FONT(15.5);
        [self.contentView addSubview:_mtitle];
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
