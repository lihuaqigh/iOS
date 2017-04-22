//
//  LoginViewController.m
//  Noob2017
//
//  Created by lihuaqi on 2017/4/5.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "LoginViewController.h"
#import "A_RegistViewController.h"
#import "A_ForgetViewController.h"
#import "JJLTabBarController.h"

@interface LoginViewController ()
@property (nonatomic, strong) UITextField *userTf;
@property (nonatomic, strong) UITextField *passTf;
@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.alpha = 1.0;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

-(void)createUI {
    CGFloat iconIv_W = 130*SizeScale;
    UIImageView *iconIv = [KCKit createIvWithFrame:CGRectMake((WIDTH-iconIv_W)*.5, 90, iconIv_W, iconIv_W) ImageName:@"logo"];
    [self.view addSubview:iconIv];
    
    CGFloat userBg_X = 25*SizeScale;
    UIView *userBg = [[UIView alloc]initWithFrame:CGRectMake(userBg_X, CGRectGetMaxY(iconIv.frame)+50, WIDTH-userBg_X*2, 44*SizeScale)];
    userBg.backgroundColor = [UIColor colorFromHexString:Kd9dadb];
    userBg.layer.cornerRadius = 5.0;
    [self.view addSubview:userBg];
    
    UIImageView *userIv = [KCKit createIvWithFrame:CGRectMake(15, (44*SizeScale-70/3)*.5, 60/3, 70/3) ImageName:@"user"];
    [userBg addSubview:userIv];
    
    self.userTf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userIv.frame)+15, 0, WIDTH-50*SizeScale-50, 44*SizeScale)];
    _userTf.placeholder = @"手机号";
    _userTf.keyboardType = UIKeyboardTypeNumberPad;
    _userTf.textColor = [UIColor colorFromHexString:k4c4c4c];
    _userTf.font = [UIFont fontWithName:K_CHANGE_TEXT_FONT size:14*SizeScale];
    [userBg addSubview:_userTf];
    
    UIView *passBg = [[UIView alloc]initWithFrame:CGRectMake(userBg_X, CGRectGetMaxY(userBg.frame)+20, WIDTH-userBg_X*2, 44*SizeScale)];
    passBg.backgroundColor = [UIColor colorFromHexString:Kd9dadb];
    passBg.layer.cornerRadius = 5.0;
    [self.view addSubview:passBg];
    
    UIImageView *passIv = [KCKit createIvWithFrame:CGRectMake(15, (44*SizeScale-70/3)*.5, 60/3, 70/3) ImageName:@"lock"];
    [passBg addSubview:passIv];
    
    self.passTf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userIv.frame)+15, 0, WIDTH-50*SizeScale-50, 44*SizeScale)];
    _passTf.placeholder = @"密码";
    _passTf.secureTextEntry = YES;
    _passTf.textColor = [UIColor colorFromHexString:k4c4c4c];
    _passTf.font = [UIFont fontWithName:K_CHANGE_TEXT_FONT size:14*SizeScale];
    [passBg addSubview:_passTf];
    
    UIButton *loginBtn = [KCKit createBtnWithFrame:CGRectMake(CGRectGetMinX(passBg.frame), CGRectGetMaxY(passBg.frame)+25*SizeScale, CGRectGetWidth(passBg.frame), CGRectGetHeight(passBg.frame)) Text:@"登    录" TextColor:Kffffff TextFontSize:16*SizeScale bgColor:K2088e2 Target:self method:@selector(login)];
    loginBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:loginBtn];
    
    UIButton *registBtn = [KCKit createBtnWithFrame:CGRectMake(CGRectGetMinX(passBg.frame)+10, CGRectGetMaxY(loginBtn.frame), 120, CGRectGetHeight(passBg.frame)) Text:@"注册" TextColor:k9a9a9a TextFontSize:14*SizeScale bgColor:nil Target:self method:@selector(regist)];
    registBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:registBtn];
    
    UIButton *forgetBtn = [KCKit createBtnWithFrame:CGRectMake(CGRectGetMaxX(passBg.frame)-130, CGRectGetMaxY(loginBtn.frame), 120, CGRectGetHeight(passBg.frame)) Text:@"忘记密码？" TextColor:k9a9a9a TextFontSize:14*SizeScale bgColor:nil Target:self method:@selector(forget)];
    forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:forgetBtn];
    
    //其他登录方式分割线
    UIImageView *otherImage = [KCKit createIvWithFrame:CGRectMake((WIDTH-287*SizeScale)/2, HEIGHT-114*SizeScale, 287*SizeScale, 14*SizeScale) ImageName:@"otherlogin"];
    [self.view addSubview:otherImage];
    
    //使用微信登陆
    UIButton *WXbtn = [[UIButton alloc]initWithFrame:CGRectMake(36 * SizeScale, HEIGHT - 30 * SizeScale - 40 * SizeScale, 277/2 * SizeScale, 40 * SizeScale)];
    [WXbtn setBackgroundImage:[UIImage imageNamed:@"login-wechat-btn"] forState:UIControlStateNormal];
    [WXbtn addTarget:self action:@selector(WXlogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:WXbtn];
    
    //使用微博登陆
    UIButton *WBlogin = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH - 277/2 * SizeScale - 36 * SizeScale, HEIGHT - 30 * SizeScale - 40 * SizeScale, 277/2 * SizeScale, 40 * SizeScale)];
    [WBlogin setBackgroundImage:[UIImage imageNamed:@"login-weibo-btn"] forState:UIControlStateNormal];
    [WBlogin addTarget:self action:@selector(WBlogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:WBlogin];
}

#pragma 登录(手机号，微信，微博)
-(void)login {
    if (_userTf.text.length == 0) {
        [SVP showErrorWithStatus:@"用户名不能为空"];
        return;
    }
    if (_passTf.text.length == 0) {
        [SVP showErrorWithStatus:@"密码不能为空"];
        return;
    }
    
    NSString *agent_idfa = [NSString stringWithFormat:@"App-iOS-%@",[SimulateIDFA createSimulateIDFA]];
    [KCNetWorkSpecial loginRequest:@"auth" params:
                                         @{
                                           @"action":@"login",
                                           @"params":@{@"user_name":_userTf.text,
                                                       @"verify_code":@"",
                                                       @"password":_passTf.text,
                                                       @"agent_idfa":agent_idfa
                                                       }
                                           } success:^(id obj) {
                   
                   if ([obj[@"code"] intValue] == 200) {
                       [self loginSuccess];
                   }else {
                       [SVP showErrorWithStatus:[NSString stringWithFormat:@"%@",obj[@"message"]]];
                   }
        
    }];
}
-(void)WXlogin {
    [SVP showWithStatus:@"微信登录"];
}

-(void)WBlogin {
    [SVP showSuccessWithStatus:@"微博登录"];
//    [KCNetworkTool getRequest:@"http://120.77.213.246:80/user/token" params:@{} success:^(id obj) {
//        NSLog(@"%@",obj);
//    }];
}

#pragma 注册
-(void)regist {
    A_RegistViewController *vc =[[A_RegistViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma 忘记密码
-(void)forget {
    A_ForgetViewController *vc =[[A_ForgetViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loginSuccess {
    [SVP showSuccessWithStatus:@"登录成功"];
    [[NSNotificationCenter defaultCenter] postNotificationName:KApploginSuccess object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
