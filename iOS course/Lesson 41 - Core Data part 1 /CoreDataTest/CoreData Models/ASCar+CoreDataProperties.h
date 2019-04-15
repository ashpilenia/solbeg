//
//  ASCar+CoreDataProperties.h
//  CoreDataTest
//
//  Created by Alex on 3/5/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASCar+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ASCar (CoreDataProperties)

+ (NSFetchRequest<ASCar *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *model;
@property (nullable, nonatomic, retain) ASStudent *owner;

@end

NS_ASSUME_NONNULL_END
