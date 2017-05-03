//
//  AppDelegate.m
//  Noob2017
//
//  Created by lihuaqi on 17/2/10.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "AppDelegate.h"
#import "JJLTabBarController.h"
#import "JJLNavigationController.h"
#import "AppDelegate+Services.h"
@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self delegateConfig];
    [self launchPrepare];
    [self KeyboardManager];
    [self pushServices];
    return YES;

}

//AppDelegate自身的代理
-(void)delegateConfig{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:KApploginSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login) name:KApplogin object:nil];
}

//运行判断
-(void)launchPrepare {
    JJLTabBarController *tabVC = [[JJLTabBarController alloc] init];
    self.window.rootViewController = tabVC;
    
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    JJLNavigationController *nav = [[JJLNavigationController alloc]initWithRootViewController:loginVC];
    
    if ([self isVersionUpdated]) {//首次登陆
        //引导页
        self.window.rootViewController = nav;
    }else {
        NSString *access_token  = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
        if (!access_token || access_token == (id)kCFNull) {//未登录状态
            self.window.rootViewController = nav;
        }
    }
}

//是否是版本更新后首次打开
- (BOOL)isVersionUpdated {
    NSString *updateVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *saveVersion  = [[NSUserDefaults standardUserDefaults] objectForKey:@"CFBundleShortVersionString"];
    if (!saveVersion || saveVersion == (id)kCFNull) {
        [[NSUserDefaults standardUserDefaults] setObject:updateVersion forKey:@"CFBundleShortVersionString"];
        return YES;
    }
    if ([updateVersion isEqualToString:saveVersion]) {
        return NO;
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:updateVersion forKey:@"CFBundleShortVersionString"];
        return YES;
    }
    return NO;
}

#pragma 登陆成功进首页
-(void)loginSuccess {
    JJLTabBarController *tabVC = [[JJLTabBarController alloc] init];
    KCWeakSelf(weakSelf);
    [UIView transitionFromView:weakSelf.window.rootViewController.view
                        toView:tabVC.view
                        duration:1
                        options:UIViewAnimationOptionTransitionCrossDissolve
                        completion:^(BOOL finished) {
                            weakSelf.window.rootViewController = tabVC;
    }];
}

#pragma 进登陆页
-(void)login {
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    JJLNavigationController *nav = [[JJLNavigationController alloc]initWithRootViewController:loginVC];
    self.window.rootViewController = nav;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

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
