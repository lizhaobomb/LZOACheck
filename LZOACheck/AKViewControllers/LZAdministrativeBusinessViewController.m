//
//  LZAdministrativeBusinessViewController.m
//  LZOACheck
//
//  Created by lizhao on 15/5/14.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZAdministrativeBusinessViewController.h"
#import "LZNetworkTools.h"
#import "DDPagedScrollView.h"
#import "DDTabControl.h"
#import "LZEmailViewController.h"
#import "LZToDosViewController.h"
#import "LZMonitorStatisticViewController.h"
#import "LZContactViewController.h"
#import "LZCoreMacros.h"

@interface LZAdministrativeBusinessViewController () <DDPagedScrollViewDelegate>{
    DDPagedScrollView *_scrollView;
    DDTabControl      *_tabControl;
    LZEmailViewController  *_emailVC;
    LZToDosViewController  *_todosVC;
    LZMonitorStatisticViewController *_monitorStatisticVC;
    LZContactViewController *_contactVC;
}

@end

@implementation LZAdministrativeBusinessViewController

- (id)init {
    if (self = [super init]) {
        self.title = @"行政办公";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
    
}

- (void)initContentView {

    _tabControl = [[DDTabControl alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    [self.view addSubview:_tabControl];
    
    _tabControl.itemTitles = @[@"行政事项",@"监察统计", @"邮件", @"通讯录"];
    
    _tabControl.backgroundColor = UIColorFromRGB(0xededed);
    [_tabControl addTarget:self action:@selector(controlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    _scrollView = [[DDPagedScrollView alloc] initWithFrame:CGRectMake(0, 108, self.view.frame.size.width, self.view.frame.size.height - 108 - 49)];
    _scrollView.delegate = self;
    _scrollView.continuous = YES;
    [self.view addSubview:_scrollView];
    
    [_scrollView setCurrentPage:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)numberOfPagesInPagedView:(DDPagedScrollView *)pagedView{
    return [_tabControl.itemTitles count];
}

- (UIView *)pagedView:(DDPagedScrollView *)pagedView viewForPageAtIndex:(NSUInteger)index{
    AKLog(@"%zd",index);
//    pagedView.layer.borderColor = [UIColor redColor].CGColor;
//    pagedView.layer.borderWidth = 1;
    if (index == 0) {
        _todosVC.view = (UIView *)[pagedView dequeueReusableViewWithTag:200];
        if (!_todosVC.view) {
            _todosVC = [[LZToDosViewController alloc] init];
            _todosVC.view.tag = 200;
            [self addChildViewController:_todosVC];
        }
        _todosVC.view.frame = [pagedView bounds];
        return _todosVC.view;
    }
    
    if (index == 1) {
        _monitorStatisticVC.view = (UIView *)[pagedView dequeueReusableViewWithTag:201];
        if (!_monitorStatisticVC.view) {
            _monitorStatisticVC = [[LZMonitorStatisticViewController alloc] init];
            _monitorStatisticVC.view.tag = 201;
            [self addChildViewController:_monitorStatisticVC];
        }
        _monitorStatisticVC.view.frame = [pagedView bounds];
        return _monitorStatisticVC.view;
    }

    
    if (index == 2) {
        _emailVC.view = (UIView *) [pagedView dequeueReusableViewWithTag:202];
        if (!_emailVC.view) {
            _emailVC = [[LZEmailViewController alloc] init];
            _emailVC.view.tag = 202;
            [self addChildViewController:_emailVC];
        }
        _emailVC.view.frame = [pagedView bounds];
        return _emailVC.view;
    }
    
    if (index == 3) {
        _contactVC.view = (UIView *)[pagedView dequeueReusableViewWithTag:203];
        if (!_contactVC.view) {
            _contactVC = [[LZContactViewController alloc] init];
            _contactVC.view.tag = 203;
            [self addChildViewController:_contactVC];
        }
        _contactVC.view.frame = pagedView.bounds;
        return _contactVC.view;
    }
    return nil;
}

- (void)pagedView:(DDPagedScrollView *)pagedView didScrollToPageAtIndex:(NSUInteger)index{
    AKLog(@"%zd",index);
    _tabControl.selectedIndex = index;
    if (index == 0) {
        [_todosVC viewWillAppear:YES];
    } else if (index == 1) {
        [_monitorStatisticVC viewWillAppear:YES];
    } else if (index == 2) {
        [_emailVC viewWillAppear:YES];
    } else {
        [_contactVC viewWillAppear:YES];
    }
}

-(void)controlValueChanged:(DDTabControl *)sender{
    
    NSLog(@"selectedIndex = %ld",sender.selectedIndex);
    [_scrollView setCurrentPage:sender.selectedIndex];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
