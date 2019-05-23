//
//  ASUserLoginController.m
//  APITest
//
//  Created by Alex on 5/22/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASUserLoginController.h"
#import "ASAccessToken.h"
#import <WebKit/WebKit.h>

@interface ASUserLoginController () <WKNavigationDelegate>

@property (nonatomic, copy) loginCompletionBlock loginCompletion;

@end

@implementation ASUserLoginController

- (instancetype)initWithCompletionBlock:(loginCompletionBlock)completion {
    
    self = [super init];
    if (self) {
        self.loginCompletion = completion;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Login";
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    
    NSString *urlString =
    @"https://oauth.vk.com/authorize?"
    "client_id=6950956&"
    "redirect_uri=https://oauth.vk.com/blank.html&"
    "scope=139286&"
    "response_type=token&"
    "v=5.95";
    //"revoke=1";
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemCancel)
                                                                               target:self
                                                                               action:@selector(cancelAction:)];
    
    [self.navigationItem setRightBarButtonItem:barButton];
    
    [webView loadRequest:request];
    
}

#pragma mark - Actions

- (void)cancelAction:(UIBarButtonItem *)sender {
    
    if (self.loginCompletion) {
        self.loginCompletion(nil);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    NSLog(@"%@", response);
    
    if ([[[response URL] fragment] containsString:@"access_token"]) {
        
        ASAccessToken *accessToken = [[ASAccessToken alloc] init];
        
        NSString *query = response.URL.absoluteString;
        NSArray *array = [query componentsSeparatedByString:@"#"];
        
        if (array.count > 1) {
            query = [array lastObject];
        }
        
        NSArray *pairs = [query componentsSeparatedByString:@"&"];
        for (NSString *pair in pairs) {
            
            NSArray *values = [pair componentsSeparatedByString:@"="];
            
            if (values.count == 2) {
                NSString *key = [values firstObject];
                
                if ([key isEqualToString:@"access_token"]) {
                    
                    accessToken.token = values.lastObject;
                    
                } else if ([key isEqualToString:@"expires_in"]) {
                    
                    NSTimeInterval interval = [values.lastObject doubleValue];
                    accessToken.expirationDate = [NSDate dateWithTimeIntervalSinceNow:interval];
                    
                } else if ([key isEqualToString:@"user_id"]) {
                    
                    accessToken.userID = [NSNumber numberWithInteger:[values.lastObject integerValue]];
                }
            }
        }
        
        decisionHandler(WKNavigationResponsePolicyCancel);
        
        if (self.loginCompletion) {
            self.loginCompletion(accessToken);
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
}

@end

