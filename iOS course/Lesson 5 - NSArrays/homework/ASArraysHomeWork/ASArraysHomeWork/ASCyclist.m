//
//  ASCyclist.m
//  ASArraysHomeWork
//
//  Created by Alex on 9/4/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASCyclist.h"

@implementation ASCyclist


- (void) movement {
    NSLog(@"Moving on bicycle.");
}

- (NSString*) run
{
    return @"Even cyclists can run.";
}

- (BOOL) record
{
    NSLog(@"Was it a new record?");
    BOOL boolVar = arc4random() % 2;
    return boolVar;
}

- (NSInteger) averageSpeed
{
    NSInteger distVar = arc4random();
    NSInteger timeVar = arc4random();
    return distVar / timeVar;
}

@end
