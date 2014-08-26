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
+ (NSMutableDictionary *)gestationalAgeFromLastMenstrualPeriod:(NSString *)string {
    NSMutableDictionary * AfterDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"-1", @"AfterTheWeeks", @"-1", @"AfterTheDays",  @"-1", @"totalDays", nil];
    
    NSInteger year = [[string substringToIndex:4] integerValue];
    NSInteger month = [[string substringWithRange:NSMakeRange(5, 2)] integerValue];
    NSInteger day = [[string substringFromIndex:8] integerValue];
    
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *curDate = [NSDate date];
    NSString * curTime = [[formater stringFromDate:curDate] substringToIndex:10];
    
    NSInteger curYear = [[curTime substringToIndex:4] integerValue];
    NSInteger curMonth = [[curTime substringWithRange:NSMakeRange(5, 2)] integerValue];
    NSInteger curDay = [[curTime substringFromIndex:8] integerValue];
    
    if (year == curYear){
        if (month == curMonth){
            if (day == curDay){
                [AfterDic setObject:@"0" forKey:@"AfterTheWeeks"];
                [AfterDic setObject:@"1" forKey:@"AfterTheDays"];
                [AfterDic setObject:@"1" forKey:@"totalDays"];

            }else if (day < curDay){
                NSInteger AfterTheWeeks = (curDay - day)/7;
                NSInteger AfterTheDays = (curDay - day)%7;
                
                [AfterDic setObject:[NSString stringWithFormat:@"%d",AfterTheWeeks] forKey:@"AfterTheWeeks"];
                [AfterDic setObject:[NSString stringWithFormat:@"%d",AfterTheDays] forKey:@"AfterTheDays"];
                [AfterDic setObject:[NSString stringWithFormat:@"%d",curDay - day] forKey:@"totalDays"];
            }else if (day > curDay){
                NSLog(@"error:末次月经期天大于当前天");
            }
        }else if (month < curMonth){
            NSInteger totalDays = 0;
            
            if ([[self judgeTypeMonth:month withYear:year] isEqualToString:bigMonthType]){
                totalDays = 31 - day;
            }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:smallMonthType]){
                totalDays = 30 - day;
            }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:LeapMonthType]){
                totalDays = 29 - day;
            }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:NOTLeapMonthType]){
                totalDays = 28 - day;
            }
            totalDays = totalDays + curDay;
            month ++;
            
            while (month < curMonth) {
                if ([[self judgeTypeMonth:month withYear:year] isEqualToString:bigMonthType]){
                    totalDays += 31;
                }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:smallMonthType]){
                    totalDays += 30;
                }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:LeapMonthType]){
                    totalDays += 29;
                }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:NOTLeapMonthType]){
                    totalDays += 28;
                }

                month ++;
            }
            NSInteger AfterTheWeeks = totalDays/7;
            NSInteger AfterTheDays = totalDays%7;
            
            [AfterDic setObject:[NSString stringWithFormat:@"%d",AfterTheWeeks] forKey:@"AfterTheWeeks"];
            [AfterDic setObject:[NSString stringWithFormat:@"%d",AfterTheDays] forKey:@"AfterTheDays"];
            [AfterDic setObject:[NSString stringWithFormat:@"%d",totalDays] forKey:@"totalDays"];

        }else if (month > curMonth) {
            NSLog(@"error:末次月经期月份大于当前月份");
        }
    }else if (year < curYear){
        NSInteger totalDays = 0;
        
        if ([[self judgeTypeMonth:month withYear:year] isEqualToString:bigMonthType]){
            totalDays = 31 - day;
        }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:smallMonthType]){
            totalDays = 30 - day;
        }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:LeapMonthType]){
            totalDays = 29 - day;
        }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:NOTLeapMonthType]){
            totalDays = 28 - day;
        }
        month ++;
        
        while (month <= 12) {
            if ([[self judgeTypeMonth:month withYear:year] isEqualToString:bigMonthType]){
                totalDays += 31;
            }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:smallMonthType]){
                totalDays += 30;
            }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:LeapMonthType]){
                totalDays += 29;
            }else if ([[self judgeTypeMonth:month withYear:year] isEqualToString:NOTLeapMonthType]){
                totalDays += 28;
            }
            
            month ++;
        }

        NSInteger value = 1;
        while (value < curMonth) {
            if ([[self judgeTypeMonth:value withYear:curYear] isEqualToString:bigMonthType]){
                totalDays += 31;
            }else if ([[self judgeTypeMonth:value withYear:curYear] isEqualToString:smallMonthType]){
                totalDays += 30;
            }else if ([[self judgeTypeMonth:value withYear:curYear] isEqualToString:LeapMonthType]){
                totalDays += 29;
            }else if ([[self judgeTypeMonth:value withYear:curYear] isEqualToString:NOTLeapMonthType]){
                totalDays += 28;
            }
            value ++;
        }
        
        if ([[self judgeTypeMonth:curMonth withYear:curYear] isEqualToString:bigMonthType]){
            totalDays += curDay;
        }else if ([[self judgeTypeMonth:curMonth withYear:curYear] isEqualToString:smallMonthType]){
            totalDays += curDay;
        }else if ([[self judgeTypeMonth:curMonth withYear:curYear] isEqualToString:LeapMonthType]){
            totalDays += curDay;
        }else if ([[self judgeTypeMonth:curMonth withYear:curYear] isEqualToString:NOTLeapMonthType]){
            totalDays += curDay;
        }
  
        NSInteger AfterTheWeeks = totalDays/7;
        NSInteger AfterTheDays = totalDays%7;
                
        [AfterDic setObject:[NSString stringWithFormat:@"%d",AfterTheWeeks] forKey:@"AfterTheWeeks"];
        [AfterDic setObject:[NSString stringWithFormat:@"%d",AfterTheDays] forKey:@"AfterTheDays"];
        [AfterDic setObject:[NSString stringWithFormat:@"%d",totalDays] forKey:@"totalDays"];
    }else{
        NSLog(@"error:末次月经期的年份大于当前年年份");
    }
    return AfterDic;
}

/**
 通过月周计算当天处于孕月的月份
 */
+ (NSString *)monthOfPregnancyFromGestationalAge:(NSInteger)value {
    if (value == 0){
        return @"error: 孕周计算出错";
    }
    
    if (value > 0 && value <= 4){
        return @"1";
    }else if (value >=5 && value <= 8){
        return @"2";
    }else if (value >= 9 && value <= 12){
        return @"3";
    }else if (value >= 13 && value <= 16){
        return @"4";
    }else if (value >= 17 && value <= 20){
        return @"5";
    }else if (value >= 21 && value <= 24){
        return @"6";
    }else if (value >=25 && value <= 28){
        return @"7";
    }else if (value >=29 && value <= 32){
        return @"8";
    }else if (value >=33 && value <= 36){
        return @"9";
    }else if (value >= 37 && value <= 40){
        return @"10";
    }
    return @"error:不满足条件";
}

/**
 通过怀孕多少天计算出当天距生产日还有几天
 */
+ (NSString *)howManyDaysInTotalFromLastMenstrualPeriod:(NSInteger)value {
    return [NSString stringWithFormat:@"%d",280-value];
}

/**
 生男生女预测 
 根据1.受孕的农历月份  2.孕妈妈受孕时的虚岁年龄
 女性年龄是以农历虚岁（即真实年龄加一岁），而怀孕的月份即是受孕的那个月份
 
 计算公式：岁数-月份= 奇数（女宝宝）
 偶数（男宝宝）
 */
+ (NSString *)getBoyOrGirlWithAge:(NSString *)age WithMonth:(NSString *)month {
    NSInteger value = age.integerValue - month.integerValue;
    if (value%2 == 0){
        return @"男宝宝";
    }else {
        return @"女宝宝";
    }
}

/**
 宝宝身高预测
 */
+ (NSMutableDictionary *)getBabyHeightWithFatherHeight:(NSString *)F_height WithMotherHeight:(NSString *)M_height WithGender:(NSString *)gender {
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"0.0", @"babyHeight_MAX", @"0.0", @"babyHeight_MIN", nil];
    
    float babyHeight_MAX = 0.00;
    float babyHeight_MIN = 0.00;

    float Fheight = 0.00;
    float Mheight = 0.00;
    
    Fheight = F_height.floatValue;
    Mheight = M_height.floatValue;
        
    if ([gender isEqualToString:@"男"]){
        babyHeight_MAX = (56.699 + 0.419 * Fheight + 0.265 * Mheight) + 3;
        babyHeight_MIN = (56.699 + 0.419 * Fheight + 0.265 * Mheight) - 3;
    }else{
        babyHeight_MAX = (40.089 + 0.306 * Fheight + 0.431 * Mheight) + 3;
        babyHeight_MIN = (40.089 + 0.306 * Fheight + 0.431 * Mheight) - 3;
    }
    
    [dic setObject:[NSString stringWithFormat:@"%lf",babyHeight_MAX] forKey:@"babyHeight_MAX"];
    [dic setObject:[NSString stringWithFormat:@"%lf",babyHeight_MIN] forKey:@"babyHeight_MIN"];
    return dic;
}

/**
 宝宝 血型预测
 */
+ (NSMutableDictionary *)getBabyBloodTypeWithFatherType:(NSString *)F_Type WithMotherType:(NSString *)M_Type {
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"-1", @"maybe", @"-1", @"impossibility", nil];
    
    if ([F_Type isEqualToString:@"A"] && [M_Type isEqualToString:@"A"]){
        [dic setObject:@"A,O" forKey:@"maybe"];
        [dic setObject:@"B,AB" forKey:@"impossibility"];
    }else if ([F_Type isEqualToString:@"A"] && [M_Type isEqualToString:@"O"]){
        [dic setObject:@"A,O" forKey:@"maybe"];
        [dic setObject:@"B,AB" forKey:@"impossibility"];
    }else if ([F_Type isEqualToString:@"A"] && [M_Type isEqualToString:@"B"]){
        [dic setObject:@"A,B" forKey:@"maybe"];
        [dic setObject:@"AB,O" forKey:@"impossibility"];
    }else if ([F_Type isEqualToString:@"A"] && [M_Type isEqualToString:@"AB"]){
        [dic setObject:@"A,B" forKey:@"maybe"];
        [dic setObject:@"AB,O" forKey:@"impossibility"];
    }else if ([F_Type isEqualToString:@"B"] && [M_Type isEqualToString:@"B"]){
        [dic setObject:@"B,O" forKey:@"maybe"];
        [dic setObject:@"A,AB" forKey:@"impossibility"];
    }else if ([F_Type isEqualToString:@"B"] && [M_Type isEqualToString:@"O"]){
        [dic setObject:@"B,O" forKey:@"maybe"];
        [dic setObject:@"A,AB" forKey:@"impossibility"];
    }else if ([F_Type isEqualToString:@"B"] && [M_Type isEqualToString:@"AB"]){
        [dic setObject:@"A,B" forKey:@"maybe"];
        [dic setObject:@"AB,O" forKey:@"impossibility"];
    }else if ([F_Type isEqualToString:@"AB"] && [M_Type isEqualToString:@"O"]){
        [dic setObject:@"A,B" forKey:@"maybe"];
        [dic setObject:@"AB,O" forKey:@"impossibility"];
    }else if ([F_Type isEqualToString:@"AB"] && [M_Type isEqualToString:@"AB"]){
        [dic setObject:@"A,B" forKey:@"maybe"];
        [dic setObject:@"AB,O" forKey:@"impossibility"];
    }else if ([F_Type isEqualToString:@"O"] && [M_Type isEqualToString:@"O"]){
        [dic setObject:@"O" forKey:@"maybe"];
        [dic setObject:@"A,B,AB" forKey:@"impossibility"];
    }else{
        [dic setObject:@"-1" forKey:@"maybe"];
        [dic setObject:@"-1" forKey:@"impossibility"];
    }
    
    return dic;
}


@end
