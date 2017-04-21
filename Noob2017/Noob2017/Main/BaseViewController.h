//
//  BaseViewController.h
//  Noob2017
//
//  Created by lihuaqi on 17/4/5.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic,copy) NSString *navTitle;
@property (nonatomic,strong) UILabel *topbarLb;
@property (nonatomic,assign) BOOL isHideLeftPop;
- (void)leftBtnPop;
//- (void)createHUD:(NSString*)textStr __attribute__((objc_requires_super));
//- (void)haha __attribute__((objc_requires_super));
@end
