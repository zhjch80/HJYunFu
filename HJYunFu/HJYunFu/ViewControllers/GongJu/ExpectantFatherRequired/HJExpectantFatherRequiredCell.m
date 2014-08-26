//
//  HJExpectantFatherRequiredCell.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-25.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJExpectantFatherRequiredCell.h"

@implementation HJExpectantFatherRequiredCell
@synthesize mtitle = _mtitle,subtitle = _subtitlel,upImg = _upImg,centerImg = _centerImg,downImg = _downImg,cornerImg = _cornerImg,bgView = _bgView,content = _content;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _mtitle = [[UILabel alloc] init];
        _mtitle.textColor = [UIColor colorWithRed:0.99 green:0 blue:0.29 alpha:1];
        _mtitle.backgroundColor = [UIColor clearColor];
        _mtitle.frame = CGRectMake(0, 10, 60, 30);
        _mtitle.textAlignment = NSTextAlignmentCenter;
        _mtitle.font = [UIFont boldSystemFontOfSize:15.0];
        [self.contentView addSubview:_mtitle];
        
        _cornerImg = [[UIImageView alloc] init];
        _cornerImg.frame = CGRectMake(64, 25, 6, 10);
        _cornerImg.image = LOADIMAGE(@"gj_corner_img", kImageTypePNG);
        [self.contentView addSubview:_cornerImg];
        
        _upImg = [[UIImageView alloc] init];
        _upImg.frame = CGRectMake(55, 0, 1, 25);
        _upImg.image = LOADIMAGE(@"gj_verticalLine_img@2x", kImageTypePNG);
        [self.contentView addSubview:_upImg];
        
        _centerImg = [[UIImageView alloc] init];
        _centerImg.frame = CGRectMake(51, 30, 8, 8);
        _centerImg.image = LOADIMAGE(@"sy_yellowRound_img@2x", kImageTypePNG);
        [self.contentView addSubview:_centerImg];
        
        _downImg = [[UIImageView alloc] init];
        _downImg.image = LOADIMAGE(@"gj_verticalLine_img@2x", kImageTypePNG);
        [self.contentView addSubview:_downImg];
        
        _subtitlel = [[UILabel alloc] init];
        _subtitlel.backgroundColor = [UIColor clearColor];
        _subtitlel.frame = CGRectMake(0, 30, 60, 30);
        _subtitlel.textAlignment = NSTextAlignmentCenter;
        _subtitlel.textColor = [UIColor colorWithRed:0.52 green:0.52 blue:0.52 alpha:1];
        _subtitlel.font = [UIFont boldSystemFontOfSize:15.0];
        _subtitlel.text = @"孕";
        [self.contentView addSubview:_subtitlel];
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView.layer setCornerRadius:7.0];
        [self.contentView addSubview:_bgView];
        
        _content = [[UILabel alloc] init];
        _content.backgroundColor = [UIColor clearColor];
        _content.numberOfLines = 0;
        _content.textColor = [UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1];
        _content.font = LANTING_FONT(14.0);
        [self.contentView addSubview:_content];
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
