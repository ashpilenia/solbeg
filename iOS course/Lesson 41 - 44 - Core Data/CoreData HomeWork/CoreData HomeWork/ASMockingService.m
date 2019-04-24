//
//  ASMockingService.m
//  CoreData HomeWork
//
//  Created by Alex on 4/22/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASMockingService.h"
#import "ASUser+CoreDataClass.h"

static NSString *firstNames[] = { @"Alex", @"John", @"Vasiliy", @"Pavel", @"Bill",
    @"Gennadiy", @"Vitaliy", @"Eugene", @"Molly", @"Eva", @"Angelina", @"Olga",
    @"Maria", @"Daria", @"Dmitriy"
};

static NSString *lastNames[] = { @"Alexeev", @"Johnson", @"Vasilivskiy", @"Pavelovich", @"Billevich",
    @"Gradulevskiy", @"Vitalevskiy", @"Eugenenevich", @"MollyHole", @"Bagushevich", @"Jolie", @"Lopatkin",
    @"Shirshov", @"Prohorov", @"Belyaev"
};



@implementation ASMockingService

+ (void)generateDataWithContext:(NSManagedObjectContext *)context {
    
//    NSArray *coursesArray = @[[ASMockingService addCourseWithName:@"PHP" forContext:context],
//                              [ASMockingService addCourseWithName:@"SQL" forContext:context],
//                              [ASMockingService addCourseWithName:@"HTML" forContext:context],
//                              [ASMockingService addCourseWithName:@"CSS" forContext:context],
//                              [ASMockingService addCourseWithName:@"JavaScript" forContext:context]];
    
    NSMutableArray *usersArray = [NSMutableArray array];
    for (int i = 0; i < 50; i++) {
        
        ASUser *user  = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ASUser class])
                                                      inManagedObjectContext:context];
        
        user.firstName = firstNames[arc4random_uniform(14)];
        user.lastName = lastNames[arc4random_uniform(14)];
        
        //NSInteger coursesAttendedNumber = arc4random_uniform(4) + 1;
        
//        while (user.coursesAttended.count < coursesAttendedNumber) {
//            ASCourse *course = [coursesArray objectAtIndex:arc4random_uniform(5)];
//            if (![user.coursesAttended containsObject:course]) {
//                [user addCoursesAttendedObject:course];
//            }
//        }
       
        [usersArray addObject:user];
    }
    
    //[ASMockingService setupLectorsRelationsWithUsers:usersArray andCourses:coursesArray];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"%@", error.localizedDescription);
    }
}

//+ (ASCourse *)addCourseWithName:(NSString *)name forContext:(NSManagedObjectContext *)context {
//
//    ASCourse *course = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ASCourse class])
//                                                     inManagedObjectContext:context];
//    course.name = name;
//    return course;
//}

//+ (void)setupLectorsRelationsWithUsers:(NSArray<ASUser *> *)usersArray
//                            andCourses:(NSArray<ASCourse *> *)coursesArray {
//
//    for (ASCourse *course in coursesArray) {
//        ASUser *teacher = [usersArray objectAtIndex:arc4random_uniform(49)];
//        course.teacher = teacher;
//    }
//
//}

@end
