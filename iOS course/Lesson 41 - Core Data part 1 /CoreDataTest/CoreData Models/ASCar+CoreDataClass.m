//
//  ASCar+CoreDataClass.m
//  CoreDataTest
//
//  Created by Alex on 3/5/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASCar+CoreDataClass.h"

@implementation ASCar

- (BOOL)validateForDelete:(NSError * _Nullable __autoreleasing *)error {
    
    NSLog(@"ASCar validateForDelete");
    return YES;
}

@end
