//
//  DDTabControl.h
//  DDTabControl
//
//  Created by bright on 14/11/26.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDTabItem;
@interface DDTabControl : UIControl

@property (nonatomic,strong  ) UIImage   *backgroundImage;
@property (nonatomic,strong  ) NSArray   *itemTitles;
@property (nonatomic,assign  ) NSInteger selectedIndex;

- (id)initWithFrame:(CGRect)frame;
- (DDTabItem *)itemAtIndex:(NSInteger) idx;

@end


@interface DDTabItem : UIControl

@property (nonatomic,assign  ) NSInteger idx;
@property (nonatomic,readonly) CGFloat   itemWidth;
@property (nonatomic,strong  ) NSString  *title;
@property (nonatomic,strong) UIImageView *bgImgView;

- (id)initWithFrame:(CGRect)frame;

@end