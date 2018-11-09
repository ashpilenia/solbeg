//
//  ASStarsView.m
//  Drawings Home Work
//
//  Created by Alex on 11/9/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ASStarsView.h"

@implementation ASStarsView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [[UIColor clearColor] CGColor]);
    
    CGFloat borderSize = 200;
    
    CGPoint l1 = CGPointMake(CGRectGetMidX(rect) - 1.5 * borderSize, CGRectGetMidY(rect) - 0.5 * borderSize);
    CGPoint l2 = CGPointMake(l1.x + borderSize, l1.y);
    CGPoint l3 = CGPointMake(l2.x + borderSize / 2, l2.y - sqrtf(3) / 2 * borderSize);
    CGPoint l4 = CGPointMake(l2.x + borderSize, l2.y);
    CGPoint l5 = CGPointMake(l4.x + borderSize, l4.y);
    CGPoint l6 = CGPointMake(l5.x - borderSize * 5 / 7, l5.y + sqrtf(3) / 2 * borderSize);
    
    CGFloat maxVal = l6.y + borderSize;
    CGFloat minVal = l6.y + sqrtf(3) / 2 * borderSize;
    CGFloat delta = (maxVal - minVal) / 2;
    
    CGPoint l7 = CGPointMake(l6.x + borderSize / 3,
                             l6.y + borderSize - delta);
    CGPoint l8 = CGPointMake(l3.x, l6.y + borderSize / 3);
    CGPoint l10 = CGPointMake(l1.x + borderSize * 5 / 7, l6.y);
    CGPoint l9 = CGPointMake(l10.x - borderSize / 3, l7.y);
    
    
    CGContextMoveToPoint(context, l1.x, l1.y);
    
    
    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
    
    CGContextAddLineToPoint(context, l2.x, l2.y);
    CGContextAddLineToPoint(context, l3.x, l3.y);
    CGContextAddLineToPoint(context, l4.x, l4.y);
    CGContextAddLineToPoint(context, l5.x, l5.y);
    CGContextAddLineToPoint(context, l6.x, l6.y);
    CGContextAddLineToPoint(context, l7.x, l7.y);
    CGContextAddLineToPoint(context, l8.x, l8.y);
    CGContextAddLineToPoint(context, l9.x, l9.y);
    CGContextAddLineToPoint(context, l10.x, l10.y);
    CGContextAddLineToPoint(context, l1.x, l1.y);
    
    CGContextFillPath(context);
    
    CGContextRef lineCotnext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(lineCotnext, [[UIColor purpleColor] CGColor]);
    CGContextSetLineWidth(lineCotnext, 4.f);
    
    CGContextMoveToPoint(lineCotnext, l1.x, l1.y);
    
    CGContextAddLineToPoint(lineCotnext, l3.x, l3.y);
    CGContextAddLineToPoint(lineCotnext, l5.x, l5.y);
    CGContextAddLineToPoint(lineCotnext, l7.x, l7.y);
    CGContextAddLineToPoint(lineCotnext, l9.x, l9.y);
    CGContextAddLineToPoint(lineCotnext, l1.x, l1.y);
    
    CGContextStrokePath(lineCotnext);
    
    
    CGContextRef contextForArcs = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(contextForArcs, [[UIColor magentaColor] CGColor]);
    
    CGContextAddArc(contextForArcs, l1.x, l1.y, 50.f, 0, 2*M_PI, YES);
    
    CGContextSetFillColorWithColor(contextForArcs, [[UIColor blueColor] CGColor]);
    
    
    CGContextMoveToPoint(contextForArcs, l3.x - 50.f, l3.y);
    CGContextAddArc(contextForArcs, l3.x, l3.y, 50.f, M_PI, 3*M_PI, NO);
    
    CGContextMoveToPoint(contextForArcs, l5.x - 50.f, l5.y);
    CGContextAddArc(contextForArcs, l5.x, l5.y, 50.f, M_PI, 3*M_PI, NO);
    
    CGContextMoveToPoint(contextForArcs, l7.x - 50.f, l7.y);
    CGContextAddArc(contextForArcs, l7.x, l7.y, 50.f, M_PI, 3*M_PI, NO);
    
    CGContextMoveToPoint(contextForArcs, l9.x - 50.f, l9.y);
    CGContextAddArc(contextForArcs, l9.x, l9.y, 50.f, M_PI, 3*M_PI, NO);
    
    CGContextFillPath(contextForArcs);
    
    
    if (self.areSmallStarsNeeded)
    {
        [self drawSmallStars:context andRect:rect];
    }
    
}

#pragma Private Methods

- (void)drawSmallStars:(CGContextRef)context andRect:(CGRect)rect
{
    for (int i = 0; i < 5; i++)
    {
        CGContextSetStrokeColorWithColor(context, [[UIColor clearColor] CGColor]);
        
        CGFloat borderSize = 50;
        
        CGPoint l1 = [self randomPointInRect:rect];
        CGPoint l2 = CGPointMake(l1.x + borderSize, l1.y);
        CGPoint l3 = CGPointMake(l2.x + borderSize / 2, l2.y - sqrtf(3) / 2 * borderSize);
        CGPoint l4 = CGPointMake(l2.x + borderSize, l2.y);
        CGPoint l5 = CGPointMake(l4.x + borderSize, l4.y);
        CGPoint l6 = CGPointMake(l5.x - borderSize * 5 / 7, l5.y + sqrtf(3) / 2 * borderSize);
        
        CGFloat maxVal = l6.y + borderSize;
        CGFloat minVal = l6.y + sqrtf(3) / 2 * borderSize;
        CGFloat delta = (maxVal - minVal) / 2;
        
        CGPoint l7 = CGPointMake(l6.x + borderSize / 3,
                                 l6.y + borderSize - delta);
        CGPoint l8 = CGPointMake(l3.x, l6.y + borderSize / 3);
        CGPoint l10 = CGPointMake(l1.x + borderSize * 5 / 7, l6.y);
        CGPoint l9 = CGPointMake(l10.x - borderSize / 3, l7.y);
        
        
        CGContextMoveToPoint(context, l1.x, l1.y);
        
        CGContextSetStrokeColorWithColor(context, [[UIColor purpleColor] CGColor]);
        CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
        
        CGContextAddLineToPoint(context, l2.x, l2.y);
        CGContextAddLineToPoint(context, l3.x, l3.y);
        CGContextAddLineToPoint(context, l4.x, l4.y);
        CGContextAddLineToPoint(context, l5.x, l5.y);
        CGContextAddLineToPoint(context, l6.x, l6.y);
        CGContextAddLineToPoint(context, l7.x, l7.y);
        CGContextAddLineToPoint(context, l8.x, l8.y);
        CGContextAddLineToPoint(context, l9.x, l9.y);
        CGContextAddLineToPoint(context, l10.x, l10.y);
        CGContextAddLineToPoint(context, l1.x, l1.y);
        
        CGContextSetFillColorWithColor(context, [self randomColor]);
        CGContextFillPath(context);
    }
    
}

- (CGPoint)randomPointInRect:(CGRect)r
{
    CGPoint p = r.origin;
    
    p.x += arc4random_uniform((u_int32_t) CGRectGetWidth(r));
    p.y += arc4random_uniform((u_int32_t) CGRectGetHeight(r));
    
    return p;
}

- (CGColorRef)randomColor
{
    float r = (float)(arc4random() % 256) / 255.f;
    float g = (float)(arc4random() % 256) / 255.f;
    float b = (float)(arc4random() % 256) / 255.f;
    
    return [[UIColor colorWithRed:r green:g blue:b alpha:1.f] CGColor];
}


@end
