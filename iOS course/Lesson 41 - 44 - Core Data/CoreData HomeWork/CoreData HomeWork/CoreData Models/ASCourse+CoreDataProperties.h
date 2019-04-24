//
//  ASCourse+CoreDataProperties.h
//  CoreData HomeWork
//
//  Created by Alex on 4/24/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//
//

#import "ASCourse+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ASCourse (CoreDataProperties)

+ (NSFetchRequest<ASCourse *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *branch;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *subject;
@property (nullable, nonatomic, retain) NSSet<ASUser *> *students;
@property (nullable, nonatomic, retain) ASUser *teacher;

@end

@interface ASCourse (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(ASUser *)value;
- (void)removeStudentsObject:(ASUser *)value;
- (void)addStudents:(NSSet<ASUser *> *)values;
- (void)removeStudents:(NSSet<ASUser *> *)values;

@end

NS_ASSUME_NONNULL_END
