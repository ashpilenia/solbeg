//
//  ASStudent+CoreDataClass.m
//  CoreDataTest
//
//  Created by Alex on 3/5/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASStudent+CoreDataClass.h"

@implementation ASStudent

- (BOOL)validateForDelete:(NSError * _Nullable __autoreleasing *)error {
    
    NSLog(@"ASStudent validateForDelete");
    return YES;
}

@end