//
//  KCCommonTool.h
//  Noob2017
//
//  Created by lihuaqi on 17/4/12.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCCommonTool : NSObject
//字典转JSON
+(NSString *)common_dicToJson:(NSDictionary *)dict;
    
//JSON转字典
+(NSDictionary *)common_jsonTodic:(NSString *)jsonString;
    
//检测合法手机号
+(BOOL)common_mobile:(NSString *)mobile;
@end
