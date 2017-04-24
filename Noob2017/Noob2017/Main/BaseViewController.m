//
//  BaseViewController.m
//  Noob2017
//
//  Created by lihuaqi on 17/4/5.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () <UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIBarButtonItem *leftButton;
@property (nonatomic,strong) UIBarButtonItem *space;
@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorFromHexString:Kf0f5f5];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.alpha = 1.0;
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self topbar];
}
- (void)setNavTitle:(NSString *)navTitle {
    if (navTitle.length > 0) {
        _topbarLb.text = navTitle;
    }
}
-(void)setIsHideLeftPop:(BOOL)isHideLeftPop {
    _isHideLeftPop = isHideLeftPop;
    if (!_isHideLeftPop) {
        _leftButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"topbar-back-btn"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] style: UIBarButtonItemStylePlain target:self action:@selector(leftBtnPop)];
        _space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        _space.width = 0;
        self.navigationItem.leftBarButtonItems = @[_space, _leftButton];
    }else{
        self.navigationItem.leftBarButtonItems = nil;
    }
}

#pragma mark 导航
-(void)topbar{
    _topbarLb = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2-100, 12, 200, 20)];
    _topbarLb.font = [UIFont fontWithName:K_CHANGE_TEXT_FONT size:kNav_font];
    _topbarLb.textColor = [UIColor colorFromHexString:kNav_Color];
    _topbarLb.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = _topbarLb;
    
    self.isHideLeftPop = NO;
}
#pragma mark 返回上一级
- (void)leftBtnPop{
    [SVP dismissSVP];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 界面的右滑返回
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.navigationController.viewControllers.count == 1){
        return NO;
    }else {
        return YES;
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
