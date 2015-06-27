//
//  LZSettings.m
//  LZOACheck
//
//  Created by lizhao on 15/5/18.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZSettings.h"

#define K_USER_USERID               @"K_USER_USERID"
#define K_USER_SESSIONID            @"K_USER_SESSIONID"

@implementation LZSettings
+(instancetype) sharedLZSettings {
    static LZSettings *settings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings = [[LZSettings alloc] init];
    });
    return settings;
}

+ (void)loadPrefs {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    LZSettings *setings = [LZSettings sharedLZSettings];
    setings.userId = [defaults objectForKey:K_USER_USERID];
    setings.sessionId = [defaults objectForKey:K_USER_SESSIONID];
}

+ (void)savePrefs {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    LZSettings *settings = [LZSettings sharedLZSettings];
    [prefs setObject:settings.userId forKey:K_USER_USERID];
    [prefs setObject:settings.sessionId forKey:K_USER_SESSIONID];
    [prefs synchronize];
}

@end
