//
//  ASUniversity+CoreDataProperties.h
//  CoreDataTest
//
//  Created by Alex on 4/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASUniversity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ASUniversity (CoreDataProperties)

+ (NSFetchRequest<ASUniversity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<ASStudent *> *studetnts;
@property (nullable, nonatomic, retain) NSSet<ASCourse *> *courses;

@end

@interface ASUniversity (CoreDataGeneratedAccessors)

- (void)addStudetntsObject:(ASStudent *)value;
- (void)removeStudetntsObject:(ASStudent *)value;
- (void)addStudetnts:(NSSet<ASStudent *> *)values;
- (void)removeStudetnts:(NSSet<ASStudent *> *)values;

- (void)addCoursesObject:(ASCourse *)value;
- (void)removeCoursesObject:(ASCourse *)value;
- (void)addCourses:(NSSet<ASCourse *> *)values;
- (void)removeCourses:(NSSet<ASCourse *> *)values;

@end

NS_ASSUME_NONNULL_END
