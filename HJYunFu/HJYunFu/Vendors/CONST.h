//
//  CONST.h
//  YunFu
//
//  Created by 华晋传媒 on 14-7-11.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "UtilityFunc.h"

/*
 UMeng需要的框架
 Security.framework,libiconv.dylib,SystemConfiguration.framework,CoreGraphics.framework，libsqlite3.dylib，CoreTelephony.framework,libstdc++.dylib,libz.dylib。
 */

#define kBaseURL @"http://app.food.ttys5.com/api/food"

#define UMENG_APPKEY                @"53bf521c56240b3b5f00103d"         //zhjch90 测试appkey 友盟的

#define APP_NAME
#define APP_DOWNLOADADDRESS
#define APP_GIVEUSSCORE


#define kFirstLaunch                    @"firstLaunch"
#define kEverLaunched                   @"everLaunched"

#define kImageTypePNG @"png"
#define LOADIMAGE(file,ext)   [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define LANTING_FONT(_size) [UIFont fontWithName:@"Heiti SC" size:(_size)]

//familyName,fontName  :Microsoft YaHei - MicrosoftYaHei
/*
Family name: Heiti SC
Font name: STHeitiSC-Medium
Font name: STHeitiSC-Light
Family name: Heiti TC
Font name: STHeitiTC-Medium
Font name: STHeitiTC-Light
*/


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)














