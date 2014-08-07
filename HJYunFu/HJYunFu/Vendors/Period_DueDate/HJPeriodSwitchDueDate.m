//
//  HJPeriodSwitchDueDate.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-8-4.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJPeriodSwitchDueDate.h"

#define bigMonthType            @"大月"
#define smallMonthType          @"小月"
#define LeapMonthType           @"闰月"
#define NOTLeapMonthType        @"非闰月"

@implementation HJPeriodSwitchDueDate

/**
 根据预产期推算末次月经期
 day减7  month减9
 */
+ (NSString *)lastMenstrualPeriodFromDueDate:(NSString *)string {
    NSInteger year = [[string substringToIndex:4] integerValue];
    NSInteger month = [[string substringWithRange:NSMakeRange(5, 2)] integerValue];
    NSInteger day = [[string substringFromIndex:8] integerValue];
    
    if (day > 7){
        day = day - 7;
        if (month > 9){
            month = month - 9;
        }else if (month == 9){
            year = year - 1;
            month = 12;
        }else if (month < 9){
            year = year - 1;
            month = 12 - 9 + month;
        }
    }else if (day == 7){
        if (month == 1){
            month = 12 - 9;
            day = 31;
            year = year - 1;
        }else {
            month = month - 1;
            if ([[self judgeTypeMonth:month withYear:year] isEqualToString:bigMonthType]){
                day = 31;
                if (month > 9){
                    month = month - 9;
                }else if (month == 9){
                    year = year - 1;
                    month = 12;
                }else if (month < 9){
                    month = 12 - 9 + month;
                    year = year - 1;
                }
            }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:smallMonthType]){
                day = 30;
                if (month > 9){
                    month = month - 9;
                }else if (month == 9){
                    year = year - 1;
                    month = 12;
                }else if (month < 9){
                    month = 12 - 9 + month;
                    year = year - 1;
                }
            }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:LeapMonthType]){
                day = 28;
                year = year - 1;
                month = 5;
            }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:NOTLeapMonthType]){
                day = 29;
                year = year - 1;
                month = 5;
            }
        }
    }else if (day < 7){
        if ([[self judgeTypeMonth:month withYear:year] isEqualToString:bigMonthType]){
            if (month == 1){
                month = 3;
                day = 31 - 7 + day;
                year = year - 1;
            }else{
                if (month > 10){
                    month = month - 1 - 9;
                    day = 31 - 7 + day;
                }else if (month == 10){
                    month = 12;
                    year = year - 1;
                    day = 31 - 7 + day;
                }else if (month < 10){
                    month = 12 - 10 + month;
                    year = year - 1;
                    day = 31 - 7 + day;
                }
            }
        }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:smallMonthType]){
            if (month > 10){
                month = month - 10;
                day = 30 - 7 + day;
            }else if (month == 10){
                month = 12;
                year = year - 1;
                day = 30 - 7 + day;
            }else if (month < 10){
                month = 12 - 10 + month;
                day = 30 - 7 + day;
                year = year - 1;
            }
        }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:LeapMonthType]){
            month = 12 - 10 + month;
            day = 29 - 7 + day;
            year = year - 1;
        }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:NOTLeapMonthType]){
            month = 12 - 10 + month;
            day = 28 - 7 + day;
            year = year - 1;
        }
    }
    return [self combinationToDateFormYear:year Month:month Day:day];
}

/**
 根据末次月经期推算预产期
 day加7  month加9
 */
+ (NSString *)dueDateFromLastMenstrualPeriod:(NSString *)string {
    NSInteger year = [[string substringToIndex:4] integerValue];
    NSInteger month = [[string substringWithRange:NSMakeRange(5, 2)] integerValue];
    NSInteger day = [[string substringFromIndex:8] integerValue];

    if ([[self judgeTypeMonth:month withYear:year] isEqualToString:bigMonthType]){
        if (day > 24){
            day = day + 7 - 31;
            month = month + 1 + 9;
            if (month > 12){
                month = month - 12;
                year = year + 1;
            }else{
            }
        }else if (day <= 24){
            day = day + 7;
            month = month + 9;
            if (month > 12){
                month = month - 12;
                year = year + 1;
            }else{
            }
        }
    }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:smallMonthType]){
        if (day > 23){
            day = day + 7 - 30;
            month = month + 1 + 9;
            if (month > 12){
                month = month - 12;
                year = year + 1;
            }else{
                
            }
        }else if (day <= 23){
            day = day + 7;
            month = month + 9;
            if (month > 12){
                month = month - 12;
                year = year + 1;
            }else{
                
            }
        }
    }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:LeapMonthType]){
        if (day > 22){
            day = day + 7 - 29;
            month = month + 1 + 9;
            if (month > 12){
                month = month - 12;
                year = year + 1;
            }else{
                
            }
        }else if (day <= 22){
            day = day + 7;
            month = month + 9;
            if (month > 12){
                month = month - 12;
                year = year + 1;
            }else{
                
            }
        }
    }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:NOTLeapMonthType]){
        if (day > 21){
            day = day + 7 - 28;
            month = month + 1 + 9;
            if (month > 12){
                month = month - 12;
                year = year + 1;
            }else{
                
            }
        }else if (day <= 21){
            day = day + 7;
            month = month + 9;
            if (month > 12){
                month = month - 12;
                year = year + 1;
            }else{
                
            }
        }
    }
    return [self combinationToDateFormYear:year Month:month Day:day];
}

/**
 判断该月份是大月，小月，闰月（2月份）
 return 大月 小月 闰月
 */
+ (NSString *)judgeTypeMonth:(NSInteger)month withYear:(NSInteger)year {
    switch (month) {
        case 1:{
            return bigMonthType;
            break;
        }
        case 2:{
            NSString * LeapYearMark = year%(year%100?4:400)?@"NO":@"YES";
            if ([LeapYearMark isEqualToString:@"YES"]){
                return LeapMonthType;
            }else if ([LeapYearMark isEqualToString:@"NO"]){
                return NOTLeapMonthType;
            }
            break;
        }
        case 3:{
            return bigMonthType;
            break;
        }
        case 4:{
            return smallMonthType;
            break;
        }
        case 5:{
            return bigMonthType;
            break;
        }
        case 6: {
            return smallMonthType;
            break;
        }
        case 7:{
            return bigMonthType;
            break;
        }
        case 8:{
            return bigMonthType;
            break;
        }
        case 9:{
            return smallMonthType;
            break;
        }
        case 10:{
            return bigMonthType;
            break;
        }
        case 11:{
            return smallMonthType;
            break;
        }
        case 12:{
            return bigMonthType;
            break;
        }
            
        default:
            break;
    }
    return nil;
}

/*
 组合成一个年月日的时间格式
 */
+ (NSString *)combinationToDateFormYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day {
    NSString * newMonth;
    NSString * newDay;
    if (month < 10){
        newMonth = [NSString stringWithFormat:@"0%d",month];
    }else{
        newMonth = [NSString stringWithFormat:@"%d",month];
    }
    
    if (day < 10){
        newDay = [NSString stringWithFormat:@"0%d",day];
    }else{
        newDay = [NSString stringWithFormat:@"%d",day];
    }
    
    return [NSString stringWithFormat:@"%d-%@-%@",year,newMonth,newDay];
}

/**
 通过末次月经期计算当天处于孕周的第几周的第几天
 */
+ (NSString *)gestationalAgeFromLastMenstrualPeriod:(NSString *)string {
    string = @"2013-08-09";
    
    return @"";
}

/**
 通过末次月经期计算当天处于孕月的月份且第几天
 */
+ (NSString *)monthOfPregnancyFromLastMenstrualPeriod:(NSString *)string {
    
    return @"";
}

/**
 通过末次月经期计算出当天距生产日还有几天
 */
+ (NSString *)howManyDaysInTotalFromLastMenstrualPeriod:(NSString *)string {
    
    return @"";
}




@end
