//
//  QJKJChatMoreView.m
//  LYCModuleManager
//
//  Created by 史ios on 2017/1/4.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJChatMoreView.h"

#import <MobileCoreServices/MobileCoreServices.h>

#pragma mark - 距离
//距离左边空隙
#define MORE_LEFT_SPACE 15
//距离上边空隙
#define MORE_TOP_SPACE 15
//按钮宽度
#define MORE_BUTTON_WIDTH 60
//按钮数量
#define MORE_BUTTON_COUNT 2

//表情键盘高度
#define CHAT_FACE_INPUT_HEIGHT 190.f

//tag
#define CHAT_MORE_TAG 3000

@interface QJKJChatMoreView ()
<UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@end

@implementation QJKJChatMoreView {
    QJKJScrollView *_moreScrollView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CHAT_FACE_INPUT_HEIGHT);
        
        _moreScrollView = [[QJKJScrollView alloc] initWithFrame:self.bounds];
        _moreScrollView.backgroundColor = [UIColor whiteColor];
        _moreScrollView.bounces = NO;
        _moreScrollView.pagingEnabled = YES;
        [self addSubview:_moreScrollView];
        
        //暂时不考虑多行
        for (NSInteger i = 0; i < MORE_BUTTON_COUNT; i++) {
            QJKJButton *fileButton = [QJKJButton buttonWithType:UIButtonTypeCustom];
            fileButton.frame = CGRectMake(MORE_LEFT_SPACE + (MORE_LEFT_SPACE + MORE_BUTTON_WIDTH) * i, MORE_TOP_SPACE, MORE_BUTTON_WIDTH, MORE_BUTTON_WIDTH);
            fileButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
            fileButton.layer.borderWidth = 0.5;
            fileButton.layer.cornerRadius = 5;
            fileButton.layer.masksToBounds = YES;
            fileButton.tag = CHAT_MORE_TAG + i;
            [fileButton addTarget:self action:@selector(clickedMore:) forControlEvents:UIControlEventTouchUpInside];
            [fileButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            if ( i == 0) {
                [fileButton setTitle:@"照片" forState:UIControlStateNormal];
            }
            else {
                [fileButton setTitle:@"拍摄" forState:UIControlStateNormal];
            }
            [_moreScrollView addSubview:fileButton];
        }

    }
    return self;
}

- (void)clickedMore:(UIButton *)btn {
    UITabBarController *tabbar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    if (btn.tag - CHAT_MORE_TAG == 0) {
        // 判断是否支持相册功能
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            DLog(@"当前设备不支持相册功能");
            return;
        }

        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePicker setMediaTypes:[NSArray arrayWithObject:(NSString*)kUTTypeImage]];
        [imagePicker setDelegate:self];
        imagePicker.allowsEditing = YES;
        [tabbar.selectedViewController presentViewController:imagePicker animated:YES completion:nil];
    }
    else {
        // 判断是否支持拍照功能
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            DLog(@"当前设备不支持相机功能");
            return;
        }
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePicker setMediaTypes:[[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage, nil]];
        [imagePicker setDelegate:self];
        imagePicker.allowsEditing = YES;
        [tabbar.selectedViewController presentViewController:imagePicker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 改变大小
    CGFloat TW = image.size.width;
    CGFloat TH = image.size.height;
    
    if (TW > TH)
    {
        if (TW > 512)
        {
            TH = 512/TW*TH;
            TW = 512;
        }
    }
    else
    {
        if (TH > 512)
        {
            TW = 512/TH*TW;
            TH = 512;
        }
        
    }
    
    CGRect rect = CGRectMake(0, 0, TW, TH);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
}

@end
