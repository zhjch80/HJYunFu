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
 通过末次月经期计算出孕周，通过key取值 AfterTheWeeks是孕周 AfterTheDays是当下孕周的第几天
 */
+ (NSMutableDictionary *)gestationalAgeFromLastMenstrualPeriod:(NSString *)string;

/**
 通过月周计算当天处于孕月的月份
 */
+ (NSString *)monthOfPregnancyFromGestationalAge:(NSInteger)value;

/**
 通过怀孕多少天计算出当天距生产日还有几天
 */
+ (NSString *)howManyDaysInTotalFromLastMenstrualPeriod:(NSInteger)value;

/**
 生男生女预测 return 性别
 */
+ (NSString *)getBoyOrGirlWithAge:(NSString *)age WithMonth:(NSString *)month;

/**
 宝宝身高预测 通过key babyHeight_MAX,babyHeight_MIN 获取最高身高,最低身高
 */
+ (NSMutableDictionary *)getBabyHeightWithFatherHeight:(NSString *)F_height WithMotherHeight:(NSString *)M_height WithGender:(NSString *)gender;

/**
 血型预测 通过key maybe,impossibility 获取可能得血型,不可能得血型
 */
+ (NSMutableDictionary *)getBabyBloodTypeWithFatherType:(NSString *)F_Type WithMotherType:(NSString *)M_Type;

@end
