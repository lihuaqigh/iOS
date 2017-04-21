//
//  UIControl+Safety.m
//  Noob2017
//
//  Created by lihuaqi on 17/2/20.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "UIControl+Safety.h"
#import <objc/runtime.h>
static const char kSafety_ignoreEventTime;
static const char kSafety_acceptEventInterval;
@interface UIControl ()
@property (nonatomic, assign) NSTimeInterval safety_ignoreEventTime;
@end
@implementation UIControl (Safety)
+(void)load {
    [self swizzleMethod:@selector(sendAction:to:forEvent:) anotherMethod:@selector(safety_sendAction:to:forEvent:)];
}
+ (void)swizzleMethod:(SEL)oneSel anotherMethod:(SEL)anotherSel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oneMethod = class_getInstanceMethod(self, oneSel);
        Method anotherMethod = class_getInstanceMethod(self, anotherSel);
        if (!oneMethod || !anotherMethod) return;
        method_exchangeImplementations(oneMethod, anotherMethod);
    });
}
- (void)safety_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (NSDate.date.timeIntervalSince1970 - self.safety_ignoreEventTime < self.safety_acceptEventInterval) {
        return;
    }
    
    if (self.safety_acceptEventInterval > 0) {
        self.safety_ignoreEventTime = NSDate.date.timeIntervalSince1970;
    }
    [self safety_sendAction:action to:target forEvent:event];
}

#pragma mark property 关联属性
- (NSTimeInterval)safety_ignoreEventTime {
    return [objc_getAssociatedObject(self, &kSafety_ignoreEventTime) doubleValue];
}

- (void)setSafety_ignoreEventTime:(NSTimeInterval)safety_ignoreEventTime {
    objc_setAssociatedObject(self, &kSafety_ignoreEventTime, @(safety_ignoreEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)safety_acceptEventInterval {
    return [objc_getAssociatedObject(self, &kSafety_acceptEventInterval) doubleValue];
}

- (void)setSafety_acceptEventInterval:(NSTimeInterval)safety_acceptEventInterval {
    objc_setAssociatedObject(self, &kSafety_acceptEventInterval, @(safety_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end


