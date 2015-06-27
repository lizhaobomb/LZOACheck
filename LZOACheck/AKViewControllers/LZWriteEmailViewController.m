//
//  LZWriteEmailViewController.m
//  LZOACheck
//
//  Created by lizhao on 15/5/19.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZWriteEmailViewController.h"
#import "UIViewExt.h"
#import "LZNetworkTools.h"
#import "LZUtils.h"
@interface LZWriteEmailViewController ()

@end

@implementation LZWriteEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
}

- (void)initContentView {
    UILabel *toUser = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET_12, 64 + OFFSET_12, 50, 20)];
    toUser.text = @"收件人";
    toUser.font = FONT_14;
    CGSize toUserSize = [LZUtils sizeByText:toUser.text byFont:FONT_14 byWidth:200];
    toUser.size = toUserSize;
    [self.view addSubview:toUser];
    
    UITextField *toUserField = [[UITextField alloc] initWithFrame:CGRectMake(toUser.right, toUser.top, 200, 20)];
    toUserField.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:toUserField];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET_12, toUserField.bottom + 15, 50, 20)];
    title.text = @"标　题";
    title.font = FONT_14;
    CGSize titleSize = [LZUtils sizeByText:title.text byFont:FONT_14 byWidth:200];
    title.size = titleSize;
    [self.view addSubview:title];
    
    UITextField *titleField = [[UITextField alloc] initWithFrame:CGRectMake(title.right, title.top, 200, 20)];
    titleField.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:titleField];
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET_12, title.bottom + 15, 50, 20)];
    content.text = @"内　容";
    content.font = FONT_14;
    CGSize contentSize = [LZUtils sizeByText:content.text byFont:FONT_14 byWidth:200];
    content.size = contentSize;
    [self.view addSubview:content];
    
    UITextView *contentTV = [[UITextView alloc] initWithFrame:CGRectMake(content.right, content.top, 200, 200)];
    contentTV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    contentTV.layer.borderWidth = 1;
    contentTV.layer.masksToBounds = YES;
    [self.view addSubview:contentTV];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendBtn.frame = CGRectMake(0, contentTV.bottom + 20, self.view.width, 30);
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendEmail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendEmail:(id)sender {
    [[LZNetworkTools sharedLZNetworkTools] POST:@"/oa/phone/sendMail" parameters:@{@"userId":@"16",@"title":@"title",@"content":@"content",@"receiverIds":@"1,2,3,4,5"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
