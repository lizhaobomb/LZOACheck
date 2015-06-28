//
//  LZMonitorStatisticViewController.m
//  LZOACheck
//
//  Created by lizhao on 15/5/19.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZMonitorStatisticViewController.h"
#import "ASFTableView.h"
@interface LZMonitorStatisticViewController ()<ASFTableViewDelegate>
@property (nonatomic, strong) ASFTableView *mASFTableView;
@property (nonatomic, retain) NSMutableArray *rowsArray;

@end

@implementation LZMonitorStatisticViewController

- (instancetype)init {
    if (self = [super init]) {
        _rowsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
    
    [self initGridView];
}


- (void)initGridView {
    
    _mASFTableView = [[ASFTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    [self.view addSubview:_mASFTableView];
    
    CGFloat width = ScreenWidth/4;
    NSArray *cols = @[@"日期",@"已处理",@"未处理",@"已退回"];
    NSArray *weights = @[@(width),@(width),@(width),@(width)];
    NSDictionary *options = @{kASF_OPTION_CELL_TEXT_FONT_SIZE : @(16),
                              kASF_OPTION_CELL_TEXT_FONT_BOLD : @(true),
                              kASF_OPTION_CELL_BORDER_COLOR : [UIColor lightGrayColor],
                              kASF_OPTION_CELL_BORDER_SIZE : @(2.0),
                              kASF_OPTION_BACKGROUND : [UIColor colorWithRed:239/255.0 green:244/255.0 blue:254/255.0 alpha:1.0]};
    
    [_mASFTableView setDelegate:self];
    [_mASFTableView setBounces:NO];
    [_mASFTableView setSelectionColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0f]];
    [_mASFTableView setTitles:cols
                  WithWeights:weights
                  WithOptions:options
                    WitHeight:32 Floating:YES];
    
    [_rowsArray removeAllObjects];
    for (int i=0; i<25; i++) {
        [_rowsArray addObject:@{
                                kASF_ROW_ID :
                                    @(i),
                                
                                kASF_ROW_CELLS :
                                    @[@{kASF_CELL_TITLE : @"Sample ID", kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)},
                                      @{kASF_CELL_TITLE : @"Sample Name 里 乐山大佛", kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentLeft)},
                                      @{kASF_CELL_TITLE : @"Sample Phone No.", kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)},
                                      @{kASF_CELL_TITLE : @"Sample Gender", kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)}],
                                
                                kASF_ROW_OPTIONS :
                                    @{kASF_OPTION_BACKGROUND : [UIColor whiteColor],
                                      kASF_OPTION_CELL_PADDING : @(5),
                                      kASF_OPTION_CELL_BORDER_COLOR : [UIColor lightGrayColor]},
                                
                                @"some_other_data" : @(123)}];
    }
    
    [_mASFTableView setRows:_rowsArray];
}
- (void)initContentView {

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
