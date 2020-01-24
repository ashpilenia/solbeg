//
//  AppDelegate.m
//  TricksTest
//
//  Created by Alex Shpilenia on 10/9/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "AppDelegate.h"
#import "ASUtils.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
#ifdef PROJECT_A
    [[UIButton appearance] setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
#elif PROJECT_B
    [[UIButton appearance] setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
#endif
    
    return YES;
}


@end
