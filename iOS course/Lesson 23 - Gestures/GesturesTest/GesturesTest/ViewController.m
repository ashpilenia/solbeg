//
//  ViewController.m
//  GesturesTest
//
//  Created by Alex on 11/5/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIView *testView;

@property (assign, nonatomic) CGFloat testViewScale;
@property (assign, nonatomic) CGFloat testViewRotation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(CGRectGetMidX(self.view.bounds) - 50,
                                                             CGRectGetMidY(self.view.bounds) - 50,
                                                             100.f,
                                                             100.f)];
    
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin
                           | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    self.testView = view;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleTap:)];
    
    [self.view addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleDoubleTap:)];
    
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    [tapGesture requireGestureRecognizerToFail:doubleTap];
    
    UITapGestureRecognizer *doubleTouch = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(handleDoubleTouch:)];
    
    doubleTouch.numberOfTapsRequired = 2;
    doubleTouch.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:doubleTouch];
    
    [tapGesture requireGestureRecognizerToFail:doubleTouch];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handlePinch:)];
    [self.view addGestureRecognizer:pinchGesture];
    
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                                action:@selector(handleRotation:)];
    
    [self.view addGestureRecognizer:rotationGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handlePan:)];
    
    [self.view addGestureRecognizer:panGesture];
    
    UISwipeGestureRecognizer *horizontalSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleHorizontalSwipe:)];
    
    horizontalSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:horizontalSwipeGesture];
    
    UISwipeGestureRecognizer *verticalSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                                 action:@selector(handleVerticalSwipe:)];
    
    verticalSwipeGesture.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:verticalSwipeGesture];
    
    
    
    rotationGesture.delegate = self;
    pinchGesture.delegate = self;
    panGesture.delegate = self;
    verticalSwipeGesture.delegate = self;
    horizontalSwipeGesture.delegate = self;
}

#pragma mark - Private Methods

- (UIColor *)randomColor
{
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
    
}

#pragma mark - Gestures

- (void)handleTap:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"Tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    self.testView.backgroundColor = [self randomColor];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"Double Tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    CGAffineTransform currentTransform = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, 1.2f, 1.2f);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.testView.transform = newTransform;
    }];
    
    //self.testViewScale = 1.2f;
}

- (void)handleDoubleTouch:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"Double Touch: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    CGAffineTransform currentTransform = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, 0.8f, 0.8f);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.testView.transform = newTransform;
    }];
    
    //self.testViewScale = 0.8f;
}

- (void)handlePinch:(UIPinchGestureRecognizer *)pinchGesture
{
    NSLog(@"Pinch: %1.3f", pinchGesture.scale);
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan)
    {
        self.testViewScale = 1.f;
    }
    
    CGFloat newScale = 1.f + pinchGesture.scale - self.testViewScale;
    
    CGAffineTransform currentTransform = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    
    self.testView.transform = newTransform;
    
    self.testViewScale = pinchGesture.scale;
}

- (void)handleRotation:(UIRotationGestureRecognizer *)rotationGesture
{
    NSLog(@"Roatation: %1.3f", rotationGesture.rotation);
    
    if (rotationGesture.state == UIGestureRecognizerStateBegan)
    {
        self.testViewRotation = 0;
    }
    
    CGFloat newRotation = rotationGesture.rotation - self.testViewRotation;
    
    CGAffineTransform currentTransform = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, newRotation);
    
    self.testView.transform = newTransform;
    self.testViewRotation = rotationGesture.rotation;
}

- (void)handlePan:(UIPanGestureRecognizer *)panGesture
{
    NSLog(@"Pan");
    self.testView.center = [panGesture locationInView:self.view];
}

- (void)handleHorizontalSwipe:(UISwipeGestureRecognizer *)horizontalSwipe
{
    NSLog(@"Horizontal swipe");
}

- (void)handleVerticalSwipe:(UISwipeGestureRecognizer *)verticalSwipe
{
    NSLog(@"Vertical swipe");
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]];
}


@end
