//
//  ASSwimmer.m
//  ASArraysHomeWork
//
//  Created by Alex on 9/4/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASSwimmer.h"

@implementation ASSwimmer

- (void) movement {
    NSLog(@"Sinking boat.");}

#pragma mark - ASSwimmers

- (void) swimming
{
    NSLog(@"Swimming like a fish");
}

- (NSInteger) distance
{
    NSInteger dist = arc4random_uniform(100);
    return dist;
}


- (CGFloat) technique
{
    CGFloat floatVar = arc4random_uniform(15) / 1.5;
    NSInteger style = arc4random_uniform(5);
    self.style = style;
    NSLog(@"Style number is: %ld", style);
    return floatVar;
}

@end
