//
//  WeiboApiManager.h
//  Noob2017
//
//  Created by lihuaqi on 2017/6/15.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"

@protocol WeiboAuthDelegate <NSObject>

@optional
- (void)weiboAuthSucceed:(NSString*)code;
- (void)weiboAuthDenied;
- (void)weiboAuthCancel;

@end
@interface WeiboApiManager : NSObject <WeiboSDKDelegate>

@property (nonatomic, assign) id<WeiboAuthDelegate, NSObject> delegate;

/**
 *  严格单例，唯一获得实例的方法.
 *
 *  @return 实例对象.
 */

+ (instancetype)sharedManager;

- (void)sendWeiboLinkContent:(NSString *)urlString
                        Title:(NSString *)title;
@end
