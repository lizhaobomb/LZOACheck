//
//  Contact.h
//  
//
//  Created by lizhao on 15/6/25.
//
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *email1;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *loginName;
@property (nonatomic, strong) NSString *mobile1;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *photoUrl;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *telephone1;

//+ (instancetype)contactWithDict:(NSDictionary *)dict;
//- (instancetype)initWithDict:(NSDictionary *)dict;

@end
