//
//  WXShareView.h
//  Noob2017
//
//  Created by lihuaqi on 2017/6/13.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KCShareView : UIView
//-(instancetype)initUrlString:(NSString *)urlString
//                       Title:(NSString *)title
//                 Description:(NSString *)description
//                  ThumbImage:(UIImage *)thumbImage
//                   imageData:(NSData *)imageData
//                   shareType:(NSString *)shareType;

//ThumbImage缩略图，imageData分享到微信的图片
//分享网页
+(void)showWebpageUrlString:(NSString *)urlString
             Title:(NSString *)title
       Description:(NSString *)description
        ThumbImage:(UIImage *)thumbImage;

//分享图片
+(void)showImageTitle:(NSString *)title
      ThumbImage:(UIImage *)thumbImage
       imageData:(NSData *)imageData;


@end
