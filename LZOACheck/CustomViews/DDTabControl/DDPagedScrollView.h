//
//  DDPagedScrollView.h
//  Group
//
//  Created by bright on 14-7-22.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDPagedScrollViewDelegate;

@interface  DDPagedScrollView : UIScrollView

@property (nonatomic, assign  ) id <DDPagedScrollViewDelegate,    UIScrollViewDelegate> delegate;
@property (nonatomic, assign  ) NSUInteger           currentPage;
@property (nonatomic, readonly) NSUInteger           numberOfPages;
@property (nonatomic, assign  ) BOOL                 continuous;

- (UIView *)dequeueReusableViewWithTag:(NSInteger)tag;
- (UIView *)viewForPageAtIndex:(NSUInteger)index;
- (void)scrollToPageAtIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)reloadData;
- (NSUInteger)indexForView:(UIView *)view;

@end

@protocol DDPagedScrollViewDelegate <UIScrollViewDelegate>

- (NSUInteger)numberOfPagesInPagedView:(DDPagedScrollView *)pagedView;
- (UIView *)pagedView:(DDPagedScrollView *)pagedView viewForPageAtIndex:(NSUInteger)index;

@optional

- (void)pagedView:(DDPagedScrollView *)pagedView didScrollToPageAtIndex:(NSUInteger)index;
- (void)pagedView:(DDPagedScrollView *)pagedView didRecycleView:(UIView *)view;

@end