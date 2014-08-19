//
//  HJAgeChoiceCell.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-19.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJAgeChoiceCell.h"



@implementation HJAgeChoiceCell
@synthesize leftImg = _leftImg,mtitle = _mtitle,line = _line;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _leftImg = [[UIImageView alloc] init];
        _leftImg.userInteractionEnabled = YES;
        _leftImg.backgroundColor = [UIColor clearColor];
        _leftImg.frame = CGRectMake(35, 11, 15, 15);
        [self.contentView addSubview:_leftImg];
        
        _mtitle = [[UILabel alloc] init];
        _mtitle.userInteractionEnabled = YES;
        _mtitle.backgroundColor = [UIColor clearColor];
        _mtitle.frame = CGRectMake(70, 5, 100, 30);
        [self.contentView addSubview:_mtitle];
        
        _line = [[UIImageView alloc] init];
        _line.frame = CGRectMake(0, 40, 151-6, 1);
        _line.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        _line.userInteractionEnabled = YES;
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
