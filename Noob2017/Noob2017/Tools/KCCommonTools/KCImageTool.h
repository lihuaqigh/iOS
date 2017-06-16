//
//  KCImageTool.h
//  Noob2017
//
//  Created by lihuaqi on 2017/6/14.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCImageTool : NSObject
+(UIImage*)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth;
+(UIImage *)tailoringImage:(UIImage *)image newWidth:(CGFloat)newImageWidth;
@end
