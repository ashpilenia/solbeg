//
//  ViewController.m
//  Drawings Home Work
//
//  Created by Alex on 11/9/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Orientation

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    self.starsContainerView.areSmallStarsNeeded = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(coordinator.transitionDuration / 2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.starsContainerView setNeedsDisplay];
    });
    
}


@end
