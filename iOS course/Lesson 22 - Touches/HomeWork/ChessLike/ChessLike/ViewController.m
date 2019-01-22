//
//  ViewController.m
//  ChessLike
//
//  Created by Alex on 9/20/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

#import "ASChessView.h"

@interface ViewController ()

@property (weak, nonatomic) UIView *boardView;
@property (weak, nonatomic) UIView *draggingView;

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
    [self createCheckers];
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
        
        ASChessView *cellView = [[ASChessView alloc] initWithFrame:CGRectMake(cellOrigin.x, cellOrigin.y, borderSize, borderSize)];
        cellView.backgroundColor = [self colorDetector:rowNumber andColumnNumber:columnNumber];
        cellView.isBlack = [cellView.backgroundColor isEqual:[UIColor blackColor]] ? YES : NO;
        cellView.row = rowNumber;
        cellView.column = columnNumber;
        
        [self.boardView addSubview:cellView];
    }
    
}

- (void)createCheckers {

    for (ASChessView *chessView in self.boardView.subviews)
    {
        CGFloat delta = (0.2f * chessView.bounds.size.width ) / 2;
        if ((chessView.row == 7 || chessView.row == 6 || chessView.row == 5) && chessView.isBlack)
        {
            CGRect checkerRect = CGRectMake(chessView.frame.origin.x + delta, chessView.frame.origin.y + delta, 0.8 * chessView.frame.size.width, 0.8 * chessView.frame.size.height);
            UIView *roundView = [[UIView alloc] initWithFrame:checkerRect];
            roundView.layer.cornerRadius = 47.5f;
            roundView.backgroundColor = [UIColor redColor];
            
            chessView.isOccupied = YES;
            
            [self.boardView addSubview:roundView];
        }
        if (((chessView.row == 0 || chessView.row == 1 || chessView.row == 2) && chessView.isBlack))
        {
            CGRect checkerRect = CGRectMake(chessView.frame.origin.x + delta, chessView.frame.origin.y + delta, 0.8 * chessView.frame.size.width, 0.8 * chessView.frame.size.height);
            UIView *roundView = [[UIView alloc] initWithFrame:checkerRect];
            roundView.layer.cornerRadius = 47.5f;
            roundView.backgroundColor = [UIColor greenColor];
            
            chessView.isOccupied = YES;
            
            [self.boardView addSubview:roundView];
        }
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

- (ASChessView *)calculateClosestAvailableView:(CGPoint)point inView:(ASChessView *)parentView {
    
    ASChessView *retVal;
    CGFloat compareToDistance = 0.f;
    
    for (UIView *view in self.boardView.subviews)
    {
        if ([view isKindOfClass:[ASChessView class]])
        {
            CGFloat distance = hypotf(point.x - view.center.x, point.y - view.center.y);
            
            if ([self isCurrentViewValid:(ASChessView *)view])
            {
                if (compareToDistance)
                {
                    if (distance < compareToDistance)
                    {
                        retVal = (ASChessView *)view;
                        compareToDistance = distance;
                    }
                }
                else
                {
                    retVal = (ASChessView *)view;
                    compareToDistance = distance;
                }
            }
        }
    }
    
    return retVal;
}

- (ASChessView *)getCellViewForTouchPoint:(CGPoint)point {
    
    __block ASChessView *retVal;
    
    [self.boardView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (CGRectContainsPoint(obj.frame, point))
        {
            if ([obj isKindOfClass:[ASChessView class]])
            {
                retVal = obj;
                *stop = YES;
            }
        }
    }];
    
    return retVal;
}

- (BOOL)isCurrentViewValid:(ASChessView *)view {
    
    BOOL isValid = NO;
    if (view.isOccupied == NO && view.isBlack == YES)
    {
        isValid = YES;
    }
    
    return isValid;
}

- (void)moveToView:(ASChessView *)destinationView {
    
    destinationView.isOccupied = YES;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.draggingView.transform = CGAffineTransformIdentity;
        self.draggingView.alpha = 1.f;
    }];
    
    self.draggingView.center = destinationView.center;
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.boardView];
    UIView *view = [self.boardView hitTest:point withEvent:event];
    
    if (![view isKindOfClass:[ASChessView class]])
    {
        self.draggingView = view;
        [self.boardView bringSubviewToFront:self.draggingView];
        
        ASChessView *currentCell = [self getCellViewForTouchPoint:point];
        currentCell.isOccupied = NO;
        
        [UIView animateWithDuration:0.3f animations:^{
            
            self.draggingView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
            self.draggingView.alpha = 0.6;
        }];
    }
    else
    {
        self.draggingView = nil;
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.draggingView)
    {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.boardView];
        
        self.draggingView.center = point;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.draggingView)
    {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.boardView];
        
        ASChessView *destinationView = [self getCellViewForTouchPoint:point];
        BOOL isCurrentViewValid = [self isCurrentViewValid:destinationView];
        
        if (isCurrentViewValid)
        {
            [self moveToView:destinationView];
        }
        else
        {
            ASChessView *vacantView = [self calculateClosestAvailableView:point inView:destinationView];
            [self moveToView:vacantView];
        }
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self touchesEnded];
}

- (void)touchesEnded {
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.draggingView.transform = CGAffineTransformIdentity;
        self.draggingView.alpha = 1.f;
    }];
    
    self.draggingView = nil;
}



@end
