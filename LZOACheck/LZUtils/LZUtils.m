//
//  LZUtils.m
//  LZOACheck
//
//  Created by lizhao on 15/5/19.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZUtils.h"

@implementation LZUtils

+ (CGSize) sizeByText:(NSString *)text byFont:(UIFont *)font byWidth:(CGFloat)width {
    
    NSMutableDictionary *attribs = [NSMutableDictionary dictionary];
    [attribs setObject:font forKey:NSFontAttributeName];
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attribs
                                         context:nil].size;
    
    return textSize;
}

@end
