//
//  ASDrawningView.m
//  DrawningsTest
//
//  Created by Alex on 11/8/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ASDrawningView.h"

@interface ASDrawningView ()

@end

@implementation ASDrawningView

- (void)drawRect:(CGRect)rect {
    
    NSLog(@"drawRect: %@",NSStringFromCGRect(rect));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //spike for two different view setups;
    NSInteger index = 0;
    //
    if (index)
    {
        CGRect square1 = CGRectMake(100, 100, 100, 100);
        CGRect square2 = CGRectMake(200, 200, 100, 100);
        CGRect square3 = CGRectMake(300, 300, 100, 100);
        
        //CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
        CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
        
        CGContextAddRect(context, square1);
        CGContextAddRect(context, square2);
        CGContextAddRect(context, square3);
        
        //CGContextFillPath(context);
        CGContextStrokePath(context);
        
        CGContextSetFillColorWithColor(context, [[UIColor brownColor] CGColor]);
        
        CGContextAddEllipseInRect(context, CGRectMake(100, 100, 100, 100));
        CGContextAddEllipseInRect(context, CGRectMake(200, 200, 100, 100));
        CGContextAddEllipseInRect(context, CGRectMake(300, 300, 100, 100));
        
        CGContextFillPath(context);
        
        CGContextSetStrokeColorWithColor(context, [[UIColor blueColor] CGColor]);
        
        CGContextSetLineWidth(context, 1.5f);
        CGContextSetLineCap(context, kCGLineCapRound);
        
        CGContextMoveToPoint(context, CGRectGetMinX(square1), CGRectGetMaxY(square1));
        CGContextAddLineToPoint(context, CGRectGetMinX(square3), CGRectGetMaxY(square3));
        
        CGContextMoveToPoint(context, CGRectGetMaxX(square3), CGRectGetMinY(square3));
        CGContextAddLineToPoint(context, CGRectGetMaxX(square1), CGRectGetMinY(square1));
        
        CGContextStrokePath(context);
        
        CGContextSetStrokeColorWithColor(context, [[UIColor grayColor] CGColor]);
        
        CGContextMoveToPoint(context, CGRectGetMinX(square1), CGRectGetMaxY(square1));
        CGContextAddArc(context, CGRectGetMaxX(square1), CGRectGetMaxY(square1), CGRectGetWidth(square1), M_PI, M_PI_2, 1);
        
        CGContextMoveToPoint(context, CGRectGetMaxX(square3), CGRectGetMinY(square3));
        CGContextAddArc(context, CGRectGetMinX(square3), CGRectGetMinY(square3), CGRectGetWidth(square3), 0, -M_PI_2, 1);
        
        CGContextStrokePath(context);
        
        NSString *text = @"text";
        UIFont *font = [UIFont systemFontOfSize:25.f];
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = CGSizeMake(1.5f, 1.5f);
        shadow.shadowColor = [UIColor whiteColor];
        shadow.shadowBlurRadius = 0.5f;
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor grayColor], NSForegroundColorAttributeName,
                                    font,                NSFontAttributeName,
                                    shadow,              NSShadowAttributeName, nil];
        
        CGSize textSize = [text sizeWithAttributes:attributes];
        
        // этот способ более надежный и помогает избежать размытия (из-за того что рект не будет с дробными пиксилями после исчисления ректа по размеру текста из-за CGRectIntegral) по сравнениею с закоментированым кодом ниже.
        CGRect textRect = CGRectMake(CGRectGetMidX(square2) - textSize.width / 2,
                                     CGRectGetMidY(square2) - textSize.height / 2,
                                     textSize.width,
                                     textSize.height);
        
        textRect = CGRectIntegral(textRect);
        
        [text drawInRect:textRect withAttributes:attributes];
        
        //    [text drawAtPoint:CGPointMake(CGRectGetMidX(square2) - textSize.width / 2,
        //                                  CGRectGetMidY(square2) - textSize.height / 2) withAttributes:attributes];
    }
    else
    {
        CGFloat offset = 50.f;
        CGFloat borderWidth = 4.f;
        
        CGFloat delta = offset * 2 + borderWidth * 2;
        
        CGFloat maxBoardSize = MIN(CGRectGetWidth(rect) - delta, CGRectGetHeight(rect) - delta);
        
        int cellSize = (int)maxBoardSize / 8;
        int boardSize = cellSize * 8;
        
        CGRect boardRect = CGRectMake((CGRectGetWidth(rect) - boardSize) / 2,
                                      (CGRectGetHeight(rect) - boardSize) / 2,
                                      boardSize,
                                      boardSize);
        
        boardRect = CGRectIntegral(boardRect);
        
        // CGContextAddRect(context, boardRect);
        
        for (int i = 0; i < 8; i++)
        {
            for (int j = 0; j < 8; j++)
            {
                if (i % 2 != j % 2)
                {
                    CGRect cellRect = CGRectMake(CGRectGetMinX(boardRect) + i * cellSize,
                                                 CGRectGetMinY(boardRect) + j * cellSize,
                                                 cellSize,
                                                 cellSize);
                    
                    CGContextAddRect(context, cellRect);
                }
            }
        }
        
        
        CGContextSetFillColorWithColor(context, [[UIColor grayColor] CGColor]);
        
        CGContextFillPath(context);
        
        CGContextSetStrokeColorWithColor(context, [[UIColor grayColor] CGColor]);
        
        CGContextAddRect(context, boardRect);
        
        CGContextSetLineWidth(context, borderWidth);
        
        CGContextStrokePath(context);
        
    }
}

@end
