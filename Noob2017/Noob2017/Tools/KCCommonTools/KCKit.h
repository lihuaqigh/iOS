//
//  KCKit.h
//  Noob2017
//
//  Created by lihuaqi on 17/4/6.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCKit : NSObject
//创建Label
+(UILabel*)createLbWithFrame:(CGRect)frame text:(NSString*)text textColor:(NSString*)textColor font:(CGFloat)font;
//创建Button
+(UIButton*)createBtnWithFrame:(CGRect)frame Text:(NSString*)text ImageName:(NSString*)imageName bgImageName:(NSString*)bgImageName Target:(id)target method:(SEL)Method;
+(UIButton*)createBtnWithFrame:(CGRect)frame Text:(NSString*)text TextColor:(NSString*)textColor TextFontSize:(CGFloat)fontSize bgColor:(NSString*)bgColor Target:(id)target method:(SEL)Method;
//创建ImageView
+(UIImageView*)createImgVWithFrame:(CGRect)frame imageName:(NSString*)imageName;
@end
