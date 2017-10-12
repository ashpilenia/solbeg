//
//  ASAppDelegate.m
//  SelectorsTest
//
//  Created by Oleksii Skutarenko on 22.10.13.
//  Copyright (c) 2013 Alex Skutarenko. All rights reserved.
//

#import "ASAppDelegate.h"
#import "ASObject.h"

@implementation ASAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    ASObject* obj = [[ASObject alloc] init];
    
    SEL selector1 = @selector(testMethod);
    SEL selector2 = @selector(testMethod:);
    SEL selector3 = @selector(testMethod:parameter2:);
    
    [self performSelector:selector1];
    [obj performSelector:selector1];
    
    NSString* secret = [obj performSelector:@selector(superSecretTextx)];
    
    NSLog(@"secret = %@", secret);
    
    [self performSelector:selector2 withObject:@"test string"];
    [self performSelector:selector3 withObject:@"string1" withObject:@"string2"];
    [self performSelector:selector1 withObject:nil afterDelay:5.f];
    
    //NSString* a = NSStringFromSelector(selector1);
    //SEL sel = NSSelectorFromString(a);
    
    
    //NSString* string = [self testMethodParameter1:2 parameter2:3.1f parameter3:5.5f];
    //NSLog(@"string = %@", string);
    
    /*
    SEL selector = @selector(testMethodParameter1:parameter2:parameter3:);
    
    NSMethodSignature* signature = [ASAppDelegate instanceMethodSignatureForSelector:selector];
    
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    [invocation setTarget:self];
    [invocation setSelector:selector];
    
    NSInteger iVal = 2;
    CGFloat fVal = 3.1f;
    double dVal = 5.5f;
    
    NSInteger * p1 = &iVal;
    CGFloat * p2 = &fVal;
    double * p3 = &dVal;
    
    [invocation setArgument:p1 atIndex:2];
    [invocation setArgument:p2 atIndex:3];
    [invocation setArgument:p3 atIndex:4];
    
    [invocation invoke];
    
    __unsafe_unretained NSString* string = nil;
    [invocation getReturnValue:&string];
    NSLog(@"string = %@", string);
     */
    
    return YES;
}


- (void) testMethod {
    NSLog(@"testMethod");
}

- (void) testMethod:(NSString*) string {
    NSLog(@"testMethod: %@", string);
}

- (void) testMethod:(NSString*) string parameter2:(NSString*) string2 {
    NSLog(@"testMethod:parameter2: %@, %@", string, string2);
}

- (NSString*) testMethodParameter1:(NSInteger) intValue parameter2:(CGFloat) floatValue parameter3:(double) doubleValue {
    
    return [NSString stringWithFormat:@"testMethodParameter1: %d parameter2: %f parameter3: %f", intValue, floatValue, doubleValue];
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
