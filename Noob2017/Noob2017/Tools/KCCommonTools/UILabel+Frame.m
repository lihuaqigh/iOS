//
//  UILabel+Frame.m
//  计算宽高Label
//
//  Created by lihuaqi on 16/10/24.
//  Copyright © 2016年 lihuaqi. All rights reserved.
//

#import "UILabel+Frame.h"

@implementation UILabel (Frame)
//根据内容计算Label动态高度（参数：宽高限定，文本，字号）
+(CGFloat)getHeightOfW:(CGFloat)width andText:(NSString *)text andFontSize:(CGFloat)fontSize
{
    CGSize size =CGSizeMake(width,MAXFLOAT);
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:K_CHANGE_TEXT_FONT size:fontSize],NSFontAttributeName,nil];
    CGSize sizeLabel =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:dict context:nil].size;
    return sizeLabel.height;
}
//根据内容计算Label动态高度（参数：宽高限定，文本，字号,行高）
+(CGFloat)getHeightOfW:(CGFloat)width andText:(NSString *)text andFontSize:(CGFloat)fontSize andLineSpacing:(CGFloat)lineSpacing
{
    CGSize size =CGSizeMake(width,MAXFLOAT);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;// 字体的行间距
    
    NSDictionary *dict = @{
                           NSFontAttributeName: [UIFont fontWithName:K_CHANGE_TEXT_FONT size:fontSize],
                           NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    CGSize sizeLabel =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:dict context:nil].size;
    
    return sizeLabel.height;
}
//根据内容计算Label动态宽度（参数：宽高限定，文本，字号）
+(CGFloat)getwidthOfH:(CGFloat)height andText:(NSString *)text andFontSize:(CGFloat)fontSize
{
    CGSize size =CGSizeMake(MAXFLOAT,height);
    NSDictionary *dict = @{
                           //NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                           NSFontAttributeName:[UIFont fontWithName:K_CHANGE_TEXT_FONT size:fontSize],
                           };
    CGSize sizeLabel =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:dict context:nil].size;
    return sizeLabel.width;
}
//给数字加颜色
+(NSMutableAttributedString * )setColorWithText:(NSString*)text andColorStr:(NSString*)colorStr
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    for (int i = 0; i < text.length; i ++) {
        //这里的小技巧，每次只截取一个字符的范围
        NSString *a = [text substringWithRange:NSMakeRange(i, 1)];
        //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
        NSString *phoneRegex = @"^[0-9]*$";
        NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        if ([regexTestMobile evaluateWithObject:a]) {
            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:colorStr] range:NSMakeRange(i, 1)];
        }
    }
    return attributeString;
}
@end
