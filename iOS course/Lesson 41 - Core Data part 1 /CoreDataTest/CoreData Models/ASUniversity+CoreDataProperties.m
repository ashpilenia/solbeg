//
//  ASUniversity+CoreDataProperties.m
//  CoreDataTest
//
//  Created by Alex on 4/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASUniversity+CoreDataProperties.h"

@implementation ASUniversity (CoreDataProperties)

+ (NSFetchRequest<ASUniversity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ASUniversity"];
}

@dynamic name;
@dynamic studetnts;
@dynamic courses;

@end
