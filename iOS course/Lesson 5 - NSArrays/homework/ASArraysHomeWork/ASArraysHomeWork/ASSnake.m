//
//  ASSnake.m
//  ASArraysHomeWork
//
//  Created by Alex on 9/4/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASSnake.h"

@implementation ASSnake

- (void) movement {
    NSLog(@"Sneaking snake.");
}

#pragma mark - ASJumpers

- (void) jumping {
    NSLog(@"Snake makes a jump!");
}
- (NSInteger) numberOfTries {
    NSInteger tryNumber = arc4random();
    return tryNumber;
}

@end
