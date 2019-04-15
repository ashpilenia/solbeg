//
//  ASCourse+CoreDataProperties.m
//  CoreDataTest
//
//  Created by Alex on 4/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASCourse+CoreDataProperties.h"

@implementation ASCourse (CoreDataProperties)

+ (NSFetchRequest<ASCourse *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ASCourse"];
}

@dynamic name;
@dynamic university;
@dynamic students;

@end
