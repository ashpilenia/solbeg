//
//  ASRat.m
//  ASArraysHomeWork
//
//  Created by Alex on 9/4/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASRat.h"

@implementation ASRat

- (void) movement
  {
      NSLog(@"Running rat");
  }

#pragma mark - ASSwimmers

- (void) swimming
{
    NSLog(@"Swimming rats");
}

- (NSInteger) distance
{
    NSInteger dist = arc4random();
    return dist;
}

@end
