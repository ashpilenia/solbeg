//
//  AppDelegate.m
//  CoreDataTest
//
//  Created by Alex on 2/25/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "AppDelegate.h"
#import "ASStudent+CoreDataClass.h"

static NSString *firstNames[] = {
    @"Pavel", @"John", @"Alex", @"Eugene", @"Dmitriy",
    @"Vasiliy", @"Daniil", @"Artem", @"Bill", @"Colin"
};

static NSString *lastNames[] = {
    @"Pavlov", @"Johnson", @"Alexeev", @"Egorov", @"Dmitriev",
    @"Vasilevskiy", @"Daniiov", @"Artison", @"Bilevich", @"Colinson"
};

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSLog(@"%@",[self.persistentContainer.managedObjectModel entitiesByName]);
//    NSManagedObject *student = [NSEntityDescription insertNewObjectForEntityForName:@"ASStudent" inManagedObjectContext:self.persistentContainer.viewContext];
//
//    [student setValue:@"Alex" forKey:@"firstName"];
//    [student setValue:@"Shpilenia" forKey:@"lastName"];
//    [student setValue:[NSDate dateWithTimeIntervalSinceReferenceDate:0] forKey:@"dateOfBirth"];
//    [student setValue:@(4) forKey:@"score"];
//
//    NSError *error = nil;
//    if (![self.persistentContainer.viewContext save:&error]) {
//        NSLog(@"%@", [error localizedDescription]);
//    }
    
    ASStudent *newStudent = [self addRandomStudent];
    NSError *newStudError = nil;
    [newStudent.managedObjectContext save:&newStudError];
    
    if (newStudError) {
        
        NSLog(@"Wooops, %@", newStudError.localizedDescription);
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"ASStudent"
                                                   inManagedObjectContext:self.persistentContainer.viewContext];
    
    [request setEntity:description];
    //[request setResultType:NSDictionaryResultType];
    
    NSError *requestError = nil;
    NSArray *resultArray = [self.persistentContainer.viewContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"Error: %@", requestError.localizedDescription);
    }
    
    NSLog(@"Result: %@", resultArray);
    
    for (ASStudent *student in resultArray) {
        NSLog(@"%@ %@ - %1.2f", student.firstName, student.lastName, student.score);
    }
    
    return YES;
}

- (ASStudent *)addRandomStudent {
    
    ASStudent *student = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ASStudent class]) inManagedObjectContext:self.persistentContainer.viewContext];
    student.score = (float)arc4random_uniform(201)/200.f + 2.f;
    student.firstName = firstNames[arc4random_uniform(9)];
    student.lastName = lastNames[arc4random_uniform(9)];
    student.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:60 * 60 * 24 * 365 * arc4random_uniform(31)];
    
    return student;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

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
