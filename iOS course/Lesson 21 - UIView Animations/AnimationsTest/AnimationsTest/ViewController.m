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

- (UIColor *) randomColor
{
    
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;
    UIColor *rColor = [UIColor colorWithRed:r green:g blue:b alpha:1.f];
    
    return rColor;
}

- (void) moveView:(UIView *) view
{
    
    CGRect rect = self.view.bounds;
    rect = CGRectInset(rect, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    
    CGFloat x = arc4random() % (int)CGRectGetWidth(rect) + CGRectGetMinX(rect);
    CGFloat y = arc4random() % (int)CGRectGetHeight(rect) + CGRectGetMinY(rect);
    
    CGFloat s = (float)(arc4random() % 151) / 100.f + 0.5;
    
    CGFloat rot = (double)(arc4random() % (int)(M_PI * 2 * 10000)) / 10000 - M_PI;
    
    CGFloat d = (float)(arc4random() % 20001) / 10000 + 2;
    
    
    [UIView animateWithDuration:d
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut /* | UIViewAnimationOptionRepeat |UIViewAnimationOptionAutoreverse */
                     animations:^{
                         
                         view.center = CGPointMake(x, y);
                         view.backgroundColor = [self randomColor];
                         
//                         view.transform = CGAffineTransformMakeRotation(M_PI);
//                         view.transform = CGAffineTransformMakeScale(2.f, 0.5);
                         
                         CGAffineTransform scale = CGAffineTransformMakeScale(s, s);
                         CGAffineTransform rotation = CGAffineTransformMakeRotation(rot);

                         CGAffineTransform transform = CGAffineTransformConcat(scale, rotation);
                         
                         view.transform = transform;
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"animation finished %d", finished);
                         NSLog(@"\nview frame = %@\nview bounds = %@", NSStringFromCGRect(view.frame) , NSStringFromCGRect(view.bounds));
                         
                         __weak UIView *weakView = view;
                         [self moveView:weakView];
                         
                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];ee
    
    [self moveView:self.testView];
    
    /*
    [UIView animateWithDuration:5
                     animations:^{
                         self.testView.center = CGPointMake(CGRectGetWidth(self.view.bounds) - (CGRectGetWidth(self.testView.bounds) /2), 250);
                     }];
     */

    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        //[self.testView.layer removeAllAnimations];
//        
//        [UIView animateWithDuration:4
//                              delay:0
//                            options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState //UIViewAnimationOptionRepeat |UIViewAnimationOptionAutoreverse
//                         animations:^{
//                             
//                             self.testView.center = CGPointMake(500,500);
//                         }
//                         completion:^(BOOL finished) {
//                             NSLog(@"animation finished %d", finished);
//                         }];
//        
//    });
    
}

@end
