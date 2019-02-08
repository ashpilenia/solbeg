//
//  ViewController.m
//  WebViewTest
//
//  Created by Alex on 2/7/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController () <WKUIDelegate, WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@property (nonatomic, weak) WKWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:frame configuration:configuration];
    
    [self.view addSubview:webView];
    [self.view bringSubviewToFront:self.activityView];
    [self.view bringSubviewToFront:self.toolBar];
    
    // способ 1: грузим по внешнему URL
//    NSURL *url = [NSURL URLWithString:@"http://www.fapl.ru"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [webView loadRequest:request];
    
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    
    self.webView = webView;
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"01" ofType:@"pdf"];
//    NSURL *baseUrl = [NSURL fileURLWithPath:filePath];
    
    // способ 2: грузим через NSData
//    NSData *data = [NSData dataWithContentsOfFile:filePath];
//    NSURL *baseUrl = [NSURL fileURLWithPath:filePath];
//    [self.webView loadData:data MIMEType:@"application/pdf" characterEncodingName:@"UTF-8" baseURL:baseUrl];
    
    // способ 3: грузим через внутренний URL
//    NSURLRequest *request = [NSURLRequest requestWithURL:baseUrl];
//    [self.webView loadRequest:request];
    
    // способ 4: грузим через HTML строку
    NSString *htmlString = @"<html>"
                                "<body>"
                                    "<p style=\"font-size: 500%; text-align: center;\">Hello World!</p>"
                                    "<a href=\"https://vk.com/iosdevcourse\">iOS Dev Course</a>"
                                "</body>"
                            "</html>";
    [self.webView loadHTMLString:htmlString baseURL:nil];
    
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSLog(@"decidePolicyForNavigationAction");
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
    [self.activityView startAnimating];
    NSLog(@"didStartProvisionalNavigation");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
    [self.activityView stopAnimating];
    if (!self.webView.canGoBack) {
        self.backButton.tintColor = [UIColor grayColor];
        self.backButton.enabled = NO;
    } else {
        self.backButton.tintColor = [UIColor blueColor];
        self.backButton.enabled = YES;
    }
    
    if (!self.webView.canGoForward) {
        self.forwardButton.tintColor = [UIColor grayColor];
        self.forwardButton.enabled = NO;
    } else {
        self.forwardButton.tintColor = [UIColor blueColor];
        self.forwardButton.enabled = YES;
    }
    NSLog(@"didFinishNavigation");
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
    [self.activityView stopAnimating];
    NSLog(@"didFailNavigation");
}

#pragma mark - Actions

- (IBAction)backAction:(UIBarButtonItem *)sender {
    
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }
    
    if (!self.forwardButton.enabled) {
        self.forwardButton.enabled = YES;
        self.forwardButton.tintColor = [UIColor blueColor];
    }
}

- (IBAction)forwardAction:(UIBarButtonItem *)sender {
    if (self.webView.canGoForward) {
        [self.webView goForward];
    }
    
    if (!self.backButton.enabled) {
        self.backButton.enabled = YES;
        self.backButton.tintColor = [UIColor blueColor];
    }
}

- (IBAction)refreshAction:(UIBarButtonItem *)sender {
    [self.webView reload];
}
@end
