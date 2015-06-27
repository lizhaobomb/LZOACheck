//
//  LZAlertUtils.m
//  LZOACheck
//
//  Created by lizhao on 15/5/17.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZAlertUtils.h"
#import "MBProgressHUD.h"
#import "LZCoreMacros.h"
@interface LZAlertUtils() <MBProgressHUDDelegate>
@property (nonatomic, strong) MBProgressHUD *msgHUD;
@end

@implementation LZAlertUtils

+ (instancetype) sharedLZAlertUtils {
    static LZAlertUtils *alertUtils = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        alertUtils = [[LZAlertUtils alloc] init];
    });
    return alertUtils;
}

- (void)toggleMessage:(NSString *)message {
    if (nil == message || [message isEqualToString:@""]) {
        return;
    }
    
    if (nil != self.msgHUD) {
        return;
    }
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD* msgHUD = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    msgHUD.mode = MBProgressHUDModeText;
    msgHUD.cornerRadius = 4.0f;
    msgHUD.detailsLabelFont = FONT_16;
    msgHUD.detailsLabelText = message;
    msgHUD.yOffset = CGRectGetHeight(keyWindow.frame) / 2.f - 60.f;
    msgHUD.removeFromSuperViewOnHide = YES;
    msgHUD.delegate = self;
    [msgHUD hide:YES afterDelay:1.5];
    
    self.msgHUD = msgHUD;
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    if (self.msgHUD) {
        [self.msgHUD removeFromSuperview];
        self.msgHUD = nil;
    }
}

@end
