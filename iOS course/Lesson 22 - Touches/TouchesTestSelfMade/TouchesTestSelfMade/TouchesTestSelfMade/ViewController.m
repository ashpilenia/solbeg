//
//  ViewController.m
//  TouchesTestSelfMade
//
//  Created by Alex on 9/19/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView *draggingView;
@property (assign, nonatomic) CGPoint touchOffSet;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 0; i < 8; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 + 100*i, 100, 100, 100)];
        view.backgroundColor = [self randomColor];
        [self.view addSubview:view];
    }

    //self.view.multipleTouchEnabled = YES;
}

#pragma mark - Private methods

- (void)logTouches:(NSSet *)touches withMethod:(NSString *)methodName {
    
    NSMutableString *string = [NSMutableString stringWithString:methodName];
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        [string appendFormat:@" %@",NSStringFromCGPoint(point)];
    }
    
    NSLog(@"%@", string);
}

- (UIColor *)randomColor {
    
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;
    
    UIColor *randomColor = [UIColor colorWithRed:r green:g blue:b alpha:1.f];
    
    return randomColor;
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesBegan"];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    UIView *view = [self.view hitTest:point withEvent:event];
    
    if (![view isEqual:self.view])
    {
        self.draggingView = view;
        [self.view bringSubviewToFront:self.draggingView];
        
        CGPoint touchPoint =  [touch locationInView:self.draggingView];
        
        self.touchOffSet = CGPointMake(CGRectGetMidX(self.draggingView.bounds) - touchPoint.x,
                                       CGRectGetMidY(self.draggingView.bounds) - touchPoint.y);
        
        //[self.draggingView.layer removeAllAnimations];
        [UIView animateWithDuration:0.3 animations:^{
            
            self.draggingView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
            self.draggingView.alpha = 0.3f;
        }];
    }
    else
    {
        self.draggingView = nil;
    }
 
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesEnded"];
    
    [self touchEnded];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesMoved"];
    
    if (self.draggingView)
    {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        
        CGPoint correction = CGPointMake(point.x + self.touchOffSet.x,
                                         point.y + self.touchOffSet.y);
        
        self.draggingView.center = correction;
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesCancelled"];
    [self touchEnded];
}

- (void)touchEnded {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.draggingView.transform = CGAffineTransformIdentity;
        self.draggingView.alpha = 1.f;
    }];
    self.draggingView = nil;
}

@end
