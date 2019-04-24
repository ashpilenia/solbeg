//
//  ASCourse+CoreDataProperties.m
//  CoreData HomeWork
//
//  Created by Alex on 4/24/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASCourse+CoreDataProperties.h"

@implementation ASCourse (CoreDataProperties)

+ (NSFetchRequest<ASCourse *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ASCourse"];
}

@dynamic branch;
@dynamic name;
@dynamic subject;
@dynamic students;
@dynamic teacher;

@end
