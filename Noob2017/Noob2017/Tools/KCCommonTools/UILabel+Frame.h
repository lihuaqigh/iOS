//
//  UILabel+Frame.h
//  计算宽高Label
//
//  Created by lihuaqi on 16/10/24.
//  Copyright © 2016年 lihuaqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Frame)

+(CGFloat)getHeightOfW:(CGFloat)width andText:(NSString *)text andFontSize:(CGFloat)fontSize;
+(CGFloat)getHeightOfW:(CGFloat)width andText:(NSString *)text andFontSize:(CGFloat)fontSize andLineSpacing:(CGFloat)lineSpacing;
+(CGFloat)getwidthOfH:(CGFloat)height andText:(NSString *)text andFontSize:(CGFloat)fontSize;
+(NSMutableAttributedString * )setColorWithText:(NSString*)text andColorStr:(NSString*)colorStr;

@end
