//
//  LZLoginViewController.h
//  LZOACheck
//
//  Created by lizhao on 15/5/16.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZLoginViewController : UIViewController
@property (nonatomic, strong) void(^LoginSucceed)(void);
@end
