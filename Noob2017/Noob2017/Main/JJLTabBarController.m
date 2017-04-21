//
//  JJLTabBarController.m
//  OverseasStudy
//
//  Created by wtw on 15/10/9.
//  Copyright © 2015年 jjl. All rights reserved.
//

#import "JJLTabBarController.h"
#import "JJLNavigationController.h"
//#import "JJLCustomizationController.h"
//#import "JJLHomepageController.h"
#import "JJLProfileController.h"


@interface JJLTabBarController ()

@end

@implementation JJLTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加所有的控制器
    [self setupAllChildVc];
}

#pragma mark - 添加所有的子控制器
- (void)setupAllChildVc {
    [self addChildVcWithName:@"JJLProfileController" title:@"我的" image:[UIImage imageNamed:@"my"] selectedImage:[UIImage imageWithOriginalName:@"my-select"]];
    [self addChildVcWithName:@"UIViewController" title:@"首页" image:[UIImage imageNamed:@"home"] selectedImage:[UIImage imageWithOriginalName:@"home-select"]];
    [self addChildVcWithName:@"UIViewController" title:@"发现" image:[UIImage imageNamed:@"discver"] selectedImage:[UIImage imageWithOriginalName:@"discver-select"]];
    [self addChildVcWithName:@"UIViewController" title:@"动态" image:[UIImage imageNamed:@"Customized"] selectedImage:[UIImage imageWithOriginalName:@"Customized-select"]];
}

#pragma mark - 抽取一个添加子控制器的方法
- (void)addChildVcWithName:(NSString *)childControllerName title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    
    UIViewController *childController = [[NSClassFromString(childControllerName) alloc]init];
    childController.title = title;
    childController.tabBarItem.image = image;
    childController.tabBarItem.selectedImage = selectedImage;
    
    UIColor *color = [UIColor colorWithRed:253/255.0 green:75/255.0 blue:48/255.0 alpha:1];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    //导航控制器
    JJLNavigationController *nav =[[JJLNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
