//
//  ForgetViewController.m
//  Noob2017
//
//  Created by lihuaqi on 17/4/6.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "A_ForgetViewController.h"
#import "B_ForgetViewController.h"
@interface A_ForgetViewController ()
@property (nonatomic, strong) UITextField *userTf;
@property (nonatomic, strong) UITextField *verifyTf;
@property (nonatomic, strong) UIButton *codenBtn;
@property (nonatomic, assign) NSInteger cdTime;//倒计时
@property (nonatomic, strong) MSWeakTimer *countdownTimer;//计时器
@end

@implementation A_ForgetViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navTitle = @"重置密码(1/2)";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // app从后台进入前台都会调用这个方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
    // 添加检测app进入后台的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];
    [self createUI];
}

-(void)applicationBecomeActive {
    //此处有个问题：1后台怎么刷新UI，或进入前台前一刻刷新UI也可以
}

-(void)applicationEnterBackground {
    //程序段时间内可以在后台继续运行
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
}

-(MSWeakTimer *)countdownTimer {
    if (_countdownTimer == nil) {
        _countdownTimer = [MSWeakTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:YES dispatchQueue:dispatch_get_main_queue()];
    }
    return _countdownTimer;
}

-(void)createUI {
    CGFloat userBg_X = 25*SizeScale;
    UIView *userBg = [[UIView alloc]initWithFrame:CGRectMake(userBg_X, 64+20, (WIDTH-userBg_X*2)*.7-10, 44*SizeScale)];
    userBg.backgroundColor = [UIColor colorFromHexString:Kd9dadb];
    userBg.layer.cornerRadius = 5.0;
    [self.view addSubview:userBg];
    
    UIImageView *userIv = [KCKit createIvWithFrame:CGRectMake(15, (44*SizeScale-70/3)*.5, 60/3, 70/3) ImageName:@"user"];
    [userBg addSubview:userIv];
    
    self.userTf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userIv.frame)+15, 0, CGRectGetWidth(userBg.frame)-50-10, 44*SizeScale)];
    _userTf.placeholder = @"请输入手机号";
    _userTf.keyboardType = UIKeyboardTypeNumberPad;
    _userTf.textColor = [UIColor colorFromHexString:k4c4c4c];
    _userTf.font = [UIFont fontWithName:K_CHANGE_TEXT_FONT size:14*SizeScale];
    [userBg addSubview:_userTf];
    
    _codenBtn = [KCKit createBtnWithFrame:CGRectMake(CGRectGetMaxX(userBg.frame)+10, CGRectGetMinY(userBg.frame), (WIDTH-userBg_X*2)*.3, CGRectGetHeight(userBg.frame)) Text:@"获取验证码" TextColor:Kffffff TextFontSize:14*SizeScale bgColor:K2088e2 Target:self method:@selector(testGetCoden)];
    _codenBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:_codenBtn];
    
    UIView *passBg = [[UIView alloc]initWithFrame:CGRectMake(userBg_X, CGRectGetMaxY(userBg.frame)+20, WIDTH-userBg_X*2, 44*SizeScale)];
    passBg.backgroundColor = [UIColor colorFromHexString:Kd9dadb];
    passBg.layer.cornerRadius = 5.0;
    [self.view addSubview:passBg];
    
    UIImageView *passIv = [KCKit createIvWithFrame:CGRectMake(15, (44*SizeScale-70/3)*.5, 60/3, 70/3) ImageName:@"lock"];
    [passBg addSubview:passIv];
    
    self.verifyTf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userIv.frame)+15, 0, WIDTH-50*SizeScale-50-10, 44*SizeScale)];
    _verifyTf.placeholder = @"请输入验证码";
    _verifyTf.textColor = [UIColor colorFromHexString:k4c4c4c];
    _verifyTf.font = [UIFont fontWithName:K_CHANGE_TEXT_FONT size:14*SizeScale];
    [passBg addSubview:_verifyTf];
    
    UIButton *loginBtn = [KCKit createBtnWithFrame:CGRectMake(CGRectGetMinX(passBg.frame), CGRectGetMaxY(passBg.frame)+25*SizeScale, CGRectGetWidth(passBg.frame), CGRectGetHeight(passBg.frame)) Text:@"下一步" TextColor:Kffffff TextFontSize:16*SizeScale bgColor:K2088e2 Target:self method:@selector(nextB)];
    loginBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:loginBtn];
}

#pragma 获取验证码
-(void)testGetCoden {
    if (self.cdTime>0) return;
    
    if (![KCCommonTool common_mobile:_userTf.text]) {
        [SVP showErrorWithStatus:@"请输出正确手机号"];
        return;
    }
    
    [KCNetworkTool postRequest:@"verify" params:
                                             @{
                                               @"action":@"gain",
                                               @"params":@{@"user_name":_userTf.text,
                                                           @"verify_type":@(3)
                                                           }
                                               }success:^(id obj) {
                                                   if ([obj[@"code"] intValue] == 200) {
                                                       [SVP showSuccessWithStatus:@"短信验证已经发送成功"];
                                                   }else {
                                                       [SVP showErrorWithStatus:[NSString stringWithFormat:@"%@",obj[@"message"]]];
                                                   }
     }];
    self.cdTime = 60;
    self.countdownTimer = [MSWeakTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:YES dispatchQueue:dispatch_get_main_queue()];
    [_countdownTimer fire];
}

//倒计时
-(void)countdown{
    if (_cdTime == 0) {
        [_countdownTimer invalidate];
        [_codenBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    }else if (_cdTime > 0) {
        self.cdTime --;
        [_codenBtn setTitle:[NSString stringWithFormat:@"%ld秒",(long)_cdTime] forState:UIControlStateNormal];
    }
}

-(void)nextB {
    [KCNetworkTool postRequest:@"verify" params:
                                             @{
                                               @"action":@"verify",
                                               @"params":@{@"user_name":_userTf.text,
                                                           @"verify_type":@(3),
                                                           @"verify_code":_verifyTf.text
                                                           }
                                               } success:^(id obj) {
                                                   if ([obj[@"code"] intValue] == 200) {
                                                       B_ForgetViewController *vc = [[B_ForgetViewController alloc]init];
                                                       vc.user_name = _userTf.text;
                                                       vc.verify_code = _verifyTf.text;
                                                       [self.navigationController pushViewController:vc animated:YES];
                                                   }else {
                                                       [SVP showErrorWithStatus:[NSString stringWithFormat:@"%@",obj[@"message"]]];
                                                   }
       }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
