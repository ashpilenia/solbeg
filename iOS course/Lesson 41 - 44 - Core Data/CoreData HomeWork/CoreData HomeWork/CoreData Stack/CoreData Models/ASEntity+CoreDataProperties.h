//
//  ASEntity+CoreDataProperties.h
//  CoreData HomeWork
//
//  Created by Alex on 4/24/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ASEntity (CoreDataProperties)

+ (NSFetchRequest<ASEntity *> *)fetchRequest;


@end

NS_ASSUME_NONNULL_END
