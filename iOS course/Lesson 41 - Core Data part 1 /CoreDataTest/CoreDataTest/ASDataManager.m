//
//  ASDataManager.m
//  CoreDataTest
//
//  Created by Alex on 4/16/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASDataManager.h"
#import "ASStudent+CoreDataClass.h"
#import "ASCar+CoreDataClass.h"
#import "ASUniversity+CoreDataClass.h"
#import "ASCourse+CoreDataClass.h"

static NSString *firstNames[] = {
    @"Pavel", @"John", @"Alex", @"Eugene", @"Dmitriy",
    @"Vasiliy", @"Daniil", @"Artem", @"Bill", @"Colin"
};

static NSString *lastNames[] = {
    @"Pavlov", @"Johnson", @"Alexeev", @"Egorov", @"Dmitriev",
    @"Vasilevskiy", @"Danilov", @"Artison", @"Bilevich", @"Colinson"
};

static NSString *carsNames[] = {
    @"BMW", @"Mazda", @"Toyota", @"Nissan", @"Dodge"
};

@implementation ASDataManager

@synthesize persistentContainer = _persistentContainer;

+ (ASDataManager *)sharedManager {
    
    static ASDataManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[ASDataManager alloc] init];
    });
    
    return manager;
}

- (void)generateAndAddUniversity {
    
    //    [self deleteAllObjects];
    
    NSArray *courses = @[[self addCourseWithName:@"iOS"],
                         [self addCourseWithName:@"Android"],
                         [self addCourseWithName:@"SQL"],
                         [self addCourseWithName:@"PHP"],
                         [self addCourseWithName:@"HTML"]];

    NSSet *coursesSet = [NSSet setWithArray:courses];

    ASUniversity *university = [self addUniversity];
    [university addCourses:coursesSet];

    for (int i = 0; i < 100; i++) {

        ASStudent *student = [self addRandomStudent];
        if (arc4random_uniform(1000) < 500) {
            ASCar *car = [self addRandomCar];
            student.car = car;
        }

        [university addStudetntsObject:student];

        NSInteger number = arc4random_uniform(4) + 1;

        while (student.courses.count < number) {
            ASCourse *course = [courses objectAtIndex:arc4random_uniform(5)];
            if (![student.courses containsObject:course]) {
                [student addCoursesObject:course];
            }
        }
    }

    NSError *error = nil;
    if (![self.persistentContainer.viewContext save:&error]) {
        NSLog(@"%@", error.localizedDescription);
    }

//    [self printAllObjects];
//
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    NSEntityDescription *description = [NSEntityDescription entityForName:NSStringFromClass([ASCourse class]) inManagedObjectContext:self.persistentContainer.viewContext];
//
//    [request setEntity:description];
//    [request setFetchBatchSize:20];
//    [request setRelationshipKeyPathsForPrefetching:@[@"courses"]];
//
//    NSSortDescriptor *lastNameDescriptior = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
//    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
//
//    [request setSortDescriptors:@[firstNameDescriptor, lastNameDescriptior]];
//
//    NSArray *validNames = @[@"Vasiliy", @"Alex", @"John"];
//
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:
//                              @"score > 2.0 AND score <= 3.0"
//                              "AND courses.@count > 2"
//                              "AND firstName IN %@", validNames];
//
//    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
//    [request setSortDescriptors:@[nameDescriptor]];
//
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"@avg.students.score > 3"];
//
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SUBQUERY(students, $c, $c.car.model == 'BMW').@count >= 10"];
//
//    [request setPredicate:predicate];
//
//    NSFetchRequest *request = [[self.persistentContainer.managedObjectModel fetchRequestTemplateForName:@"FetchMidStudents"] copy];
//
//    NSSortDescriptor *lastNameDescriptior = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
//    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
//
//    [request setSortDescriptors:@[firstNameDescriptor, lastNameDescriptior]];
//
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    NSEntityDescription *description = [NSEntityDescription entityForName:NSStringFromClass([ASCourse class]) inManagedObjectContext:self.persistentContainer.viewContext];
//    [request setEntity:description];
//
//
//    NSError *requestError = nil;
//    NSArray *resultArray = [self.persistentContainer.viewContext executeFetchRequest:request error:&requestError];
//
//    for (ASCourse *course in resultArray) {
//
//        NSLog(@"COURSE NAME: %@", course.name);
//        NSLog(@"BEST STUDENTS:");
//        [self printArray:course.bestStudents];
//
//    }
    
    //[self printArray:resultArray];
    
}

- (NSArray *)allObjects {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"ASObject"
                                                   inManagedObjectContext:self.persistentContainer.viewContext];
    
    [request setEntity:description];
    
    NSError *requestError = nil;
    NSArray *resultArray = [self.persistentContainer.viewContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", requestError.localizedDescription);
    }
    
    return resultArray;
    
}
- (void)printAllObjects {
    
    NSArray *allObjects = [self allObjects];
    
    [self printArray:allObjects];
}

- (void)printArray:(NSArray *)array {
    
    for (id object in array) {
        if ([object isKindOfClass:[ASCar class]]) {
            
            ASCar *car = (ASCar *)object;
            NSLog(@"CAR: %@, OWNER: %@ %@", car.model, car.owner.firstName, car.owner.lastName);
            
        } else if ([object isKindOfClass:[ASStudent class]]) {
            
            ASStudent *student = (ASStudent *)object;
            NSLog(@"STUDENT: %@ %@, SCORE: %1.2f, COURSES: %ld", student.firstName, student.lastName, student.score, student.courses.count);
            
        } else if ([object isKindOfClass:[ASUniversity class]]) {
            
            ASUniversity *university = (ASUniversity *)object;
            NSLog(@"UNIVERSITY: %@ STUDENTS: %lu", university.name, (unsigned long)university.studetnts.count);
            
        } else if ([object isKindOfClass:[ASCourse class]]) {
            
            ASCourse *course = (ASCourse *)object;
            NSLog(@"COURSE: %@ STUDENTS: %lu", course.name, (unsigned long)course.students.count);
        }
    }
    
    NSLog(@"COUNT = %ld", array.count);
}

- (void)deleteAllObjects {
    
    NSArray *allObjects = [self allObjects];
    
    for (id object in allObjects) {
        [self.persistentContainer.viewContext deleteObject:object];
    }
    [self.persistentContainer.viewContext save:nil];
}

- (ASStudent *)addRandomStudent {
    
    ASStudent *student = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ASStudent class]) inManagedObjectContext:self.persistentContainer.viewContext];
    student.score = (float)arc4random_uniform(201)/100.f + 2.f;
    student.firstName = firstNames[arc4random_uniform(9)];
    student.lastName = lastNames[arc4random_uniform(9)];
    student.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:60 * 60 * 24 * 365 * arc4random_uniform(31)];
    
    return student;
}

- (ASCar *)addRandomCar {
    
    ASCar *car = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ASCar class])
                                               inManagedObjectContext:self.persistentContainer.viewContext];
    car.model = carsNames[arc4random_uniform(4)];
    return car;
}

- (ASUniversity *)addUniversity {
    
    ASUniversity *university = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ASUniversity class]) inManagedObjectContext:self.persistentContainer.viewContext];
    university.name = @"BSU";
    
    return university;
}

- (ASCourse *)addCourseWithName:(NSString *)name {
    
    ASCourse *course = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ASCourse class]) inManagedObjectContext:self.persistentContainer.viewContext];
    course.name = name;
    
    return course;
    
}

#pragma mark - Core Data stack

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"CoreDataTest"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                NSLog(@"storeDescription: %@", storeDescription);
                if (error != nil) {
                    
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
