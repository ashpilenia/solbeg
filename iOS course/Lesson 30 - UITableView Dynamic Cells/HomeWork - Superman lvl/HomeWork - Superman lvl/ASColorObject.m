//
//  ASColorObject.m
//  HomeWork - Superman lvl
//
//  Created by Alex on 10/26/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASColorObject.h"

@implementation ASColorObject

- (UIColor *) randomColor
{
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;
    
    UIColor *color = [[UIColor alloc] initWithRed:r green:g blue:b alpha:1.f];
    
    self.usedName = [self getColorDetails:r g:g b:b];
    
    return color;
}

- (NSString *) getColorDetails:(CGFloat) red g:(CGFloat) green b:(CGFloat) blue
{
    
    NSString *str = [NSString stringWithFormat:@"RGB(%f %f, %f)", red, green, blue];
    
    return str;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.usedName = nil;
        self.color = [self randomColor];
        self.name = self.usedName;
    }
    return self;
}

@end
