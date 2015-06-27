//
//  ProcessDataModel.h
//  LZOACheck
//
//  Created by lizhao on 15/6/26.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProcessDataModel : NSObject

@property(nonatomic, strong) NSNumber *processId;
@property(nonatomic, strong) NSNumber *priority;
@property(nonatomic, strong) NSNumber *processInstanceId;
@property(nonatomic, strong) NSNumber *processDefId;
@property(nonatomic, strong) NSString *processDefKey;
@property(nonatomic, strong) NSString *taskDefKey;
@property(nonatomic, strong) NSString *priorityName;
@property(nonatomic, strong) NSString *submissionUnit;
@property(nonatomic, strong) NSString *submissionUnitName;
@property(nonatomic, strong) NSString *submissionTime;
@property(nonatomic, strong) NSString *endTime;
@property(nonatomic, strong) NSString *deleteReason;
@property(nonatomic, strong) NSString *desc;
@property(nonatomic, strong) NSString *statusName;
@property(nonatomic, strong) NSString *taskHandleName;
@property(nonatomic, strong) NSNumber *owerId;
@property(nonatomic, strong) NSString *owerName;
@property(nonatomic, strong) NSString *dueData;
@property(nonatomic, strong) NSString *processName;

@end
