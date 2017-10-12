//
//  ViewController.m
//  ViewsTest
//
//  Created by Alex on 10/11/17.
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
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    view.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.75];
    [self.view addSubview:view];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(20, 80, 250, 80)];
    view2.backgroundColor = [[UIColor magentaColor] colorWithAlphaComponent:0.75];
    [self.view addSubview:view2];
    
    [self.view bringSubviewToFront:view];
    
    UIView *viewSub1 = [[UIView alloc] initWithFrame:CGRectMake(4, 4, 20, 20)];
    viewSub1.backgroundColor = [UIColor redColor];
    [view2 addSubview:viewSub1];
    
    view2.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    
    self.testView = view2;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSLog(@"\nframe = %@\nbounds = %@", NSStringFromCGRect(self.testView.frame), NSStringFromCGRect(self.testView.bounds));
    
    CGPoint origin = CGPointZero;
    [self.view convertPoint:origin fromView:self.view.window];
    NSLog(@"origin = %@", NSStringFromCGPoint(origin));
}

@end
