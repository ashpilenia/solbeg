//
//  AppDelegate.m
//  BlocksTest
//
//  Created by Alex on 9/22/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "AppDelegate.h"
#import "ASObject.h"


typedef void (^OutTestBlock) (void);
@interface AppDelegate ()

@property (nonatomic, copy) OutTestBlock testBlockP;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    void (^testBlockWithParams) (NSString *, NSInteger);
    
    testBlockWithParams = ^(NSString * string, NSInteger intValue){
        
        NSLog(@"testBlockWithParams %@ %ld",string, intValue);
    };
    
    testBlockWithParams(@"asd",123);
    
    __block NSString *testString = @"How is it possible?";
    
    __block NSInteger i = 0;
    
     void (^testBlock)(void) = ^(){
        
        NSLog(@"test block");
        
        i = i +1;
        testString = [NSString stringWithFormat:@"How it is possible ? %ld", i];
        
        NSLog(@"%@", testString);
    };
    
    testBlock();
    testBlock();
    testBlock();
    testBlock();
    
    [self testBlocksMethod:^{
        NSLog(@"block!!!");
    }];
    
    NSComparisonResult (^bbb) (id, id) = ^(id obj1, id obj2){
    
        return NSOrderedAscending;
    };
    
    NSArray *array = nil;
    
    array = [array sortedArrayUsingComparator:bbb];
    
   
    
    
    
    ASObject* obj = [[ASObject alloc] init];
    
    obj.name = @"Name";
    
    OutTestBlock testBlock228 = ^{
        NSLog(@"type def Block %@", obj.name);
    };
    [self testBlocksMethod:testBlock228];
    
    self.testBlockP = testBlock228; 
    
    
    return YES;
}

- (void) testMethodWithParams:(NSString *) string value:(NSInteger) intValue
{
    NSLog(@"testMethodWithParams %@ %ld", string, intValue);
}

- (NSString *) testReturnValueAndParam:(NSString *) string value:(NSInteger) intValue
{
    return [NSString stringWithFormat:@"testReturnValueAndParam %@ %ld", string, intValue];
}

- (void) testBlocksMethod:(void (^)(void)) testBlock28
{
    NSLog(@"testBlockMethod");
    testBlock28();
    
}

- (void) testTypeDefBlock:(OutTestBlock) testBlockVar{
    
    testBlockVar();

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
