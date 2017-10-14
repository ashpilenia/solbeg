//
//  ViewController.m
//  OutletsTest
//
//  Created by Alex on 10/13/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat) randomFromNoneToOne
{
    CGFloat random = (float)(arc4random() % 256) / 255;
    return random;
}

- (UIColor *) randomColor
{
    
    CGFloat r = [self randomFromNoneToOne];
    CGFloat g = [self randomFromNoneToOne];
    CGFloat b = [self randomFromNoneToOne];
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    for (UIView *obj in self.collectionOne)
    {
        obj.backgroundColor = [self randomColor];
    }
}

@end
