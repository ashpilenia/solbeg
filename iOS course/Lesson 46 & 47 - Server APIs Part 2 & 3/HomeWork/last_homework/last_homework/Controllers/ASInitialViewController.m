//
//  ASInitialViewController.m
//  last_homework
//
//  Created by Alex on 5/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASInitialViewController.h"
#import "ASLoginController.h"
#import "ASSessionManager.h"
#import "ASAlbumsController.h"
#import "ASVideosController.h"

@interface ASInitialViewController ()

@property (nonatomic, assign) BOOL isFirstAppearance;

@end

@implementation ASInitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isFirstAppearance = NO;
    
    self.navigationItem.title = @"MAIN MENU";
    
    self.photosView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.videosView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.photosView.layer.borderWidth = 2.f;
    self.videosView.layer.borderWidth = 2.f;
    
    UITapGestureRecognizer *photosTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(photosAction:)];
    
    UITapGestureRecognizer *videoTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(videosAction:)];
    
    [self.photosView addGestureRecognizer:photosTap];
    [self.videosView addGestureRecognizer:videoTap];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (!self.isFirstAppearance) {
        
        self.isFirstAppearance = YES;
        
        self.photosView.hidden = YES;
        self.videosView.hidden = YES;
        
        [self login];
    } else {
        self.photosView.hidden = NO;
        self.videosView.hidden = NO;
        
    }
    
}

#pragma mark - API

- (void)login {
    
    [[ASSessionManager sharedManager] authorizeUser];
    
}

#pragma mark - Actions

- (void)photosAction:(UITapGestureRecognizer *)sender {
    
    ASAlbumsController *vc = [[ASAlbumsController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)videosAction:(UITapGestureRecognizer *)sender {
    
    ASVideosController *vc = [[ASVideosController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
