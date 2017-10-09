//
//  AppDelegate.m
//  NSDateTest
//
//  Created by Alex on 10/4/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSDate *date1 = [NSDate date];
    
    NSLog(@"%@", date1);
    
    NSDate *d2 = [date1 dateByAddingTimeInterval:5000];
    
    NSDate *d3 = [date1 dateByAddingTimeInterval:50050];
    
    NSDate *d4 = [date1 dateByAddingTimeInterval:-50050];
    
    NSLog(@"%@", [date1 dateByAddingTimeInterval:-5555] );
    NSLog(@"%@", d2);
   
    NSArray *array = [[NSArray alloc] initWithObjects:date1, d2, d3, d4, nil];
    
    NSLog(@"-------------------");
    for (NSDate *dateObj in array)
    {
        NSLog(@"%@", dateObj);
    }
  
    [date1 earlierDate:d2];
    [date1 timeIntervalSinceReferenceDate];
 
    NSDate *d5 = [NSDate dateWithTimeIntervalSinceNow:5];
    
    NSLog(@"%@", d5);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterShortStyle];
    NSLog(@"%@", [formatter stringFromDate:d5]);
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    NSLog(@"%@", [formatter stringFromDate:d5]);
    
    [formatter setDateStyle:NSDateFormatterLongStyle];
    NSLog(@"%@", [formatter stringFromDate:d5]);
    
    [formatter setDateStyle:NSDateFormatterFullStyle];
    NSLog(@"%@", [formatter stringFromDate:d5]);
    
    [formatter  setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSLog(@"%@", [formatter stringFromDate:d5]);
    
    NSString *string = @"2008/10/06 22:45";
    NSDate *d6 = [formatter dateFromString:string];
    NSLog(@"%@", d6);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int year = [@"2013" intValue];
    NSLog(@"%d", year);
    
    NSDateComponents *components = [calendar components:NSCalendarUnitEra |
                                                        NSCalendarUnitYear |
                                                        NSCalendarUnitMonth |
                                                        NSCalendarUnitDay |
                                                        NSCalendarUnitHour |
                                                        NSCalendarUnitMinute|
                                                        NSCalendarUnitSecond |
                                                        NSCalendarUnitWeekday |
                                                        NSCalendarUnitWeekdayOrdinal
                                                           fromDate:d6  ];

    NSInteger hourVar = [components hour];
    NSLog(@"%ld", hourVar);
    
    NSDateComponents *components2 = [calendar components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute
                                                fromDate:d6
                                                  toDate:d5
                                                 options:0];
    NSLog(@"%@",components2);
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTest:) userInfo:nil repeats:YES];
    
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:5]];
    
    return YES;
}

- (void) timerTest:(NSTimer *) timer
{
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"HH:mm:ss:SSS"];
    NSLog(@"%@", [formatter2 stringFromDate:[NSDate date]]);
    
    [timer invalidate];
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
