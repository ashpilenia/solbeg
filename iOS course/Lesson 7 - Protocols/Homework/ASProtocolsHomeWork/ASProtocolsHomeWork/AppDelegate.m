//
//  AppDelegate.m
//  ASProtocolsHomeWork
//
//  Created by Alex on 9/11/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "AppDelegate.h"
#import "ASJumpers.h"
#import "ASRunners.h"
#import "ASSwimmers.h"
#import "ASAnimal.h"
#import "ASCyclist.h"
#import "ASHuman.h"
#import "ASRat.h"
#import "ASRunner.h"
#import "ASSchoolboy.h"
#import "ASSnake.h"
#import "ASSwimmer.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*
    1. Реализуйте протоколы Jumpers, Swimmers, Runners. Каждый протокол должен иметь пару свойств, например скорость или максимальная высота прыжка и пару методов, например прыгать или плыть, нырять и тд. Включите фантазию!!!
     
    2. Часть методов делайте обязательными (например у пловцов обязательный метод это плыть а у бегунов - бежать, логично?), а другую часть не обязательными. 
    
    3. Используйте классы из задания про массивы, там где у вас люди и животные. Например у кенгуру и у особых спортсменов реализуйте протокол Jumpers, тоже самое с другими протоколами. Пусть каждый протокол будет реализован как некоторыми классами животных, так и некоторыми классами людей.
     
    4. Положите всех в одни массив. Тех кто прыгает заставьте прыгать и рассказывать про свои свойства. Причем у некоторых объектов пусть будут одни необязательные свойства или методы, а у других другие. Тот кто бегает пусть бегает, а тот кто плавает, пусть плавает. Тот кто ничего не делает должен быть выведен на экран как лодырь :)
     
    5. Сделайте так чтобы один какой-то класс мог и бегать и прыгать и плавать и посмотрите как он себя поведет в цикле.
    */
    
    
    /* !!! Чтобы было проще разобраться, что тут к чему относится, я сделал схемку. Закинул ее сюда: solbeg/iOS course/Lesson 7 - Protocols/Homework/ASProtocolsHomeWork/ASProtocolsHomeWork/Media.xcassets/Scheme.imageset/schema.pdf
       !!!
    */
    
    ASAnimal* animal = [[ASAnimal alloc] init];
    ASSnake* snake = [[ASSnake alloc] init];
    ASRat* rat = [[ASRat alloc] init];
    
    ASHuman* human = [[ASHuman alloc] init];
    ASSwimmer* swimmer = [[ASSwimmer alloc] init];
    ASRunner* runner = [[ASRunner alloc] init];
    ASCyclist* cyclist = [[ASCyclist alloc] init];
    ASSchoolboy* boy = [[ASSchoolboy alloc] init];
    
    animal.p_name = @"Bob";
    animal.speed = 21.f;
    
    snake.p_name = @"Anakonda";
    snake.p_height = 10;
    
    rat.p_name = @"Jerry";
    rat.age = 70;
    
    human.p_name = @"Andrew";
    human.p_height = 2;
    human.balance = NO;
    
    swimmer.p_name = @"Carl";
    swimmer.age = 21;
    [swimmer setStyle:Butterfly];
    
    cyclist.p_name = @"Michael";
    cyclist.speed = 62.2f;
    cyclist.distance = 250;
    
    
    
    
    NSArray* array = [NSArray arrayWithObjects:animal, snake, rat, human, swimmer, runner, cyclist, boy, nil];
    
    for ( int i = 0; i <= [array count] - 1; i++)
    {
        id <ASJumpers> obj = [array objectAtIndex:i];
        if ( [obj conformsToProtocol:@protocol(ASJumpers)])
        {
            
            NSLog(@"jump height is %ld. Jumper's name is%@", obj.p_height, obj.p_name);
            [obj jumping];
            [obj numberOfTries];
            if ([obj respondsToSelector:@selector(landing)])
            {
                [obj landing];
            }
        }
        
        id <ASSwimmers> obj2 = [array objectAtIndex:i];
        if ([obj2 conformsToProtocol:@protocol(ASSwimmers)])
        {
            NSLog(@"name = %@, age = %ld", obj2.p_name, obj2.age);
            [obj2 swimming];
            [obj2 distance];
            if ([obj2 respondsToSelector:@selector(technique)])
            {
                [obj2 technique];
            }
        }
        id <ASRunners> obj3 = [array objectAtIndex:i];
        if ([obj3 conformsToProtocol:@protocol(ASRunners)])
        {
            NSLog(@"name = %@, speed = %f", obj3.p_name, obj3.speed);
            [obj3 speed];
            [obj3 record];
            if ([obj3 respondsToSelector:@selector(averageSpeed)])
            {
                [obj3 averageSpeed];
            }
        }
        else
        {
            NSLog(@"Useless instance");
        }
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
