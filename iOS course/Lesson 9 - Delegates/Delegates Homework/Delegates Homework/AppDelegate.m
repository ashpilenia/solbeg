//
//  AppDelegate.m
//  Delegates Homework
//
//  Created by Alex on 9/15/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "AppDelegate.h"
#import "ASPatient.h"
#import "ASDoctor.h"
#import "ASFriend.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /*
     Ученик:
     
     1. Создать пару пациентов и доктора по тому же принципу что и в видео. (Доктор делегат у пациентов)
     2. У пациента пусть будет температура и другие симптомы, по которым доктор может принимать решение.
     3. У пациента сделайте метод типа стало хуже и пусть когда станет хуже, то он идет к доктору
     4. Всех пациентов объедините в массив и в цикле вызовите метод "стало хуже".
     5. Доктор должен лечить каждого согласно симптомам.

     */
    ASPatient* patient1 = [[ASPatient alloc] init];
    ASPatient* patient2 = [[ASPatient alloc] init];
    ASPatient* patient3 = [[ASPatient alloc] init];
    ASPatient* patient4 = [[ASPatient alloc] init];
    ASPatient* patient5 = [[ASPatient alloc] init];
    
    ASDoctor* doctor1 = [[ASDoctor alloc] init];
    
    patient1.name = @"John";
    patient1.temperature = 36.6f;
    patient1.analysisAreOk = TRUE;
    patient1.delegate = doctor1;
    
    patient2.name = @"Jimmy";
    patient2.temperature = 37.6f;
    patient2.analysisAreOk = TRUE;
    patient2.delegate = doctor1;
    
    patient3.name = @"Mike";
    patient3.temperature = 38.6f;
    patient3.analysisAreOk = FALSE;
    patient3.delegate = doctor1;
    
    patient4.name = @"Nick";
    patient4.temperature = 36.6f;
    patient4.analysisAreOk = FALSE;
    patient4.delegate = doctor1;
    
    patient5.name = @"Michael";
    patient5.temperature = 40.6f;
    patient5.analysisAreOk = TRUE;
    patient5.delegate = doctor1;
    
    
    
    
    NSArray* patientsArray = [NSArray arrayWithObjects:patient1, patient2, patient3, patient4, patient5, nil];
    
    for (ASPatient* obj in patientsArray)
    {
        if ([obj gettingWorse])
        {
            if (obj.temperature >= 37.f && obj.temperature <= 40.f)
            {
                if (obj.analysisAreOk)
                {
                    NSLog(@"Patient %@ is sick", obj.name);
                    [obj firstHelp];
                }
                else
                {
                    NSLog(@"Patient %@ is sick and needs medical assistance", obj.name);
                    [obj urgentHelp];
                }
            }
            else
            {
                if (obj.temperature < 37.f)
                {
                    NSLog(@"Patient %@ is simulant. Call the cops.", obj.name);
                }
                else
                {
                    NSLog(@"Patient %@ is going to die. Move to the next one.", obj.name);
                }
            }
        }
        else
        {
            NSLog(@"Patient %@ is fine.", obj.name);
        }
    }
    
    
    /*
     Студент:
     
     6. Создайте другой класс доктора, не наследника от первого доктора, например друг :)
     7. этот друг должен лечить своих пациентов своими собственными методами и короче плохой он доктор
     8. пусть кто-то ходит к врачу, а кто-то к нему
     9. создайте пару разных объектов класса друг и пусть они лечат своих пациентов (чтобы понять что делегат это не класс, а объект)
     */
    NSLog(@"-----------TASKS 6-9-----------");

    
    ASPatient* patient6 = [[ASPatient alloc] init];
    ASPatient* patient7 = [[ASPatient alloc] init];
    ASPatient* patient8 = [[ASPatient alloc] init];
    ASPatient* patient9 = [[ASPatient alloc] init];
    ASPatient* patient10 = [[ASPatient alloc] init];
    
    ASFriend* friend1 = [[ASFriend alloc] init];
    ASFriend* friend2 = [[ASFriend alloc] init];
    
    patient6.name = @"John";
    patient6.temperature = 36.6f;
    patient6.analysisAreOk = TRUE;
    patient6.delegate = doctor1;
    
    patient7.name = @"Jimmy";
    patient7.temperature = 37.6f;
    patient7.analysisAreOk = TRUE;
    patient7.delegate = friend1;
    
    patient8.name = @"Mike";
    patient8.temperature = 38.6f;
    patient8.analysisAreOk = FALSE;
    patient8.delegate = friend2;
    
    patient9.name = @"Nick";
    patient9.temperature = 36.6f;
    patient9.analysisAreOk = FALSE;
    patient9.delegate = doctor1;
    
    patient10.name = @"Michael";
    patient10.temperature = 40.6f;
    patient10.analysisAreOk = TRUE;
    patient10.delegate = doctor1;
    
    
    
    NSArray* array2 = [NSArray arrayWithObjects:patient6, patient7, patient8, patient9, patient10,  nil];
    
    for (ASPatient* obj in array2)
    {
        if ([obj gettingWorse])
        {
        
            if (obj.temperature >= 37.f && obj.temperature <= 40.f)
            {
                if (obj.analysisAreOk)
                {
                    NSLog(@"Patient %@ is sick", obj.name);
                    [obj firstHelp];
                }
                else
                {
                    NSLog(@"Patient %@ is sick and needs medical assistance", obj.name);
                    [obj urgentHelp];
                }
            }
            else
            {
                if (obj.temperature < 37.f)
                {
                    NSLog(@"Patient %@ is simulant. Call the cops.", obj.name);
                }
                else
                {
                    NSLog(@"Patient %@ is going to die. Move to the next one.", obj.name);
                }
            }
        }
    }
    
    /*
     
     Мастер:
     
     10. Создайте список частей тела в делегате пациента (голова, живот, нога и тд) и когда пациент приходит к врачу, пусть говорит что болит.
     11. Доктор должен принимать во внимание что болит
     12. Создайте у доктора метод "рапорт". Пусть в конце дня, когда все уже нажаловались достаточно, доктор составит рапорт (выдаст имена) тех у кого болит голова, потом тех у кого болел живот и тд

     */
    NSLog(@"-----------TASKS 10-12-----------");
    
    ASPatient* patient11 = [[ASPatient alloc] init];
    ASPatient* patient12 = [[ASPatient alloc] init];
    ASPatient* patient13 = [[ASPatient alloc] init];
    ASPatient* patient14 = [[ASPatient alloc] init];
    ASPatient* patient15 = [[ASPatient alloc] init];
    
    ASDoctor* doctor2 = [[ASDoctor alloc] init];
    
    patient11.name = @"John";
    patient11.temperature = 36.6f;
    patient11.analysisAreOk = TRUE;
    patient11.delegate = doctor1;
    patient11.organ = [patient11 organ];
    
    patient12.name = @"Jimmy";
    patient12.temperature = 37.6f;
    patient12.analysisAreOk = TRUE;
    patient12.delegate = doctor1;
    patient12.organ = [patient12 organ];
    
    patient13.name = @"Mike";
    patient13.temperature = 38.6f;
    patient13.analysisAreOk = FALSE;
    patient13.delegate = doctor1;
    patient13.organ = [patient13 organ];
    
    patient14.name = @"Nick";
    patient14.temperature = 36.6f;
    patient14.analysisAreOk = FALSE;
    patient14.delegate = doctor1;
    patient14.organ = [patient14 organ];
    
    patient15.name = @"Michael";
    patient15.temperature = 40.6f;
    patient15.analysisAreOk = TRUE;
    patient15.delegate = doctor1;
    patient15.organ = [patient15 organ];
    
    NSArray* array3 = [NSArray arrayWithObjects:patient11, patient12, patient13, patient14, patient15, nil];
    
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];

    for (ASPatient* obj in array3)
    {
        if ([obj gettingWorse])
        {
            [dic setObject:[obj formatOrganToString:obj.organ] forKey:obj.name];
            
            if (obj.temperature >= 37.f && obj.temperature <= 40.f)
            {
                if (obj.analysisAreOk)
                {
                    NSLog(@"Patient %@ is sick", obj.name);
                    [obj firstHelpUpd:obj.organ];
                
                }
                else
                {
                    NSLog(@"Patient %@ is sick and needs medical assistance", obj.name);
                    [obj urgentHelpUpd:obj.organ];
                }
            }
            else
            {
                if (obj.temperature < 37.f)
                {
                    NSLog(@"Patient %@ is simulant. Call the cops.", obj.name);
                }
                else
                {
                    NSLog(@"Patient %@ is going to die. Move to the next one.", obj.name);
                }
            }
        }

    }
    NSLog(@"%@", dic); // for test purposes
    
    NSArray* stomachPatients = [dic allKeysForObject:@"Stomach"];
    NSArray* assPatients = [dic allKeysForObject:@"Ass"];
    NSArray* backPatients = [dic allKeysForObject:@"Back"];
    NSArray* headPatients = [dic allKeysForObject:@"Head"];
    
    if ([stomachPatients count] > 0)
    {
        for (int i = 0; i <= [stomachPatients count] - 1; i++)
        {
            NSString* str = [stomachPatients objectAtIndex:i];
            NSLog(@"%@ - Stomach", str);
        }
    }
    
    if ([assPatients count] > 0)
    {
        for (int i = 0; i <= [assPatients count] - 1; i++)
        {
            NSString* str = [assPatients objectAtIndex:i];
            NSLog(@"%@ - Ass", str);
        }
    }
    
    if ([backPatients count] > 0)
    {
        for (int i = 0; i <= [backPatients count] - 1; i++)
        {
            NSString* str = [backPatients objectAtIndex:i];
            NSLog(@"%@ - Back", str);
        }
    }
    
    if ([headPatients count] > 0)
    {
        for (int i = 0; i <= [headPatients count] - 1; i++)
        {
            NSString* str = [headPatients objectAtIndex:i];
            NSLog(@"%@ - Head", str);
        }
    }
    
    /*
     
     Супермен:
     
     13. Создайте в классе пациента проперти - оценка доктору.
     14. Когда доктор вам назначает лечение некоторые пациенты должны стать недовольны.
     15. В конце дня после того как все лечение будет сделано и доктор напишет рапорт, надо пройтись по пациентам и всем недовольным поменять доктора.
     16. Начать новый день и убедиться что Недовольные пациенты таки поменяли доктора.
     
     */
    NSLog(@"-----------TASKS 13-16-----------");
    
    ASPatient* patient16 = [[ASPatient alloc] init];
    ASPatient* patient17 = [[ASPatient alloc] init];
    ASPatient* patient18 = [[ASPatient alloc] init];
    ASPatient* patient19 = [[ASPatient alloc] init];
    ASPatient* patient20 = [[ASPatient alloc] init];
    
    ASDoctor* doctor3 = [[ASDoctor alloc] init];
    ASDoctor* doctor4 = [[ASDoctor alloc] init];
    ASDoctor* doctor5 = [[ASDoctor alloc] init];
    
    
    
    
    patient16.name = @"John";
    patient16.temperature = 36.6f;
    patient16.analysisAreOk = TRUE;
    patient16.delegate = doctor3;
    patient16.organ = [patient16 organ];
    patient16.d_name = @"doctor3";
    
    patient17.name = @"Jimmy";
    patient17.temperature = 37.6f;
    patient17.analysisAreOk = TRUE;
    patient17.delegate = doctor4;
    patient17.organ = [patient17 organ];
    patient17.d_name = @"doctor4";
    
    patient18.name = @"Mike";
    patient18.temperature = 38.6f;
    patient18.analysisAreOk = FALSE;
    patient18.delegate = doctor5;
    patient18.organ = [patient18 organ];
    patient18.d_name = @"doctor5";
    
    patient19.name = @"Nick";
    patient19.temperature = 36.6f;
    patient19.analysisAreOk = FALSE;
    patient19.delegate = doctor3;
    patient19.organ = [patient19 organ];
    patient19.d_name = @"doctor3";
    
    patient20.name = @"Michael";
    patient20.temperature = 40.6f;
    patient20.analysisAreOk = TRUE;
    patient20.delegate = doctor4;
    patient20.organ = [patient20 organ];
    patient20.d_name = @"doctor4";

    NSArray* array4 = [NSArray arrayWithObjects:patient16, patient17, patient18, patient19, patient20, nil];
    
    NSMutableDictionary* dic2 = [[NSMutableDictionary alloc] init];
    
    for (ASPatient* obj in array4)
    {
        if ([obj gettingWorse])
        {
            obj.mark = arc4random() % 2;
            [dic2 setObject:[obj formatOrganToString:obj.organ] forKey:obj.name];
            
            if (obj.temperature >= 37.f && obj.temperature <= 40.f)
            {
                if (obj.analysisAreOk)
                {
                    NSLog(@"Patient %@ is sick", obj.name);
                    [obj firstHelpUpd:obj.organ];
                    
                }
                else
                {
                    NSLog(@"Patient %@ is sick and needs medical assistance", obj.name);
                    [obj urgentHelpUpd:obj.organ];
                }
            }
            else
            {
                if (obj.temperature < 37.f)
                {
                    NSLog(@"Patient %@ is simulant. Call the cops.", obj.name);
                }
                else
                {
                    NSLog(@"Patient %@ is going to die. Move to the next one.", obj.name);
                }
            }
        }
        
    }
    NSLog(@"%@", dic2); // for test purposes
    
    NSArray* stomachPatients2 = [dic2 allKeysForObject:@"Stomach"];
    NSArray* assPatients2 = [dic2 allKeysForObject:@"Ass"];
    NSArray* backPatients2 = [dic2 allKeysForObject:@"Back"];
    NSArray* headPatients2 = [dic2 allKeysForObject:@"Head"];
    
    if ([stomachPatients2 count] > 0)
    {
        for (int i = 0; i <= [stomachPatients2 count] - 1; i++)
        {
            NSString* str = [stomachPatients2 objectAtIndex:i];
            NSLog(@"%@ - Stomach", str);
        }
    }
    
    if ([assPatients2 count] > 0)
    {
        for (int i = 0; i <= [assPatients2 count] - 1; i++)
        {
            NSString* str = [assPatients2 objectAtIndex:i];
            NSLog(@"%@ - Ass", str);
        }
    }
    
    if ([backPatients2 count] > 0)
    {
        for (int i = 0; i <= [backPatients2 count] - 1; i++)
        {
            NSString* str = [backPatients2 objectAtIndex:i];
            NSLog(@"%@ - Back", str);
        }
    }
    
    if ([headPatients2 count] > 0)
    {
        for (int i = 0; i <= [headPatients2 count] - 1; i++)
        {
            NSString* str = [headPatients2 objectAtIndex:i];
            NSLog(@"%@ - Head", str);
        }
    }
    
    for (ASPatient* obj in array4) {
        NSLog(@"name = %@ mark = %u doctor = %@", obj.name, obj.mark, obj.d_name);
        if (obj.mark)
        {
            if (obj.delegate == doctor3)
            {
                obj.delegate = doctor4;
                obj.d_name = @"doctor4";
            }
            if (obj.delegate == doctor4)
            {
                obj.delegate = doctor5;
                obj.d_name = @"doctor5";
            }
            
            if (obj.delegate == doctor5)
            {
                obj.delegate = doctor3;
                obj.d_name = @"doctor3";
            }
            
        }
        
       
    }
    NSLog(@"NEW DAY");
    for (ASPatient* obj in array4)
    {
        NSLog(@"name = %@ doctor = %@", obj.name, obj.d_name );
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
