//
//  AppDelegate.m
//  BlocksHomeWork
//
//  Created by Alex on 9/25/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "AppDelegate.h"
#import "ASStudent.h"
#import "ASPatient.h"



@interface AppDelegate ()

@property (nonatomic, strong) NSArray *arrayAppDel;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /*
     
     Ученик.
     
     1. В апп делегате создайте блок с без возвращаемой переменной и без параметров и вызовите его.
     2. Создайте блоки с параметрами и передайте туда строку, которую выведите на экран в последствии.
     3. Если вы не определили тип данных для ваших блоков, то сделайте это сейчас и используйте их
     4. Создайте метод который принимает блок и вызывает его и вызовите этот метод.

     Студент.
     5. Создайте класс студент с проперти имя и фамилия.
     6. Создайте в аппделегате 10 разных студентов, пусть у парочки будут одинаковые фамилии.
     7. Поместите всех в массив.
     8. Используя соответствующий метод сортировки массива (с блоком) отсортируйте массив студентов сначала по фамилии, а если они одинаковы то по имени.
     
     Мастер.
     9. Задание из видео. Из урока о делегатах. У пациентов удалите протокол делегат и соответствующее проперти.
     10. Добавьте метод принимающий блок когда им станет плохо.
     11. Блок должен передавать указатель на самого студента ну и на те параметры, которые были в задании по делегатам.
     12. Теперь когда пациентам поплохеет, они должны вызывать блок, а в блоке нужно принимать решения что делать (доктор не нужен делайте все в апп делегате)
     
     Cупермен.
     13. Познайте истинное предназначение блоков :) Пусть пациентам становится плохо не тогда когда вы их вызываете в цикле(это убрать), а через случайное время 5-15 секунд после создания (используйте специальный метод из урока по селекторам в ините пациента).
     14. не забудьте массив пациентов сделать проперти аппделегата, а то все помрут по выходе из функции так и не дождавшись :)
     
     */
    
#pragma mark - Disciple
    //  Ученик
    
    void (^testBlock)(void) = ^(){
    
        NSLog(@"Block with no parameters");
    };
    
    testBlock();
    
    void (^stringBlock)(NSString *) = ^(NSString *testString){
    
        NSLog(@"received string: %@", testString);
    };
    
    stringBlock(@"hello!");
    
    
    NSInteger (^intBlock)(NSInteger) = ^(NSInteger a){
        a = a*2;
       //NSLog(@"%ld", a);
        return a;
    };
    
    
    [self testMethodWIthBlock:intBlock];
    
    
#pragma mark - Student
    // Студент
    
    ASStudent *student1 = [[ASStudent alloc] init];
    ASStudent *student2 = [[ASStudent alloc] init];
    ASStudent *student3 = [[ASStudent alloc] init];
    ASStudent *student4 = [[ASStudent alloc] init];
    ASStudent *student5 = [[ASStudent alloc] init];
    ASStudent *student6 = [[ASStudent alloc] init];
    ASStudent *student7 = [[ASStudent alloc] init];
    ASStudent *student8 = [[ASStudent alloc] init];
    ASStudent *student9 = [[ASStudent alloc] init];
    ASStudent *student10 = [[ASStudent alloc] init];
    
    student1.name = @"Vasya";
    student1.lastName = @"Petrov";
    
    student2.name = @"Semen";
    student2.lastName = @"Petrov";
    
    student3.name = @"Fedor";
    student3.lastName = @"Semenov";
    
    student4.name = @"Anrew";
    student4.lastName = @"Gorodilov";
    
    student5.name = @"Eugene";
    student5.lastName = @"Kovalevskiy";
    
    student6.name = @"Nikolai";
    student6.lastName = @"Krosovskiy";
    
    student7.name = @"Ivan";
    student7.lastName = @"Slatvinskiy";
    
    student8.name = @"Vovan";
    student8.lastName = @"Kovalevskiy";

    
    student9.name = @"Artem";
    student9.lastName = @"Kapustin";
    
    student10.name = @"Alexander";
    student10.lastName = @"Hodik";
    
    
    NSArray *array = [NSArray arrayWithObjects:student1, student2, student3, student4, student5, student6, student7, student8 , student9, student10, nil];
    
    
    NSComparisonResult (^bloclkSorting)(ASStudent *obj1 , ASStudent *obj2) = ^(ASStudent *obj1 , ASStudent *obj2)  {
    
        NSComparisonResult result;
        
        if ([obj1.lastName isEqualToString:obj2.lastName])
        {
            result = [obj1.name compare:(obj2.name)];
            
        }
        else
        {
            result = [obj1.lastName compare:(obj2.lastName)];
        }
        
        
        return result;
    };
    
    array = [array sortedArrayUsingComparator:bloclkSorting];
    
    for (ASStudent *obj in array)
    {
        NSLog(@"last name = %@, name = %@", obj.lastName, obj.name);
    }
    
    
    
#pragma mark - Master
    //Мастер (закомментирован из-за Супермена)
    
    /*
    
    
    
    NSLog(@"-----------------MASTER---------------------");
    
    ASPatient* patient16 = [[ASPatient alloc] init];
    ASPatient* patient17 = [[ASPatient alloc] init];
    ASPatient* patient18 = [[ASPatient alloc] init];
    ASPatient* patient19 = [[ASPatient alloc] init];
    ASPatient* patient20 = [[ASPatient alloc] init];
    
    
    patient16.name = @"John";
    patient16.temperature = 36.6f;
    patient16.analysisAreOk = TRUE;
    patient16.organ = [patient16 organ];

    
    patient17.name = @"Jimmy";
    patient17.temperature = 37.6f;
    patient17.analysisAreOk = TRUE;
    patient17.organ = [patient17 organ];

    
    patient18.name = @"Mike";
    patient18.temperature = 38.6f;
    patient18.analysisAreOk = FALSE;
    patient18.organ = [patient18 organ];

    patient19.name = @"Nick";
    patient19.temperature = 36.6f;
    patient19.analysisAreOk = FALSE;
    patient19.organ = [patient19 organ];
    
    patient20.name = @"Michael";
    patient20.temperature = 40.6f;
    patient20.analysisAreOk = TRUE;
    patient20.organ = [patient20 organ];

    
    NSArray* array4 = [NSArray arrayWithObjects:patient16, patient17, patient18, patient19, patient20, nil];
    
    NSMutableDictionary* dic2 = [[NSMutableDictionary alloc] init];
    
    void (^blockOne)(ASPatient *) = ^(ASPatient *obj){
        
        
        [dic2 setObject:[obj formatOrganToString:obj.organ] forKey:obj.name];
        
        NSLog(@"Healing Block is called for patient %@.", obj.name);
        if (obj.temperature >= 37.f && obj.temperature <= 40.f)
        {
            if (obj.analysisAreOk)
            {
                NSLog(@"Patient %@ needs a pill", obj.name);
                [obj firstHelpUpd:obj.organ];
                
            }
            else
            {
                NSLog(@"Patient %@ needs a shot", obj.name);
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

        
    };
    
    
    
    for (ASPatient *obj in array4)
    {
        if ([obj gettingWorse])
        {
            NSLog(@"sick patient appears");
            [obj blockHealing:blockOne];
        }
        else
        {
            NSLog(@"Patient %@ didn't ask for help", obj.name);
        }
    }
    
    NSArray* stomachPatients2 = [dic2 allKeysForObject:@"Stomach"];
    NSArray* assPatients2 = [dic2 allKeysForObject:@"Ass"];
    NSArray* backPatients2 = [dic2 allKeysForObject:@"Back"];
    NSArray* headPatients2 = [dic2 allKeysForObject:@"Head"];
    
    if ([stomachPatients2 count])
    {
        for (NSString *obj in stomachPatients2)
        {
            NSLog(@"%@ - Stomach", obj);
        }
    }
    
    if ([assPatients2 count])
    {
        for (NSString *obj in assPatients2)
        {
            NSLog(@"%@ - Ass", obj);
        }
    }
    
    if ([backPatients2 count])
    {
        for (NSString *obj in backPatients2)
        {
            NSLog(@"%@ - Back", obj);
        }
    }
    
    if ([headPatients2 count])
    {
        for (NSString *obj in headPatients2)
        {
            NSLog(@"%@ - Head", obj);
        }
    }
    
     */
    
#pragma mark - Superman
    //Супермен
        NSLog(@"-----------------Superman---------------------");
    
    ASPatient* patient16 = [[ASPatient alloc] init];
    ASPatient* patient17 = [[ASPatient alloc] init];
    ASPatient* patient18 = [[ASPatient alloc] init];
    ASPatient* patient19 = [[ASPatient alloc] init];
    ASPatient* patient20 = [[ASPatient alloc] init];
    
    
    patient16.name = @"John";
    patient16.temperature = 36.6f;
    patient16.analysisAreOk = TRUE;
    patient16.organ = [patient16 organ];
    
    
    patient17.name = @"Jimmy";
    patient17.temperature = 37.6f;
    patient17.analysisAreOk = TRUE;
    patient17.organ = [patient17 organ];
    
    
    patient18.name = @"Mike";
    patient18.temperature = 38.6f;
    patient18.analysisAreOk = FALSE;
    patient18.organ = [patient18 organ];
    
    patient19.name = @"Nick";
    patient19.temperature = 36.6f;
    patient19.analysisAreOk = FALSE;
    patient19.organ = [patient19 organ];
    
    patient20.name = @"Michael";
    patient20.temperature = 40.6f;
    patient20.analysisAreOk = TRUE;
    patient20.organ = [patient20 organ];
    
    
    NSArray* array4 = [NSArray arrayWithObjects:patient16, patient17, patient18, patient19, patient20, nil];

    
    self.arrayAppDel = array4;

    
    void (^blockOne)(ASPatient *) = ^(ASPatient *obj){
        
        NSLog(@"Healing Block is called for patient %@.", obj.name);
        if (obj.temperature >= 37.f && obj.temperature <= 40.f)
        {
            if (obj.analysisAreOk)
            {
                NSLog(@"Patient %@ needs a pill", obj.name);
                [obj firstHelpUpd:obj.organ];
                
            }
            else
            {
                NSLog(@"Patient %@ needs a shot", obj.name);
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
        
        
    };
    
    
    
    for (ASPatient *obj in array4)
    {
        if (obj.feelsBad)
        {
            NSLog(@"sick patient appears");
            [obj blockHealing:blockOne];
        }
        else
        {
            NSLog(@"Patient %@ didn't ask for help", obj.name);
        }
    }
    
  
    return YES;
}

void (^blockTwo)(ASPatient *) = ^(ASPatient *obj){

    
    NSLog(@"Healing Block is called for patient %@.", obj.name);
    if (obj.temperature >= 37.f && obj.temperature <= 40.f)
    {
        if (obj.analysisAreOk)
        {
            NSLog(@"Patient %@ needs a pill", obj.name);
            [obj firstHelpUpd:obj.organ];
            
        }
        else
        {
            NSLog(@"Patient %@ needs a shot", obj.name);
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

};



- (void) testMethodWIthBlock:(NSInteger (^)(NSInteger)) testBlockVar
{

    NSLog(@"method with block returns: %ld", testBlockVar(5));
}

- (void) setArrayAppDel:(NSArray *)arrayAppDel
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gettingWorseNotification) name:ASPatientGettingWorseNotifiaction object:nil];
}

- (void) gettingWorseNotification
{
    NSLog(@"one of the patients is getting worse");
    
    for (int i = 0; i <= 4; i++)
    {
    blockTwo([self.arrayAppDel objectAtIndex:i]);
    }
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
