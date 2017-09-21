//
//  ASAppNotification.m
//  NotificationsTest
//
//  Created by Alex on 9/21/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASAppNotification.h"
#import <UIKit/UIKit.h>

@implementation ASAppNotification

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        [nc addObserver:self
               selector:@selector(willResignActiveNotification)
                   name:UIApplicationWillResignActiveNotification
                 object:nil];
        
        [nc addObserver:self
               selector:@selector(enteredBackgroundNotification)
                   name:UIApplicationDidEnterBackgroundNotification
                 object:nil];
        
        [nc addObserver:self
               selector:@selector(enteredForegroundNotification)
                   name:UIApplicationWillEnterForegroundNotification
                 object:nil];
        
        [nc addObserver:self
               selector:@selector(becameActiveNotification)
                   name:UIApplicationDidBecomeActiveNotification
                 object:nil];
 
        [nc addObserver:self
               selector:@selector(WillTerminateNotification)
                   name:UIApplicationWillTerminateNotification
                 object:nil];

        
    }
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) willResignActiveNotification
{
    NSLog(@"UIApplicationWillResignActiveNotification Notification is called for ASAppNotification object");
}

- (void) enteredBackgroundNotification
{
    NSLog(@"UIApplicationDidEnterBackgroundNotification Notification is called  for ASAppNotification object");
}

- (void) enteredForegroundNotification
{
    NSLog(@"UIApplicationWillEnterForegroundNotification Notification is called for ASAppNotification object");
}

- (void) becameActiveNotification
{
    NSLog(@"UIApplicationDidBecomeActiveNotification Notification is called for ASAppNotification object");
}

- (void) WillTerminateNotification
{
    NSLog(@"UIApplicationWillTerminateNotification Notification is called for ASAppNotification object");
}


@end

