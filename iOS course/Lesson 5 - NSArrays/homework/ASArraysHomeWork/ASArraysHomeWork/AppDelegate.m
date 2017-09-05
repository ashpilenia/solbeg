//
//  AppDelegate.m
//  ASArraysHomeWork
//
//  Created by Alex on 9/4/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//


#import "AppDelegate.h"
#import "ASHuman.h"
#import "ASSwimmer.h"
#import "ASRunner.h"
#import "ASCyclist.h"
#import "ASSchoolboy.h"
#import "ASAnimal.h"
#import "ASRat.h"
#import "ASSnake.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*
     1. Создать класс "человек", который будет содержать в себе базовые качества - "имя", "рост", "вес", "пол", а также будет иметь метод "передвижение".
     2. Создать дочерние классы (наследники) "велосипедист", "бегун", "пловец" и переопределить метод "передвижение" в каждом из этих классов.
     3. При старте программы создать по одному объекту каждого класса и объединить их в массив.
     4. В цикле пройти по всем элементам массива и вывести на экран все характеристики каждого объекта (имя, рост и тд) и у каждого вызвать метод "передвижение".
     5. Создать еще одного наследника от класса человек, добавить в него пару новых свойств, добавить в массив и в цикле вывода вывести его свойства как дополнение к свойствам человека
     6. Метод "передвижение" реализовать таким образом, чтобы перед тем как выполнить свое собственное передвижение, он выполнял передвижение реализованное в классе человек
     7. Массив выводить в обратном порядке.
     
     */

    
    ASHuman* humanObj = [[ASHuman alloc] init];
    ASCyclist* cyclistObj = [[ASCyclist alloc] init];
    ASRunner* runnerObj = [[ASRunner alloc] init];
    ASSwimmer* swimmerObj = [[ASSwimmer alloc] init];
    ASSchoolboy* schBoyObj =[[ASSchoolboy alloc]init];
    
    humanObj.height = 180;
    humanObj.weight = 82.2f;
    humanObj.name = @"Vasiliy 'The Human'";
    humanObj.gender = @"male";
   
    runnerObj.height = 150;
    runnerObj.weight = 182.2f;
    runnerObj.name = @"Marry 'MCDolands'";
    runnerObj.gender = @"female";
    
    swimmerObj.height = 100;
    swimmerObj.weight = 40.2f;
    swimmerObj.name = @"Eugene";
    swimmerObj.gender = @"transgender";
    
    cyclistObj.height = 166;
    cyclistObj.weight = 66.2f;
    cyclistObj.name = @"Michael Sch.";
    cyclistObj.gender = @"male";
    
    schBoyObj.height = 120;
    schBoyObj.weight = 66.2f;
    schBoyObj.name = @"Petrashkevich";
    schBoyObj.gender = @"male";
    schBoyObj.grade = 3;
    schBoyObj.shift = @"second";

    
    NSArray* array = [[NSArray alloc] initWithObjects:humanObj, cyclistObj, runnerObj, swimmerObj, schBoyObj,  nil];
    for (ASHuman* obj in array) {
        NSLog(@"name = %@, gender = %@, weight = %lf, height = %ld", obj.name, obj.gender, obj.weight, obj.height);
        
        
        if ([obj isKindOfClass:[ASSchoolboy class]]){
            ASSchoolboy* boy = (ASSchoolboy*) obj;
            NSLog(@"grade =%ld, shift =%@", boy.grade, boy.shift);
        }
    }
    
     /* for (int i = [array count] -1; i >= 0; i--) {
        ASHuman* obj = [array objectAtIndex:i];
        NSLog(@"name = %@, gender = %@, weight = %lf, height = %ld", obj.name, obj.gender, obj.weight, obj.height);
        
        if ([obj isKindOfClass:[ASSchoolboy class]]) {
            ASSchoolboy* boy = (ASSchoolboy*) obj;
            NSLog(@"grade =%ld, shift =%@", boy.grade, boy.shift);
        
        }
        */
        //[obj movement];
     
        
/*
 8. Создать класс "животное" (не наследник класса человек!) со своими собственными базовыми свойствами (отличными от человеческих) и методом "передвижение".
 9. Унаследоваться от него и создать пару других классов с переопределенным передвижением.
 10. Объединить всех людей и животных в один массив.
 11. В цикле выводить тип объекта (человек или животное) перед тем как выводить его свойства и вызывать метод
 
 */
        NSLog(@"--------------8 to 11---------------");
        
        ASAnimal* animalObj = [[ASAnimal alloc] init];
        ASSnake* snakeObj = [[ASSnake alloc] init];
        ASRat* ratObj = [[ASRat alloc] init];
        
        animalObj.a_name = @"monkey";
        animalObj.age = 10;
        animalObj.a_gender = @"female";
        
        snakeObj.a_name = @"cobra";
        snakeObj.age = 3;
        snakeObj.a_gender = @"male";
        
        ratObj.a_name = @"white rat";
        ratObj.age = 1;
        ratObj.a_gender = @"female";
        
        
        
        NSArray* mergedArray = [[NSArray alloc] initWithObjects:humanObj, schBoyObj, cyclistObj, runnerObj, swimmerObj, animalObj, ratObj, snakeObj, nil];
        
        for (NSObject* obj in mergedArray) {
        
            if ([obj isKindOfClass: [ASHuman  class]])
            {
                NSLog(@"Object Type = Human");
                ASHuman* human = (ASHuman*) obj;
            NSLog(@"name = %@, gender = %@, weight = %lf, height = %ld", human.name, human.gender, human.weight, human.height);
                [human movement];
                
                if ([obj isKindOfClass: [ASSchoolboy class]])
                {
                    ASSchoolboy* boy = (ASSchoolboy*) obj;
                    NSLog(@"grade =%ld, shift =%@", boy.grade, boy.shift);
                }
                
            }
            else
            {
                NSLog(@"Object Type = Animal");
                ASAnimal* animal = (ASAnimal*) obj;
                NSLog(@"name = %@, gender = %@, age = %ld", animal.a_name, animal.a_gender, animal.age);
                [animal movement];
            }
            
        }
            
    /*
     12. Поместить всех людей в один массив, а животных в другой массив (количество людей и животных должно быть разное)
     13. В одном цикле выводить сначала человека а потом животное, доставая данные поочередно из двух разных массивов, если в одном из массивов объектов больше, то в конце должны выводиться только объекты этого массива (так как других уже нет)
     */
    
    NSLog(@"--------------------12 to 13---------------------");
    
    NSArray* animalArray = [[NSArray alloc] initWithObjects: animalObj, ratObj, snakeObj, nil];
    
    NSInteger maxCount = 0;
    
    if ([array count] > [animalArray count])
    {
        maxCount = [array count];
    }

    else
    {
        maxCount = [animalArray count];
    }
    
    for (int i = 0; i < maxCount; i++)
    {
        if (i <= ([array count] -1 ))
        {
        ASHuman* humObj = [array objectAtIndex:i];
        NSLog(@"name = %@, gender = %@, weight = %lf, height = %ld", humObj.name, humObj.gender, humObj.weight, humObj.height);
        [humObj movement];
        
        if ([humObj isKindOfClass: [ASSchoolboy class]])
          {
            ASSchoolboy* boy = (ASSchoolboy*) humObj;
            NSLog(@"grade =%ld, shift =%@", boy.grade, boy.shift);
          }
        }
        
        if (i <= ([animalArray count] -1 ))
        {
        ASAnimal* aniObj = [animalArray objectAtIndex:i];
        NSLog(@"name = %@, gender = %@, age = %ld", aniObj.a_name, aniObj.a_gender, aniObj.age);
        [aniObj movement];
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
