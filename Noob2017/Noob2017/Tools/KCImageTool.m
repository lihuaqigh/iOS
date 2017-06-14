//
//  KCImageTool.m
//  Noob2017
//
//  Created by lihuaqi on 2017/6/14.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "KCImageTool.h"

@implementation KCImageTool
+(UIImage*)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth {

    CGFloat width = newImageWidth;
    
    CGFloat height = (width *image.size.height)/image.size.width;

    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    [image drawInRect:CGRectMake(0,0,width,height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, [UIScreen mainScreen].scale);
//    
//    [image drawInRect:CGRectMake(0, 0, width, height)];
//    
//    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return scaledImage;   //返回的就是已经改变的图片
}

+(UIImage *)tailoringImage:(UIImage *)image newWidth:(CGFloat)newImageWidth {
    CGFloat width = newImageWidth;
    
    CGFloat height = (width *image.size.height)/image.size.width;
    
    CGRect rect =  CGRectMake(0, 0, width, height);//要裁剪的图片区域，按照原图的像素大小，超过原图大小的边自动适配
    
    CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
    
    UIImage * newImage = [UIImage imageWithCGImage:cgimg];
    
    CGImageRelease(cgimg);//用完一定要释放，否则内存泄露
    
    return newImage;
}
@end
