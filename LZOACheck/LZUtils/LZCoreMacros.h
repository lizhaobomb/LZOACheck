//
//  LZCoreMacros.h
//  LZOACheck
//
//  Created by lizhao on 15/5/16.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

//#import <AFNetworking/AFNetworking.h>
#import "LZNetworkTools.h"

#ifndef LZOACheck_LZCoreMacros_h
#define LZOACheck_LZCoreMacros_h

#ifdef DEBUG
#define AKLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define AKLog(xx, ...)  ((void)0)
#endif



//--------------------UI相关宏-------------------
#define OFFSET_12   12
#define OFFSET_20   20

#define FONT_LIGHT(s)           {[UIFont systemFontOfSize:s];}
#define FONT_BOLD(s)            {[UIFont boldSystemFontOfSize:s];}

#define FONT_18                 (FONT_LIGHT(18))
#define FONT_16                 (FONT_LIGHT(16))
#define FONT_14                 (FONT_LIGHT(14))
#define FONT_12                 (FONT_LIGHT(12))
#define FONT_9                  (FONT_LIGHT(9))

#define FONT_21B                (FONT_BOLD(21))
#define FONT_18B                (FONT_BOLD(18))
#define FONT_16B                (FONT_BOLD(16))
#define FONT_14B                (FONT_BOLD(14))
#define FONT_12B                (FONT_BOLD(12))

#define OFFSET_N                (47/3)

//--------------------屏幕相关宏-------------------
#define ScreenHeight        [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth         [[UIScreen mainScreen] bounds].size.width

#define StateBarHeight 20
#define MainHeight (ScreenHeight - StateBarHeight)
#define MainWidth ScreenWidth


//--------------------颜色相关宏-------------------

#define TEXT_COLOR UIColorFromRGB(0x555555)

#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#endif
