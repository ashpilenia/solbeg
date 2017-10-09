//
//  AppDelegate.m
//  NSDateHomeWork
//
//  Created by Alex on 10/5/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "AppDelegate.h"
#import "ASStudent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*
     
     Ученик.
     
     1. Создайте класс студент у когторого будет проперти dateOfBirth (дата рождения), которая собственно NSDate.
     2. Инициализируйте NSMutableArray и в цикле создайте 30 студентов.
     3. Каждому установите дату рождения. Возраст рандомный от 16 до 50 лет.
     4. В другом цикле пройдитесь по всему массиву и выведите день рождения каждого студента в адекватном формате.
     
     */
//    1966 2000
    
    NSMutableArray *array = [NSMutableArray array];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM yyyy"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    for (int i = 0; i < 30; i++)
    {
        ASStudent *stud = [[ASStudent alloc] initWithAlias:[NSString stringWithFormat:@"student#%d",i+1]];
        
        
        
        NSDate *date = [NSDate date];
        
       // date = [NSDate dateWithTimeIntervalSinceNow:-100000*i];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
        [components setYear:(arc4random_uniform(2001 - 1967) + 1967)];
        [components setMonth:(arc4random_uniform(12)+1)];
        [components setDay:15];
        
        stud.dateOfBirth = [calendar dateFromComponents:components];
        
        
        [array addObject:stud];
    }
    
    for (ASStudent *obj in array)
    {
        NSLog(@"%@", [formatter stringFromDate:obj.dateOfBirth]);
    }

    /*
     
     Студент.
     
     5. Отсортируйте массив студентов по дате рождения, начиная от самого юного.
     6. Используя массивы имен и фамилий (по 5-10 имен и фамилий), каждому студенту установите случайное имя и случайную фамилию.
     7. Выведите отсортированных студентов: Имя, Фамилия, год рождения

     
     */
  
    [array sortUsingComparator:^NSComparisonResult(ASStudent *obj1, ASStudent *obj2){
    NSComparisonResult result = [obj1.dateOfBirth compare:obj2.dateOfBirth];
        
        return result == NSOrderedAscending;
    }];
    
    NSString *str1 = @"Vasiliy";
    NSString *str2 = @"Vitaliy";
    NSString *str3 = @"Andrey";
    NSString *str4 = @"Nikolai";
    NSString *str5 = @"Alexander";
    NSString *str6 = @"Vadim";
    NSString *str7 = @"Petr";
    NSString *str8 = @"Sergey";
    NSString *str9 = @"Daniil";
    NSString *str10 = @"Alexey";
    
    NSString *str11 =@"Pavlov";
    NSString *str12 =@"Shmavlov";
    NSString *str13 =@"Petrashkevich";
    NSString *str14 =@"Steblin";
    NSString *str15 =@"Bezinson";
    NSString *str16 =@"Ovechkin";
    NSString *str17 =@"Kozlov";
    NSString *str18 =@"Nosov";
    NSString *str19 =@"Popsov";
    NSString *str20 =@"Hrenov";
    
    __block NSArray *nameArray = [NSArray arrayWithObjects:str1, str2, str3, str4, str5, str6, str7, str8, str9, str10, nil];
    NSArray *lastNameArray = [NSArray arrayWithObjects:str11, str12, str13, str14, str15, str16, str17, str18, str19, str20, nil];

    for (ASStudent *obj in array)
    {
        obj.name = [nameArray objectAtIndex:arc4random_uniform(9)];
        obj.lastName = [lastNameArray objectAtIndex:arc4random_uniform(9)];
    }
    
    for (ASStudent *obj in array)
    {
        NSLog(@"%@ %@ %@",obj.lastName, obj.name, [formatter stringFromDate:obj.dateOfBirth]);
    }
    
    /*
     
     Мастер.
     
     10. Создайте таймер в апп делегате, который отсчитывает один день за пол секунды.
     11. Когда таймер доходит до дня рождения любого их студентов - поздравлять его с днем рождения.
     12. Выведите на экран разницу в возрасте между самым молодым и самым старым студентом (количество лет, месяцев, недель и дней)
     
     */
    

//    NSDate *startDate = nil;
//    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitYear startDate:&startDate interval:NULL forDate:[NSDate date]];
//    
//    NSLog(@"%@", startDate);
    NSDateFormatter *daysFormatter = [[NSDateFormatter alloc] init];
    [daysFormatter setDateFormat:@"EEEE"];
    
    NSDateFormatter *sunday = [[NSDateFormatter alloc] init];
    [sunday setDateFormat:@"dd MMM"];
    
    __block NSDate *currentDate = [NSDate date];
    
    
    currentDate = [formatter dateFromString:@"01 Jan 1966"];
    
    
    __block NSInteger *workDays = 0;

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 repeats:self block:^(NSTimer * _Nonnull timer) {
        
        NSDateComponents *currentComponents = [calendar components:
                                                NSCalendarUnitDay |
                                                NSCalendarUnitYear |
                                                NSCalendarUnitMonth |
                                                NSCalendarUnitWeekday
                                                          fromDate:currentDate];
        NSLog(@"%@", currentDate);
        for (ASStudent *obj in array)
        {
            if ([obj.dateOfBirth isEqualToDate:currentDate])
            {
                NSLog(@"%@ %@ was born. Happy Birthday!", obj.name, obj.lastName);
            }
            else {}
        }
        
        
        if (currentComponents.year == 1966)
        {
    
            if (currentComponents.day == 01)
            {
                NSLog(@" %@", [daysFormatter stringFromDate:currentDate]);
            }
         
            
            if (currentComponents.weekday == 01)
            {
                NSLog(@"%@", [sunday stringFromDate:currentDate] );
                
            }
       
            
        }
        else {}
        
        currentDate = [currentDate dateByAddingTimeInterval:86400]; //прибавляю 1 день
        
    }];
    
    [timer setFireDate:[NSDate date]];
    
    NSDate *date1 = [[array objectAtIndex:0] dateOfBirth];
    NSDate *date2 = [[array objectAtIndex:([array count] -1)] dateOfBirth];
    
    NSDateComponents *componentsForComparison = [calendar components:NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth| NSCalendarUnitWeekOfMonth fromDate:date2 toDate:date1 options:0];
    
    NSLog(@"the difference is %ld years, %ld months, %ld weeks and %ld days",componentsForComparison.year, componentsForComparison.month, componentsForComparison.weekOfMonth, componentsForComparison.day);
    

   
    [self performSelector:@selector(timerKiller:) withObject:timer afterDelay:30];
    

    /*
     
     Супермен.
     
     13. Выведите на экран день недели, для каждого первого дня каждого месяца в текущем году (от начала до конца) 
     
     
     --- сделал в таймере, за текущий год взял 1966 чтобы не ждать пока таймер до 2017 дойдет. ---
     
    
     14. Выведите дату (число и месяц) для каждого воскресенья в текущем году (от начала до конца)
     
     --- см. 13п. ---
     
     
     15. Выведите количество рабочих дней для каждого месяца в текущем году (от начала до конца)
     
     */
    
    __block NSDate *dateForWorkDays = [formatter dateFromString:@"01 Jan 2017"];
    
    __block NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    __block NSInteger jan = 0;
    __block NSInteger feb = 0;
    __block NSInteger mar = 0;
    __block NSInteger apr = 0;
    __block NSInteger may = 0;
    __block NSInteger jun = 0;
    __block NSInteger jul = 0;
    __block NSInteger aug = 0;
    __block NSInteger sep = 0;
    __block NSInteger oct = 0;
    __block NSInteger nov = 0;
    __block NSInteger dec = 0;
    
    NSTimer *timerForWorkDays = [NSTimer scheduledTimerWithTimeInterval:0.05 repeats:self block:^(NSTimer * _Nonnull timer) {
        
        NSDateComponents *components = [calendar components: NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday fromDate:dateForWorkDays];
        
        if (components.year == 2017)
        {
            if (components.month == 1)
            {
                if ((components.weekday != 7) & (components.weekday != 1))
                {
                    jan++;
                }
            }
            
            if (components.month == 2)
            {
                if ((components.weekday != 7) & (components.weekday != 1))
                {
                    feb++;
                }
            }
            
            if (components.month == 3)
            {
                if ((components.weekday != 7) & (components.weekday != 1))
                {
                    mar++;
                }
            }
            
            if (components.month == 4)
            {
                if ((components.weekday != 7) & (components.weekday != 1))
                {
                    apr++;
                }
            }
            
            if (components.month == 5)
            {
                if ((components.weekday != 7) & (components.weekday != 1))
                {
                    may++;
                }
            }
            
            if (components.month == 6)
            {
                if ((components.weekday != 7) & (components.weekday != 1))
                {
                    jun++;
                }
            }
            
            if (components.month == 7)
            {
                if ((components.weekday != 7) & (components.weekday != 1))
                {
                    jul++;
                }
            }
            
            if (components.month == 8)
            {
                if ((components.weekday != 7) & (components.weekday != 1))
                {
                    aug++;
                }
            }
            
            if (components.month == 9)
            {
                if ((components.weekday != 7) & (components.weekday != 1))
                {
                    sep++;
                }
            }
            
            if (components.month == 10)
            {
                if ((components.weekday != 7) & (components.weekday != 1))
                {
                    oct++;
                }
            }
            
            if (components.month == 11)
            {
                if ((components.weekday != 7) & (components.weekday != 1))
                {
                    nov++;
                }
            }
            
            if (components.month == 12)
            {
                if ((components.weekday != 7) & (components.weekday != 1))
                {
                    dec++;
                }
            }
        }
        else {}
        
        [dic setObject:[NSNumber numberWithUnsignedInteger:jan] forKey:@"January 2017"];
        [dic setObject:[NSNumber numberWithUnsignedInteger:feb] forKey:@"February 2017"];
        [dic setObject:[NSNumber numberWithUnsignedInteger:mar] forKey:@"March 2017"];
        [dic setObject:[NSNumber numberWithUnsignedInteger:apr] forKey:@"April 2017"];
        [dic setObject:[NSNumber numberWithUnsignedInteger:may] forKey:@"May 2017"];
        [dic setObject:[NSNumber numberWithUnsignedInteger:jun] forKey:@"June 2017"];
        [dic setObject:[NSNumber numberWithUnsignedInteger:jul] forKey:@"July 2017"];
        [dic setObject:[NSNumber numberWithUnsignedInteger:aug] forKey:@"August 2017"];
        [dic setObject:[NSNumber numberWithUnsignedInteger:sep] forKey:@"September 2017"];
        [dic setObject:[NSNumber numberWithUnsignedInteger:oct] forKey:@"October 2017"];
        [dic setObject:[NSNumber numberWithUnsignedInteger:nov] forKey:@"November 2017"];
        [dic setObject:[NSNumber numberWithUnsignedInteger:dec] forKey:@"December 2017"];
        
        
         
        dateForWorkDays = [dateForWorkDays dateByAddingTimeInterval:86400];
        
    }];
    
    
    
    [timerForWorkDays setFireDate:[NSDate dateWithTimeIntervalSinceNow:30]];
    [self performSelector:@selector(timerKiller:) withObject:timerForWorkDays afterDelay:60];
    
    [self performSelector:@selector(numberOfWorkDays:) withObject:dic afterDelay:60];
    
    
    return YES;
}

- (void) timerKiller:(NSTimer *) timerName
{
    [timerName invalidate];
    NSLog(@"A timer has been deactivated.");
}

-(void) numberOfWorkDays:(NSMutableDictionary *) dic
{
    NSLog(@"%@",dic);
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
