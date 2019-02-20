//
//  AppDelegate.m
//  KVCTest
//
//  Created by Alex on 2/18/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "AppDelegate.h"
#import "ASStudent.h"
#import "ASGroup.h"

@interface AppDelegate ()

@property (nonatomic, strong) ASStudent *student;
@property (nonatomic, strong) NSArray<ASGroup *> *groups;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ASStudent *student = [[ASStudent alloc] init];
    
    [student addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    student.name = @"Alex";
    student.age = 20;
    NSLog(@"%@", student);
    
    [student setValue:@"Roger" forKey:@"name1"];
    NSNumber *ageTest = [student valueForKey:@"age1"];
    NSLog(@"Age Test = %ld", (long)ageTest);
    
    [student setValue:@"Roger" forKey:@"name"];
    [student setValue:@(25) forKey:@"age"];
    
    self.student = student;
    
    [self.student changeName];
    
    ASStudent *student1 = [[ASStudent alloc] init];
    student1.name = @"John";
    student1.age = 21;
    
    ASStudent *student2 = [[ASStudent alloc] init];
    student2.name = @"Bill";
    student2.age = 22;
    
    ASStudent *student3 = [[ASStudent alloc] init];
    student3.name = @"Karl";
    student3.age = 23;
    
    ASStudent *student4 = [[ASStudent alloc] init];
    student4.name = @"Mark";
    student4.age = 24;
    
    ASGroup *group = [[ASGroup alloc] init];
    group.students = @[student1, student2, student3, student4];
    
    [group addObserver:self forKeyPath:@"students" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    NSMutableArray *mutArray = [group mutableArrayValueForKey:@"students"];
    
    [mutArray removeLastObject];
    
    NSLog(@"%@ \n%@", group.students, mutArray);
    
    NSLog(@"%@", [self valueForKeyPath:@"student.name"]);
    
    NSString *name = @"Alex111";
    NSError *error = nil;
    
    if (![self.student validateValue:&name forKey:@"name" error:&error]) {
        
        NSLog(@"%@", error.localizedDescription);
    }
    
    NSString *name2 = @(23);
    
    if (![self.student validateValue:&name2 forKey:@"name" error:&error]) {
        NSLog(@"%@", error.localizedDescription);
    }
    
    ASStudent *student5 = [[ASStudent alloc] init];
    student5.name = @"George";
    student5.age = 25;
    
    ASStudent *student6 = [[ASStudent alloc] init];
    student6.name = @"Michael";
    student6.age = 26;
    
    ASGroup *group2 = [[ASGroup alloc] init];
    group2.students = @[student5, student6];
    
    self.groups = @[group, group2];
    
    NSLog(@"groups count %@", [self valueForKeyPath:@"groups.@count"]);
    
    NSArray *allStudents = [self valueForKeyPath:@"groups.@distinctUnionOfArrays.students"];
    NSLog(@"%@", allStudents);
    
    NSNumber *minAge = [allStudents valueForKeyPath:@"@min.age"];
    NSNumber *maxAge = [allStudents valueForKeyPath:@"@max.age"];
    NSNumber *avgAge = [allStudents valueForKeyPath:@"@avg.age"];
    NSNumber *sumAge = [allStudents valueForKeyPath:@"@sum.age"];
    
    NSLog(@"minAge = %@", minAge);
    NSLog(@"maxAge = %@", maxAge);
    NSLog(@"avgAge = %@", avgAge);
    NSLog(@"sumAge = %@", sumAge);
    
    NSArray *allNames = [allStudents valueForKeyPath:@"@distinctUnionOfObjects.name"];
    
    NSLog(@"%@", allNames);
    
    return YES;
}

- (void)dealloc {
    
    [self.student removeObserver:self forKeyPath:@"name"];
}


#pragma mark - Observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"\nobserveValueForKeyPath: %@ \nofObject %@ \nchange %@", keyPath, object, change);
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
}


@end
