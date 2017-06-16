//
//  UIColor+HexString.h
//  JMS
//
//  Created by KH on 14/12/25.
//  Copyright (c) 2014年 JMS Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

/**
 * @brief 根据十六进制获取颜色
 *
 * @param hexString 十六进制字符串. 例: #333333
 *
 * @return UIColor
 */
+ (UIColor *)colorFromHexString:(NSString *)hexString;


/**
 * @brief 根据颜色创建UIImage
 *
 * @@param color 颜色
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;


@end
