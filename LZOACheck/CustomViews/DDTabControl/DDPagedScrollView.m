//
//  DDPagedScrollView.m
//  Group
//
//  Created by bright on 14-7-22.
//  Copyright (c) 2014年 Qunar.com. All rights reserved.
//

#import "DDPagedScrollView.h"


@interface DDPagedScrollView ()

@property (nonatomic, retain) NSMutableArray *views;
@property (nonatomic, retain) NSMutableDictionary *queues;
@property (nonatomic, readonly) NSInteger actualPage;
@property (nonatomic, readonly) NSUInteger numberOfActualPages;
@property (nonatomic, readonly) NSUInteger otherVisiblePage;

- (void)setUp;
- (CGPoint)centerForViewForPageAtIndex:(NSInteger)index;
- (NSMutableArray *)queueWithTag:(NSInteger)tag;
- (void)queueView:(UIView *)view;
- (void)queueExistingViews;
- (void)loadNewViews;
- (void)correctContentOffset;

@end


@implementation DDPagedScrollView

- (id <DDPagedScrollViewDelegate>)delegate
{
	return (id <DDPagedScrollViewDelegate>) [super delegate];
}

- (void)setDelegate:(id<DDPagedScrollViewDelegate>)delegate
{
	[super setDelegate:delegate];
}

- (void)setCurrentPage:(NSUInteger)currentPage
{
	if (_currentPage == currentPage) {
		return;
	}
	
	[self scrollToPageAtIndex:currentPage animated:NO];
}



- (id)init
{
	self = [self initWithFrame:CGRectZero];
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setUp];
	}
	return self;
}

- (void)setUp
{
	_actualPage = NSNotFound;
	_currentPage = NSNotFound;
	_numberOfPages = NSNotFound;
	_numberOfActualPages = NSNotFound;
	_otherVisiblePage = NSNotFound;
	
	// Set default scrollview properties
	self.pagingEnabled = YES;
	self.showsHorizontalScrollIndicator = NO;
	self.showsVerticalScrollIndicator = NO;
	self.alwaysBounceHorizontal = YES;
	
	_views = [[NSMutableArray alloc] init];
	_queues = [[NSMutableDictionary alloc] init];
}

- (void)reloadData
{
	_actualPage = NSNotFound;
	_currentPage = NSNotFound;
	_numberOfPages = NSNotFound;
	_numberOfActualPages = NSNotFound;
	
	for (UIView *view in _views) {
		if ([view isKindOfClass:[UIView class]]) {
			[view removeFromSuperview];
		}
	}
	
	[_views removeAllObjects];
	[_queues removeAllObjects];
	
	self.contentOffset = CGPointZero;
	
	[self setNeedsLayout];
}




- (NSMutableArray *)queueWithTag:(NSInteger)tag
{
	NSNumber *key = [NSNumber numberWithInteger:tag];
	NSMutableArray *queue = [_queues objectForKey:key];
	
	// Create a queue if none exists
	if (!queue) {
		queue = [NSMutableArray array];
		[_queues setObject:queue forKey:key];
	}
	
	return queue;
}

- (UIView *)dequeueReusableViewWithTag:(NSInteger)tag
{
	NSMutableArray *queue = [self queueWithTag:tag];
	
	// No queued view available
	if ([queue count] == 0) {
		return nil;
	}
	
	// Remove view from queue and return it
	UIView *view = [queue objectAtIndex:0];
	[queue removeObjectAtIndex:0];
	
	return view;
}

- (void)queueView:(UIView *)view
{
	// Add view to queue
	NSMutableArray *queue = [self queueWithTag:view.tag];
	[queue addObject:view];
}

- (void)queueExistingViews
{
	// Create index set for visible views
	NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSetWithIndex:_currentPage];
	
	// Add index of view to the left
	NSInteger leftIndex = _currentPage - 1;
	if (leftIndex >= 0 || _continuous) {
		if (leftIndex < 0) {
			leftIndex += _numberOfPages;
		}
		[indexSet addIndex:leftIndex];
	}
	
	// Add index of view to the right
	NSInteger rightIndex = _currentPage + 1;
	if (rightIndex < _numberOfPages || _continuous) {
		if (rightIndex >= _numberOfPages) {
			rightIndex -= _numberOfPages;
		}
		[indexSet addIndex:rightIndex];
	}
	
	for (NSInteger i = 0; i < [_views count]; i++) {
		UIView *view = [_views objectAtIndex:i];
		
		// If this object is not a view, don't queue it
		if (![view isKindOfClass:[UIView class]]) {
			continue;
		}
		
		// If this is a visible view, don't queue it
		if ([indexSet containsIndex:i]) {
			continue;
		}
		
		// Remove view from superview and add it to queue for later reuse
		[view removeFromSuperview];
		[self queueView:view];
		[_views replaceObjectAtIndex:i withObject:[NSNull null]];
		
		// Notify the delegate of the view being removed from the view hierachy
		if ([self.delegate respondsToSelector:@selector(pagedView:didRecycleView:)]) {
			[self.delegate pagedView:self didRecycleView:view];
		}
	}
}

- (CGPoint)centerForViewForPageAtIndex:(NSInteger)index
{
	CGPoint point = CGPointMake((index + 0.5) * self.bounds.size.width, self.bounds.size.height / 2.0);
	return point;
}

- (UIView *)viewForPageAtIndex:(NSUInteger)index
{
	UIView *view = [_views objectAtIndex:index];
	
	// If no queued view available, return nil
	if (![view isKindOfClass:[UIView class]]) {
		return nil;
	}
	
	return view;
}

- (void)loadNewViews
{
	for (NSInteger i = _actualPage - 1; i < _actualPage + 2; i++) {
		NSInteger index = i;
		
		// Get correct view index for this page
		if (_continuous) {
			if (i < 0) {
				index += _numberOfPages;
			} else if (i >= _numberOfPages) {
				index -= _numberOfPages;
			}
		} else if (i < 0 || i >= _numberOfPages) {
			continue;
		}
		
		// No view for this index
		if (index >= [_views count]) {
			continue;
		}
		
		UIView *view = [_views objectAtIndex:index];
		
		// This view is already visible, reposition it and continue
		if ([view isKindOfClass:[UIView class]]) {
			if (_continuous && _numberOfPages == 2) {
				if (i != _actualPage) {
					view.center = [self centerForViewForPageAtIndex:_otherVisiblePage];
					continue;
				}
			}
			
			// Always position view at first page when there's only one page
			if (_continuous && _numberOfPages == 1) {
				view.center = [self centerForViewForPageAtIndex:0];
				continue;
			}
			
			view.center = [self centerForViewForPageAtIndex:i];
			continue;
		}
		
		// Get view for this page
		view = [self.delegate pagedView:self viewForPageAtIndex:index];
		view.center = [self centerForViewForPageAtIndex:i];
		if (_continuous && _numberOfPages == 2 && i != _actualPage) {
			view.center = [self centerForViewForPageAtIndex:_otherVisiblePage];
		}
		[_views replaceObjectAtIndex:index withObject:view];
		[self addSubview:view];
	}
}

- (void)layoutSubviews
{
	if (_numberOfPages == NSNotFound) {
		// This is executed only once
		_numberOfPages = [self.delegate numberOfPagesInPagedView:self];
		_numberOfActualPages = _numberOfPages;
		
		if (_continuous && _numberOfPages > 1) {
			_numberOfActualPages++;
		}
		
		// Prepopulate views array
		while ([_views count] < _numberOfPages) {
			[_views addObject:[NSNull null]];
		}
	}
	
	self.contentSize = CGSizeMake(self.bounds.size.width * _numberOfActualPages, self.bounds.size.height);
	
	[self correctContentOffset];
	
	NSInteger actualPage = round(self.contentOffset.x / self.bounds.size.width);
	NSInteger otherVisiblePage;
	if (actualPage == floor(self.contentOffset.x / self.bounds.size.width)) {
		otherVisiblePage = actualPage + 1;
	} else {
		otherVisiblePage = actualPage - 1;
	}
	
	// If there's only one page, never change page
	if (_numberOfPages == 1) {
		actualPage = 0;
	}
	
	// If page hasn't changed, nothing to do
	if (_actualPage == actualPage && _otherVisiblePage == otherVisiblePage) {
		return;
	}
	
	_actualPage = actualPage;
	_otherVisiblePage = otherVisiblePage;
	
	// Calculate current page when continuous scrolling is enabled
	NSInteger currentPage = actualPage;
	if (_continuous) {
		if (currentPage >= _numberOfPages) {
			currentPage -= _numberOfPages;
		} else if (currentPage < 0) {
			currentPage += _numberOfPages;
		}
	} else {
		currentPage = MIN(MAX(0, currentPage), _numberOfPages - 1);
	}
	
	// Only notify delegate if current page has changed
	BOOL notifyDelegate = NO;
	if (_currentPage != currentPage) {
		notifyDelegate = YES;
		_currentPage = currentPage;
	}
	
	[self queueExistingViews];
	[self loadNewViews];
	
	if (notifyDelegate && [self.delegate respondsToSelector:@selector(pagedView:didScrollToPageAtIndex:)]) {
		[self.delegate pagedView:self didScrollToPageAtIndex:_currentPage];
	}
}

- (NSUInteger)indexForView:(UIView *)view
{
	return [_views indexOfObject:view];
}


- (void)correctContentOffset
{
	// Correct content offset for continuous scrolling with multiple pages
	if (_continuous && _numberOfPages > 1) {
		if (self.contentOffset.x >= _numberOfPages * self.bounds.size.width) {
			self.contentOffset = CGPointMake(self.contentOffset.x - (_numberOfPages * self.bounds.size.width), 0.0);
		} else if (self.contentOffset.x < 0.0) {
			self.contentOffset = CGPointMake(self.contentOffset.x + (_numberOfPages * self.bounds.size.width), 0.0);
		}
	}
}

- (void)scrollToPageAtIndex:(NSUInteger)index animated:(BOOL)animated
{
	CGPoint contentOffset = CGPointMake(index * self.bounds.size.width, 0.0);
	[self setContentOffset:contentOffset animated:animated];
}

@end