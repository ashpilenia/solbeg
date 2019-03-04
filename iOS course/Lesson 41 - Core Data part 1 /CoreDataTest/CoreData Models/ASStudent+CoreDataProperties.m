//
//  ASStudent+CoreDataProperties.m
//  CoreDataTest
//
//  Created by Alex on 3/4/19.
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

@end
