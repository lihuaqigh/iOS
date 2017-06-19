//
//  JJLProfileHeaderView.m
//  Noob2017
//
//  Created by lihuaqi on 2017/6/20.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "JJLProfileHeaderView.h"
@interface JJLProfileHeaderView()
@property (nonatomic,weak) UIViewController *controller;/**导航控制器*/
@property (nonatomic,strong) UIImageView *iconImgV;/**头像*/
@property (nonatomic,strong) UILabel *nicknameLb;/**昵称*/
@property (nonatomic,strong) UILabel *descriptionLb;/**一句话描述自己*/
@end
@implementation JJLProfileHeaderView
-(instancetype)initWithController:(UIViewController *)controller{
    if (self = [super init]) {
        _controller = controller;
        [self createUI];
    }
    return self;
}

-(void)createUI {
    self.backgroundColor = [UIColor whiteColor];
    [self setFrame:CGRectMake(0, 0, WIDTH, 88*SizeScale)];
    
    CGFloat icon_W = 60*SizeScale;
    CGFloat icon_Y = (CGRectGetHeight(self.frame)-icon_W)*.5;
    _iconImgV= [[UIImageView alloc]initWithFrame:CGRectMake(20, icon_Y, icon_W, icon_W)];
    _iconImgV.contentMode = UIViewContentModeScaleAspectFill;
    _iconImgV.userInteractionEnabled = YES;
    [_iconImgV zy_attachBorderWidth:0.5 color:[UIColor lightGrayColor]];
    [_iconImgV zy_cornerRadiusAdvance:5.0f rectCornerType:UIRectCornerAllCorners];
    _iconImgV.image = [UIImage imageNamed:@"jks.jpg"];
    [self addSubview:_iconImgV];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconClick)];
    [_iconImgV addGestureRecognizer:tap];
    
    
    _nicknameLb = [KCKit createLbWithFrame:CGRectMake(CGRectGetMaxX(_iconImgV.frame)+10, CGRectGetMinY(_iconImgV.frame)+5, WIDTH-50-icon_W, 25) text:@"哼哼哼哼" textColor:k4c4c4c font:15];
    [self addSubview:_nicknameLb];
    
    _nicknameLb = [KCKit createLbWithFrame:CGRectMake(CGRectGetMinX(_nicknameLb.frame), CGRectGetMaxY(_iconImgV.frame)-25, WIDTH-50-icon_W, 20) text:@"一句话描述自己" textColor:k9a9a9a font:13];
    [self addSubview:_nicknameLb];
    
}

-(void)refreshWithIcon:(NSString *)icon nickname:(NSString *)nickname description:(NSString *)description {
    

}

-(void)iconClick {
    
}
@end
