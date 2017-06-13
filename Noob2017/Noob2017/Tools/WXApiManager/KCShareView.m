//
//  WXShareView.m
//  Noob2017
//
//  Created by lihuaqi on 2017/6/13.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "KCShareView.h"
#import "WXApiManager.h"

int const kShareHeight = 110;
int const kShareSpacing = 6;
@interface KCShareView()
@property (nonatomic, strong) UIView *shareView;
@property (nonatomic, copy) NSString *shareType;//分享的类型
@end
@implementation KCShareView
-(instancetype)init {
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

-(void)shareBtnClick:(UIButton *)btn {
    switch (btn.tag-1000) {
        case 0:{
            [[WXApiManager sharedManager] sendWeiXinLinkContentAtScene:0];
            break;
        }
        case 1:{
            [[WXApiManager sharedManager] sendWeiXinLinkContentAtScene:1];
            break;
        }
        case 2:{
            
            break;
        }
        default:
            break;
    }
    [self hidden_animatio];
}

-(void)createUI {
    [self setFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidden_animatio)];
    [self addGestureRecognizer:tap];
    
    _shareView = [[UIView alloc]initWithFrame:CGRectMake(kShareSpacing, HEIGHT, WIDTH-2*kShareSpacing, kShareHeight*SizeScale)];
    _shareView.layer.cornerRadius = 3.0;
    _shareView.layer.masksToBounds = YES;
    _shareView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_shareView];
    
    NSArray *imgArr = @[@"share-wechat-btn",@"share-moments-btn",@"share-weibo-btn"];
    NSArray *titleArr = @[@"微信好友",@"朋友圈",@"新浪微博"];
    CGFloat btn_W = 110*SizeScale;
    CGFloat btn_X = (WIDTH - btn_W*3)*.5;
    for (int i=0; i<3; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(btn_X+btn_W*i, 0, btn_W, kShareHeight*SizeScale)];
        [btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:K_CHANGE_TEXT_FONT size:14*SizeScale];
        [btn setTitleColor:[UIColor colorFromHexString:k4c4c4c] forState:UIControlStateNormal];
        btn.tag = 1000+i;
        [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
                             imageTitleSpace:10];
        [_shareView addSubview:btn];
    }
}

+(void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    for (UIView *subView in window.subviews) {
        if ([subView isKindOfClass:[KCShareView class]]) {
            [subView removeFromSuperview];
        }
    }
    KCShareView *shareView = [[KCShareView alloc] init];
    [window addSubview:shareView];
    [shareView show_animation];
}

-(void)show_animation {
    [_shareView setFrame:CGRectMake(kShareSpacing, HEIGHT, WIDTH-kShareSpacing*2, kShareHeight*SizeScale)];
    [UIView animateWithDuration:0.25 animations:^{
        [_shareView setFrame:CGRectMake(kShareSpacing, HEIGHT-kShareHeight*SizeScale-kShareSpacing, WIDTH-kShareSpacing*2, kShareHeight*SizeScale)];
    }];
}

-(void)hidden_animatio {
    [_shareView setFrame:CGRectMake(kShareSpacing, HEIGHT-kShareHeight*SizeScale-kShareSpacing, WIDTH-kShareSpacing*2, kShareHeight*SizeScale)];
    [UIView animateWithDuration:0.25 animations:^{
        [_shareView setFrame:CGRectMake(kShareSpacing, HEIGHT, WIDTH-kShareSpacing*2, kShareHeight*SizeScale)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
