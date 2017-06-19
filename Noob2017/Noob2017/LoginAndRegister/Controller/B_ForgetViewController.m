//
//  B_ForgetViewController.m
//  Noob2017
//
//  Created by lihuaqi on 17/4/6.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "B_ForgetViewController.h"
#import "SVProgressHUD.h"
@interface B_ForgetViewController ()
@property (nonatomic, strong) UITextField *passTf;
@property (nonatomic, strong) UITextField *passAgainTf;
@end

@implementation B_ForgetViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navTitle = @"重置密码(2/2)";
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

-(void)createUI {
    //密码
    CGFloat userBg_X = 25*SizeScale;
    UIView *passBg = [[UIView alloc]initWithFrame:CGRectMake(userBg_X, 64+20, WIDTH-userBg_X*2, 44*SizeScale)];
    passBg.backgroundColor = [UIColor colorFromHexString:Kd9dadb];
    passBg.layer.cornerRadius = 5.0;
    [self.view addSubview:passBg];
    
    UIImageView *passIv = [KCKit createImgVWithFrame:CGRectMake(15, (44*SizeScale-70/3)*.5, 60/3, 70/3) imageName:@"lock"];
    [passBg addSubview:passIv];
    
    self.passTf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(passIv.frame)+15, 0, WIDTH-50*SizeScale-50, 44*SizeScale)];
    _passTf.placeholder = @"请输入新密码(6-20位)";
    _passTf.secureTextEntry = YES;
    _passTf.textColor = [UIColor colorFromHexString:k4c4c4c];
    _passTf.font = [UIFont fontWithName:K_CHANGE_TEXT_FONT size:14*SizeScale];
    [passBg addSubview:_passTf];
    
    //密码确认
    UIView *passAgainBg = [[UIView alloc]initWithFrame:CGRectMake(userBg_X, CGRectGetMaxY(passBg.frame)+20, WIDTH-userBg_X*2, 44*SizeScale)];
    passAgainBg.backgroundColor = [UIColor colorFromHexString:Kd9dadb];
    passAgainBg.layer.cornerRadius = 5.0;
    [self.view addSubview:passAgainBg];
    
    UIImageView *passAgainIv = [KCKit createImgVWithFrame:CGRectMake(15, (44*SizeScale-70/3)*.5, 60/3, 70/3) imageName:@"lock"];
    [passAgainBg addSubview:passAgainIv];
    
    self.passAgainTf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(passAgainIv.frame)+15, 0, WIDTH-50*SizeScale-50, 44*SizeScale)];
    _passAgainTf.placeholder = @"请再次确认密码";
    _passAgainTf.secureTextEntry = YES;
    _passAgainTf.textColor = [UIColor colorFromHexString:k4c4c4c];
    _passAgainTf.font = [UIFont fontWithName:K_CHANGE_TEXT_FONT size:14*SizeScale];
    [passAgainBg addSubview:_passAgainTf];
    
    UIButton *changePwdBtn = [KCKit createBtnWithFrame:CGRectMake(CGRectGetMinX(passBg.frame), CGRectGetMaxY(passAgainBg.frame)+25*SizeScale, CGRectGetWidth(passBg.frame), CGRectGetHeight(passBg.frame)) Text:@"完    成" TextColor:Kffffff TextFontSize:16*SizeScale bgColor:K2088e2 Target:self method:@selector(changePwd)];
    changePwdBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:changePwdBtn];
}
#pragma 修改密码
-(void)changePwd {
    if ([_passTf.text isEqualToString:_passAgainTf.text]) {
        NSString *url = [NSString stringWithFormat:@"user/%@",_user_name];
        NSString *agent_idfa = [NSString stringWithFormat:@"App-iOS-%@",[SimulateIDFA createSimulateIDFA]];
        [KCNetworkTool postRequest:url params:
                                                         @{
                                                           @"action":@"change_password",
                                                           @"params":@{@"verify_code":_verify_code,
                                                                       @"new_password":_passTf.text,
                                                                       @"agent_idfa":agent_idfa,
                                                                       @"verify_code":@(3)
                                                                       }
                                                           }success:^(id obj) {
                                                               if ([obj[@"code"] intValue] == 200) {
                                                                   [self successChange];
                                                               }else {
                                                                   [SVP showErrorWithStatus:[NSString stringWithFormat:@"%@",obj[@"message"]]];
                                                               }
           }];
    }else {
        [SVP showErrorWithStatus:@"两次设置的密码不一致"];
    }
    
}

-(void)successChange {
    [SVProgressHUD showSuccessWithStatus:@"修改成功,自动登录中~"];
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
