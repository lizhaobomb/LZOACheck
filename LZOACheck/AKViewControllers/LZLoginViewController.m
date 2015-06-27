//
//  LZLoginViewController.m
//  LZOACheck
//
//  Created by lizhao on 15/5/16.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZLoginViewController.h"
#import "LZCoreMacros.h"
#import "UIViewExt.h"
#import "LZUserDataModel.h"
@interface LZLoginViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *userNameField;
@property (nonatomic, strong) UITextField *pwdField;
@end

@implementation LZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back:)];
    [self initContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void) back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) initContentView {
    _userNameField = [[UITextField alloc] initWithFrame:CGRectMake(OFFSET_12, OFFSET_20+64, 200, 30)];
    _userNameField.borderStyle = UITextBorderStyleRoundedRect;
    _userNameField.placeholder = @"请输入您的用户名";
    _userNameField.delegate = self;
    _userNameField.text = @"admin";
    [self.view addSubview:_userNameField];
    
    _pwdField = [[UITextField alloc] initWithFrame:CGRectMake(OFFSET_12, _userNameField.bottom + OFFSET_12, 200, 30)];
    _pwdField.borderStyle = UITextBorderStyleRoundedRect;
    _pwdField.placeholder = @"请输入您的密码";
    _pwdField.secureTextEntry = YES;
    _pwdField.delegate = self;
    _pwdField.text = @"123456";
    [self.view addSubview:_pwdField];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginBtn.frame = CGRectMake(OFFSET_12, ScreenHeight - 45, ScreenWidth - OFFSET_12 * 2, 40);
    [loginBtn addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
}

- (void)loginClicked:(id)sender {
    NSDictionary *params = @{@"account":_userNameField.text, @"password":_pwdField.text};
    
    [[LZNetworkTools sharedLZNetworkTools] POST:@"/oa/phone/login" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Login Succeed:%@",responseObject);
        LZUserDataModel *user = [LZUserDataModel objectWithKeyValues:responseObject];
        [LZSettings sharedLZSettings].userId = user.userId;
        [LZSettings sharedLZSettings].sessionId = user.sessionId;
        [LZSettings savePrefs];
        if (self.LoginSucceed) {
            self.LoginSucceed();
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Login failed:%@",error);
        [[LZAlertUtils sharedLZAlertUtils] toggleMessage:error.description];
    }];
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
