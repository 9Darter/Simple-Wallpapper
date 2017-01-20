//
//  AppDelegate.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/17.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewControllerHeader.h"
#import "NetManager.h"
#import "DefineAppKey.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
    
//定义一个方法，返回一个WMPageController的对象，其中加入了全部标签的题目和每个题目对应的viewController对象，用此方法可以不用创建一个继承于WMPageConrroller的类，进而不用写代理方法，比较简洁
- (WMPageController *)p_defaultController {
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 13; i++) {
        Class vcClass;
        NSString *title;
        switch (i) {
            case 0:
            vcClass = [RecommendedController class];
            title = @"推荐";
            break;
            
            case 1:
            vcClass = [TopicController class];
            title = @"主题套图";
            break;
            
            case 2:
            vcClass = [LockedScreenController class];
            title = @"锁屏";
            break;
            
            case 3:
            vcClass = [HomeScreenController class];
            title = @"主屏";
            break;
            
            case 4:
            vcClass = [PerfectCoupleController class];
            title = @"天生一对";
            break;
            
            case 5:
            vcClass = [PeopleWatchingController class];
            title = @"全民看点";
            break;
            
            case 6:
            vcClass = [LatestController class];
            title = @"最新图集";
            break;
            
            case 7:
            vcClass = [MostPopularController class];
            title = @"最热";
            break;
            
            case 8:
            vcClass = [BoysController class];
            title = @"男生请进";
            break;
            
            case 9:
            vcClass = [GirlsController class];
            title = @"女生请进";
            break;
            
            case 10:
            vcClass = [WordWallpapersController class];
            title = @"文字壁纸";
            break;
            
            case 11:
            vcClass = [ChatBackgroundsController class];
            title = @"聊天背景";
            break;
            
            case 12:
            vcClass = [ProfilePicsController class];
            title = @"头像";
            break;
        }
        [viewControllers addObject:vcClass];
        [titles addObject:title];
    }
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.menuItemWidth = 85;
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    //让菜单显示在导航栏上
    pageVC.showOnNavigationBar = NO;
    //设置菜单高度
    //vc.menuHeight = 250;
    //设置菜单背景色
    pageVC.menuBGColor = [UIColor clearColor];
    //选中时的样式
    pageVC.menuViewStyle = WMMenuViewStyleLine;
    //预加载机制，在停止滑动的时候预加载 n 页
    pageVC.preloadPolicy = WMPageControllerPreloadPolicyNeighbour;
    //选中时的文字颜色
    pageVC.titleColorSelected = [UIColor greenColor];

    pageVC.navigationItem.title = @"180壁纸";
    return pageVC;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_APPKEY];
    
    [self configUSharePlatforms];
    [self confitUShareSettings];

    //************************************************************************
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    WMPageController *vc = [self p_defaultController];
    
    _window.rootViewController = [[UINavigationController alloc]initWithRootViewController:vc];
    
    return YES;
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WECHAT_APPKEY appSecret:WECHAT_APPSECRET redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_APPKEY/*设置QQ平台的appID*/  appSecret:QQ_APPSECRET redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SINA_APPKEY  appSecret:SINA_APPSECRET redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}


// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
