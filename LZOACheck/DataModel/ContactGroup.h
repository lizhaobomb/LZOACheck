//
//  ContactGroup.h
//  
//
//  Created by lizhao on 15/6/25.
//
//

#import <Foundation/Foundation.h>

@interface ContactGroup : NSObject

@property (nonatomic, strong) NSArray *contacts;
@property (nonatomic, strong) NSString *groupName;

@property (nonatomic, assign, getter = isOpened) BOOL opened;

//+ (instancetype)contactGroupWithDict:(NSDictionary *)dict;
//- (instancetype)initWithDict:(NSDictionary *)dict;

@end
