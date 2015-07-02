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
#import "LZCoreMacros.h"
#import "LZContactViewController.h"
#import "LZNavigationController.h"
#import "Contact.h"
@interface LZWriteEmailViewController () {
    UITextField *_toUserField;
}

@end

@implementation LZWriteEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateSelectContacts];
}

- (void)initContentView {
    
    UILabel *toUser = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET_N, OFFSET_12, 50, 20)];
    toUser.text = @"收件人";
    toUser.textColor = TEXT_COLOR;
    toUser.font = FONT_14;
    CGSize toUserSize = [LZUtils sizeByText:toUser.text byFont:FONT_14 byWidth:200];
    toUser.size = toUserSize;
    [self.view addSubview:toUser];
    
    CGFloat toUserFieldWidth = ScreenWidth - toUser.right - OFFSET_12 - OFFSET_N;
    
    _toUserField = [[UITextField alloc] initWithFrame:CGRectMake(toUser.right+OFFSET_12, toUser.top, toUserFieldWidth, 100/3)];
    _toUserField.borderStyle = UITextBorderStyleNone;
    [self customView:_toUserField];
    
    //添加联系人按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *addContactImg = [UIImage imageNamed:@"add_contact"];
    btn.frame = CGRectMake(_toUserField.width - addContactImg.size.width - 5, 5, addContactImg.size.width, addContactImg.size.height);
    [btn setImage:addContactImg forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(presentContactVC) forControlEvents:UIControlEventTouchUpInside];
    [_toUserField addSubview:btn];
    
    [self.view addSubview:_toUserField];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET_12, _toUserField.bottom + 15, 50, 20)];
    title.text = @"标　题";
    title.textColor = TEXT_COLOR;
    title.font = FONT_14;
    CGSize titleSize = [LZUtils sizeByText:title.text byFont:FONT_14 byWidth:200];
    title.size = titleSize;
    [self.view addSubview:title];
    
    CGFloat titleFieldWidth = ScreenWidth - title.right - OFFSET_12 - OFFSET_N;
    UITextField *titleField = [[UITextField alloc] initWithFrame:CGRectMake(title.right+OFFSET_12, title.top, titleFieldWidth, 100/3)];
    titleField.borderStyle = UITextBorderStyleNone;
    [self customView:titleField];
    [self.view addSubview:titleField];
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET_12, titleField.bottom + 15, 50, 20)];
    content.text = @"内　容";
    content.textColor = TEXT_COLOR;
    content.font = FONT_14;
    CGSize contentSize = [LZUtils sizeByText:content.text byFont:FONT_14 byWidth:200];
    content.size = contentSize;
    [self.view addSubview:content];
    
    CGFloat contentTVWidth = ScreenWidth - content.right - OFFSET_12 - OFFSET_N;
    UITextView *contentTV = [[UITextView alloc] initWithFrame:CGRectMake(content.right + OFFSET_12, content.top, contentTVWidth, 200)];
    [self customView:contentTV];
    [self.view addSubview:contentTV];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(OFFSET_N, contentTV.bottom + OFFSET_N, ScreenWidth - OFFSET_N * 2, 100/3);
    [self customView:sendBtn];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setBackgroundColor:[UIColor redColor]];
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
        [[LZAlertUtils sharedLZAlertUtils] toggleMessage:error.localizedDescription];
    }];
}

- (void)customView:(UIView *)view {
    view.layer.cornerRadius = 2;
    if ([view isKindOfClass:[UIButton class]]) {
        return;
    }
    view.layer.borderWidth = 1;
    view.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
    view.layer.masksToBounds = YES;
}

- (void)presentContactVC {
    
    LZContactViewController *contactVC = [[LZContactViewController alloc] init];
    contactVC.pageType = ContactPageTypeEmail;
    __weak typeof(self) weakSelf = self;
    contactVC.selectContactsBlock = ^(NSArray *selectContacts){
        _selectContacts = selectContacts;
        [weakSelf updateSelectContacts];
//        AKLog(@"%@",_selectContacts);
    };
    LZNavigationController *navi = [[LZNavigationController alloc] initWithRootViewController:contactVC];
    [self presentViewController:navi animated:YES completion:nil];
}

- (void) updateSelectContacts {
    NSMutableString *mutName = [NSMutableString string];
    for (Contact *contact in _selectContacts) {
        [mutName appendFormat:@"%@;",contact.loginName];
    }
    
    _toUserField.text = mutName;
}


@end
