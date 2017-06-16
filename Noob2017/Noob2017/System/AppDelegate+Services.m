//
//  AppDelegate+Services.m
//  Noob2017
//
//  Created by lihuaqi on 17/5/3.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "AppDelegate+Services.h"
//测试的
static NSString* const kGtAppId = @"l6uQ8fSNLC8AMpz7lrgbC3";
static NSString* const kGtAppKey = @"OTUWIpaM9w6zHRxkQxwGL9";
static NSString* const kGtAppSecret = @"NLpL2HS0ru5HmdFN2NSqB7";
static NSString* const KWxAppId = @"wxd73071baf25ec8df";
static NSString* const KWeiboAppId = @"698424430";

@implementation AppDelegate (Services) 
- (void)servicesApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self KeyboardManager];
    
    //[self pushServices];
    
    [WXApi registerApp:KWxAppId];
    
    //[WeiboSDK enableDebugMode:YES];//调试模式
    [WeiboSDK registerApp:KWeiboAppId];
    
}


///** 注册推送 */
//-(void)pushServices {
//    KCWeakSelf(weakSelf);
//    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:weakSelf];
//}
//
///** 远程通知注册成功委托 */
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
//    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
//    //向个推服务器注册deviceToken
//    [GeTuiSdk registerDeviceToken:token];
//}
//
///** APP已经接收到“远程”通知(推送) - 透传推送消息  */
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
//
//    [GeTuiSdk handleRemoteNotification:userInfo];
//    // 控制台打印接收APNs信息
//    NSLog(@"\n>>>[Receive RemoteNotification]:%@\n\n", userInfo);
//
//}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]]||[WeiboSDK handleOpenURL:url delegate:[WeiboApiManager sharedManager]];;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]]||[WeiboSDK handleOpenURL:url delegate:[WeiboApiManager sharedManager]];;
}


-(void)KeyboardManager {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;//控制整个功能是否启用。
    manager.shouldResignOnTouchOutside = YES;//控制点击背景是否收起键盘
    manager.shouldToolbarUsesTextFieldTintColor = NO;//控制键盘上的工具条文字颜色是否用户自定义
    manager.enableAutoToolbar = NO;//控制是否显示键盘上的工具条
}
@end
