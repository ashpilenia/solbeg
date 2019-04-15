//
//  ASStudent+CoreDataProperties.m
//  CoreDataTest
//
//  Created by Alex on 4/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASStudent+CoreDataProperties.h"

@implementation ASStudent (CoreDataProperties)

+ (NSFetchRequest<ASStudent *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ASStudent"];
}

@dynamic dateOfBirth;
@dynamic firstName;
@dynamic lastName;
@dynamic score;
@dynamic car;
@dynamic university;
@dynamic courses;

@end
