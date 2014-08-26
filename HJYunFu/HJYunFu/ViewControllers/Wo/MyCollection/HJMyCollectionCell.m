//
//  HJMyCollectionCell.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-26.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJMyCollectionCell.h"

@implementation HJMyCollectionCell
@synthesize bgImg = _bgImg,leftImg = _leftImg,mtitle = _mtitle,sLeftImg_1 = _sLeftImg_1,sLeftImg_2 = _sLeftImg_2,subtitle_1 = _subtitle_1,subtitle_2 = _subtitle_2,scImg = _scImg,sctitle = _sctitle,line = _line;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _bgImg = [[UIImageView alloc] init];
        _bgImg.frame = CGRectMake(10, 15, 303, 73);
        _bgImg.image = LOADIMAGE(@"me_sccellbg_img", kImageTypePNG);
        _bgImg.backgroundColor = [UIColor clearColor];
        _bgImg.userInteractionEnabled = YES;
        [self.contentView addSubview:_bgImg];
        
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = [UIColor clearColor];
        _line.userInteractionEnabled = YES;
        _line.image = LOADIMAGE(@"me_fgxcell_img@2x", kImageTypePNG);
        _line.frame = CGRectMake(10, 100, 300, 1);
        [self.contentView addSubview:_line];
        
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
