//
//  ASStudent+CoreDataClass.m
//  CoreDataTest
//
//  Created by Alex on 3/4/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASStudent+CoreDataClass.h"

@implementation ASStudent

- (void)setFirstName:(NSString *)firstName {
    
    [self willChangeValueForKey:@"firstName"];
    [self setPrimitiveValue:firstName forKey:@"firstName"];
    [self didChangeValueForKey:@"firstName"];
    
    NSLog(@"ASStudent SET NAME method was just called!");
}

- (NSString *)firstName {
    
    NSString *string = nil;
    [self willAccessValueForKey:@"firstName"];
    string = [self primitiveValueForKey:@"firstName"];
    [self didAccessValueForKey:@"firstName"];
    
    NSLog(@"ASStudent GET NAME method was just called!");
    
    return string;
}

@end
