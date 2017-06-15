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
                    title:(NSString *)title
                 description:(NSString *)description
                   imageData:(NSData *)imageData {

    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    WBMessageObject *message = [WBMessageObject message];
    message.text = [NSString stringWithFormat:@"@千寻E %@ %@ %@",title,description,urlString];
    if (imageData.length>0) {
        WBImageObject *imageObject = [WBImageObject object];
        imageObject.imageData = imageData;
        message.imageObject = imageObject;
    }
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:@""];
    request.userInfo = @{@"ShareMessageFrom": @"WeiboApiManager",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    debugMethod();
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    debugMethod();
}
@end
