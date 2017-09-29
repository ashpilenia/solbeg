//
//  AppDelegate.m
//  ThreadsHomeWork
//
//  Created by Alex on 9/28/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "AppDelegate.h"
#import "ASStudent.h"
#import "ASStudentOperation.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*
    Ученик.
    
    1. Создайте класс студент. У него должен быть метод - угадать ответ :)
    2. В метод передается случайное целое число например в диапазоне от 0 - 100 (или больше) и сам диапазон, чтобы студент знал где угадывать
    3. Студент генерирует случайное число в том же диапазоне пока оно не будет искомым
    4. Весь процесс угадывания реализуется в потоке в классе студент
    5. Когда студент досчитал то пусть пишет в НСЛог
    6. Создайте 5 студентов и дайте им одну и туже задачу и посмотрите кто справился с ней лучше
     
     
     Студент.
     
     7. Задача та же, но вместе с условием передавайте студенту блок, в котором вы и объявите результаты
     8. Блок должен определяться в томже классе, где и определялись студенты
     9. Блок должен быть вызван на главном потоке
     
     
     Мастер.
     
     10. Создать приватный метод класса (да да, приватный метод да еще и с плюсом), который будет возвращать статическую (то есть одну на все объекты класса студент) dispatch_queue_t, которая инициализируется при первом обращении к этому методу.
     11. Лучше в этом методе реализовать блок dispatch_once, ищите в инете как и зачем :) А что, программист всегда что-то ищет и хороший программист всегда находит.
     12. Все студенты должны выполнять свои процессы в этой queue и она должна быть CONCURRENT, типа все блоки одновременно выполняются
     
     
     Супермен.
     
     13. Добавьте еще один класс студента, который делает все тоже самое что вы реализовали до этого, только вместо GCD он использует NSOperation и NSOperationQueue. Вообще вынос мозга в самостоятельной работе :)
     14. Все сделавшие Мастера и Супермена и с красивым кодом получают отдельный огромный РЕСПЕКТ, так как они это на самом деле заслуживают.
     
    */
    
    
    ASStudent *student1 = [[ASStudent alloc] init];
    ASStudent *student2 = [[ASStudent alloc] init];
    ASStudent *student3 = [[ASStudent alloc] init];
    ASStudent *student4 = [[ASStudent alloc] init];
    ASStudent *student5 = [[ASStudent alloc] init];
    
    student1.name = @"student1";
    student2.name = @"student2";
    student3.name = @"student3";
    student4.name = @"student4";
    student5.name = @"student5";
    
    NSArray *studentsArray = [[NSArray alloc] initWithObjects:student1, student2, student3, student4, student5, nil];
    
    for (ASStudent *obj in studentsArray)
    {
        [obj guessAnswer:322 lowerBound:0 higherBound:10000000 innerBlock:^{
        
            dispatch_async(dispatch_get_main_queue(),^{
                NSLog(@"%@ has finished in %f", obj.name, obj.durationP);
            });
        }];
    }
    
    ASStudentOperation *studOp1 = [[ASStudentOperation alloc] init];
    ASStudentOperation *studOp2 = [[ASStudentOperation alloc] init];
    ASStudentOperation *studOp3 = [[ASStudentOperation alloc] init];
    ASStudentOperation *studOp4 = [[ASStudentOperation alloc] init];
    ASStudentOperation *studOp5 = [[ASStudentOperation alloc] init];
    
    studOp1.name = @"studOp1";
    studOp2.name = @"studOp2";
    studOp3.name = @"studOp3";
    studOp4.name = @"studOp4";
    studOp5.name = @"studOp5";
    
    NSArray *studOpsArray = [NSArray arrayWithObjects:studOp1, studOp2, studOp3, studOp4, studOp5, nil];
    
    for (ASStudentOperation *obj in studOpsArray)
    {
        [obj guessNumberUsingOperations:228 lowerBound:0 higherBound:10000000 innerBlock:^{
            
            [NSOperationQueue mainQueue];
            NSLog(@"%@ has finished in %f", obj.name, obj.durationOp);
            
        }];
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
