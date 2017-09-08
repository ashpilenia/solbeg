//
//  AppDelegate.m
//  TypesTest
//
//  Created by Alex on 9/6/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "AppDelegate.h"
#import "ASStudent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    BOOL boolVar = TRUE;
    NSInteger intVar = 10;
    NSUInteger intUVar = 11;
    CGFloat floatVar = 1.1f;
    double doubleVar = 100.f;
    
    
    /*
    NSLog(@"bool = %ld int = %ld UInt = %ld float = %f, double = %f", boolVar, intVar, intUVar, floatVar, doubleVar);
    NSLog(@"bool = %ld int = %ld UInt = %ld float = %f, double = %f", sizeof(boolVar), sizeof(intVar), sizeof(intUVar), sizeof(floatVar), sizeof(doubleVar));
    */
    
    ASStudent* studentA = [[ASStudent alloc] init];
    studentA.name = @"Vasiliy";
    NSLog(@"Student A has name = %@", studentA.name );
    
    ASStudent* studentB = studentA;
    
    studentB.name = @"Ne Vasiliy";
    
    NSLog(@"Student A has name = %@", studentA.name);
    
    NSInteger a = 10;
    
    NSLog(@"a = %ld", a);
    
    NSInteger b = a;
    
    b = 5;
    
    NSLog(@"a = %ld, b = %ld", a, b);
    
    NSInteger *c = &a;
    
    *c = 19;
    
    NSLog(@"a = %ld, b = %ld", a, b);
    
    NSInteger d = 0;
    
    NSInteger e = [self test:a testPointer:&d];
    
    NSLog(@"a = %ld, b = %ld, d = %ld, e = %ld", a, b, d, e);
    
    ASStudent* genderStudM = [[ASStudent alloc] init];
    ASStudent* genderStudF = [[ASStudent alloc] init];
    
    genderStudM.gender = Male;
    [genderStudF setGender:(Trans)];
    
    NSLog(@"stud one is %u stud two is %u", genderStudM.gender, genderStudF.gender);
    
    CGRect rectVar;
    CGPoint pointVar;
    CGSize sizeVar;
    
    pointVar.x = 3;
    pointVar.y = 3.5f;
    
    sizeVar = CGSizeMake(5, 5.5f);
   /* sizeVar.height = 5;
    sizeVar.width = 5.5f; */
    
    rectVar.origin = pointVar;
    rectVar.size = sizeVar;
    
    CGPoint pointRandomVar;
    pointRandomVar = CGPointMake(3, 9);
    
    
    BOOL result = CGRectContainsPoint(rectVar, pointRandomVar);
    NSLog(@"Hit on target: %ld", result);
    
    NSNumber* boolVarObj = [[NSNumber alloc] initWithBool:boolVar];
    NSNumber* intVarObj = [[NSNumber alloc] initWithInt:intVar];
    NSNumber* intUVarObj = [[NSNumber alloc] initWithUnsignedInt:intUVar];
    NSNumber* floatVarObj = [[NSNumber alloc] initWithFloat:floatVar];
    NSNumber* doubleVarObj = [[NSNumber alloc] initWithDouble:doubleVar];
    
    NSArray* arrayVar = [NSArray arrayWithObjects:boolVarObj, intVarObj, intUVarObj, floatVarObj, doubleVarObj, nil ];
    
    NSLog(@"bool = %ld int = %ld UInt = %ld float = %f, double = %f",
          [[arrayVar objectAtIndex:0] boolValue],
          [[arrayVar objectAtIndex:1] integerValue],
          [[arrayVar objectAtIndex:2] unsignedIntegerValue],
          [[arrayVar objectAtIndex:3] floatValue],
          [[arrayVar objectAtIndex:4] doubleValue]);
    
    
    CGPoint point1 = CGPointMake(0, 1);
    CGPoint point2 = CGPointMake(1, 2);
    CGPoint point3 = CGPointMake(2, 4);
    CGPoint point4 = CGPointMake(4, 1);
    CGPoint point5 = CGPointMake(5, 3);
    
    NSArray* arrayStruct = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:point1], [NSValue valueWithCGPoint:point2], [NSValue valueWithCGPoint:point3], [NSValue valueWithCGPoint:point4], [NSValue valueWithCGPoint:point5], nil];
    
    for (NSValue* valueVar in arrayStruct) {
        CGPoint p = [valueVar CGPointValue];
        NSLog(@"point = %@", NSStringFromCGPoint(p));
    }
    
    
    
    
    /*
     1. Я очень хочу чтобы вы попрактиковались создавать и использовать enum списки. Они ОЧЕНЬ распространены, они делают код красивее и вносят дополнительную информацию. Это просто очень хорошая практика их использовать! Практикуйтесь! Создайте кучу разных пропертей под разные энумы. Постарайтесь усвоить это сразу.
     */
    
    ASStudent* student13th = [[ASStudent alloc] init];
   
    
    student13th.last_name = Vasilevskiy;
    [student13th setGender:Trans];
    student13th.age = teenager;
    [student13th setRace:black];
    student13th.name = @"John";
    
    NSLog(@"Student #13: %@, %@, %@, %@, %@", student13th.name, [student13th formatLastNameToString:student13th.last_name], [student13th formatGenderToString:[student13th gender]], [student13th formatRaceToString: student13th.race], [student13th formatAgeToString:student13th.age]);
    
    /*
     2. Надо попрактиковаться со структурами. Например такое небольшое задание:
     на поле 10х10 рандомно создайте точек (разберитесь как рандомно генерировать цифры, подсказка - функция arc4random()) и проверяйте какая из точек попадает в квадрат размером 3х3 в самом центре поля. Грубо говоря надо определить какие из точек в массиве попадают в центр и вывести их на печать. Пробуйте и задавайте вопросы.
     3. Разберитесь с оболочками NSNumber и NSValue. На самом деле тут все предельно просто, но вы должны понять саму суть.
     */
    
    CGRect midSquare = CGRectMake(3.5, 3.5, 3, 3);
    
    CGPoint randomPoint1 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint2 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint3 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint4 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint5 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint6 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint7 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint8 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint9 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint10 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint11 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint12 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint13 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint14 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint15 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint16 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint17 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint18 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint19 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    CGPoint randomPoint20 = CGPointMake(arc4random_uniform(10), arc4random_uniform(10));
    
    
    NSArray* pointsArray = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:randomPoint1], [NSValue valueWithCGPoint:randomPoint2], [NSValue valueWithCGPoint:randomPoint3], [NSValue valueWithCGPoint:randomPoint4], [NSValue valueWithCGPoint:randomPoint5], [NSValue valueWithCGPoint:randomPoint6], [NSValue valueWithCGPoint:randomPoint7], [NSValue valueWithCGPoint:randomPoint8], [NSValue valueWithCGPoint:randomPoint9], [NSValue valueWithCGPoint:randomPoint10], [NSValue valueWithCGPoint:randomPoint11], [NSValue valueWithCGPoint:randomPoint12], [NSValue valueWithCGPoint:randomPoint13], [NSValue valueWithCGPoint:randomPoint14], [NSValue valueWithCGPoint:randomPoint15], [NSValue valueWithCGPoint:randomPoint16], [NSValue valueWithCGPoint:randomPoint17], [NSValue valueWithCGPoint:randomPoint18], [NSValue valueWithCGPoint:randomPoint19], [NSValue valueWithCGPoint:randomPoint20],  nil];
    
    for (int i = 0; i <= ([pointsArray count] - 1); i++) {
        NSValue *point = [pointsArray objectAtIndex:i];
        CGPoint convertPoint = [point CGPointValue];
        bool result = CGRectContainsPoint(midSquare, convertPoint);
        NSLog(@"Point# %ld : Hit on target result: %ld", i+1,result);
    }
   
    


    return YES;
}

-(NSInteger) test:(NSInteger) var1 testPointer:(NSInteger*) testPointer{
    *testPointer = 199;
    return var1;
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
