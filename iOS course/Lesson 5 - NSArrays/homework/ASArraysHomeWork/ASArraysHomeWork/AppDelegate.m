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


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ASHuman* humanObj = [[ASHuman alloc] init];
    ASCyclist* cyclistObj = [[ASCyclist alloc] init];
    ASRunner* runnerObj = [[ASRunner alloc] init];
    ASSwimmer* swimmerObj = [[ASSwimmer alloc] init];
    
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
    
    
    NSArray* array = [[NSArray alloc] initWithObjects:humanObj, cyclistObj, runnerObj, swimmerObj, nil];
    for (ASHuman* obj in array) {
        NSLog(@"name = %@ gender = %@ weight = %lf height = %ld", obj.name, obj.gender, obj.weight, obj.height);
        /*NSLog(@"gender =%@", obj.gender);
        NSLog(@"height =%ld", obj.height);
        NSLog(@"weight =%lf", obj.weight);
        */
        [obj movement];
        
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
