//
//  ASViewController.m
//  ViewControllersTest
//
//  Created by Oleksii Skutarenko on 06.11.13.
//  Copyright (c) 2013 Alex Skutarenko. All rights reserved.
//

#import "ASViewController.h"

@interface ASViewController ()

@end

@implementation ASViewController

#pragma mark - Loading

- (void) loadView {
    
    [super loadView];
    
    NSLog(@"loadView");
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSLog(@"viewDidLoad");
    
    self.view.backgroundColor = [UIColor redColor];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        NSLog(@"iPad");
    } else {
        NSLog(@"iPhone");
    }
}


#pragma mark - Views

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
 
    [super viewDidAppear:animated];
    
    NSLog(@"viewDidAppear");
    
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    NSLog(@"viewWillLayoutSubviews");
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    NSLog(@"viewDidLayoutSubviews");
}

#pragma mark - Orientation

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortraitUpsideDown | UIInterfaceOrientationMaskPortrait;
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    NSLog(@"willRotateToInterfaceOrientation from %d to %d", self.interfaceOrientation, toInterfaceOrientation);
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    NSLog(@"didRotateFromInterfaceOrientation from %d to %d", fromInterfaceOrientation, self.interfaceOrientation);
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
