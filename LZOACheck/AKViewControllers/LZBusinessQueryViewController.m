//
//  LZAffairQueryViewController.m
//  LZOACheck
//
//  Created by lizhao on 15/5/14.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZBusinessQueryViewController.h"
#import "LZNetworkTools.h"
@interface LZBusinessQueryViewController () {
    UITextField *_cardField;
}

@end

@implementation LZBusinessQueryViewController

- (id)init {
    if (self = [super init]) {
        self.title = @"办公查询";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initContentView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    _cardField = [[UITextField alloc] initWithFrame:CGRectMake(OFFSET_12, (64-30)/2, 200, 30)];
    _cardField.borderStyle = UITextBorderStyleBezel;
    _cardField.font = FONT_14;
    _cardField.placeholder = @"身份证/编号";
    [topView addSubview:_cardField];
    
    UIButton *queryBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    queryBtn.frame = CGRectMake(_cardField.right + 5, _cardField.top, self.view.width - _cardField.width - OFFSET_12 - 5, 30);
    [queryBtn setTitle:@"办事查询" forState:UIControlStateNormal];
    [queryBtn addTarget:self action:@selector(queryBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:queryBtn];
    [topView addSubview:_cardField];
    
    [self.view addSubview:topView];
}

- (void)queryBtnClicked:(id)sender {
    [[LZNetworkTools sharedLZNetworkTools].requestSerializer setValue:[LZSettings sharedLZSettings].sessionId forHTTPHeaderField:@"sessionId"];
    [[LZNetworkTools sharedLZNetworkTools] POST:@"/oa/phone/getByInsId" parameters:@{@"procInsId":_cardField.text} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
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
