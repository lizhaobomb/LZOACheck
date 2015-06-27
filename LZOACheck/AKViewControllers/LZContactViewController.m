//
//  LZContactViewController.m
//  LZOACheck
//
//  Created by lizhao on 15/5/21.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZContactViewController.h"
#import "HeadView.h"
#import "ContactGroup.h"
#import "Contact.h"
#import "LZContactDetailViewController.h"
@interface LZContactViewController () <UITableViewDataSource, UITableViewDelegate, HeadViewDelegate> {
    UITableView *_contactList;
    NSArray *_contacts;
    ContactGroup *_contactGroup;
}

@end

@implementation LZContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
    [self loadRequest];
}

- (void)initContentView {
    _contactList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.height - 44- 64 - 49)];
    _contactList.delegate = self;
    _contactList.dataSource = self;
    [self.view addSubview:_contactList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AKLog(@"3333333333333");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadRequest {
    [[LZNetworkTools sharedLZNetworkTools].requestSerializer setValue:[LZSettings sharedLZSettings].sessionId forHTTPHeaderField:@"sessionId"];
    [[LZNetworkTools sharedLZNetworkTools] POST:@"/oa/phone/getContact" parameters:@{@"userId":[LZSettings sharedLZSettings].userId} success:^(NSURLSessionDataTask *task, id responseObject) {
        AKLog(@"%@",responseObject);
        _contacts = responseObject;
        NSMutableArray *tmp = [NSMutableArray array];
        for (NSDictionary *dict in _contacts) {
            _contactGroup = [ContactGroup objectWithKeyValues:dict];
            [tmp addObject:_contactGroup];
        }
        _contacts = tmp;
        [_contactList reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        AKLog(@"%@",error);
    }];
}


#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _contacts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ContactGroup *contactGroup = _contacts[section];
    NSInteger count = contactGroup.isOpened ? contactGroup.contacts.count : 0;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString *Identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    
    ContactGroup *contactGroup = _contacts[indexPath.section];
    Contact *contact = contactGroup.contacts[indexPath.row];
    cell.textLabel.text = contact.loginName;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HeadView *headerView = [HeadView headViewWithTableView:tableView];
    headerView.delegate = self;
    headerView.contactGroup = _contacts[section];
    return headerView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactGroup *contactGroup = _contacts[indexPath.section];
    Contact *contact = contactGroup.contacts[indexPath.row];
    LZContactDetailViewController *contactDetail = [[LZContactDetailViewController alloc] init];
    contactDetail.contact = contact ;
    [self.navigationController pushViewController:contactDetail animated:YES];
}

- (void)clickHeadView {
    [_contactList reloadData];
}
@end
