//
//  JJLProfileCell.m
//  Noob2017
//
//  Created by lihuaqi on 17/2/15.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "JJLProfileCell.h"
@interface JJLProfileCell()
@property (nonatomic,strong) UILabel *titleLb;/**标题*/
@end
@implementation JJLProfileCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"profileCellId";
    JJLProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JJLProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)createUI {
    _titleLb = [KCKit createLbWithFrame:CGRectZero text:@"" textColor:k4c4c4c font:14];
    [self.contentView addSubview:_titleLb];
}

-(void)refreshTitle:(NSString *)title {
    _titleLb.text = title;
    if (title.length == 0) {
        self.contentView.backgroundColor = [UIColor colorFromHexString:Kf0f5f5];
    }else {
         self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [_titleLb setFrame:CGRectMake(20, 0, 180, self.frame.size.height)];
}

@end
