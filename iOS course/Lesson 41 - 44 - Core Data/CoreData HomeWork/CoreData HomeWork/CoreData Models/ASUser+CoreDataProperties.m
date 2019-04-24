//
//  ASUser+CoreDataProperties.m
//  CoreData HomeWork
//
//  Created by Alex on 4/24/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASUser+CoreDataProperties.h"

@implementation ASUser (CoreDataProperties)

+ (NSFetchRequest<ASUser *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ASUser"];
}

@dynamic email;
@dynamic firstName;
@dynamic lastName;
@dynamic coursesAttended;
@dynamic coursesLead;

@end
