//
//  ASWebViewController.m
//  WebView HomeWork
//
//  Created by Alex on 2/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASWebViewController.h"
#import <WebKit/WebKit.h>

@interface ASWebViewController () <WKNavigationDelegate>

@property (weak, nonatomic) WKWebView *webView;

@end

@implementation ASWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 85.f)];
    
    [self.view addSubview:webView];
    
    self.webView = webView;
    
    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;
    
    self.webView.navigationDelegate = self;
    
    [self.view bringSubviewToFront:self.activityIndicator];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.passedUrl];
    [self.webView loadRequest:request];
}

#pragma mark - Actions

- (IBAction)backAction:(UIBarButtonItem *)sender {
    
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }
}

- (IBAction)forwardAction:(UIBarButtonItem *)sender {
    
    if (self.webView.canGoForward) {
        [self.webView goForward];
    }
}

- (IBAction)refreshAction:(UIBarButtonItem *)sender {
    
    [self.webView reload];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
    [self.activityIndicator startAnimating];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
    self.backButton.enabled    = self.webView.canGoBack    ? YES : NO;
    self.forwardButton.enabled = self.webView.canGoForward ? YES : NO;
    
    [self.activityIndicator stopAnimating];
}
@end
