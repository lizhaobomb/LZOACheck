//
//  LZToDosViewController.m
//  LZOACheck
//
//  Created by lizhao on 15/5/20.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZToDosViewController.h"

@interface LZToDosViewController () <UITableViewDataSource, UITableViewDelegate>{
    UITableView *_todoList;
    
    NSArray *_todos;
    NSArray *_dos;
    NSArray *_backs;
    NSArray *totalAry;

    BOOL _isTodoOpened;
    BOOL _isDoOpened;
    BOOL _isBackOpened;
}

@end

@implementation LZToDosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initContentView];
    [self requestData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    AKLog(@"00000000");
}

- (void)requestData {
    [[LZNetworkTools sharedLZNetworkTools].requestSerializer setValue:[LZSettings sharedLZSettings].sessionId forHTTPHeaderField:@"sessionId"];
    [[LZNetworkTools sharedLZNetworkTools] POST:@"/oa/phone/getInvolvedTasks" parameters:@{@"userId":[LZSettings sharedLZSettings].userId,@"cp":@"1",@"ps":@"100"} success:^(NSURLSessionDataTask *task, id responseObject) {
        AKLog(@"%@", responseObject);
        _todos = responseObject[@"resultList"];
        [_todoList reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[LZAlertUtils sharedLZAlertUtils] toggleMessage:error.localizedDescription];
    }];
    
    [[LZNetworkTools sharedLZNetworkTools] POST:@"/oa/phone/getFinishedTasks" parameters:@{@"userId":[LZSettings sharedLZSettings].userId,@"cp":@"1",@"ps":@"100"} success:^(NSURLSessionDataTask *task, id responseObject) {
        AKLog(@"%@", responseObject);
        _dos = responseObject[@"resultList"];
        [_todoList reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[LZAlertUtils sharedLZAlertUtils] toggleMessage:error.localizedDescription];
    }];
    
    [[LZNetworkTools sharedLZNetworkTools] POST:@"/oa/phone/getReturnedTasks" parameters:@{@"userId":[LZSettings sharedLZSettings].userId,@"cp":@"1",@"ps":@"100"} success:^(NSURLSessionDataTask *task, id responseObject) {
        AKLog(@"%@", responseObject);
        _backs = responseObject[@"resultList"];
        [_todoList reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[LZAlertUtils sharedLZAlertUtils] toggleMessage:error.localizedDescription];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initContentView {
    _todoList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-44-49)];
    _todoList.delegate = self;
    _todoList.dataSource = self;
//    _todoList.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_todoList];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _isTodoOpened ? _todos.count : 0;
    } else if (section == 1) {
        return  _isDoOpened ? _dos.count : 0;
    } else {
        return _isBackOpened ? _backs.count : 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    
    NSDictionary *data = nil;
    if (indexPath.section == 0) {
        data = _todos[indexPath.row];
    } else if (indexPath.section == 1) {
        data = _dos[indexPath.row];
    } else {
        data = _backs[indexPath.row];
    }
    
    cell.textLabel.text = data[@"processName"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return [self headerViewWithTitle:@"待办事项"];
    } else if (section == 1) {
        return [self headerViewWithTitle:@"已办事项"];
    } else {
        return [self headerViewWithTitle:@"退回"];
    }
}

- (UIView *)headerViewWithTitle:(NSString *)title {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headerBtn.frame = CGRectMake(0, 0, self.view.width, 40);
    [headerBtn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
    [headerBtn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
    [headerBtn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];

    [headerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    headerBtn.imageView.contentMode = UIViewContentModeCenter;
    headerBtn.imageView.clipsToBounds = NO;
    headerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    headerBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    headerBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [headerBtn setTitle:title forState:UIControlStateNormal];
    [headerBtn addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:headerBtn];
    [self transformHeaderImg:headerBtn];
    return headerView;
}

- (void)transformHeaderImg:(UIButton *)headerBtn {
    if ([headerBtn.currentTitle isEqualToString:@"待办事项"]) {
        headerBtn.imageView.transform = _isTodoOpened ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformMakeRotation(0);
    } else if ([headerBtn.currentTitle isEqualToString:@"已办事项"]) {
        headerBtn.imageView.transform = _isDoOpened ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformMakeRotation(0);
    } else {
        headerBtn.imageView.transform = _isBackOpened ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformMakeRotation(0);
    }

}

- (void)headerClicked:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"待办事项"]) {
        _isTodoOpened = !_isTodoOpened;
    } else if ([sender.currentTitle isEqualToString:@"已办事项"]) {
        _isDoOpened = !_isDoOpened;
    } else {
        _isBackOpened = !_isBackOpened;
    }
    [_todoList reloadData];

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
