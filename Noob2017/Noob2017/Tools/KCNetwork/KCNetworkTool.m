//
//  KCNetworkTool.m
//  Noob2017
//
//  Created by lihuaqi on 17/4/7.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "KCNetworkTool.h"
#import "AFNetworking.h"
#import "KCUrlConfig.h"
static const NSTimeInterval kTimeOutInterval = 8.0;// 请求超时的时间
@implementation KCNetworkTool

+ (void)getRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler {
    
    //网络不可用
    if (![self checkNetworkStatus]) {
        successHandler(nil);
        return;
    }
    
    [SVP show];
    
    AFHTTPSessionManager *manager = [self getRequstManager];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVP dismissSVP];
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [KCCommonTool common_jsonTodic:responseStr];
        successHandler(dic);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVP showErrorWithStatus:@"您的网络好像不给力哦~"];
        debugLog(@"%@",error);
    }];

}

+ (void)getRequest:(NSString *)url params:(NSDictionary *)params show:(BOOL)show success:(requestSuccessBlock)successHandler {
    
    //网络不可用
    if (![self checkNetworkStatus]) {
        successHandler(nil);
        return;
    }
    
    if (show) {
        [SVP show];
    }
    
    AFHTTPSessionManager *manager = [self getRequstManager];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVP dismissSVP];
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [KCCommonTool common_jsonTodic:responseStr];
        successHandler(dic);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVP showErrorWithStatus:@"您的网络好像不给力哦~"];
        debugLog(@"%@",error);
    }];
    
}

+ (void)postRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler {
    
    if (![self checkNetworkStatus]) {
        successHandler(nil);
        return;
    }
    
    [SVP show];
    
    NSString *urlStr = [KCUrlConfig posturl:url];
    
    AFHTTPSessionManager *manager = [self getRequstManager];
    
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVP dismissSVP];
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [KCCommonTool common_jsonTodic:responseStr];
        successHandler(dic);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVP showErrorWithStatus:@"您的网络好像不给力哦~"];
        debugLog(@"%@",error);
    }];
}

+ (void)postRequest:(NSString *)url params:(NSDictionary *)params show:(BOOL)show success:(requestSuccessBlock)successHandler {
    
    if (![self checkNetworkStatus]) {
        successHandler(nil);
        return;
    }
    
    if (show) {
        [SVP show];
    }
    
    NSString *urlStr = [KCUrlConfig posturl:url];
    
    AFHTTPSessionManager *manager = [self getRequstManager];
    
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVP dismissSVP];
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [KCCommonTool common_jsonTodic:responseStr];
        successHandler(dic);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVP showErrorWithStatus:@"您的网络好像不给力哦~"];
        debugLog(@"%@",error);
    }];
}




+ (AFHTTPSessionManager *)getRequstManager {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Access-Token"]) {
        [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"Access-Token"] forHTTPHeaderField:@"Access-Token"];
    }
    
    //网络请求返回的数据类型格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //如果报接受类型不一致请替换一致text/html  或者 text/plain
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    //请求超时，时间设置
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    
    return manager;
}


/**
 监控网络状态
 */
+ (BOOL)checkNetworkStatus {
    
    __block BOOL isNetworkUse = YES;
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusNotReachable){
            // 网络异常操作
            isNetworkUse = NO;
        }
    }];
    [reachabilityManager startMonitoring];
    return isNetworkUse;
}

@end
