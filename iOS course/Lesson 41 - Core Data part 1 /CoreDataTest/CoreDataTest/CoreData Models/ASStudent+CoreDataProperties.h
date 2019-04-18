//
//  ASStudent+CoreDataProperties.h
//  CoreDataTest
//
//  Created by Alex on 4/15/19.
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
@property (nullable, nonatomic, retain) ASCar *car;
@property (nullable, nonatomic, retain) ASUniversity *university;
@property (nullable, nonatomic, retain) NSSet<ASCourse *> *courses;

@end

@interface ASStudent (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(ASCourse *)value;
- (void)removeCoursesObject:(ASCourse *)value;
- (void)addCourses:(NSSet<ASCourse *> *)values;
- (void)removeCourses:(NSSet<ASCourse *> *)values;

@end

NS_ASSUME_NONNULL_END
