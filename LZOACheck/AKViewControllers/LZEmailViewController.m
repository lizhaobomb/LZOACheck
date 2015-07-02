//
//  LZEmailViewController.m
//  LZOACheck
//
//  Created by lizhao on 15/5/18.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZEmailViewController.h"
#import "UIViewExt.h"
#import "LZNetworkTools.h"
#import "LZWriteEmailViewController.h"
#import "LZEmailListViewController.h"
#import "LZCoreMacros.h"
@interface LZEmailViewController () {
    UIView *_writeEmailView;
    UIView *_bottomView;
    
    UILabel *_unreadCount;
    UILabel *_readedCount;
    UILabel *_sendedCount;
}

@end

@implementation LZEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initContentView];
    [self getEmailsCount];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AKLog(@"2222222");
}

- (void)getEmailsCount {
    [[LZNetworkTools sharedLZNetworkTools].requestSerializer setValue:[LZSettings sharedLZSettings].sessionId forHTTPHeaderField:@"sessionId"];
    
    [[LZNetworkTools sharedLZNetworkTools] POST:@"/oa/phone/getMailsCount" parameters:@{@"userId":[LZSettings sharedLZSettings].userId} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"获取邮件数量成功：%@",responseObject);
        [self configViewWithResponseObject:responseObject];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"获取邮件数量失败：%@",error);
        [[LZAlertUtils sharedLZAlertUtils] toggleMessage:error.localizedDescription];

    }];
}

- (void) configViewWithResponseObject:(NSDictionary *)respondObject {
    _readedCount.text = [respondObject[@"markReadCount"] stringValue];
    _sendedCount.text = [respondObject[@"sendCount"] stringValue];
    _unreadCount.text = [respondObject[@"unReadCount"] stringValue];
}

- (void)initContentView {
    [self createWriteEmailView];
    [self createBottomView];
}

- (void)createWriteEmailView {
    _writeEmailView = [[UIView alloc] initWithFrame:CGRectMake(0, OFFSET_N, self.view.width, 64)];
    _writeEmailView.backgroundColor = UIColorFromRGB(0xf3f3f3);
    UIButton *writeEmailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    writeEmailBtn.frame = _writeEmailView.bounds;
    [writeEmailBtn setTitle:@"写邮件" forState:UIControlStateNormal];
    [writeEmailBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [writeEmailBtn addTarget:self action:@selector(writeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [writeEmailBtn setImage:[UIImage imageNamed:@"write_email"] forState:UIControlStateNormal];

    [_writeEmailView addSubview:writeEmailBtn];
    [self.view addSubview:_writeEmailView];
}

- (void)writeBtnClicked:(id)sender {
    NSLog(@"%@ clicked!!!",sender);
    LZWriteEmailViewController *writeEmail = [[LZWriteEmailViewController alloc] init];
    [self.navigationController pushViewController:writeEmail animated:YES];
}

- (void)createBottomView {
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _writeEmailView.bottom + OFFSET_N, self.view.width, 64 * 3 +20 *2)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    
    UIView *unreadEmail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    unreadEmail.backgroundColor = UIColorFromRGB(0xf3f3f3);
    
    UIButton *unreadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    unreadBtn.frame = unreadEmail.bounds;
    [unreadBtn addTarget:self action:@selector(unreadBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [unreadBtn setTitle:@"未读邮件" forState:UIControlStateNormal];
    [unreadBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [unreadBtn setImage:[UIImage imageNamed:@"unread_email"] forState:UIControlStateNormal];
    unreadBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    unreadBtn.contentEdgeInsets = UIEdgeInsetsMake(0, OFFSET_N, 0, 0);
    [unreadEmail addSubview:unreadBtn];
    
    
    _unreadCount = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width - 50 - OFFSET_N, 0, 50, 20)];
    _unreadCount.center = CGPointMake(_unreadCount.center.x,64/2);
    _unreadCount.text = @"0";
    _unreadCount.textAlignment = NSTextAlignmentRight;
    [unreadEmail addSubview:_unreadCount];
    [_bottomView addSubview:unreadEmail];
    
    UIView *readedEmail = [[UIView alloc] initWithFrame:CGRectMake(0, unreadEmail.bottom + OFFSET_N, self.view.width, 64)];
    readedEmail.backgroundColor = UIColorFromRGB(0xf3f3f3);
    _readedCount = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width - 50 - OFFSET_N, 0, 50, 20)];
    AKLog(@"%@",NSStringFromCGPoint(readedEmail.center));
    _readedCount.center = CGPointMake(_readedCount.center.x, 64/2);
    _readedCount.text = @"0";
    _readedCount.textAlignment = NSTextAlignmentRight;
    [readedEmail addSubview:_readedCount];
    
    UIButton *readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    readBtn.frame = readedEmail.bounds;
    [readBtn setTitle:@"已读邮件" forState:UIControlStateNormal];
    [readBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [readBtn setImage:[UIImage imageNamed:@"readed_email"] forState:UIControlStateNormal];
    readBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    readBtn.contentEdgeInsets = UIEdgeInsetsMake(0, OFFSET_N, 0, 0);
    [readBtn addTarget:self action:@selector(readBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [readedEmail addSubview:readBtn];
    
    [_bottomView addSubview:readedEmail];
    
    UIView *sendedEmail = [[UIView alloc] initWithFrame:CGRectMake(0, readedEmail.bottom + 20, self.view.width, 64)];
    sendedEmail.backgroundColor = UIColorFromRGB(0xf3f3f3)
    ;
    UIButton *sendedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendedBtn.frame = sendedEmail.bounds;
    [sendedBtn setTitle:@"已发送邮件" forState:UIControlStateNormal];
    [sendedBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [sendedBtn setImage:[UIImage imageNamed:@"sended_email"] forState:UIControlStateNormal];
    sendedBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    sendedBtn.contentEdgeInsets = UIEdgeInsetsMake(0, OFFSET_N, 0, 0);
    [sendedBtn addTarget:self action:@selector(sendedBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [sendedEmail addSubview:sendedBtn];
    
    _sendedCount = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width - 50 - OFFSET_N, 0, 50, 20)];
    _sendedCount.center = CGPointMake(_sendedCount.center.x, 64/2);
    _sendedCount.text = @"0";
    _sendedCount.textAlignment = NSTextAlignmentRight;
    [sendedEmail addSubview:_sendedCount];

    [_bottomView addSubview:sendedEmail];
    [self.view addSubview:_bottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)unreadBtnClicked:(id)sender {
    LZEmailListViewController *emailList = [[LZEmailListViewController alloc] init];
    emailList.pageType = TYPE_UNREAD;
    [self.navigationController pushViewController:emailList animated:YES];
}

- (void)readBtnClicked:(id)sender {
    LZEmailListViewController *emailList = [[LZEmailListViewController alloc] init];
    emailList.pageType = TYPE_READED;
    [self.navigationController pushViewController:emailList animated:YES];
}

- (void)sendedBtnClicked:(id)sender {
    LZEmailListViewController *emailList = [[LZEmailListViewController alloc] init];
    emailList.pageType = TYPE_SENDED;
    [self.navigationController pushViewController:emailList animated:YES];
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
