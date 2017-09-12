//
//  ASAnimal.m
//  ASArraysHomeWork
//
//  Created by Alex on 9/4/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASAnimal.h"

@implementation ASAnimal

- (void) movement {
    NSLog(@"What luker is doing? He is crawling.");
}

- (NSComparisonResult) compare: (ASAnimal*) newObj
{
    return [self.a_name compare:newObj.a_name];
}


#pragma mark - ASRunners

- (NSString*) run
{
    return @"Do running is fun.";
}
- (BOOL) record
{
    NSLog(@"Was it a new record?");
    BOOL boolVar = arc4random() % 2;
    return boolVar;
}

@end
