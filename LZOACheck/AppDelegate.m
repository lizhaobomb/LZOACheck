//
//  AppDelegate.m
//  LZOACheck
//
//  Created by lizhao on 15/5/14.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "AppDelegate.h"
#import "LZInfomationViewController.h"
#import "LZAdministrativeBusinessViewController.h"
#import "LZBusinessQueryViewController.h"
#import "RDVTabBarItem.h"
#import "LZLoginViewController.h"
#import "LZSettings.h"
#import "LZNavigationController.h"
@interface AppDelegate ()<RDVTabBarControllerDelegate>
@property (nonatomic, strong) void (^selectNavTabBlock)(void) ;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.tabbarController = [[RDVTabBarController alloc] init];
//    
//    UINavigationBar *bar = [UINavigationBar appearance];
//    bar.tintColor = [UIColor redColor];
    
    LZNavigationController *informationNav = [[LZNavigationController alloc] initWithRootViewController:[[LZInfomationViewController alloc] init]];
    
    LZNavigationController *businessQueryNav = [[LZNavigationController alloc] initWithRootViewController:[[LZBusinessQueryViewController alloc] init]];
    
    LZNavigationController *administativeBusinessNav = [[LZNavigationController alloc] initWithRootViewController:[[LZAdministrativeBusinessViewController alloc] init]];
    
    self.tabbarController.viewControllers = @[informationNav, businessQueryNav, administativeBusinessNav];
    self.tabbarController.delegate = self;
    [self customizeTabBarForController:self.tabbarController];
    self.window.rootViewController = self.tabbarController;
    [self.window makeKeyAndVisible];
    [LZSettings loadPrefs];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - RDVTabbarController
- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UINavigationController *)viewController {
    if ([viewController.topViewController isKindOfClass:[LZAdministrativeBusinessViewController class]]) {
        if (![LZSettings sharedLZSettings].userId) {
            [self presentLoginNavController];
            return NO;
        }
    }
    return YES;
}


- (void)presentLoginNavController
{
    LZLoginViewController *loginVC = [[LZLoginViewController alloc] init];
    loginVC.LoginSucceed = ^(void) {
        self.tabbarController.selectedIndex = 2;
    };
    LZNavigationController *loginNav = [[LZNavigationController alloc] initWithRootViewController:loginVC];
    [self.tabbarController presentViewController:loginNav animated:YES completion:nil];
}


- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"infomation_center", @"business_query", @"admin_business"];
    NSArray *titles = @[@"信息中心", @"办事查询", @"行政办公"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        item.title = titles[index];
        [item setUnselectedTitleAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
        [item setSelectedTitleAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        index++;
    }
}


@end
