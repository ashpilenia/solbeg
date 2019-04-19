//
//  ASUser+CoreDataProperties.h
//  CoreData HomeWork
//
//  Created by Alex on 4/19/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ASUser (CoreDataProperties)

+ (NSFetchRequest<ASUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, retain) NSSet<ASCourse *> *coursesAttended;
@property (nullable, nonatomic, retain) NSSet<ASCourse *> *coursesLead;

@end

@interface ASUser (CoreDataGeneratedAccessors)

- (void)addCoursesAttendedObject:(ASCourse *)value;
- (void)removeCoursesAttendedObject:(ASCourse *)value;
- (void)addCoursesAttended:(NSSet<ASCourse *> *)values;
- (void)removeCoursesAttended:(NSSet<ASCourse *> *)values;

- (void)addCoursesLeadObject:(ASCourse *)value;
- (void)removeCoursesLeadObject:(ASCourse *)value;
- (void)addCoursesLead:(NSSet<ASCourse *> *)values;
- (void)removeCoursesLead:(NSSet<ASCourse *> *)values;

@end

NS_ASSUME_NONNULL_END
