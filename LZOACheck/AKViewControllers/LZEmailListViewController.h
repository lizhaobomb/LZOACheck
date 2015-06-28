//
//  LZEmailListViewController.h
//  LZOACheck
//
//  Created by lizhao on 15/5/20.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZBaseViewController.h"

typedef enum : NSUInteger {
    TYPE_UNREAD,
    TYPE_READED,
    TYPE_SENDED,
} PageType;

@interface LZEmailListViewController : LZBaseViewController

@property(nonatomic, assign) PageType pageType;

@end
