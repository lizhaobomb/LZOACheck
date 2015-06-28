//
//  DDTabControl.m
//  DDTabControl
//
//  Created by bright on 14/11/26.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "DDTabControl.h"
#import "LZCoreMacros.h"

@interface DDTabControl()
{
    UIImageView *backgroundView;
    UIScrollView *scrollView;
    
    NSMutableArray *items;
}

@end

@implementation DDTabControl

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        items = [[NSMutableArray alloc] init];
        
        backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:backgroundView];
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        
        [self addSubview:scrollView];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self relayout];
}

-(void)setItemTitles:(NSArray *)itemTitles{

    for (DDTabItem *item in items) {
        [item removeFromSuperview];
    }
    [items removeAllObjects];

    _itemTitles = itemTitles;
    
    for (NSInteger idx = 0;idx< [_itemTitles count];idx ++) {
        
        DDTabItem *item = [[DDTabItem alloc] initWithFrame:CGRectZero];
        [scrollView addSubview:item];
        [item addTarget:self action:@selector(itemTaped:) forControlEvents:UIControlEventTouchUpInside];
        [items addObject:item];
    }
    
    [self setNeedsLayout];
}

- (DDTabItem *)itemAtIndex:(NSInteger) idx{

    if (idx<[items count]) {
        return items[idx];
    }
    return nil;
}

-(void)setSelectedIndex:(NSInteger)selectedIndex{

    _selectedIndex = selectedIndex;
    
    for (NSInteger idx = 0;idx< [items count];idx ++) {
        DDTabItem *item = items[idx];
        if (_selectedIndex == idx) {
            item.selected = YES;
        }else{
            item.selected = NO;
        }
    }
    
    DDTabItem *item = [self itemAtIndex:selectedIndex];
    
    CGFloat itemCenterX = item.center.x;
    if (scrollView.contentSize.width>self.frame.size.width) {
        CGFloat offset = 0;
        if (itemCenterX > self.frame.size.width/2&&itemCenterX < (scrollView.contentSize.width-self.frame.size.width/2)) {
            offset = itemCenterX-self.frame.size.width/2;
        }else if(itemCenterX >= (scrollView.contentSize.width-self.frame.size.width/2)){
            offset = scrollView.contentSize.width - self.frame.size.width;
        }
        [scrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    }else{
        CGRect rect = item.frame;
        [scrollView scrollRectToVisible:rect animated:YES];
    }
}

-(void)relayout{

    CGFloat left = 10;
    
    for (NSInteger idx = 0;idx< [_itemTitles count];idx ++) {
        
        DDTabItem *item = items[idx];
        item.title = _itemTitles[idx];
        item.idx = idx;
        item.frame = CGRectMake(left, 0, item.itemWidth, self.frame.size.height);
        left = left+item.itemWidth+10;
        scrollView.contentSize = CGSizeMake(left, self.frame.size.height);
    }
    
    if (scrollView.contentSize.width<self.frame.size.width) {
        scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    }
    
    [self setSelectedIndex:_selectedIndex];
}

-(void)itemTaped:(DDTabItem *)sender{
    
    if(_selectedIndex != sender.idx){
        [self setSelectedIndex:sender.idx];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

@interface DDTabItem()
{

    UILabel *titleLabel;
}

@end

@implementation DDTabItem

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _bgImgView.layer.cornerRadius = 5;
        _bgImgView.layer.masksToBounds = YES;
        _bgImgView.backgroundColor = MAIN_COLOR;
        [self addSubview:_bgImgView];

        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:titleLabel];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = TEXT_COLOR ;
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        
        
    }
    
    return self;
}

-(void)setTitle:(NSString *)title{

    _title = title;
    titleLabel.text = _title;
    [titleLabel sizeToFit];
    
    _itemWidth = titleLabel.frame.size.width + 10;
    _itemWidth = _itemWidth < 50 ? 50:_itemWidth;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    titleLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _bgImgView.frame = CGRectMake(-5, 5, frame.size.width+10, frame.size.height - 10);
}

-(void)setSelected:(BOOL)selected{
    if (selected) {
        [UIView animateWithDuration:0.3 animations:^{
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.transform =CGAffineTransformMakeScale(1.1,1.1);
            
        } completion:^(BOOL finished) {
            _bgImgView.hidden = NO;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            titleLabel.textColor = TEXT_COLOR;
            titleLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            _bgImgView.hidden = YES;
        }];
    }
}

@end