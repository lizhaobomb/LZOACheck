//
//  LZAlertUtils.h
//  LZOACheck
//
//  Created by lizhao on 15/5/17.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZAlertUtils : NSObject
+ (instancetype) sharedLZAlertUtils;
- (void)toggleMessage:(NSString*)message;
@end
