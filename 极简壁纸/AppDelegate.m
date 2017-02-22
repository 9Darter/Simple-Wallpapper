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
#import "SaveController.h"


@interface AppDelegate ()
@property(nonatomic, strong) WMPageController *vcProperty;
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
    //根据标题长度自动计算每个标题的宽度
    pageVC.automaticallyCalculatesItemWidths = YES;
    //每个标题间的间隔
    pageVC.itemMargin = 22;
    //选中的字号
    pageVC.titleSizeSelected = 14;
    //非选中的字号
    pageVC.titleSizeNormal = 14;
    
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    //让菜单显示在导航栏上
    pageVC.showOnNavigationBar = NO;
    
    //设置菜单背景色
    pageVC.menuBGColor = [UIColor clearColor];
    //选中时的样式
    pageVC.menuViewStyle = WMMenuViewStyleLine;
    //预加载机制，在停止滑动的时候预加载 n 页
    pageVC.preloadPolicy = WMPageControllerPreloadPolicyNeighbour;
    //选中时的文字颜色
    pageVC.titleColorSelected = [UIColor colorWithRed:0 green:171/255.0 blue:108/255.0 alpha:1];
    //非选中时的文字颜色
    pageVC.titleColorNormal = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
    
    pageVC.navigationItem.title = @"180壁纸";

    return pageVC;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //****************友盟统计************************
    UMConfigInstance.appKey = USHARE_APPKEY;
    UMConfigInstance.channelId = @"App Store";
    //UMConfigInstance.eSType = E_UM_GAME; //仅适用于游戏场景，应用统计不用设置
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    //************************友盟分享**********************************
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_APPKEY];
    
    [self configUSharePlatforms];
    [self confitUShareSettings];
    //************************************************************************
    //获取documents路径
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *thumbArrPath = [docPath stringByAppendingPathComponent:@"thumbArr.plist"];
    NSString *standArrPath = [docPath stringByAppendingPathComponent:@"standArr.plist"];
    //读磁盘
    //判断当前要打开的数组在磁盘上是否存在
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL exitsThumb = [fileMgr fileExistsAtPath:thumbArrPath];
    BOOL exitsStand = [fileMgr fileExistsAtPath:standArrPath];
    if (!exitsThumb) {
        NSArray *thumbArr = [NSArray new];
        [thumbArr writeToFile:thumbArrPath atomically:YES];
        self.thumbArr = thumbArr;
    }
    if (!exitsStand) {
        NSArray *standArr = [NSArray new];
        [standArr writeToFile:standArrPath atomically:YES];
        self.standArr = standArr;
    }
    //************************************************************************
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    WMPageController *vc = [self p_defaultController];
    self.vcProperty = vc;
    _window.rootViewController = [[UINavigationController alloc]initWithRootViewController:vc];
    
    //创建一个导航栏按钮，点击进入收藏页面
    vc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(alarmForSaveOrClearSave)];
    
    
    NSLog(@"%@", NSHomeDirectory());

    return YES;
}
-(void)alarmForSaveOrClearSave {
    //创建警告提醒
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    // 添加按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"查看收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.vcProperty.navigationController pushViewController:[SaveController new] animated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"清空收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //获取documents路径
        NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *thumbArrPath = [docPath stringByAppendingPathComponent:@"thumbArr.plist"];
        NSString *standArrPath = [docPath stringByAppendingPathComponent:@"standArr.plist"];
        //读磁盘，添加url到plist文件中
        NSMutableArray *thumbArr = [[NSMutableArray alloc]initWithContentsOfFile:thumbArrPath];
        NSMutableArray *standArr = [[NSMutableArray alloc]initWithContentsOfFile:standArrPath];
        [standArr removeAllObjects];
        [thumbArr removeAllObjects];
        [thumbArr writeToFile:thumbArrPath atomically:YES];
        [standArr writeToFile:standArrPath atomically:YES];
        //做一个alert对话框
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"已清空收藏" message:nil preferredStyle:UIAlertControllerStyleAlert];
        //    step2:  创建可以收集用户意图的按键 — UIAlertAction， 创建时，不仅仅说明该按键上要显示的提示性文字，还要使用block的方式来设定点击了该按键之后要做的事情
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
        }];
        //    step3: 将创建好的  UIAlertAction 添加到 UIAlertController中
        [alert addAction:action1];
        //    step4：使用控制器的pressentViewController方法将AlertController推出显示
        alert.popoverPresentationController.sourceView = self.vcProperty.view;
        [self.vcProperty.navigationController presentViewController:alert animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    
    ///alert.popoverPresentationController.sourceView = self.vcProperty.view;
    [self.vcProperty.navigationController presentViewController:alert animated:YES completion:nil];
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
