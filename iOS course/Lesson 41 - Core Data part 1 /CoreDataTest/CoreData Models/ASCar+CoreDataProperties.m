//
//  ASCar+CoreDataProperties.m
//  CoreDataTest
//
//  Created by Alex on 4/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASCar+CoreDataProperties.h"

@implementation ASCar (CoreDataProperties)

+ (NSFetchRequest<ASCar *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ASCar"];
}

@dynamic model;
@dynamic owner;

@end
