//
//  ASEntity+CoreDataProperties.m
//  CoreData HomeWork
//
//  Created by Alex on 4/24/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASEntity+CoreDataProperties.h"

@implementation ASEntity (CoreDataProperties)

+ (NSFetchRequest<ASEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ASEntity"];
}


@end
