//
//  NGShoppingCarCell.m
//  Noob2017
//
//  Created by lihuaqi on 17/3/2.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "NGShoppingCarCell.h"
#import "NGShoppingCarModel.h"
@interface NGShoppingCarCell()
@property (nonatomic, strong) UIImageView *selectedImgV;
@property (nonatomic, strong) UIImageView *headerImgV;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *typeLb;
@property (nonatomic, strong) UILabel *priceLb;
@property (nonatomic, strong) UIView *btnsView;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *lessBtn;
@property (nonatomic, strong) UILabel *goodCountLb;
@end
@implementation NGShoppingCarCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"shoppingcell";
    NGShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NGShoppingCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)createUI {
    self.selectedImgV = [[UIImageView alloc]init];
    _selectedImgV.backgroundColor = [UIColor grayColor];
    _selectedImgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectClick)];
    [_selectedImgV addGestureRecognizer:tap];
    [self.contentView addSubview:_selectedImgV];
    
    self.headerImgV = [[UIImageView alloc]init];
    _headerImgV.image  = [UIImage imageNamed:@"image"];
    _headerImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_headerImgV];
    
    self.nameLb = [[UILabel alloc]init];
    _nameLb.font = [UIFont fontWithName:K_CHANGE_TEXT_FONT size:14*SizeScale];
    _nameLb.numberOfLines = 0;
    [self.contentView addSubview:_nameLb];
    
    self.typeLb = [[UILabel alloc]init];
    _typeLb.font = [UIFont fontWithName:K_CHANGE_TEXT_FONT size:12*SizeScale];
    _typeLb.textColor = [UIColor lightGrayColor];
    _typeLb.numberOfLines = 0;
    [self.contentView addSubview:_typeLb];
    
    self.priceLb = [[UILabel alloc]init];
    _priceLb.font = [UIFont systemFontOfSize:14];
    _priceLb.textColor = [UIColor redColor];
    [self.contentView addSubview:_priceLb];
    
    self.btnsView = [[UIView alloc]init];
    [self.contentView addSubview:_btnsView];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(countClick:) forControlEvents:UIControlEventTouchUpInside];
    [_btnsView addSubview:_addBtn];
    
    self.lessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_lessBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_lessBtn addTarget:self action:@selector(countClick:) forControlEvents:UIControlEventTouchUpInside];
    [_btnsView addSubview:_lessBtn];
    
    self.goodCountLb = [[UILabel alloc]init];
    _goodCountLb.textAlignment = NSTextAlignmentCenter;
    _goodCountLb.text = @"26";
    [_btnsView addSubview:_goodCountLb];
    
    _btnsView.backgroundColor = [UIColor lightGrayColor];
    _addBtn.backgroundColor = [UIColor blueColor];
    _lessBtn.backgroundColor = [UIColor blueColor];
    [_addBtn setTitle:@"+" forState:UIControlStateNormal];
    [_lessBtn setTitle:@"-" forState:UIControlStateNormal];
    
    //_nameLb.backgroundColor = [UIColor greenColor];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat selectedImgV_H = 20*SizeScale;
    _selectedImgV.frame = CGRectMake(10, (self.frame.size.height -selectedImgV_H)*.5, selectedImgV_H, selectedImgV_H);
    
    CGFloat headerImgV_WH = 80*SizeScale;
    _headerImgV.frame = CGRectMake(CGRectGetMaxX(_selectedImgV.frame)+10, (self.frame.size.height -headerImgV_WH)*.5, headerImgV_WH, headerImgV_WH);
    
    /*
     2行：27.625, 32.375, 35.742,（5s，6，6p）
     3行：41.438, 48.562,
     */
    CGFloat nameLb_W = WIDTH-selectedImgV_H-headerImgV_WH-30-50;
    CGFloat nameLb_H = [UILabel getHeightOfW:nameLb_W andText:_nameLb.text andFontSize:14];
    if (nameLb_H > 35.742) {//最多2行显示
        nameLb_H =  32.375*SizeScale+1;//因为省去位数，导致高度少算一点，所以+1。(前提是知道iPhone6 2行文字的高度)
    }
    _nameLb.frame = CGRectMake(CGRectGetMaxX(_headerImgV.frame)+10, CGRectGetMinY(_headerImgV.frame), nameLb_W, nameLb_H);
    
    CGFloat typeLb_H = [UILabel getHeightOfW:nameLb_W andText:_typeLb.text andFontSize:12*SizeScale];
    if (typeLb_H>27.75) {
        typeLb_H = 27.75;
    }
    _typeLb.frame = CGRectMake(CGRectGetMaxX(_headerImgV.frame)+10, CGRectGetMaxY(_nameLb.frame)+5, nameLb_W, 13.875);
    
    _priceLb.frame = CGRectMake(CGRectGetMinX(_nameLb.frame), CGRectGetMaxY(_headerImgV.frame)-20, CGRectGetWidth(_nameLb.frame), 20);
    
    
    CGFloat btnView_W = 90;
    CGFloat btnView_H = 18;
    _btnsView.frame = CGRectMake(WIDTH-btnView_W-20, CGRectGetMinY(_priceLb.frame), btnView_W, btnView_H);
    _lessBtn.frame = CGRectMake(0, 0, btnView_H, btnView_H);
    _addBtn.frame = CGRectMake(btnView_W-btnView_H, 0, btnView_H, btnView_H);
    _goodCountLb.frame = CGRectMake(btnView_H, 0, btnView_W-2*btnView_H, btnView_H);
    
}

-(void)setModel:(NGShoppingCarModel *)model {
    _model = model;
    
    if (_model.edited == NO) {
        if (_model.selected == NO) {
            _selectedImgV.backgroundColor = [UIColor grayColor];
        }else{
            _selectedImgV.backgroundColor = [UIColor redColor];
        }
    }else {
        if (_model.deleted == NO) {
            _selectedImgV.backgroundColor = [UIColor grayColor];
        }else{
            _selectedImgV.backgroundColor = [UIColor redColor];
        }
    }
    
    _nameLb.text = [NSString stringWithFormat:@"哈哈哈啦啦啦哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈和实话实说哈哈%@",model.goodName];
    
    _typeLb.text = [NSString stringWithFormat:@"%@",model.goodType];
    
    _priceLb.text = [NSString stringWithFormat:@"￥ %.2f",[model.goodPrice floatValue]];
    
    _goodCountLb.text = model.goodCount;
    if ([_goodCountLb.text intValue]==1) {
        [_lessBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else if ([_goodCountLb.text intValue]==99) {
        [_addBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else {
        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_lessBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
//改变商品数量
-(void)countClick:(UIButton *)btn {
    if (btn==_addBtn && [_goodCountLb.text intValue]<99) {
        //这里需要和后台交互一下
        _goodCountLb.text = [NSString stringWithFormat:@"%d",[_goodCountLb.text intValue]+1];
        [_lessBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if ([_goodCountLb.text intValue]==99) {
            [_addBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }
    
    if (btn==_lessBtn && [_goodCountLb.text intValue]>1) {
        _goodCountLb.text = [NSString stringWithFormat:@"%d",[_goodCountLb.text intValue]-1];
        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if ([_goodCountLb.text intValue]==1) {
            [_lessBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }
    
    self.model.goodCount = _goodCountLb.text;
    
    if (self.delegete && [self.delegete respondsToSelector:@selector(refreshBottom)]) {
        [self.delegete refreshBottom];
    }
    
}
//改变商品选中状态
-(void)selectClick {
    if (_model.edited == NO) {
        _model.selected = !_model.selected;
        if (_model.selected == NO) {
            _selectedImgV.backgroundColor = [UIColor grayColor];
        }else{
            _selectedImgV.backgroundColor = [UIColor redColor];
        }
    }else {
        _model.deleted = !_model.deleted;
        if (_model.deleted == NO) {
            _selectedImgV.backgroundColor = [UIColor grayColor];
        }else{
            _selectedImgV.backgroundColor = [UIColor redColor];
        }
    }
    
    if (self.delegete && [self.delegete respondsToSelector:@selector(refreshBottom)]) {
        [self.delegete refreshBottom];
    }
}
//更改cell删除样式
//-(void)cellDeleteStyle {
//    for (UIView *subView in self.subviews){
//        if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
//            CGRect cRect = subView.frame;
//            cRect.size.height = self.contentView.frame.size.height - 10;
//            subView.frame = cRect;
//            
//            UIView *confirmView=(UIView *)[subView.subviews firstObject];
//            // 改背景颜色
//            confirmView.backgroundColor=[UIColor orangeColor];
//            for(UIView *sub in confirmView.subviews){
//                if([sub isKindOfClass:NSClassFromString(@"UIButtonLabel")]){
//                    UILabel *deleteLabel=(UILabel *)sub;
//                    // 改删除按钮的字体
//                    //deleteLabel.font=[UIFont boldSystemFontOfSize:18];
//                    // 改删除按钮的文字
//                    deleteLabel.text=@"删除";
//                }
//            }
//            break;
//        }
//    }
//}
@end
