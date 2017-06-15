//Tencent is pleased to support the open source community by making WeDemo available.
//Copyright (C) 2016 THL A29 Limited, a Tencent company. All rights reserved.
//Licensed under the MIT License (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
//http://opensource.org/licenses/MIT
//Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

#import "WXApiManager.h"

static NSString * const kWXNotInstallErrorTitle = @"您还没有安装微信，不能使用微信分享功能";
int const kthumbImgaeWidth = 140;

@interface WXApiManager ()

@property (nonatomic, strong) NSString *authState;

@end

@implementation WXApiManager

#pragma mark - Life Cycle
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance = nil;
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

//网页类型
- (void)sendWeiXinLinkContent:(NSString *)urlString
                        title:(NSString *)title
                  description:(NSString *)description
                   thumbImage:(UIImage *)thumbImage
                      atScene:(enum WXScene)scene {
    if (![WXApi isWXAppInstalled]) {
        [SVP showErrorWithStatus:kWXNotInstallErrorTitle];
        return;
    }
    //类型
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = urlString;
    
    //内容
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    //message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    message.mediaObject = ext;
    NSData *thumbData = [self thumbDataOriginalImg:thumbImage];
    message.thumbData = thumbData;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.message = message;
    req.bText = NO;
    //场景
    req.scene = scene;
    [WXApi sendReq:req];
}


//图片类型
- (void)sendWeiXinImage:(NSString *)title
                    thumbImage:(UIImage *)thumbImage
                     imageData:(NSData *)imageData
                       atScene:(enum WXScene)scene {
    if (![WXApi isWXAppInstalled]) {
        [SVP showErrorWithStatus:kWXNotInstallErrorTitle];
        return;
    }
    //类型
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = imageData;
    
    //内容
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.mediaObject = ext;
    NSData *thumbData = [self thumbDataOriginalImg:thumbImage];
    message.thumbData = thumbData;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.message = message;
    req.bText = NO;
    //场景
    req.scene = scene;
    [WXApi sendReq:req];
}

-(NSData *)thumbDataOriginalImg:(UIImage *)originalImg {
    UIImage *thumbImg = originalImg;
    NSData *thumbData = UIImagePNGRepresentation(thumbImg);
    if (thumbImg.size.width >kthumbImgaeWidth || thumbImg.size.height >kthumbImgaeWidth) {
        CGFloat width = kthumbImgaeWidth;
        CGFloat height = width*thumbImg.size.height/thumbImg.size.width;
        do {
            width -= 1;
            height = width*thumbImg.size.height/thumbImg.size.width;
        } while (height >kthumbImgaeWidth);
        thumbImg = [KCImageTool compressImage:thumbImg newWidth:width];
        thumbData = UIImagePNGRepresentation(thumbImg);
        NSLog(@"压缩尺寸后：%f__%f__%lukb",thumbImg.size.width,thumbImg.size.height,(unsigned long)thumbData.length/1024);
    }
    if (thumbData.length/1024 >32) {
        do {
            thumbData = UIImageJPEGRepresentation(thumbImg,.8);
        } while (thumbData.length/1024 >32);
        thumbImg = [UIImage imageWithData:thumbData];
        NSLog(@"压缩质量后：%f__%f__%lukb",thumbImg.size.width,thumbImg.size.height,(unsigned long)thumbData.length/1024);
    }
    return thumbData;
}

#pragma mark - WXApiDelegate
-(void)onReq:(BaseReq*)req {
    NSLog(@"%s",__func__);
    // just leave it here, WeChat will not call our app
}

-(void)onResp:(BaseResp*)resp {
    NSLog(@"%s",__func__);
    if([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp* authResp = (SendAuthResp*)resp;
        /* Prevent Cross Site Request Forgery */
        if (![authResp.state isEqualToString:self.authState]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(wxAuthDenied)])
                [self.delegate wxAuthDenied];
            return;
        }
        
        switch (resp.errCode) {
            case WXSuccess:
                NSLog(@"RESP:code:%@,state:%@\n", authResp.code, authResp.state);
                if (self.delegate && [self.delegate respondsToSelector:@selector(wxAuthSucceed:)])
                    [self.delegate wxAuthSucceed:authResp.code];
                break;
            case WXErrCodeAuthDeny:
                if (self.delegate && [self.delegate respondsToSelector:@selector(wxAuthDenied)])
                    [self.delegate wxAuthDenied];
                break;
            case WXErrCodeUserCancel:
                if (self.delegate && [self.delegate respondsToSelector:@selector(wxAuthCancel)])
                    [self.delegate wxAuthCancel];
            default:
                break;
        }
    }
}

@end
