//
//  WeiboApiManager.m
//  Noob2017
//
//  Created by lihuaqi on 2017/6/15.
//  Copyright © 2017年 lihuaqi. All rights reserved.
//

#import "WeiboApiManager.h"
static NSString * const kRedirectURI = @"https://www.sina.com";
@implementation WeiboApiManager
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WeiboApiManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initInPrivate];
    });
    return instance;
}

- (instancetype)initInPrivate {
    self = [super init];
    if (self) {
        _delegate = nil;
    }
    return self;
}

- (instancetype)init {
    return nil;
}

- (instancetype)copy {
    return nil;
}

- (void)sendWeiboLinkContent:(NSString *)urlString
                       Title:(NSString *)title {

    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:@""];
    request.userInfo = @{@"ShareMessageFrom": @"WeiboApiManager",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}

- (WBMessageObject *)messageToShare {
    WBMessageObject *message = [WBMessageObject message];
    
    message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"identifier1";
    webpage.title = NSLocalizedString(@"分享网页标题", nil);
    webpage.description = [NSString stringWithFormat:NSLocalizedString(@"分享网页内容简介-%.0f", nil), [[NSDate date] timeIntervalSince1970]];
    //webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"" ofType:@"jpg"]];
    webpage.webpageUrl = @"www.baidu.com";
    message.mediaObject = webpage;
    
    return message;
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    debugMethod();
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    debugMethod();
}
@end
