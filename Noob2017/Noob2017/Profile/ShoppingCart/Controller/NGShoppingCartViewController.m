//
//  NGShoppingCartViewController.m
//  Noob2017
//
//  Created by lihuaqi on 17/3/2.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "NGShoppingCartViewController.h"
#import "NGShoppingCarCell.h"
#import "NGShoppingCarModel.h"
@interface NGShoppingCartViewController () <UITableViewDelegate,UITableViewDataSource,NGShoppingCarCellDelegete>
@property (nonatomic, assign) BOOL edited_Car;
@property (nonatomic, strong) UIButton *rightButton;//编辑按钮
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIView *clearingBView;
@property (nonatomic, strong) UIButton *totalBtn;//全选按钮
@property (nonatomic, strong) UILabel *totalpriceLb;//合计
@property (nonatomic, strong) UIButton *clearingBtn;//结算
@property (nonatomic, strong) UIView *deleteBView;
@end

@implementation NGShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"购物车";
    self.dataSource = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        NSString *ccc = [NSString stringWithFormat:@"%d",i+1];
        NGShoppingCarModel *model = [NGShoppingCarModel yy_modelWithDictionary:@{@"goodName":@"啦啦啦",@"goodPrice":@"10",@"goodCount":ccc,@"goodType":@"型号：200ml",@"selected":@"0",@"deleted":@"0",@"edited":@"0"}];
        model.selected = YES;
        [self.dataSource addObject:model];
    }
    [self topbar];
    [self createTableView];
    [self createBottomView];
    [self refreshBottom];
}

-(void)topbar {
    
    self.rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [_rightButton setTitle:@"编辑"forState:UIControlStateNormal];
    [_rightButton setTitle:@"完成" forState:UIControlStateSelected];
    [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setTitleColor:[UIColor colorFromHexString:@"#3a3a3a"] forState:UIControlStateNormal];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItems = @[rightButtonItem];
}
// 管理状态切换
-(void)rightClick:(UIButton*)btn
{
    btn.selected = !btn.selected;
    _edited_Car = btn.selected;
    CGFloat totalPrices = 0;
    NSInteger goodCounts = 0;
    for (NGShoppingCarModel *model in self.dataSource) {
        NSString *goodPrice = model.goodPrice;
        NSString *goodCount = model.goodCount;
        if (_edited_Car == YES) {
            model.edited = YES;
            model.deleted = NO;
        }else {
            model.edited = NO;
            if (model.selected == YES) {
                totalPrices = totalPrices + ([goodPrice floatValue]*[goodCount floatValue]);
                goodCounts ++;
            }
        }
    
    }
    
    [_tableView reloadData];
    
    
    if (_edited_Car == YES) {
        _totalpriceLb.hidden = YES;
        [_clearingBtn setTitle:[NSString stringWithFormat:@"删除(%ld)",(long)goodCounts] forState:UIControlStateNormal];
    }else {
        _totalpriceLb.hidden = NO;
        [_clearingBtn setTitle:[NSString stringWithFormat:@"结算(%ld)",(long)goodCounts] forState:UIControlStateNormal];
    }
}

-(void)createBottomView {
    self.clearingBView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-50, WIDTH, 50)];
    _clearingBView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_clearingBView];
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH*.7, 50)];
    leftView.backgroundColor = [UIColor orangeColor];
    [_clearingBView addSubview:leftView];
    
    self.totalBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 50, 50)];
    [_totalBtn setTitle:@"全选" forState:UIControlStateNormal];
    _totalBtn.titleLabel.font = [UIFont systemFontOfSize:14*SizeScale];
    [leftView addSubview:_totalBtn];
    
    self.totalpriceLb = [[UILabel alloc]initWithFrame:CGRectMake(20, 25*.5, 200, 25)];
    _totalpriceLb.font = [UIFont systemFontOfSize:14*SizeScale];
    _totalpriceLb.text = @"合 计：￥";
    [leftView addSubview:_totalpriceLb];
    
    self.clearingBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH*.7, 0, WIDTH*.3, 50)];
    _clearingBtn.backgroundColor = [UIColor colorFromHexString:@"#ff1a09"];
    [_clearingBtn setTitle:@"结算(2)" forState:UIControlStateNormal];
    _clearingBtn.titleLabel.font = [UIFont systemFontOfSize:14*SizeScale];
    [_clearingBView addSubview:_clearingBtn];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [_tableView reloadData];
        [self refreshBottom];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

-(void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-50-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100*SizeScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NGShoppingCarCell *cell = [NGShoppingCarCell cellWithTableView:tableView];
    cell.delegete = self;
    cell.model = _dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)refreshBottom {
    CGFloat totalPrices = 0;
    NSInteger goodCounts = 0;
    for (NGShoppingCarModel *model in self.dataSource) {
        NSString *goodPrice = model.goodPrice;
        NSString *goodCount = model.goodCount;
        if (_edited_Car == YES) {
            if (model.deleted == YES) {
                totalPrices = totalPrices + ([goodPrice floatValue]*[goodCount floatValue]);
                goodCounts ++;
            }
        }else {
            if (model.selected == YES) {
                totalPrices = totalPrices + ([goodPrice floatValue]*[goodCount floatValue]);
                goodCounts ++;
            }
        }
    }
    
    _totalpriceLb.text = [NSString stringWithFormat:@"合计：￥%.2f",totalPrices];
    CGFloat totalpriceLb_W = [self getwidthOfH:50 andText:_totalpriceLb.text andFontSize:14*SizeScale];
    _totalpriceLb.frame =CGRectMake(WIDTH*.7-totalpriceLb_W-10, 0, totalpriceLb_W, 50);
    [_clearingBtn setTitle:[NSString stringWithFormat:@"结算(%ld)",(long)goodCounts] forState:UIControlStateNormal];
}

-(CGFloat)getwidthOfH:(CGFloat)height andText:(NSString *)text andFontSize:(CGFloat)fontSize {
    CGSize size =CGSizeMake(MAXFLOAT,height);
    NSDictionary *dict = @{
                           NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                           //NSFontAttributeName:[UIFont fontWithName:K_CHANGE_TEXT_FONT size:fontSize],
                           };
    CGSize sizeLabel =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:dict context:nil].size;
    return sizeLabel.width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
