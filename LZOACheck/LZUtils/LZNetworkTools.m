//
//  LZNetworkTools.m
//  LZOACheck
//
//  Created by lizhao on 15/5/17.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZNetworkTools.h"
@implementation LZNetworkTools

+(instancetype) sharedLZNetworkTools {
    static LZNetworkTools *tools;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://111.206.163.56:8686"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        tools = [[LZNetworkTools alloc] initWithBaseURL:url sessionConfiguration:config];
        tools.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//        [tools.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//            switch (status) {
//                case AFNetworkReachabilityStatusReachableViaWWAN:
//                case AFNetworkReachabilityStatusReachableViaWiFi:
//                    [[LZAlertUtils sharedLZAlertUtils] toggleMessage:@"网路好"];
//                    break;
//                    case AFNetworkReachabilityStatusNotReachable:
//                    [[LZAlertUtils sharedLZAlertUtils] toggleMessage:@"无网路"];
//                    break;
//                default:
//                    break;
//            }
//        }];
//        [tools.reachabilityManager startMonitoring];
        
    });
    return tools;
}

@end
