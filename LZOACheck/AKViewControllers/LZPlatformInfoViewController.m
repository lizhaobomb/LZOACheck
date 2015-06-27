//
//  LZPlatformInfoViewController.m
//  LZOACheck
//
//  Created by lizhao on 15/5/26.
//  Copyright (c) 2015年 lizhao. All rights reserved.
//

#import "LZPlatformInfoViewController.h"

@interface LZPlatformInfoViewController ()<UIWebViewDelegate>

@end

@implementation LZPlatformInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initContentView];
}

- (void)initContentView {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-44-49)];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://111.206.163.56:8686/oa/portal/news/detail/293/1"]]];
    [self.view addSubview:webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    AKLog(@"Finished!!");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    AKLog(@"Failed:\n\n%@\n\n",error);
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
