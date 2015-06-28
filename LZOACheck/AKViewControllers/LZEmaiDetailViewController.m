//
//  LZEmaiDetailViewController.m
//  LZOACheck
//
//  Created by lizhao on 15/5/20.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZEmaiDetailViewController.h"

@interface LZEmaiDetailViewController ()<UIWebViewDelegate> {
    UIWebView *_contentWeb;
}

@end

@implementation LZEmaiDetailViewController

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
    _contentWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, ScreenHeight - 49)];
    _contentWeb.delegate = self;
    
    [_contentWeb loadHTMLString:self.mainBody baseURL:nil];
    [self.view addSubview:_contentWeb];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {

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
