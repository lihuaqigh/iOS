//
//  SVP.m
//  Noob2017
//
//  Created by lihuaqi on 17/4/6.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "SVP.h"
#import "SVProgressHUD.h"
static const NSTimeInterval kMinDismissInterval = 6.0;// 请求超时的时间
static const NSTimeInterval kSuccessInterval = 1.0;// 成功和失败的提示时间

@implementation SVP

//弹出显示框期间（默认不可以交互）
+ (void)show {
    [self configSVPWithInterval:kMinDismissInterval];
    [SVProgressHUD show];
}

+ (void)showWithStatus:(NSString *)status {
    [self configSVPWithInterval:kMinDismissInterval];
    if(status.length > 0) [SVProgressHUD showWithStatus:status];
}

+ (void)showSuccessWithStatus:(NSString *)status {
    [self configSVPWithInterval:kSuccessInterval];
    if(status.length > 0) [SVProgressHUD showSuccessWithStatus:status];
}

+ (void)showErrorWithStatus:(NSString *)status {
    [self configSVPWithInterval:kSuccessInterval];
    if(status.length > 0) {
        [SVProgressHUD showErrorWithStatus:status];
    }
}

+ (void)configSVPWithInterval:(NSTimeInterval)Interval  {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMinimumDismissTimeInterval:Interval];
}

+ (void)dismissSVP {
    [SVProgressHUD dismiss];
}


+ (void)showNormalMessage:(NSString *)message {
//    UIAlertView *alterView =  [[UIAlertView alloc]initWithTitle:@"子彬直播" message:message delegate:nil cancelButtonTitle:@
//                               "知道了"otherButtonTitles:nil, nil];
//    [alterView show];
}
@end
