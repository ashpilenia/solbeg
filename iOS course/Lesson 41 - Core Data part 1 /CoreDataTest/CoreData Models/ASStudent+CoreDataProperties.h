//
//  ASStudent+CoreDataProperties.h
//  CoreDataTest
//
//  Created by Alex on 3/4/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASStudent+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ASStudent (CoreDataProperties)

+ (NSFetchRequest<ASStudent *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *dateOfBirth;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nonatomic) double score;

@end

NS_ASSUME_NONNULL_END
