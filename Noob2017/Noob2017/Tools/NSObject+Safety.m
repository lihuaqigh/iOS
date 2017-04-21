//
//  NSObject+Safety.m
//  Test
//
//  Created by lihuaqi on 17/2/9.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "NSObject+Safety.h"
#import <objc/runtime.h>
@implementation NSObject (Safety)

@end
@implementation NSMutableArray (Safety)
+(void)load {
    [self swizzleMethod:@selector(addObject:) anotherMethod:@selector(safeAddObject:)];
}
+ (void)swizzleMethod:(SEL)oneSel anotherMethod:(SEL)anotherSel{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oneMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), oneSel);
        Method anotherMethod = class_getInstanceMethod(self, anotherSel);
        if (!oneMethod || !anotherMethod) return;
        method_exchangeImplementations(oneMethod, anotherMethod);
    });
}
- (void)safeAddObject:(id)obj {
    if (obj != nil) {
        [self safeAddObject:obj];
    } else {
        NSLog(@"数组不能加入nil object");
    }
}
@end

@implementation NSMutableDictionary(Safety)
+(void)load {
    [self swizzleMethod:@selector(setObject:forKey:) anotherMethod:@selector(safeSetObject:forKey:)];
}
+ (void)swizzleMethod:(SEL)oneSel anotherMethod:(SEL)anotherSel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oneMethod = class_getInstanceMethod(NSClassFromString(@"__NSDictionaryM"), oneSel);
        Method anotherMethod = class_getInstanceMethod(self, anotherSel);
        if (!oneMethod || !anotherMethod) return;
        method_exchangeImplementations(oneMethod, anotherMethod);
    });
}
-(void)safeSetObject:(id)value forKey:(id)key {
    if (value!=nil) {
        [self safeSetObject:value forKey:key];
    }else{
        NSLog(@"字典value 为nil");
    }
}
@end
