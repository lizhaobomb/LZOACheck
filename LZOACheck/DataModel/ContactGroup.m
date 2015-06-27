//
//  ContactGroup.m
//  
//
//  Created by lizhao on 15/6/25.
//
//

#import "ContactGroup.h"
#import "Contact.h"
#import "MJExtension/MJExtension.h"
@implementation ContactGroup

//+ (instancetype)contactGroupWithDict:(NSDictionary *)dict {
//    return [[self alloc] initWithDict:dict];
//}
//
//- (instancetype)initWithDict:(NSDictionary *)dict {
//    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
//        
//        NSMutableArray *tmpArray = [NSMutableArray array];
//        for (NSDictionary *dict in _contacts) {
//            Contact *contact = [Contact contactWithDict:dict];
//            [tmpArray addObject:contact];
//        }
//        _contacts = tmpArray;
//    }
//    return self;
//}

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"contacts":@"childList"};
}

+ (NSDictionary *)objectClassInArray {
    return @{@"contacts":@"Contact"};
}

@end
