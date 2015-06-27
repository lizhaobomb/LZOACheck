//
//  UserDataModel.h
//  LZOACheck
//
//  Created by lizhao on 15/5/18.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZUserDataModel : NSObject

@property(nonatomic, strong) NSNumber *userId;
@property(nonatomic, strong) NSString *account;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *phone1;
@property(nonatomic, strong) NSString *phone2;
@property(nonatomic, strong) NSString *email1;
@property(nonatomic, strong) NSString *email2;
@property(nonatomic, strong) NSString *address;
@property(nonatomic, strong) NSNumber *unitId;
@property(nonatomic, strong) NSString *unitName;
@property(nonatomic, strong) NSString *sessionId;

@end
