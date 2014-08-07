//
//  SYTableViewFoot.h
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-7.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BtnsClickEventDelegate <NSObject>

- (void)btnsClickEvent:(NSInteger)value;

@end

@interface SYTableViewFoot : UIView
@property (nonatomic, unsafe_unretained) id<BtnsClickEventDelegate>delegate;

@end
