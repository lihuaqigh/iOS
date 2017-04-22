//
//  JJLProfileController.m
//  Contract
//
//  Created by lihuaqi on 15/11/23.
//  Copyright © 2015年 JJL. All rights reserved.
//

#import "JJLProfileController.h"
#import "NGShoppingCartViewController.h"
//#import "LoginViewController.h"

@interface JJLProfileController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

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
        self.listArray = [NSArray arrayWithObjects:@"我的课程",@"我的收藏",@"我的上传", nil];
    }
    return _listArray;
}

- (NSArray *)descArray {
    if (_descArray == nil) {
        self.descArray = [NSArray arrayWithObjects:@"购物车",@"订单",@"优惠券",nil];
    }
    return _descArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"我的";
    [self initTableview];
    
}

-(void)btnClick {
    NSLog(@">>");
}


#define BgImageHeight 160
- (void)initTableview {
    //tableview
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableview];
    
}
#pragma mark - datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.listArray.count;
    }else if (section == 1 ){
        return self.descArray.count;
    }else return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseID = @"Profile";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = self.listArray[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if(indexPath.section == 1){
        cell.textLabel.text = self.descArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section == 2){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.text = @"退出登录";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NGShoppingCartViewController *vc = [[NGShoppingCartViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section == 2){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"access_token"];
        [[NSNotificationCenter defaultCenter] postNotificationName:KApplogin object:nil];
    }
    

}

@end
