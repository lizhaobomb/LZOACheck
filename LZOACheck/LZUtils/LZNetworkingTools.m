//
//  LZNetworkingTools.m
//  LZOACheck
//
//  Created by lizhao on 15/6/15.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZNetworkingTools.h"

@implementation LZNetworkingTools

+ (AFHTTPRequestOperation *)requestWithURL:(NSString *)url params:(NSMutableDictionary *)params httpMethod:(NSString *)httpMethod block:(CompletionLoad)block {
    //创建request请求管理对象
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation * operation =nil;
    //GET请求
    NSComparisonResult comparison1 = [httpMethod caseInsensitiveCompare:@"GET"];
    
    if (comparison1 == NSOrderedSame) {
        operation =[manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation,id responseObject) {
            block(responseObject);
        }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
            block(error);
        }];
    }
    //POST请求
    NSComparisonResult comparisonResult2 = [httpMethod caseInsensitiveCompare:@"POST"];
    if (comparisonResult2 == NSOrderedSame)
    {
        //标示
        BOOL isFile =NO;
        for (NSString * key in params.allKeys)
        {
            id value = params[key];
            //判断请求参数是否是文件数据
            if ([value isKindOfClass:[NSData class]]) {
                isFile =YES;
                break;
            }
        }
        if (!isFile) {
            //参数中没有文件，则使用简单的post请求
            operation =[manager POST:url
                         parameters:params
                            success:^(AFHTTPRequestOperation *operation,id responseObject) {
                                if (block !=nil) {
                                    block(responseObject);
                                }
                            }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                                if (block !=nil) {
                                    //
                                }
                            }];
        }else
        {
            operation =[manager POST:url
                         parameters:params
          constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
              
              for (NSString *key in params) {
                  id value = params[key];
                  if ([value isKindOfClass:[NSData class]]) {
                      [formData appendPartWithFileData:value
                                                 name:key
                                             fileName:key
                                             mimeType:@"image/jpeg"];
                  }
              }
          }success:^(AFHTTPRequestOperation *operation,id responseObject) {
              block(responseObject);
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"请求网络失败");
          }];
        }
    }
    //设置返回数据的解析方式
    operation.responseSerializer =[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    return operation;

}

+ (AFHTTPRequestOperation *)requestWithURL:(NSString *)url requestHeader:(NSDictionary *)header parms:(NSMutableDictionary *)params httpMethod:(NSString *)httpMethod block:(CompletionLoad)block {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    //添加请求头
    for (NSString *key in header.allKeys) {
        [request addValue:header[key] forHTTPHeaderField:key];
    }
    
    //get请求
    NSComparisonResult compResult1 =[httpMethod caseInsensitiveCompare:@"GET"];
    if (compResult1 == NSOrderedSame) {
        [request setHTTPMethod:@"GET"];
        if(params !=nil)
        {
            //添加参数，将参数拼接在url后面
            NSMutableString *paramsString = [NSMutableString string];
            NSArray *allkeys = [params allKeys];
            for (NSString *key in allkeys) {
                NSString *value = [params objectForKey:key];
                
                [paramsString appendFormat:@"&%@=%@", key, value];
            }
            
            if (paramsString.length >0) {
                [paramsString replaceCharactersInRange:NSMakeRange(0,1) withString:@"?"];
                //重新设置url
                [request setURL:[NSURL URLWithString:[url stringByAppendingString:paramsString]]];
            }
        }
    }
    
    //post请求
    
    NSComparisonResult compResult2 = [httpMethod caseInsensitiveCompare:@"POST"];
    if (compResult2 == NSOrderedSame) {
        [request setHTTPMethod:@"POST"];
        for (NSString *key in params) {
            [request setHTTPBody:params[key]];
        }
    }
    
    //发送请求
    AFHTTPRequestOperation *requstOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //设置返回数据的解析方式(这里暂时只设置了json解析)
    requstOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [requstOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,id responseObject) {
        if (block !=nil) {
            block(responseObject);
        }
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        if (block !=nil) {
            block(error);
            
        }
        
    }];
    
    [requstOperation start];
    
    return requstOperation;
}

@end
