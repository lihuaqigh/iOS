//
//  KCNetWorkSpecial.h
//  Noob2017
//
//  Created by lihuaqi on 17/4/21.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//


//特定需求的网络接口

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

@interface KCNetWorkSpecial : NSObject
//登录
+ (void)loginRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler;
//单图上传
+ (void)uploadImage:(UIImage *)image success:(requestSuccessBlock)successHandler error:(requestFailureBlock)failureHandler;
@end
