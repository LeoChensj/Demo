//
//  WebViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/6/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    [super setupNavigationBar];
    
    self.headView = [[HeadView alloc] init];
    if(!_webTitle)
    {
        self.headView.title = @"Xbed";
    }
    else
    {
        self.headView.title = _webTitle;
    }
    self.headView.imgLeft = @"ic_back";
    [self.view addSubview:self.headView];
    
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
}

- (void)setupView
{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64)];
    _webView.backgroundColor = Background_Color;
    _webView.userInteractionEnabled = YES;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 1.5;
    //CGRect navigationBarBounds = self.headView.bounds;
    CGRect barFrame = CGRectMake(0, 64-1.5, MAIN_SCREEN_WIDTH, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.headView addSubview:_progressView];
    
    NSURL *url = [NSURL URLWithString:_url];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}



#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    NSLog(@"progress=%f", progress);
    [_progressView setProgress:progress animated:YES];
    
    if(!_webTitle)
    {
        self.headView.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
}




- (void)dealloc
{
    _webView.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.webTitle = nil;
    self.url = nil;
}

@end
