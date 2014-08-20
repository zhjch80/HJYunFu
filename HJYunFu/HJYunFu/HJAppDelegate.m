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

#import "HJGuideSetViewController.h"
#import "HJShouYeViewController.h"
#import "HJSouSuoViewController.h"
#import "HJGongJuViewController.h"
#import "HJTiXingViewController.h"
#import "HJWoViewController.h"

#import "HJLeftViewController.h"
#import "HJRightViewController.h"

#import "MobClick.h"                                //UMeng 统计分析
#import "UMSocial.h"                                //UMeng社会化组件
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialTencentWeiboHandler.h"
#import "UMSocialRenrenHandler.h"
#import "UMSocialYiXinHandler.h"
#import "UMSocialLaiwangHandler.h"
#import "UMSocialFacebookHandler.h"
#import "UMSocialTwitterHandler.h"

#import "APService.h"                               //极光推送

#import "HJMTabBar.h"                               //自定义Tab


@implementation HJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //增加标识，用于判断是否是第一次启动应用...
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kEverLaunched]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kEverLaunched];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFirstLaunch];
    }
    
    [self registeredGlobalWidthAndHeight];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SwitchoverRootViewControllerMethod) name:@"SwitchoverRootViewControllerMethod" object:nil];

    
    //  友盟的方法本身是异步执行，所以不需要再异步调用
    [self umengTrack];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kFirstLaunch]) {
        //默认第一次启动的界面
        [self initFitstViewControllers];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }else {
        [self initMainViewControllers];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }

    
    [self loadJPushinfo];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self registeredJPushWithOptions:launchOptions];
    
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - 切换RootViewController

- (void)SwitchoverRootViewControllerMethod {
    [self initMainViewControllers];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - 极光推送

- (void)loadJPushinfo {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self selector:@selector(networkDidSetup:) name:kAPNetworkDidSetupNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidClose:) name:kAPNetworkDidCloseNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:) name:kAPNetworkDidRegisterNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kAPNetworkDidLoginNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kAPNetworkDidReceiveMessageNotification object:nil];

}

- (void)registeredJPushWithOptions:(NSDictionary *)launchOptions {
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)];
    [APService setupWithOption:launchOptions];
}

#pragma mark - 初始化 社会化 统计分析

- (void)umengTrack {
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
    [MobClick setLogEnabled:NO];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    //      [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
    [MobClick updateOnlineConfig];  //在线参数配置
    
    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}

- (void)umengUMSocial{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"5211818556240bc9ee01db2f"];
    //设置微信AppId，url地址传nil，将默认使用友盟的网址，需要#import "UMSocialWechatHandler.h"
    [UMSocialWechatHandler setWXAppId:@"wxd9a39c7122aa6516" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil ,需要 #import "UMSocialSinaHandler.h"
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    //打开腾讯微博SSO开关，设置回调地址,需要 #import "UMSocialTencentWeiboHandler.h"
    [UMSocialTencentWeiboHandler openSSOWithRedirectUrl:@"http://sns.whalecloud.com/tencent2/callback"];
    //打开人人网SSO开关,需要 #import "UMSocialRenrenHandler.h"
    [UMSocialRenrenHandler openSSO];
    //设置易信Appkey和分享url地址,注意需要引用头文件 #import UMSocialYixinHandler.h
    [UMSocialYixinHandler setYixinAppKey:@"yx35664bdff4db42c2b7be1e29390c1a06" url:@"http://www.umeng.com/social"];
    //设置来往AppId，appscret，显示来源名称和url地址，注意需要引用头文件 #import "UMSocialLaiwangHandler.h"
    [UMSocialLaiwangHandler setLaiwangAppId:@"8112117817424282305" appSecret:@"9996ed5039e641658de7b83345fee6c9" appDescription:@"友盟社会化组件" urlStirng:@"http://www.umeng.com/social"];
    //设置Facebook，AppID和分享url，需要#import "UMSocialFacebookHandler.h"
    //默认使用iOS自带的Facebook分享framework，在iOS 6以上有效。若要使用我们提供的facebook分享需要使用此开关：
    [UMSocialFacebookHandler setFacebookAppID:@"1440390216179601" shareFacebookWithURL:@"http://www.umeng.com/social"];
    //默认使用iOS自带的Twitter分享framework，在iOS 6以上有效。若要使用我们提供的twitter分享需要使用此开关：
//    [UMSocialTwitterHandler openTwitter];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return  [UMSocialSnsService handleOpenURL:url];
}

#pragma mark - 主入口函数

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

    NSArray * normalImageArray = [[NSArray alloc] initWithObjects:@"icon_shouye_img", @"icon_sousuo_img", @"icon_gongju_img", @"icon_tixing_img", @"icon_wo_img", nil];
    
    NSArray * selectedImageArray = [[NSArray alloc] initWithObjects:@"icon_current_shouye_img", @"icon_current_sousuo_img", @"icon_current_gongju_img", @"icon_current_tixing_img", @"icon_current_wo_img", nil];
    
    HJMTabBar * customTab = [[HJMTabBar alloc] init];
    [customTab setTabWithArray:ctlsArr NormalImageArray:normalImageArray SelectedImageArray:selectedImageArray];
    
    MMDrawerController * drawerController = [[MMDrawerController alloc] initWithCenterViewController:customTab leftDrawerViewController:leftNav rightDrawerViewController:rightNav];

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
    
    //隐藏两边侧滑
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideSlideDrawerMethods" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys: @"3", @"hideSlide", nil]];
}

- (void)initFitstViewControllers {
    HJGuideSetViewController * HJGuideSetCtl = [[HJGuideSetViewController alloc] init];
    UINavigationController * HJGuideSetNav = [[UINavigationController alloc] initWithRootViewController:HJGuideSetCtl];
    [self.window setRootViewController:HJGuideSetNav];
}

#pragma mark - 初始化屏幕宽高

- (void)registeredGlobalWidthAndHeight {
    //屏幕宽 高
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [UtilityFunc shareInstance].globleWidth = screenRect.size.width; //屏幕宽度
    [UtilityFunc shareInstance].globleHeight = screenRect.size.height-20;  //屏幕高度（无顶栏）
    [UtilityFunc shareInstance].globleAllHeight = screenRect.size.height;  //屏幕高度（有顶栏）
}

#pragma mark -

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - JPush

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [APService handleRemoteNotification:userInfo];
}

//avoid compile error for sdk under 7.0
#ifdef __IPHONE_7_0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}
#endif

#pragma mark -

- (void)networkDidSetup:(NSNotification *)notification {
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    NSLog(@"未连接。。。");
}

- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    NSLog(@"已登录");
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    NSLog(@"收到消息\ndate:%@\ntitle:%@\ncontent:%@",[dateFormatter stringFromDate:[NSDate date]],title,content);
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

#pragma mark -

@end
