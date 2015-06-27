//
//  LZNetworkingTools.h
//  LZOACheck
//
//  Created by lizhao on 15/6/15.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^CompletionLoad) (NSObject *result);
@interface LZNetworkingTools : NSObject

+ (AFHTTPRequestOperation *)requestWithURL:(NSString *)url params:(NSMutableDictionary *)params httpMethod:(NSString *)httpMethod block:(CompletionLoad)block;

+ (AFHTTPRequestOperation *)requestWithURL:(NSString *)url requestHeader:(NSDictionary *)header parms:(NSMutableDictionary *)params httpMethod:(NSString *)httpMethod block:(CompletionLoad)block;

@end
