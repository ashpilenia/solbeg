//
//  ASObject+CoreDataProperties.m
//  CoreDataTest
//
//  Created by Alex on 4/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASObject+CoreDataProperties.h"

@implementation ASObject (CoreDataProperties)

+ (NSFetchRequest<ASObject *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ASObject"];
}


@end
