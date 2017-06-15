//
//  WXShareView.h
//  Noob2017
//
//  Created by lihuaqi on 2017/6/13.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KCShareView : UIView
//ThumbImage缩略图，imageData分享到微信的图片
//分享网页
+(void)showWebpageUrlString:(NSString *)urlString
             title:(NSString *)title
       description:(NSString *)description
        thumbImage:(UIImage *)thumbImage
        imageData:(NSData *)imageData;

//分享图片
+(void)showImageUrlString:(NSString *)urlString
                title:(NSString *)title
              description:(NSString *)description
      thumbImage:(UIImage *)thumbImage
       imageData:(NSData *)imageData;


@end
