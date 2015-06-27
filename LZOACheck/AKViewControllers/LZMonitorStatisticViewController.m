//
//  LZMonitorStatisticViewController.m
//  LZOACheck
//
//  Created by lizhao on 15/5/19.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZMonitorStatisticViewController.h"

@interface LZMonitorStatisticViewController ()

@end

@implementation LZMonitorStatisticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
}

- (void)initContentView {
    UILabel *tintLbl = [[UILabel alloc]  initWithFrame:CGRectMake(0, 0, 100, 100)];
    tintLbl.text = @"监察统计";
    tintLbl.center = self.view.center;
    [self.view addSubview:tintLbl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AKLog(@"1111111111");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
