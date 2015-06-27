//
//  LZEmailListViewController.m
//  LZOACheck
//
//  Created by lizhao on 15/5/20.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZEmailListViewController.h"
#import "LZNetworkTools.h"
#import "LZEmaiDetailViewController.h"
@interface LZEmailListViewController () <UITableViewDataSource, UITableViewDelegate>{
    UITableView *_emailList;
    NSArray *_emails;
}

@end

@implementation LZEmailListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initContentView];
    [self request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)request {
    NSString *url = nil;
    if (_pageType == TYPE_UNREAD) {
        url = @"/oa/phone/getUnReadMails";
    } else if (_pageType == TYPE_READED) {
        url = @"/oa/phone/getMarkReadMails";
    } else {
        url = @"/oa/phone/getSendMails";
    }
    [[LZNetworkTools sharedLZNetworkTools].requestSerializer setValue:[LZSettings sharedLZSettings].sessionId forHTTPHeaderField:@"sessionId"];
    [[LZNetworkTools sharedLZNetworkTools] POST:url
                                     parameters:@{@"userId":[LZSettings sharedLZSettings].userId,@"cp":@"1",@"ps":@"20"}
                                        success:^(NSURLSessionDataTask *task, id responseObject) {
                                            AKLog(@"%@",responseObject);
                                            _emails = responseObject[@"resultList"];
                                            [_emailList reloadData];
                                        } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                            AKLog(@"%@",error);
                                        }];

}

- (void)initContentView {
    _emailList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, ScreenHeight - 49)];
    _emailList.delegate = self;
    _emailList.dataSource = self;
    [self.view addSubview:_emailList];
    
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _emails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    NSDictionary *email = _emails[indexPath.row];
    cell.textLabel.text = email[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     NSDictionary *email = _emails[indexPath.row];
    LZEmaiDetailViewController *emailDetail = [[LZEmaiDetailViewController alloc] init];
    emailDetail.mainBody = email[@"mainBody"];
    [self.navigationController pushViewController:emailDetail animated:YES];
}

@end
