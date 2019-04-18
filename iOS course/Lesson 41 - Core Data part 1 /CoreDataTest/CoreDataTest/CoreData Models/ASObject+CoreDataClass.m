//
//  ASObject+CoreDataClass.m
//  CoreDataTest
//
//  Created by Alex on 4/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASObject+CoreDataClass.h"

@implementation ASObject

- (BOOL)validateForDelete:(NSError * _Nullable __autoreleasing *)error {
    
    NSLog(@"%@ validateForDelete", NSStringFromClass([self class]));
    
    return YES;
}

@end
