//
//  JJLProfileController.m
//  Contract
//
//  Created by lihuaqi on 15/11/23.
//  Copyright © 2015年 JJL. All rights reserved.
//

#import "JJLProfileController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "NGShoppingCartViewController.h"
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
    self.isHideLeftPop = YES;
    [self initTableview];
    
    _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 200, 200)];
    _imageview.contentMode = UIViewContentModeScaleAspectFit;
    _imageview.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_imageview];
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
    if (indexPath.section == 0) {
        [self photo];
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NGShoppingCartViewController *vc = [[NGShoppingCartViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section == 2){
        [KCNetworkTool postRequest:@"auth" params:@{@"action":@"logout"} success:^(id obj) {
           if ([obj[@"code"] intValue] == 200) {
               [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"access_token"];
               [[NSNotificationCenter defaultCenter] postNotificationName:KApplogin object:nil];
           }else {
               [SVP showErrorWithStatus:[NSString stringWithFormat:@"%@",obj[@"message"]]];
           }
            
        }];
    }
}

-(void)photo {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }else {
            NSLog(@"不支持相机");
        }

    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"从手机相册选择" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
            imagePickerVc.sortAscendingByModificationDate = NO;
            imagePickerVc.allowCrop = YES;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }else {
            NSLog(@"不支持相册");
        }
        

    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion: nil];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
@end
