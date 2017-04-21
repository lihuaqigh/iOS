//
//  SVP.h
//  Noob2017
//
//  Created by lihuaqi on 17/4/6.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVP : NSObject
/**
 *  显示SVP,需要手动关闭(是否支持用户交互)
 */
+ (void)show;

/**
 *  显示加载数据,需要手动关闭
 */
+ (void)showWithStatus:(NSString *)status;

/**
 *  显示成功数据
 */
+ (void)showSuccessWithStatus:(NSString *)status;

/**
 *  显示失败数据
 */
+ (void)showErrorWithStatus:(NSString *)status;

/**
 *  取消显示框
 */
+ (void)dismissSVP;

/**
 *  显示普通数据
 */
+ (void)showNormalMessage:(NSString *)message;
@end
