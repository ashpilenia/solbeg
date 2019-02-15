//
//  ASWebViewController.m
//  WebView HomeWork
//
//  Created by Alex on 2/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASWebViewController.h"
#import <WebKit/WebKit.h>

@interface ASWebViewController ()

@property (weak, nonatomic) WKWebView *webView;

@end

@implementation ASWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 85.f)];
    
    [self.view addSubview:webView];
    
    self.webView = webView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.passedUrl];
    [self.webView loadRequest:request];
}



@end
