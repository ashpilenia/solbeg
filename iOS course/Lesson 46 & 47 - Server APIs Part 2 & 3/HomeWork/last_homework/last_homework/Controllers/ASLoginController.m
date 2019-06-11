//
//  ASLoginController.m
//  last_homework
//
//  Created by Alex on 5/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASLoginController.h"
#import <WebKit/WebKit.h>
#import "ASSessionManager.h"

@interface ASLoginController () <WKNavigationDelegate>

@end

@implementation ASLoginController

- (instancetype)initWithCompletion:(loginCompletionBlock)completion {
    
    self = [super init];
    if (self) {
        self.completion = completion;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame
                                            configuration:config];
    webView.navigationDelegate = self;
    
    NSString *urlString = @"https://oauth.vk.com/authorize?"
    "client_id=6950956&"
    "display=page&"
    "redirect_uri=https://oauth.vk.com/blank.html&"
    "scope=270358&"
    "response_type=token&"
    "v=5.95";
    //"revoke=1";
    
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
    
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSLog(@"%@", navigationAction.request.URL);
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    NSLog(@"%@", navigationResponse.response.URL);
    
    if ([navigationResponse.response.URL.description containsString:@"blank.html#access_token"]) {
        
        NSString *urlString = navigationResponse.response.URL.description;
        if ([urlString rangeOfString:@"#"].location != NSNotFound) {
            urlString = [urlString stringByReplacingOccurrencesOfString:@"#" withString:@"&"];
        }
        
        NSMutableDictionary *queryParamsDictionary = [[NSMutableDictionary alloc] init];
        NSArray *urlComponents = [urlString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents firstObject];
            NSString *value = [pairComponents lastObject];
            
            [queryParamsDictionary setObject:value forKey:key];
        }
        
        NSTimeInterval expirationInterval = [[queryParamsDictionary objectForKey:@"expires_in"] doubleValue];
        
        ASToken *token = [[ASToken alloc] init];
        
        token.token = [queryParamsDictionary valueForKey:@"access_token"];
        token.userId = [queryParamsDictionary valueForKey:@"user_id"];
        token.expirationDate = [NSDate dateWithTimeIntervalSinceNow:expirationInterval];
        
        decisionHandler(WKNavigationResponsePolicyCancel);
        
        if (self.completion) {
            self.completion(token);
        } else {
            NSLog(@"Error on Receiving Token");
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        decisionHandler(WKNavigationResponsePolicyAllow);
        NSLog(@"Error on Receiving Token");
    }
    
    
}

@end
