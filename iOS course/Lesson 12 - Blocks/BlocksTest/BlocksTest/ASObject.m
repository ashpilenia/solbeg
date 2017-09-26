//
//  ASObject.m
//  BlocksTest
//
//  Created by Alex on 9/25/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASObject.h"

@interface ASObject ()


@property (nonatomic, copy) testBlock2 objectBlock;

@end

@implementation ASObject
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        __weak ASObject *weakSelf = self;
        self.objectBlock = ^{
            
            NSLog(@"%@", weakSelf.name);
        }; 
    }
    return self;
}

- (void) dealloc
{
    NSLog(@"Object is deallocated");
}

@end
