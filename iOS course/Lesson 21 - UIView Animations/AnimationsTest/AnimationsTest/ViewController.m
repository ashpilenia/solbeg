//
//  ViewController.m
//  AnimationsTest
//
//  Created by Alex on 10/13/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) UIView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 100, 100)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    self.testView = view;
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /*
    [UIView animateWithDuration:5
                     animations:^{
                         self.testView.center = CGPointMake(CGRectGetWidth(self.view.bounds) - (CGRectGetWidth(self.testView.bounds) /2), 250);
                     }];
     */
    [UIView animateWithDuration:5
                          delay:1
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.testView.center = CGPointMake(CGRectGetWidth(self.view.bounds) - (CGRectGetWidth(self.testView.bounds) /2), 250);
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"animation finished %d", finished);
                     }];
    
}

@end
