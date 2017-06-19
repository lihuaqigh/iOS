//
//  B_RegistViewController.m
//  Noob2017
//
//  Created by lihuaqi on 17/4/6.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "B_RegistViewController.h"
#import "SVProgressHUD.h"

@interface B_RegistViewController ()
@property (nonatomic, strong) UITextField *userTf;
@property (nonatomic, strong) UITextField *passTf;
@end

@implementation B_RegistViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navTitle = @"注册(2/2)";
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

-(void)createUI {
    CGFloat iconIv_W = 130*SizeScale;
    UIImageView *iconIv = [KCKit createImgVWithFrame:CGRectMake((WIDTH-iconIv_W)*.5, 90, iconIv_W, iconIv_W) imageName:@"logo"];
    [self.view addSubview:iconIv];
    
    //密码
    CGFloat userBg_X = 25*SizeScale;
    UIView *userBg = [[UIView alloc]initWithFrame:CGRectMake(userBg_X, CGRectGetMaxY(iconIv.frame)+50, WIDTH-userBg_X*2, 44*SizeScale)];
    userBg.backgroundColor = [UIColor colorFromHexString:Kd9dadb];
    userBg.layer.cornerRadius = 5.0;
    [self.view addSubview:userBg];
    
    UIImageView *userIv = [KCKit createImgVWithFrame:CGRectMake(15, (44*SizeScale-70/3)*.5, 60/3, 70/3) imageName:@"lock"];
    [userBg addSubview:userIv];
    
    self.userTf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userIv.frame)+15, 0, WIDTH-50*SizeScale-50, 44*SizeScale)];
    _userTf.placeholder = @"请输入密码(6-20位)";
    _userTf.secureTextEntry = YES;
    _userTf.textColor = [UIColor colorFromHexString:k4c4c4c];
    _userTf.font = [UIFont fontWithName:K_CHANGE_TEXT_FONT size:14*SizeScale];
    [userBg addSubview:_userTf];
    
    //密码确认
    UIView *passBg = [[UIView alloc]initWithFrame:CGRectMake(userBg_X, CGRectGetMaxY(userBg.frame)+20, WIDTH-userBg_X*2, 44*SizeScale)];
    passBg.backgroundColor = [UIColor colorFromHexString:Kd9dadb];
    passBg.layer.cornerRadius = 5.0;
    [self.view addSubview:passBg];
    
    UIImageView *passIv = [KCKit createImgVWithFrame:CGRectMake(15, (44*SizeScale-70/3)*.5, 60/3, 70/3) imageName:@"lock"];
    [passBg addSubview:passIv];
    
    self.passTf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userIv.frame)+15, 0, WIDTH-50*SizeScale-50, 44*SizeScale)];
    _passTf.placeholder = @"请再次输入密码(6-20位)";
    _passTf.secureTextEntry = YES;
    _passTf.textColor = [UIColor colorFromHexString:k4c4c4c];
    _passTf.font = [UIFont fontWithName:K_CHANGE_TEXT_FONT size:14*SizeScale];
    [passBg addSubview:_passTf];
    
    UIButton *loginBtn = [KCKit createBtnWithFrame:CGRectMake(CGRectGetMinX(passBg.frame), CGRectGetMaxY(passBg.frame)+25*SizeScale, CGRectGetWidth(passBg.frame), CGRectGetHeight(passBg.frame)) Text:@"完成注册" TextColor:Kffffff TextFontSize:16*SizeScale bgColor:K2088e2 Target:self method:@selector(regist)];
    loginBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:loginBtn];
}
#pragma 注册
-(void)regist {
    if ([_passTf.text isEqualToString:_userTf.text]) {
        [KCNetworkTool postRequest:@"auth" params:
                                                @{
                                                  @"action":@"register",
                                                  @"params":@{@"user_name":_user_name,
                                                              @"password":_passTf.text,
                                                              @"verify_code":_verify_code
                                                              }
                                                  } success:^(id obj) {
                                                        if ([obj[@"code"] intValue] == 200) {
                                                            [self successRegist];
                                                        }else {
                                                            [SVP showErrorWithStatus:[NSString stringWithFormat:@"%@",obj[@"message"]]];
                                                        }
         }];
    }else {
        [SVP showErrorWithStatus:@"两次设置的密码不一致"];
    }
    
}

-(void)successRegist {
    [SVProgressHUD showSuccessWithStatus:@"注册成功,自动登录中~"];
    [SVProgressHUD dismissWithDelay:1.0 completion:^{
        NSString *agent_idfa = [NSString stringWithFormat:@"App-iOS-%@",[SimulateIDFA createSimulateIDFA]];
        [KCNetWorkSpecial loginRequest:@"auth" params:
                                                 @{
                                                   @"action":@"login",
                                                   @"params":@{@"user_name":_user_name,
                                                               @"password":_passTf.text,
                                                               @"agent_idfa":agent_idfa
                                                               }
                                                   } success:^(id obj) {
               if ([obj[@"code"] intValue] == 200) {
                   [[NSNotificationCenter defaultCenter] postNotificationName:KApploginSuccess object:nil];
               }else {
                   [SVP showErrorWithStatus:[NSString stringWithFormat:@"%@",obj[@"message"]]];
               }
        }];
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
