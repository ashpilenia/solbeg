//
//  AppDelegate.m
//  BitsTest
//
//  Created by Alex on 10/3/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "AppDelegate.h"
#import "ASStudent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ASStudent *student = [[ASStudent alloc] init];
    /*
    student.anatomy = YES;
    student.development = YES;
    student.engineering = YES;
    student.math = YES;
    student.psychology = NO;
    student.art = NO;
    student.biology = NO;
    */
    
    student.subjectType =   ASStudentSubjectTypeAnatomy | ASStudentSubjectTypeDevelopment |
                            ASStudentSubjectTypeEngineering | ASStudentSubjectTypeMath;
    NSLog(@"%@", student);
    
    /*
     
     Ученик.
     
     1. Повторите мой код и создайте класс студент с соответствующим набором предметов
     2. В цикле создайте 10 студентов и добавьте их в массив. Используйте мутабл массив
     3. У каждого рандомно установите предметы
     
     */
    
    NSLog(@"---------LEARNER----------");
    
    NSMutableArray *array = [NSMutableArray array];

    for (int i = 0; i < 10; i++)
    {
        ASStudent *student = [[ASStudent alloc] initWithAlias:[NSString stringWithFormat:@"student%d", i]];
        
        [array addObject:student];
        //student.subjectType = arc4random_uniform(6) | arc4random_uniform(6) | arc4random_uniform(6) | arc4random_uniform(6);
        student.subjectType =
        arc4random_uniform(ASStudentSubjectTypeAll);
                               
                               //(2^(arc4random_uniform(6))) | (2^(arc4random_uniform(6))) | (2^(arc4random_uniform(6))) | (2^(arc4random_uniform(6)));
        NSLog(@"%@", student);
                               
    }
    
    /*
     
     Студент
     
     4. В новом цикле пройдитесь по студентам и разделите их уже на два массива - технари и гуманитарии.
     5. Также посчитайте количество тех кто учит программирование
     
     */
    
    NSLog(@"-------STUDENT--------");
    
    NSMutableArray *techLads = [NSMutableArray array];
    NSMutableArray *blablaLads = [NSMutableArray array];
    
    NSInteger devCountNumber = 0;
    
    for (ASStudent *student in array)
    {
        NSInteger countTechSubjects = 0;
        NSInteger countBlaBlaSubjects = 0;
        
        
        if (student.subjectType & ASStudentSubjectTypeBiology)
        {
            countBlaBlaSubjects++;
        }
        if (student.subjectType & ASStudentSubjectTypeArt)
        {
            countBlaBlaSubjects++;
        }
        if (student.subjectType & ASStudentSubjectTypePsychology)
        {
            countBlaBlaSubjects++;
        }
        if (student.subjectType & ASStudentSubjectTypeAnatomy)
        {
            countBlaBlaSubjects++;
        }
        if (student.subjectType & ASStudentSubjectTypeMath)
        {
            countTechSubjects++;
        }
        if (student.subjectType & ASStudentSubjectTypeDevelopment)
        {
            countTechSubjects++;
            devCountNumber++;
        }
        if (student.subjectType & ASStudentSubjectTypeEngineering)
        {
            countTechSubjects++;
        }
        
        if (countBlaBlaSubjects <= countTechSubjects)
        {
            [techLads addObject:student];
        }
        
        if (countBlaBlaSubjects > countTechSubjects)
        {
            [blablaLads addObject:student];
        }
    }
    
    
    for (ASStudent *stud in techLads)
    {
        NSLog(@"TECH STUD %@ studies %@ ", stud.alias, stud);
    }
    
    for (ASStudent *stud in blablaLads)
    {
        NSLog(@"BLABLA STUD %@ studies %@ ", stud.alias, stud);
    }
    
    NSLog(@"Number of students who learns development = %ld", devCountNumber);
    
    /*
     
     Мастер.
     
     6. Если студенты выбрали биологию, то отмените ее у них и выведите сообщение в лог, предмет отменен
     7. Тут придется разобраться как сбросить бит, включите логику :)
     
     */
    NSLog(@"--------MASTER----------");
    
    for (ASStudent *stud in array)
    {
        if (stud.subjectType & ASStudentSubjectTypeBiology)
        {
            NSInteger newBit = ~ASStudentSubjectTypeBiology;
            stud.subjectType = stud.subjectType & newBit;
            NSLog(@"Biology subject has been canceled for %@.", stud.alias);
        }
    }
    
    for (ASStudent *stud in array)
    {
        NSLog(@"%@", stud); // для того чтобы удостовериться что биология стала = NO;
    }
    
    /*
     
     Супермен.
     8. Сгенерируйте случайный интежер в диапазоне от 0 до максимума.
     9. Используя цикл и битовые операыии (и возможно NSMutableString) выведите это число на экран в двоичном виде
     
     */
    
    NSLog(@"-------------SUPERMAN-------------");
    
    NSInteger a = arc4random();
    
    NSString *binaryRepresentation = [ASStudent numberConvertToBinary:a];
    
    
    NSLog(@"number %ld has binary representation of %@",a , binaryRepresentation);
    
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
