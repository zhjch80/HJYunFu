//
//  HJMCustomTextField.m
//  HJYueHealth
//
//  Created by 华晋传媒 on 14-5-6.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJMCustomTextField.h"

@implementation HJMCustomTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(CGRect)textRectForBounds:(CGRect)bounds{
    
    return CGRectMake(40, 0, bounds.size.width-40, bounds.size.height);
    
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    
    return CGRectMake(40, 0, bounds.size.width-40, bounds.size.height);
    
}

-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    
    return CGRectMake(40, 0, bounds.size.width-40, bounds.size.height);
    
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
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
