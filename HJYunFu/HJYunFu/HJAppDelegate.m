//
//  HJAppDelegate.m
//  HJYunFu
//
//  Created by 华晋传媒 on 14-7-13.
//  Copyright (c) 2014年 HuaJinMedia. All rights reserved.
//

#import "HJAppDelegate.h"

#import "MMDrawerBarButtonItem.h"
#import "MMExampleDrawerVisualStateManager.h"

#import "HJShouYeViewController.h"
#import "HJSouSuoViewController.h"
#import "HJGongJuViewController.h"
#import "HJTiXingViewController.h"
#import "HJWoViewController.h"

#import "HJLeftViewController.h"
#import "HJRightViewController.h"


@implementation HJAppDelegate
@synthesize customTab = _customTab;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)initMainViewControllers {
    UIViewController * leftCtl = [[HJLeftViewController alloc] init];
    UINavigationController * leftNav = [[UINavigationController alloc] initWithRootViewController:leftCtl];
    
    UIViewController * rightCtl = [[HJRightViewController alloc] init];
    UINavigationController * rightNav = [[UINavigationController alloc] initWithRootViewController:rightCtl];
    
    UIViewController * shouYeCtl = [[HJShouYeViewController alloc] init];
    UINavigationController * shouYeNav = [[UINavigationController alloc] initWithRootViewController:shouYeCtl];
    
    UIViewController * souSuoCtl = [[HJSouSuoViewController alloc] init];
    UINavigationController * souSuoNav = [[UINavigationController alloc] initWithRootViewController:souSuoCtl];
    
    UIViewController * gongJuCtl = [[HJGongJuViewController alloc] init];
    UINavigationController * gongJuNav = [[UINavigationController alloc] initWithRootViewController:gongJuCtl];
    
    UIViewController * tiXingCtl = [[HJTiXingViewController alloc] init];
    UINavigationController * tiXingNav = [[UINavigationController alloc] initWithRootViewController:tiXingCtl];
    
    UIViewController * woCtl = [[HJWoViewController alloc] init];
    UINavigationController * woNav = [[UINavigationController alloc] initWithRootViewController:woCtl];
    
    NSArray * ctlsArr = [NSArray arrayWithObjects:shouYeNav, souSuoNav, gongJuNav, tiXingNav, woNav, nil];

    NSArray * normalImageArray = [NSArray arrayWithObjects:@"ico_1@2x", @"ico_2@2x", @"ico_3@2x", @"ico_4@2x", nil];
    NSArray * selectedImageArray = [NSArray arrayWithObjects:@"ico_1_select@2x", @"ico_2_select@2x", @"ico_3_select@2x", @"ico_4_select@2x", nil];
    
    _customTab = [[HJMTabBar alloc] init];
    [_customTab setTabWithArray:ctlsArr NormalImageArray:normalImageArray SelectedImageArray:selectedImageArray];
    
    MMDrawerController * drawerController = [[MMDrawerController alloc] initWithCenterViewController:_customTab leftDrawerViewController:leftNav rightDrawerViewController:rightNav];

    [drawerController setMaximumRightDrawerWidth:280.0];
    [drawerController setMaximumLeftDrawerWidth:280.0];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [drawerController
     setDrawerVisualStateBlock:^(MMDrawerController * drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
    [self.window setRootViewController:drawerController];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
