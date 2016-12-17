//
//  AppDelegate.m
//  极简壁纸
//
//  Created by 璠 王 on 2016/12/17.
//  Copyright © 2016年 璠 王. All rights reserved.
//

#import "AppDelegate.h"

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
            vcClass = [RedViewController class];
            title = @"Greetings";
            break;
            case 1:
            vcClass = [BlueViewController class];
            title = @"Hit Me";
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
    //vc.menuHeight = 250;
    //设置菜单背景色
    pageVC.menuBGColor = [UIColor clearColor];
    //选中时的样式
    pageVC.menuViewStyle = WMMenuViewStyleLine;
    //更多的属性 自己查看头文件 因为都是中文提示
    pageVC.preloadPolicy = WMPageControllerPreloadPolicyNeighbour;
    return pageVC;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
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
