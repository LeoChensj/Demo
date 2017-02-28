//
//  WebViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/6/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface WebViewController : XbedViewController <NJKWebViewProgressDelegate, UIWebViewDelegate>
{
@private
    UIWebView *_webView;
    NJKWebViewProgress *_progressProxy;
    NJKWebViewProgressView *_progressView;
}

@property (nonatomic, strong)NSString *webTitle;
@property (nonatomic, strong)NSString *url;

@end
