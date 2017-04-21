//
//  NGShoppingCarCell.h
//  Noob2017
//
//  Created by lihuaqi on 17/3/2.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol NGShoppingCarCellDelegete <NSObject>
-(void)refreshBottom;
@end

@class NGShoppingCarModel;
@interface NGShoppingCarCell : UITableViewCell
@property (nonatomic, strong)  NGShoppingCarModel *model;
@property (nonatomic,weak) id <NGShoppingCarCellDelegete>delegete;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
