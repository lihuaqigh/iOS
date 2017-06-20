//
//  KCNetWorkSpecial.m
//  Noob2017
//
//  Created by lihuaqi on 17/4/21.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "KCNetWorkSpecial.h"
#import "AFNetworking.h"
#import "KCUrlConfig.h"
static const NSTimeInterval kTimeOutInterval = 8.0;// 请求超时的时间
@implementation KCNetWorkSpecial
+ (void)loginRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler {
    
    if (![self checkNetworkStatus]) {
        successHandler(nil);
        return;
    }
    
    [SVP showWithStatus:@"Loading..."];
    
    NSString *urlStr = [KCUrlConfig posturl:url];
    
    AFHTTPSessionManager *manager = [self getRequstManager];
    
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVP dismissSVP];
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [KCCommonTool common_jsonTodic:responseStr];
        if ([dic[@"code"] intValue] == 200) {
            NSDictionary *result = dic[@"result"];
            [[NSUserDefaults standardUserDefaults] setObject:result[@"access_token"] forKey:@"access_token"];
            [[NSUserDefaults standardUserDefaults] setObject:result[@"Mobile_number"] forKey:@"Mobile_number"];
        }
        successHandler(dic);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVP showErrorWithStatus:@"您的网络好像不给力哦~"];
        debugLog(@"%@",error);
    }];
}

//单图上传
+ (void)uploadImage:(UIImage *)image success:(requestSuccessBlock)successHandler error:(requestFailureBlock)failureHandler{
    if (![self checkNetworkStatus]) {
        successHandler(nil);
        return;
    }
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:kUploadserverOne parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imgData = UIImageJPEGRepresentation(image, 0.8f);
        [formData appendPartWithFileData:imgData name:@"file" fileName:@"xxx.png" mimeType:@"image/png"];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    manager.responseSerializer = responseSerializer;

    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:nil
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"图片单传Error: %@", error);
                      } else {
                          NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                          NSDictionary *dic = [KCCommonTool common_jsonTodic:responseStr];
                          successHandler(dic);
                      }
                  }];
    
    [uploadTask resume];
    
    
    
    
    
}

+ (AFHTTPSessionManager *)getRequstManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *access_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    if (access_token.length>0) {
        [manager.requestSerializer setValue:access_token forHTTPHeaderField:@"Access_Token"];
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
