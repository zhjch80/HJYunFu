//
//  HJGongJuTableViewCell.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-6.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJGongJuTableViewCell.h"

@implementation HJGongJuTableViewCell
@synthesize headImg = _headImg;
@synthesize bgImg = _bgImg;
@synthesize verticalImg = _verticalImg;
@synthesize mtitle = _mtitle;
@synthesize subTitle = _subTitle;
@synthesize arrowImg = _arrowImg;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(189/2 + 12, 7, 200, 138/2 + 2)];
        _bgImg.image = LOADIMAGE(@"gj_bg_img@2x", kImageTypePNG);
        _bgImg.backgroundColor = [UIColor clearColor];
        _bgImg.userInteractionEnabled = YES;
        [self.contentView addSubview:_bgImg];
        
        _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, 7, 189/2, 138/2)];
        _headImg.userInteractionEnabled = YES;
        _headImg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_headImg];
        
        _verticalImg = [[UIImageView alloc] initWithFrame:CGRectMake(150, 138/2 + 15, 1, 10)];
        _verticalImg.image = LOADIMAGE(@"gj_verticalLine_img@2x", kImageTypePNG);
        _verticalImg.backgroundColor = [UIColor clearColor];
        _verticalImg.userInteractionEnabled = YES;
        [self.contentView addSubview:_verticalImg];
        
        _mtitle = [[UILabel alloc] initWithFrame:CGRectMake(189/2 + 16, 8, 200, 30)];
        _mtitle.backgroundColor = [UIColor clearColor];
        _mtitle.textColor = [UIColor colorWithRed:0.98 green:0 blue:0.18 alpha:1];
        _mtitle.font = LANTING_FONT(16.0);
        [self.contentView addSubview:_mtitle];
        
        _subTitle = [[UILabel alloc] initWithFrame:CGRectMake(189/2 + 16, 28, 160, 50)];
        _subTitle.backgroundColor = [UIColor clearColor];
        _subTitle.textColor = [UIColor colorWithRed:0.48 green:0.48 blue:0.48 alpha:1];
        _subTitle.numberOfLines = 2;
        _subTitle.font = LANTING_FONT(15.0);
        [self.contentView addSubview:_subTitle];
        
        _arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(280, 35, 16/2, 26/2)];
        _arrowImg.userInteractionEnabled = YES;
        _arrowImg.image = LOADIMAGE(@"gj_arrow_img@2x", kImageTypePNG);
        _arrowImg.backgroundColor = [UIColor clearColor];
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
