//
//  ASWebViewController.h
//  WebView HomeWork
//
//  Created by Alex on 2/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSURL *passedUrl;

- (IBAction)backAction:(UIBarButtonItem *)sender;
- (IBAction)forwardAction:(UIBarButtonItem *)sender;
- (IBAction)refreshAction:(UIBarButtonItem *)sender;

@end
