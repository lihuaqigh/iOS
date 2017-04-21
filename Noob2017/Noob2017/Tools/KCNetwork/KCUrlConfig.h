//
//  KCURLandParams.h
//  Noob2017
//
//  Created by lihuaqi on 17/4/18.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCUrlConfig : NSObject

+(NSString *)geturl:(NSString *)url params:(NSDictionary *)params;
+(NSString *)posturl:(NSString *)url;
@end
