//
//  Contact.m
//  
//
//  Created by lizhao on 15/6/25.
//
//

#import "Contact.h"
#import "MJExtension/MJExtension.h"
@implementation Contact

//+ (instancetype)contactWithDict:(NSDictionary *)dict {
//    return [[self alloc] initWithDict:dict];
//}
//
//- (instancetype)initWithDict:(NSDictionary *)dict {
//    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
//    }
//    return self;
//}

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"userId":@"id"};
}

@end
