//
//  ASUser+CoreDataProperties.m
//  CoreData HomeWork
//
//  Created by Alex on 4/19/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASUser+CoreDataProperties.h"

@implementation ASUser (CoreDataProperties)

+ (NSFetchRequest<ASUser *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ASUser"];
}

@dynamic firstName;
@dynamic lastName;
@dynamic email;
@dynamic coursesAttended;
@dynamic coursesLead;

@end
