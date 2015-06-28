//
//  LZMonitorStatisticViewController.m
//  LZOACheck
//
//  Created by lizhao on 15/5/19.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZMonitorStatisticViewController.h"
#import "ASFTableView.h"
#import "DateTools/DateTools.h"
#import "LZAlertUtils.h"

@interface LZMonitorStatisticViewController ()<ASFTableViewDelegate>
@property (nonatomic, strong) ASFTableView *mASFTableView;
@property (nonatomic, strong) NSMutableArray *rowsArray;
@property (nonatomic, strong) UIToolbar *accessoryView;
@property (nonatomic, strong) UIDatePicker *datePickerView;
@property (nonatomic, strong) UITextField  *startDate ;
@property (nonatomic, strong) UITextField *endDate;
@property (nonatomic, strong) NSDate *startDateValue;
@property (nonatomic, strong) NSDate *endDateValue;

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
    
    [self initDatePickerView];
    [self initGridView];

}


- (void) initDatePickerView {
    _accessoryView = [[UIToolbar alloc] init];
    _accessoryView.frame=CGRectMake(0, 0, 320, 38);
    _accessoryView.backgroundColor = [UIColor grayColor];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(selectDoneAction)];
    [doneBtn setTintColor:[UIColor blueColor]];
    UIBarButtonItem *spaceBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    _accessoryView.items=@[spaceBtn,doneBtn];
    
    _datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, 175)];
    _datePickerView.datePickerMode = UIDatePickerModeDate;
}

- (void)selectDoneAction {
    if ([_startDate isFirstResponder]) {
        _startDate.text = [_datePickerView.date formattedDateWithFormat:@"yyyy-MM-dd"];
        _startDateValue = _datePickerView.date;
        [_startDate resignFirstResponder];
    } else {
        _endDate.text = [_datePickerView.date formattedDateWithFormat:@"yyyy-MM-dd"];
        _endDateValue = _datePickerView.date;
        [_endDate resignFirstResponder];
    }
}

- (void)initGridView {
    
    UIView *dateView = [[UIView alloc] initWithFrame:CGRectMake(0, OFFSET_N, ScreenWidth, 45)];
    dateView.backgroundColor = MAIN_COLOR;
    _startDate = [[UITextField alloc] initWithFrame:CGRectMake(5 , 5, 120, 35)];
    _startDate.borderStyle = UITextBorderStyleRoundedRect;
    _startDate.text = @"2015-06-01";
    _startDate.inputView = _datePickerView;
    _startDate.inputAccessoryView = _accessoryView;
    [dateView addSubview:_startDate];
    
    UIView *seperatedView = [[UIView alloc] initWithFrame:CGRectMake(_startDate.right + 5, 45/2, 5, 1)];
    seperatedView.backgroundColor = SEPERATOR_COLOR;
    [dateView addSubview:seperatedView];
    
    _endDate = [[UITextField alloc] initWithFrame:CGRectMake(seperatedView.right + 5, _startDate.top, _startDate.width, 35)];
    _endDate.text = @"2015-07-01";
    _endDate.borderStyle = UITextBorderStyleRoundedRect;
    _endDate.inputAccessoryView = _accessoryView;
    _endDate.inputView = _datePickerView;
    [dateView addSubview:_endDate];
    
    UIButton *queryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    queryBtn.frame = CGRectMake(_endDate.right + 5, _endDate.top, 50, _endDate.height);
    [queryBtn setTitle:@"查询" forState:UIControlStateNormal];
    [queryBtn addTarget:self action:@selector(query) forControlEvents:UIControlEventTouchUpInside];
    [dateView addSubview: queryBtn];
    [self.view addSubview:dateView];
    
    _mASFTableView = [[ASFTableView alloc] initWithFrame:CGRectMake(0, dateView.bottom + OFFSET_N, ScreenWidth, ScreenHeight - 64 - 44 - OFFSET_N*2 - 45 - 49)];
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
    
    [_mASFTableView setRows:_rowsArray];
}


- (void)initContentView {

}

- (void)query {
    [_rowsArray removeAllObjects];
    if (_startDateValue == nil) {
        _startDateValue = [NSDate dateWithString:_startDate.text formatString:@"yyyy-MM-dd"];
    }
    
    if (_endDateValue == nil) {
        _endDateValue = [NSDate dateWithString:_endDate.text formatString:@"yyyy-MM-dd"];
    }
    
    if([_endDateValue isEarlierThan:_startDateValue]) {
        [[LZAlertUtils sharedLZAlertUtils] toggleMessage:@"结束日期不能早于开始日期！"];
        return;
    }
    
    NSMutableArray *tmpAry = [self allDateBeginStartDate:_startDateValue endDate:_endDateValue];
    
    for (int i=0; i<tmpAry.count; i++) {
        [_rowsArray addObject:@{
                                kASF_ROW_ID :
                                    @(i),
                                
                                kASF_ROW_CELLS :
                                    @[@{kASF_CELL_TITLE : tmpAry[i], kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)},
                                      @{kASF_CELL_TITLE : @"0", kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)},
                                      @{kASF_CELL_TITLE : @"0", kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)},
                                      @{kASF_CELL_TITLE : @"0", kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)}],
                                
                                kASF_ROW_OPTIONS :
                                    @{kASF_OPTION_BACKGROUND : [UIColor whiteColor],
                                      kASF_OPTION_CELL_PADDING : @(5),
                                      kASF_OPTION_CELL_BORDER_COLOR : [UIColor lightGrayColor]},
                                
                                @"some_other_data" : @(123)}];
    }

    
    [_mASFTableView setRows:_rowsArray];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AKLog(@"1111111111");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)allDateBeginStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSMutableArray *allDates = [NSMutableArray array];
    while ([startDate isEarlierThanOrEqualTo:endDate]) {
//        AKLog(@"%@",[startDate formattedDateWithFormat:@"yyyy-MM-dd"]);
        NSString *dateString = [startDate formattedDateWithFormat:@"MM-dd"];
        startDate = [startDate dateByAddingDays:1];
        [allDates addObject:dateString];
    }
    
    return allDates;
}

@end
