//
//  HJPeriodSwitchDueDate.h
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-4.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJPeriodSwitchDueDate : NSObject


/**
 根据预产期推算末次月经期
 */
+ (NSString *)lastMenstrualPeriodFromDueDate:(NSString *)string;

/**
 根据末次月经期推算预产期
 */
+ (NSString *)dueDateFromLastMenstrualPeriod:(NSString *)string;

/**
 通过末次月经期计算出孕周
 */
+ (NSString *)gestationalAgeFromLastMenstrualPeriod:(NSString *)string;

/**
 通过末次月经期计算出孕月
 */
+ (NSString *)monthOfPregnancyFromLastMenstrualPeriod:(NSString *)string;

/**
 计算出距生产日还有几天
 */
+ (NSString *)howManyDaysInTotalFromLastMenstrualPeriod:(NSString *)string;


@end
