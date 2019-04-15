//
//  ASCourse+CoreDataProperties.h
//  CoreDataTest
//
//  Created by Alex on 4/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASCourse+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ASCourse (CoreDataProperties)

+ (NSFetchRequest<ASCourse *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) ASUniversity *university;
@property (nullable, nonatomic, retain) NSSet<ASStudent *> *students;

@end

@interface ASCourse (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(ASStudent *)value;
- (void)removeStudentsObject:(ASStudent *)value;
- (void)addStudents:(NSSet<ASStudent *> *)values;
- (void)removeStudents:(NSSet<ASStudent *> *)values;

@end

NS_ASSUME_NONNULL_END
