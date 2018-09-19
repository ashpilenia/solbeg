//
//  ViewController.m
//  ChessLike
//
//  Created by Alex on 9/20/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView *boardView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //creating the board
    UIView *boardView = [[UIView alloc] init];
    boardView.backgroundColor = [UIColor lightGrayColor];
    
    self.boardView = boardView;
    self.boardView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.boardView];
 
    NSLayoutConstraint *centreHorizontallyConstraint = [NSLayoutConstraint
                                                        constraintWithItem:self.boardView
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                        toItem:self.view
                                                        attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0
                                                        constant:0];
    
    NSLayoutConstraint *centreVerticallyConstraint = [NSLayoutConstraint
                                                        constraintWithItem:self.boardView
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                        toItem:self.view
                                                        attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0
                                                        constant:0];
    
    /* Fixed width */
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.boardView
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.0
                                                                        constant:self.view.bounds.size.width - 75];
    /* Fixed Height */
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.boardView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0
                                                                         constant:self.view.bounds.size.width - 75];
    
    [self.view addConstraints:@[centreHorizontallyConstraint,
                                centreVerticallyConstraint,
                                widthConstraint,
                                heightConstraint]];
    
}

@end
