//
//  ASCoreDataManager.m
//  CoreData HomeWork
//
//  Created by Alex on 4/19/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASCoreDataManager.h"
#import <CoreData/CoreData.h>
#import "ASUser+CoreDataClass.h"
#import "ASCourse+CoreDataClass.h"
#import "ASEntity+CoreDataClass.h"

@implementation ASCoreDataManager

static NSString *firstNames[] = {@"Alex", @"Dmitriy", @"Daniil", @"Artem", @"Vasiliy",
    @"Oleg", @"Pvael", @"Ergey", @"Petr", @"Bernard"
};

static NSString *lastNames[] = {@"Alexeev", @"Dmitriev", @"Danilov", @"Lojinskiy", @"Vasilevskiy",
    @"Chjen", @"Pvlovich", @"Karpov", @"Petrashkevich", @"Johnson"
};

+ (ASCoreDataManager *)sharedManager {
    
    static ASCoreDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ASCoreDataManager alloc] init];
    });
    
    return manager;
}

#pragma mark - Manage Mocking Data

- (void)fillDataBaseWithMockingData {
    
    NSArray *coursesArray = @[[self createCourseWithName:@"PHP"],
                              [self createCourseWithName:@"JavaScript"],
                              [self createCourseWithName:@"HTML"],
                              [self createCourseWithName:@"CSS"],
                              [self createCourseWithName:@"SQL"]];
    
    NSMutableArray *usersArray = [NSMutableArray array];
    for (int i = 0; i < 25; i++) {
        
        ASUser *user = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ASUser class]) inManagedObjectContext:self.persistentContainer.viewContext];
        
        user.firstName = firstNames[arc4random_uniform(9)];
        user.lastName = lastNames[arc4random_uniform(9)];
        
        NSInteger coursesAttendedNumber = arc4random_uniform(4) + 1;
        
        while (user.coursesAttended.count < coursesAttendedNumber) {
            ASCourse *course = [coursesArray objectAtIndex:arc4random_uniform(5)];
            if (![user.coursesAttended containsObject:course]) {
                [user addCoursesAttendedObject:course];
            }
        }
        
        [usersArray addObject:user];
    }
    [self setupTeachersRelationsForUsers:usersArray andCourses:coursesArray];
    
    NSError *error = nil;
    if (![self.persistentContainer.viewContext save:&error]) {
        NSLog(@"%@", error.localizedDescription);
    }
    
}

- (void)setupTeachersRelationsForUsers:(NSArray *)usersArray andCourses:(NSArray *)coursesArray {
    
    for (ASCourse *course in coursesArray) {
        ASUser *randomUser = [usersArray objectAtIndex:arc4random_uniform(24)];
        course.teacher = randomUser;
    }
}

- (ASCourse *)createCourseWithName:(NSString *)name {
    
    ASCourse *course = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ASCourse class]) inManagedObjectContext:self.persistentContainer.viewContext];
    course.name = name;
    
    return course;
}

- (void)printAllObjectsFromArray:(NSArray *)array {
    
    for (NSManagedObject *object in array) {
        if ([object isKindOfClass:[ASUser class]]) {
            ASUser *user = (ASUser *)object;
            NSLog(@"USER: %@ %@ ATTENDED:%ld, LEAD:%ld",user.firstName, user.lastName, user.coursesAttended.count, user.coursesLead.count);
        } else if ([object isKindOfClass:[ASCourse class]]) {
            ASCourse *course = (ASCourse *)object;
            NSLog(@"COURSE: %@, STUDENTS:%ld, TEACHER: %@ %@", course.name, course.students.count, course.teacher.firstName, course.teacher.lastName);
        } else {
            NSLog(@"Unexpected object class: %@", [object class]);
        }
    }
}

- (NSArray *)allObject {
    
    //NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([ASEntity class])];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:NSStringFromClass([ASEntity class]) inManagedObjectContext:self.persistentContainer.viewContext];
    [request setEntity:description];
    
    NSError *error = nil;
    NSArray *resultArray = [self.persistentContainer.viewContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    return resultArray;
}

- (void)showAllObjecrs {
    [self printAllObjectsFromArray:[self allObject]];
}

- (void)dropDataBase {
    
    NSArray *allObjects = [self allObject];
    for (ASEntity *object in allObjects) {
        [self.persistentContainer.viewContext deleteObject:object];
    }
    NSError *error = nil;
    if (![self.persistentContainer.viewContext save:&error]) {
        NSLog(@"%@", error.localizedDescription);
    }
}



#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"CoreData_HomeWork"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
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
