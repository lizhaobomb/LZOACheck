//
//  LZUtils.h
//  LZOACheck
//
//  Created by lizhao on 15/5/19.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
@interface LZUtils : NSObject
+ (CGSize) sizeByText:(NSString *)text byFont:(UIFont *)font byWidth:(CGFloat)width;
@end
