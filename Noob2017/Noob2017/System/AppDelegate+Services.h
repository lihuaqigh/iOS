//
//  AppDelegate+Services.h
//  Noob2017
//
//  Created by lihuaqi on 17/5/3.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "AppDelegate.h"
#import "GeTuiSdk.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate (Services) <GeTuiSdkDelegate>
//推送
-(void)pushServices;

//键盘遮挡
-(void)KeyboardManager;
@end
