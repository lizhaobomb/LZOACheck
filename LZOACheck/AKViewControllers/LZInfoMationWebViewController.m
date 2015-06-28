//
//  LZInfoMationWebViewController.m
//  
//
//  Created by lizhao on 15/6/28.
//
//

#import "LZInfoMationWebViewController.h"

@interface LZInfoMationWebViewController () {
    UIWebView *_web;
}
@end

@implementation LZInfoMationWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initContentView {
    _web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 44)];
    [self.view addSubview:_web];
    _newsUrl = [_newsUrl stringByReplacingOccurrencesOfString:@"/list/" withString:@"/detail/"];
    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_newsUrl]]];
}

@end
