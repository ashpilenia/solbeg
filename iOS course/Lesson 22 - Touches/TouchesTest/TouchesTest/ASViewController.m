//
//  ASViewController.m
//  TouchesTest
//
//  Created by Oleksii Skutarenko on 25.11.13.
//  Copyright (c) 2013 Alex Skutarenko. All rights reserved.
//

#import "ASViewController.h"

@interface ASViewController ()

@property (weak, nonatomic) UIView* draggingView;

@property (assign, nonatomic) CGPoint touchOffset;

@end

@implementation ASViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    for (int i = 0; i < 8; i++) {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(10 + 110*i, 100, 100, 100)];
        view.backgroundColor = [self randomColor];
        
        [self.view addSubview:view];
    }
    
    
 
    //self.view.multipleTouchEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    CGRect rect1 = CGRectMake(100, 100, 100, 100);
    
    UILabel *label = [[UILabel alloc] initWithFrame:rect1];
    UIColor *color = [UIColor blackColor];
    label.backgroundColor = color;
    label.text = @"asd";
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(actionCopy:)];
    
    [self.view addGestureRecognizer:longPress];
    
}

- (void) actionCopy:(UILongPressGestureRecognizer *) gestureRec
{
    if ([gestureRec.view isKindOfClass:[UILabel class]])
    {
    UILabel *label = (UILabel *)gestureRec.view;
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = label.text;
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:label2.text];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void) logTouches:(NSSet*)touches withMethod:(NSString*) methodName {
    
    NSMutableString* string = [NSMutableString stringWithString:methodName];
    
    for (UITouch* touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        [string appendFormat:@" %@", NSStringFromCGPoint(point)];
    }
    
    NSLog(@"%@", string);
}

- (UIColor*) randomColor {
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}


#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesBegan"];
    
    UITouch* touch = [touches anyObject];
    
    CGPoint pointOnMainView = [touch locationInView:self.view];
    
    UIView* view = [self.view hitTest:pointOnMainView withEvent:event];
    
    if (![view isEqual:self.view]) {
        
        self.draggingView = view;
        
        [self.view bringSubviewToFront:self.draggingView];
        
        CGPoint touchPoint = [touch locationInView:self.draggingView];
        
        self.touchOffset = CGPointMake(CGRectGetMidX(self.draggingView.bounds) - touchPoint.x,
                                       CGRectGetMidY(self.draggingView.bounds) - touchPoint.y);
        
        //[self.draggingView.layer removeAllAnimations];
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.draggingView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
                             self.draggingView.alpha = 0.3f;
                         }];
        
    } else {
        
        self.draggingView = nil;
        
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesMoved"];
    
    if (self.draggingView) {
        
        UITouch* touch = [touches anyObject];
        
        CGPoint pointOnMainView = [touch locationInView:self.view];
        
        CGPoint correction = CGPointMake(pointOnMainView.x + self.touchOffset.x,
                                         pointOnMainView.y + self.touchOffset.y);

        self.draggingView.center = correction;
    }
    
}

- (void) onTouchesEnded {
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.draggingView.transform = CGAffineTransformIdentity;
                         self.draggingView.alpha = 1.f;
                     }];
    
    self.draggingView = nil;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesEnded"];
    
    [self onTouchesEnded];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesCancelled"];
    
    [self onTouchesEnded];
}

@end
