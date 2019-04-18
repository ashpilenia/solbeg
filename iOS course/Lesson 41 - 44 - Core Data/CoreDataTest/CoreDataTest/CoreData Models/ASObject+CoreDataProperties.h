//
//  ASObject+CoreDataProperties.h
//  CoreDataTest
//
//  Created by Alex on 4/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASObject+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ASObject (CoreDataProperties)

+ (NSFetchRequest<ASObject *> *)fetchRequest;


@end

NS_ASSUME_NONNULL_END
