//
//  AppDelegate.m
//  DictionaryTest
//
//  Created by Alex on 9/13/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "AppDelegate.h"
#import "ASStudent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"Petrov", @"lastName",
                                                                     @"Ivanov", @"lastName2",
                                                                    [NSNumber numberWithInteger:25], [NSNumber numberWithBool:YES],
                                                                     nil];
    */
    
    NSInteger number = 322;
    
    NSDictionary* dic = @{@"lastName":@"Petrov", @"lastName2":@"Ivanov", [NSNumber numberWithBool:YES]:[NSNumber numberWithInteger:25], @"number":@(number)};
    
    NSLog(@"%@", dic);
    
    NSLog(@"last name = %@, last name 2 = %@, age = %@", [dic objectForKey:@"lastName"], [dic objectForKey:@"lastName2"], [NSNumber numberWithBool:YES] );
    

    for (NSObject* key in [dic allKeys])
    {
        id obj = [dic objectForKey:key];
        NSLog(@"key =%@ , value =%@",key, obj );
    }
    
    /* Уровень Ученик
    
    1. Создайте класс студент со свойствами имя, фамилия и фраза приветствия.
    2. Создайте 10 - 15 объектов этого класса.
    3. Теперь мы создадим дикшинари типо школьный журнал, где ключ будет фамилия + имя, а значение сам студент.
    4. Распечатайте дикшинари
    */
    
    ASStudent* student1 = [[ASStudent alloc] init];
    ASStudent* student2 = [[ASStudent alloc] init];
    ASStudent* student3 = [[ASStudent alloc] init];
    ASStudent* student4 = [[ASStudent alloc] init];
    ASStudent* student5 = [[ASStudent alloc] init];
    ASStudent* student6 = [[ASStudent alloc] init];
    ASStudent* student7 = [[ASStudent alloc] init];
    ASStudent* student8 = [[ASStudent alloc] init];
    ASStudent* student9 = [[ASStudent alloc] init];
    ASStudent* student10 = [[ASStudent alloc] init];
    
    student1.name = @"name 1";
    student1.lastName = @"last name 1";
    student1.greetings = @"greetings 1";
    
    student2.name = @"name 2";
    student2.lastName = @"last name 2";
    student2.greetings = @"greetings 2";
    
    student3.name = @"name 3";
    student3.lastName = @"last name 3";
    student3.greetings = @"greetings 3";
    
    student4.name = @"name 4";
    student4.lastName = @"last name 4";
    student4.greetings = @"greetings 4";
    
    student5.name = @"name 5";
    student5.lastName = @"last name 5";
    student5.greetings = @"greetings 5";
    
    student6.name = @"name 6";
    student6.lastName = @"last name 6";
    student6.greetings = @"greetings 6";
    
    student7.name = @"name 7";
    student7.lastName = @"last name 7";
    student7.greetings = @"greetings 7";
    
    student8.name = @"name 8";
    student8.lastName = @"last name 8";
    student8.greetings = @"greetings 8";
    
    student9.name = @"name 9";
    student9.lastName = @"last name 9";
    student9.greetings = @"greetings 9";
    
    student10.name = @"name 10";
    student10.lastName = @"last name 10";
    student10.greetings = @"greetings 10";
    
    
    NSString* stud1Dic = [NSString stringWithFormat:@"%@ %@", student1.name, student1.lastName];
    NSString* stud2Dic = [NSString stringWithFormat:@"%@ %@", student2.name, student2.lastName];
    NSString* stud3Dic = [NSString stringWithFormat:@"%@ %@", student3.name, student3.lastName];
    NSString* stud4Dic = [NSString stringWithFormat:@"%@ %@", student4.name, student4.lastName];
    NSString* stud5Dic = [NSString stringWithFormat:@"%@ %@", student5.name, student5.lastName];
    NSString* stud6Dic = [NSString stringWithFormat:@"%@ %@", student6.name, student6.lastName];
    NSString* stud7Dic = [NSString stringWithFormat:@"%@ %@", student7.name, student7.lastName];
    NSString* stud8Dic = [NSString stringWithFormat:@"%@ %@", student8.name, student8.lastName];
    NSString* stud9Dic = [NSString stringWithFormat:@"%@ %@", student9.name, student9.lastName];
    NSString* stud10Dic = [NSString stringWithFormat:@"%@ %@", student10.name, student10.lastName];
    
  
    
    NSDictionary* studentsDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 student1, stud1Dic,
                                 student2, stud2Dic,
                                 student3, stud3Dic,
                                 student4, stud4Dic,
                                 student5, stud5Dic,
                                 student6, stud6Dic,
                                 student7, stud7Dic,
                                 student8, stud8Dic,
                                 student9, stud9Dic,
                                 student10, stud10Dic,
                                 nil];
    
    NSLog(@"%@", studentsDic);
    
    /*
     Уровень Студент.
     
     4. В цикле пройдемся по всем ключам в дикшинари и распечатаем имя и фамилию каждого студента + его фразу приветствия.
     
     */
    
    
    
    for (NSString* key in [studentsDic allKeys]) {
        NSLog(@"%@, %@", key, [[studentsDic objectForKey:key] greetings]);
    }
    
    /*
     Уровень Мастер.
     
     5. Чтобы сделать тоже самое но по какому-то порядку, отсортируйте массив ключей по возрастанию и выведите приветствие каждого студента из дикшинари, но уже по отсортированному списку.
     */
    
    NSLog(@"------------------TASK #5------------------");
    
    NSArray* array = [[studentsDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    for (NSString* obj in array)
    {
        NSLog(@"%@, %@", obj,[[studentsDic objectForKey:obj] greetings]);
    }
    
    return YES;
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
