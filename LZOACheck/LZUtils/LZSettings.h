//
//  LZSettings.h
//  LZOACheck
//
//  Created by lizhao on 15/5/18.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZSettings : NSObject
@property(nonatomic, strong) NSNumber *userId;
@property(nonatomic, strong) NSString *sessionId;
+ (instancetype)sharedLZSettings;
+ (void)savePrefs;
+ (void)loadPrefs;
@end
