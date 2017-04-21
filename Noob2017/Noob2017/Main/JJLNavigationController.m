//
//  JJLNavigationController.m
//  OverseasStudy
//
//  Created by wtw on 15/10/9.
//  Copyright © 2015年 jjl. All rights reserved.
//

#import "JJLNavigationController.h"

@interface JJLNavigationController ()

@end

@implementation JJLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarAppearance];
}

#pragma mark - 统一设置导航栏的外观
- (void)setNavigationBarAppearance {
    // 获取导航栏的外观代理对象
    //UINavigationBar *navBar = [UINavigationBar appearance];
    // 设置统一个背景图片
    //[navBar setBackgroundImage:[UIImage imageNamed:@"nav-bg"] forBarMetrics:UIBarMetricsDefault];
    // 统一设置状态栏的标题文字效果
//    NSDictionary *attrs = @{NSForegroundColorAttributeName : [UIColor blackColor]};
//    [navBar setTitleTextAttributes:attrs];
    // 设置导航栏中的其他按钮的文字颜色
    //[navBar setTintColor:[UIColor whiteColor]];
}
#pragma mark - 统一设置状态栏的外观
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - 拦截所有的push进来的子控制器，设置隐藏底部的tabBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.view.backgroundColor =[UIColor whiteColor];
    if (self.viewControllers.count >1) {
        // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
    }
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"";
    viewController.navigationItem.backBarButtonItem = returnButtonItem;
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}


@end
