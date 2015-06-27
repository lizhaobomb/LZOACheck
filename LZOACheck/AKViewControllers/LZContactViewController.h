//
//  LZContactViewController.h
//  LZOACheck
//
//  Created by lizhao on 15/5/21.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZBaseViewController.h"

typedef NS_ENUM(NSInteger, ContactPageType) {
    ContactPageTypeEmail = 1,
};

typedef void (^SelectContacts) (NSArray *);

@interface LZContactViewController : LZBaseViewController
@property (nonatomic, assign) ContactPageType pageType;
@property (nonatomic, strong) SelectContacts selectContactsBlock;
@end
