//
//  ViewController.m
//  LZOACheck
//
//  Created by lizhao on 15/5/14.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZInfomationViewController.h"
#import "DDTabControl.h"
#import "DDPagedScrollView.h"
#import "LZPlatformInfoViewController.h"
#import "LZNewsListViewController.h"
#import "LZCoreMacros.h"

#import "LZNetworkingTools.h"
@interface LZInfomationViewController ()<DDPagedScrollViewDelegate> {
    DDPagedScrollView *_scrollView;
    DDTabControl      *_tabControl;
    NSArray           *_menus;
    NSArray           *_news;
    LZPlatformInfoViewController *_platformVC;
    LZNewsListViewController    *_newsList;
}

@end

@implementation LZInfomationViewController

- (id)init {
    if (self = [super init]) {
        self.title = @"信息中心";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRequest];
}


- (void)loadRequest {
    
    [LZNetworkingTools requestWithURL:@"http://111.206.163.56:8686/oa/portal/menus" params:nil httpMethod:@"get" block:^(NSObject *result) {
        NSLog(@"%@",result);
    }];
    
    [[LZNetworkTools sharedLZNetworkTools] GET:@"/oa/portal/menus" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        AKLog(@"%@",responseObject);
        _menus = responseObject[@"items"];
        [self updateMenus];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        AKLog(@"%@",error);
    }];
}

- (void)loadInfomationListByUrl:(NSString *)url {
    [[LZNetworkTools sharedLZNetworkTools] GET:[NSString stringWithFormat:@"/oa%@",url] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        AKLog(@"%@",responseObject);
        _news = responseObject[@"items"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        AKLog(@"%@",error);
        [[LZAlertUtils sharedLZAlertUtils] toggleMessage:error.localizedDescription];

    }];
}

- (void)updateMenus {
    NSMutableArray *titles = [NSMutableArray array];
    for (NSDictionary *dict in _menus) {
        [titles addObject:dict[@"name"]];
    }
    [titles addObject:@"平台介绍"];
    _tabControl = [[DDTabControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [self.view addSubview:_tabControl];
    _tabControl.itemTitles = titles;
    _tabControl.backgroundColor = UIColorFromRGB(0xededed);
    [_tabControl addTarget:self action:@selector(controlValueChanged:) forControlEvents:UIControlEventValueChanged];
    _scrollView = [[DDPagedScrollView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44)];
    _scrollView.delegate = self;
    _scrollView.continuous = NO;
    [self.view addSubview:_scrollView];
    
    [_scrollView setCurrentPage:2];


}

- (NSUInteger)numberOfPagesInPagedView:(DDPagedScrollView *)pagedView{
    return [_tabControl.itemTitles count];
}

- (UIView *)pagedView:(DDPagedScrollView *)pagedView viewForPageAtIndex:(NSUInteger)index{
    AKLog(@"%zd",index);
//    pagedView.layer.borderColor = [UIColor greenColor].CGColor;
//    pagedView.layer.borderWidth = 1;
    if (index == _menus.count) {
        UIView *platView = (UIView *) [pagedView dequeueReusableViewWithTag:108];
        if (!platView) {
            _platformVC = [[LZPlatformInfoViewController alloc] init];
            [self addChildViewController:_platformVC];
            platView = _platformVC.view;
            platView.tag = 100+_menus.count;
        }
        platView.frame = [pagedView bounds];
        return platView;
    }
    
    
    UIView *_page = (UITableView *) [pagedView dequeueReusableViewWithTag:100+index];
    if (!_page) {
        _newsList = [[LZNewsListViewController alloc] init];
        _newsList.url = _menus[index][@"url"];

        [self addChildViewController:_newsList];
        _page = _newsList.view;
        _page.tag = 100+index;
    }
    _page.frame = [pagedView bounds];

    return _page;
}

- (void)pagedView:(DDPagedScrollView *)pagedView didScrollToPageAtIndex:(NSUInteger)index{
    _tabControl.selectedIndex = index;
}

-(void)controlValueChanged:(DDTabControl *)sender{
    
    NSLog(@"selectedIndex = %ld",sender.selectedIndex);
    [_scrollView setCurrentPage:sender.selectedIndex];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
