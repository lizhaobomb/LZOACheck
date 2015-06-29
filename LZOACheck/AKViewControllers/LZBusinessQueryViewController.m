//
//  LZAffairQueryViewController.m
//  LZOACheck
//
//  Created by lizhao on 15/5/14.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZBusinessQueryViewController.h"
#import "LZNetworkTools.h"
#import "LZCoreMacros.h"
@interface LZBusinessQueryViewController () {
    UITextField *_cardField;
    
    UILabel *_nameValueLbl;
    UILabel *_numValueLbl;
    UILabel *_cardNoValueLbl;
    UILabel *_processValueLbl;
    UILabel *_contentValueLbl;
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
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    _cardField = [[UITextField alloc] initWithFrame:CGRectMake(OFFSET_12, (64-30)/2, ScreenWidth - 120, 30)];
    _cardField.borderStyle = UITextBorderStyleNone;
    [self customRoundView:_cardField];
    _cardField.font = FONT_14;
    _cardField.placeholder = @"身份证/编号";
    [topView addSubview:_cardField];
    
    UIButton *queryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    queryBtn.frame = CGRectMake(_cardField.right + 5, _cardField.top, 90, 30);
    queryBtn.backgroundColor = MAIN_COLOR;
    [queryBtn setTitle:@"办事查询" forState:UIControlStateNormal];
    [self customRoundView:queryBtn];
    
    [queryBtn addTarget:self action:@selector(queryBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:queryBtn];
    [topView addSubview:_cardField];
    
    [self.view addSubview:topView];
    
    UIView *seperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, topView.bottom + OFFSET_N, ScreenWidth, 2)];
    seperatorView.backgroundColor = SEPERATOR_COLOR;
    [self.view addSubview:seperatorView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, seperatorView.bottom + OFFSET_N, ScreenWidth, 0)];
    
    UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET_N, OFFSET_N, 70, 20)];
    nameLbl.text = @"名称:";
    nameLbl.textColor = MAIN_COLOR;
    nameLbl.font = FONT_14;
    nameLbl.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:nameLbl];
    
    UILabel *numLbl = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET_N, nameLbl.bottom + OFFSET_N, 70, 20)];
    numLbl.text = @"编号:";
    numLbl.textColor = MAIN_COLOR;
    numLbl.font = FONT_14;
    numLbl.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:numLbl];
    
    UILabel *cardNoLbl = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET_N, numLbl.bottom + OFFSET_N, 70, 20)];
    cardNoLbl.text = @"身份证号:";
    cardNoLbl.textColor = MAIN_COLOR;
    cardNoLbl.font = FONT_14;
    cardNoLbl.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:cardNoLbl];
    
    UILabel *processLbl = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET_N, cardNoLbl.bottom + OFFSET_N, 70, 20)];
    processLbl.text = @"进度:";
    processLbl.textColor = MAIN_COLOR;
    processLbl.font = FONT_14;
    processLbl.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:processLbl];
    
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET_N, processLbl.bottom + OFFSET_N, 70, 20)];
    contentLbl.text = @"内容:";
    contentLbl.textColor = MAIN_COLOR;
    contentLbl.font = FONT_14;
    contentLbl.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:contentLbl];
    
    [self.view addSubview:bottomView];
    
}

- (void)queryBtnClicked:(id)sender {
    [[LZNetworkTools sharedLZNetworkTools].requestSerializer setValue:[LZSettings sharedLZSettings].sessionId forHTTPHeaderField:@"sessionId"];
    [[LZNetworkTools sharedLZNetworkTools] POST:@"/oa/phone/getByInsId" parameters:@{@"procInsId":_cardField.text} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)customRoundView:(UIView *)view {
    view.layer.cornerRadius = 2;
    if ([view isKindOfClass:[UIButton class]]) {
        return;
    }
    view.layer.borderWidth = 1;
    view.layer.borderColor = BORDER_COLOR.CGColor;
    view.layer.masksToBounds = YES;
}

@end
