//
//  NGShoppingCarModel.h
//  Noob2017
//
//  Created by lihuaqi on 17/3/2.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGShoppingCarModel : NSObject
@property (nonatomic, copy) NSString *goodName;
@property (nonatomic, copy) NSString *goodPrice;
@property (nonatomic, copy) NSString *goodCount;
@property (nonatomic, copy) NSString *goodType;
@property (nonatomic, assign) BOOL selected;//是否购买
@property (nonatomic, assign) BOOL deleted;//是否删除
@property (nonatomic, assign) BOOL edited;//是否是编辑模式
@end
