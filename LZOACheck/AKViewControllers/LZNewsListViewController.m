//
//  LZNewsListViewController.m
//  LZOACheck
//
//  Created by lizhao on 15/5/27.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZNewsListViewController.h"
#import "MJRefresh/MJRefresh.h"
#import "LZInfoMationWebViewController.h"
#import "LZCoreMacros.h"

@interface LZNewsListViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *newsList;
@property(nonatomic, strong) NSArray *news;

@end

@implementation LZNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)requestData {
    [self loadInfomationListByUrl:self.url];
}

- (void)loadInfomationListByUrl:(NSString *)url {
    [[LZNetworkTools sharedLZNetworkTools] GET:[NSString stringWithFormat:@"/oa%@",url] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        AKLog(@"%@",responseObject);
        _news = responseObject[@"items"];
        [_newsList reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        AKLog(@"%@",error);
    }];
    [_newsList.header endRefreshing];
}

- (void)initContentView {
    _newsList = [[UITableView alloc] initWithFrame:CGRectZero];
    _newsList.frame = self.view.bounds;
    _newsList.delegate = self;
    _newsList.dataSource = self;

    _newsList.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:_newsList];

//    _newsList.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        // 进入刷新状态后会自动调用这个block
//        [self requestData];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _news.count;
};

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    NSDictionary *item = _news[indexPath.row];
    cell.textLabel.text = item[@"name"];
//    cell.textLabel.text = [NSString stringWithFormat:@"%zd row", indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AKLog(@"%zd",indexPath.row);
    NSDictionary *item = _news[indexPath.row];
    LZInfoMationWebViewController *webViewController = [[LZInfoMationWebViewController alloc] init];
    webViewController.newsUrl = [NSString stringWithFormat:@"%@/oa%@/%@",BASE_URL,self.url,item[@"id"]];
    [self.navigationController pushViewController:webViewController animated:YES];
}

@end
