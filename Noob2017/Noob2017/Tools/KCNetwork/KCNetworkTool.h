//
//  KCNetworkTool.h
//  Noob2017
//
//  Created by lihuaqi on 17/4/7.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 请求成功block
 */
typedef void (^requestSuccessBlock)(id obj);

/**
 请求失败block
 */
typedef void (^requestFailureBlock) (NSError *error);

/**
 请求响应block
 */
typedef void (^responseBlock)(id dataObj, NSError *error);

@interface KCNetworkTool : NSObject

/**
 GET请求(默认是：有SVP弹窗)
 */
+ (void)getRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler;
+ (void)getRequest:(NSString *)url params:(NSDictionary *)params show:(BOOL)show success:(requestSuccessBlock)successHandler;

/**
 POST请求()
 */
+ (void)postRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler;
+ (void)postRequest:(NSString *)url params:(NSDictionary *)params show:(BOOL)show success:(requestSuccessBlock)successHandler;

@end
