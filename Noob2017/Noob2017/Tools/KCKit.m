//
//  KCKit.m
//  Noob2017
//
//  Created by lihuaqi on 17/4/6.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "KCKit.h"

@implementation KCKit
//创建Label
+(UILabel*)createLbWithFrame:(CGRect)frame Text:(NSString*)text font:(CGFloat)font {
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    label.text=text;
    label.font=[UIFont systemFontOfSize:font];
    return label;
}
//创建Button
+(UIButton*)createBtnWithFrame:(CGRect)frame Text:(NSString*)text ImageName:(NSString*)imageName bgImageName:(NSString*)bgImageName Target:(id)target method:(SEL)Method {
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (bgImageName) {
        [button setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    [button addTarget:target action:Method forControlEvents:UIControlEventTouchUpInside];
    if (text) {
        [button setTitle:text forState:UIControlStateNormal];
    }
    return button;
}
+(UIButton*)createBtnWithFrame:(CGRect)frame Text:(NSString*)text TextColor:(NSString*)textColor TextFontSize:(CGFloat)fontSize bgColor:(NSString*)bgColor Target:(id)target method:(SEL)Method {
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    if (text.length>0) {
        [button setTitle:text forState:UIControlStateNormal];
    }
    if (textColor.length>0) {
        [button setTitleColor:[UIColor colorFromHexString:textColor] forState:UIControlStateNormal];
    }
    if (fontSize) {
        button.titleLabel.font = [UIFont fontWithName:K_CHANGE_TEXT_FONT size:fontSize];
        
    }
    if (bgColor.length>0) {
        [button setBackgroundColor:[UIColor colorFromHexString:bgColor]];
    }
    [button addTarget:target action:Method forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
//创建ImageView
+(UIImageView*)createIvWithFrame:(CGRect)frame ImageName:(NSString*)imageName {
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.image=[UIImage imageNamed:imageName];
    imageView.userInteractionEnabled=YES;
    return imageView;
}

@end
