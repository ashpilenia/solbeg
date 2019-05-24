//
//  ASVIdeoPlayerController.m
//  last_homework
//
//  Created by Alex on 5/24/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASVIdeoPlayerController.h"
#import  <WebKit/WebKit.h>
#import "ASVideo.h"

@interface ASVIdeoPlayerController () <WKNavigationDelegate>

@property (nonatomic, strong) ASVideo *video;

@end

@implementation ASVIdeoPlayerController

- (instancetype)initWithVideo:(ASVideo *)video {
    
    self = [super init];
    if (self) {
        self.video = video;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame
                                            configuration:config];
    webView.navigationDelegate = self;
    
    [self.view addSubview:webView];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.video.player];
    [webView loadRequest:request];
}



@end
