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
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self createChessBoard];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self createChessCells];
}

#pragma mark - prepare UI

- (void)createChessBoard {
    
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

- (void)createChessCells {

    CGFloat borderSize = (double)self.boardView.bounds.size.height / 8;
    for (int i = 0; i < 64; i++)
    {
        int rowNumber = [self rowDetector:i];
        int columnNumber = [self columntDetector:i];
        
        CGPoint cellOrigin = CGPointMake(columnNumber * borderSize, rowNumber * borderSize);
        
        UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(cellOrigin.x, cellOrigin.y, borderSize, borderSize)];
        cellView.backgroundColor = [self colorDetector:rowNumber andColumnNumber:columnNumber];
        [self.boardView addSubview:cellView];
    }
    
}

#pragma mark - Private Methods

- (UIColor *)colorDetector:(int)rowNumber andColumnNumber:(int)columnNumber {
    
    UIColor *desiredColor;
    
    BOOL startingBlack = rowNumber % 2;
    
    if (startingBlack)
    {
        BOOL isWhite = columnNumber % 2;
        desiredColor = isWhite ? [UIColor whiteColor] : [UIColor blackColor];
    }
    else
    {
        BOOL isBlack = columnNumber % 2;
        desiredColor = isBlack ? [UIColor blackColor] : [UIColor whiteColor];
    }
    
    return desiredColor;
}

- (int)rowDetector:(int)cellNumber {
    
    int retVal = 0;
    if (cellNumber < 8)
    {
        retVal = 0;
    }
    else if (cellNumber > 7 && cellNumber < 16)
    {
        retVal = 1;
    }
    else if (cellNumber > 15 && cellNumber < 24)
    {
        retVal = 2;
    }
    else if (cellNumber > 23 && cellNumber < 32)
    {
        retVal = 3;
    }
    else if (cellNumber > 31 && cellNumber < 40)
    {
        retVal = 4;
    }
    else if (cellNumber > 39 && cellNumber < 48)
    {
        retVal = 5;
    }
    else if (cellNumber > 47 && cellNumber < 56)
    {
        retVal = 6;
    }
    else if (cellNumber > 55 && cellNumber < 64)
    {
        retVal = 7;
    }
    
    return retVal;
}

- (int)columntDetector:(int)cellNumber {
    
    int index = cellNumber % 8;
    int retVal = 0;
    switch (index) {
        case 0:
            retVal = 0;
            break;
        case 1:
            retVal = 1;
            break;
        case 2:
            retVal = 2;
            break;
        case 3:
            retVal = 3;
            break;
        case 4:
            retVal = 4;
            break;
        case 5:
            retVal = 5;
            break;
        case 6:
            retVal = 6;
            break;
        case 7:
            retVal = 7;
            break;
    }
    
    return retVal;
}

@end
