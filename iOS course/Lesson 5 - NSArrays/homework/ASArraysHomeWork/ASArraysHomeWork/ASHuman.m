//
//  ASHuman.m
//  ASArraysHomeWork
//
//  Created by Alex on 9/4/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASHuman.h"
#import <UIKit/UIKit.h>

@implementation ASHuman

- (void) movement
{
    NSLog(@"Moving forward.");
}

- (NSComparisonResult) compare: (ASHuman*) newObj
{
return [self.name compare:newObj.name];
}

#pragma mark - ASJumpers
- (void) jumping
{
    NSLog(@"Some people love jumping!");
}

- (NSInteger) numberOfTries
{
    NSInteger jumpsNbr = arc4random();
    return jumpsNbr;
}

- (NSString*) landing
{
    if (self.balance)
    {
        return @"Landing was successful.";
    }
               else
               {
                   return @"Landing is failed.";
               }
}


@end
