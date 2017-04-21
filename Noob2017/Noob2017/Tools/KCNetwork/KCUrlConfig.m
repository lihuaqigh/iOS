//
//  KCURLandParams.m
//  Noob2017
//
//  Created by lihuaqi on 17/4/18.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "KCUrlConfig.h"

@implementation KCUrlConfig

+(NSString *)geturl:(NSString *)url params:(NSDictionary *)params {
    
    NSString *urlStr = @"";
    return urlStr;
}

+(NSString *)posturl:(NSString *)url {
    
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"%@/%@",KCTestUrl,url];
    return urlStr;
}

@end
