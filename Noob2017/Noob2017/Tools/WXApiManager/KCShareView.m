//
//  WXShareView.m
//  Noob2017
//
//  Created by lihuaqi on 2017/6/13.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "KCShareView.h"
#import "WXApiManager.h"
#import "WeiboApiManager.h"

int const kShareHeight = 110;
int const kShareSpacing = 6;
@interface KCShareView()
@property (nonatomic, strong) UIView *shareView;
@property (nonatomic, copy) NSString *shareType;//
@property (nonatomic, copy) NSString *shareUrlString;//
@property (nonatomic, copy) NSString *shareTitle;//
@property (nonatomic, copy) NSString *shareDescription;//
@property (nonatomic, strong) UIImage *shareThumbImage;//
@property (nonatomic, strong) NSData *shareImageData;//
@end
@implementation KCShareView
-(instancetype)initUrlString:(NSString *)urlString
                       Title:(NSString *)title
                 Description:(NSString *)description
                  ThumbImage:(UIImage *)thumbImage
                   imageData:(NSData *)imageData
                   shareType:(NSString *)shareType {
    
                        if (self = [super init]) {
                            _shareUrlString = urlString?urlString:@"";
                            _shareTitle = title?title:@"";
                            _shareDescription = description?description:@"";
                            _shareThumbImage = thumbImage;
                            _shareImageData = imageData;
                            _shareType = shareType;
                            [self createUI];
                        }
                        return self;
}

-(void)shareBtnClick:(UIButton *)btn {
    switch (btn.tag-1000) {
        case 0:{
            if ([_shareType isEqualToString:@"webpage"]) {
                [[WXApiManager sharedManager] sendWeiXinLinkContent:_shareUrlString title:_shareTitle description:_shareDescription thumbImage:_shareThumbImage atScene:0];
            }else if ([_shareType isEqualToString:@"image"]) {
                [[WXApiManager sharedManager] sendWeiXinImage:_shareTitle thumbImage:_shareThumbImage imageData:_shareImageData atScene:0];
            }
            break;
        }
        case 1:{
            if ([_shareType isEqualToString:@"webpage"]) {
                [[WXApiManager sharedManager] sendWeiXinLinkContent:_shareUrlString title:_shareTitle description:_shareDescription thumbImage:_shareThumbImage atScene:1];
            }else if ([_shareType isEqualToString:@"image"]) {
                [[WXApiManager sharedManager] sendWeiXinImage:_shareTitle thumbImage:_shareThumbImage imageData:_shareImageData atScene:1];
            }
            break;
        }
        case 2:{
            [[WeiboApiManager sharedManager] sendWeiboLinkContent:_shareUrlString title:_shareTitle description:_shareDescription imageData:_shareImageData];
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

+(void)showWebpageUrlString:(NSString *)urlString
                      title:(NSString *)title
                description:(NSString *)description
                 thumbImage:(UIImage *)thumbImage
                  imageData:(NSData *)imageData {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    for (UIView *subView in window.subviews) {
        if ([subView isKindOfClass:[KCShareView class]]) {
            [subView removeFromSuperview];
        }
    }
    KCShareView *shareView = [[KCShareView alloc] initUrlString:urlString
                                                          Title:title
                                                    Description:description
                                                     ThumbImage:thumbImage
                                                      imageData:imageData
                                                      shareType:@"webpage"];
    [window addSubview:shareView];
    [shareView show_animation];
    
}

+(void)showImageUrlString:(NSString *)urlString
                title:(NSString *)title
          description:(NSString *)description
           thumbImage:(UIImage *)thumbImage
            imageData:(NSData *)imageData {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    for (UIView *subView in window.subviews) {
        if ([subView isKindOfClass:[KCShareView class]]) {
            [subView removeFromSuperview];
        }
    }
    KCShareView *shareView = [[KCShareView alloc] initUrlString:urlString
                                                          Title:title
                                                    Description:description
                                                     ThumbImage:thumbImage
                                                      imageData:imageData
                                                      shareType:@"image"];
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
