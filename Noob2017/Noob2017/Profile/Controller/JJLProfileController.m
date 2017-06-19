//
//  JJLProfileController.m
//  Contract
//
//  Created by lihuaqi on 15/11/23.
//  Copyright © 2015年 JJL. All rights reserved.
//

#import "JJLProfileController.h"
#import "NGShoppingCartViewController.h"
#import "JJLProfileCell.h"
#import "JJLProfileHeaderView.h"
//#import "LoginViewController.h"

@interface JJLProfileController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>

@property (nonatomic,strong) NSArray *listArray;

@property (nonatomic,strong) NSArray *descArray;

@property (nonatomic,strong) UITableView *tableview;
/** 背景图片 */
@property (nonatomic,strong) UIImageView *imageview;
/** 头像 */
@property (nonatomic,strong) UIImageView *iconview;
/** 用户名 */
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation JJLProfileController

- (NSArray *)listArray {
    if (_listArray == nil) {
        self.listArray = [NSArray arrayWithObjects:@"",@"我的徽章",@"我的课程",@"我的上传",@"",@"购物车",@"我的订单",@"优惠券",nil];
    }
    return _listArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorFromHexString:Kf0f5f5];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"我的";
    self.isHideLeftPop = YES;
    [self initTableview];
    
//    _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 200, 200)];
//    _imageview.contentMode = UIViewContentModeScaleAspectFit;
//    _imageview.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:_imageview];
}

-(void)btnClick {
    NSLog(@"登出");
    [KCNetworkTool postRequest:@"auth" params:@{@"action":@"logout"} success:^(id obj) {
        if ([obj[@"code"] intValue] == 200) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"access_token"];
            [[NSNotificationCenter defaultCenter] postNotificationName:KApplogin object:nil];
        }else {
            [SVP showErrorWithStatus:[NSString stringWithFormat:@"%@",obj[@"message"]]];
        }
    }];
}


#define BgImageHeight 160
- (void)initTableview {
    //tableview
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+10*SizeScale, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    _tableview.backgroundColor = [UIColor colorFromHexString:Kf0f5f5];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableview];
    KCWeakSelf(weakSelf);
    JJLProfileHeaderView *tableHeaderView = [[JJLProfileHeaderView alloc] initWithController:weakSelf];
    _tableview.tableHeaderView = tableHeaderView;
    
}
#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.listArray[indexPath.row];
    if (title.length == 0) {
        return 10*SizeScale;
    }else {
        return 44*SizeScale;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JJLProfileCell *cell = [JJLProfileCell cellWithTableView:tableView];
    [cell refreshTitle:self.listArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {

    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NGShoppingCartViewController *vc = [[NGShoppingCartViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section == 2){
        
    }
}

@end
