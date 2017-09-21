//
//  ASDoctor.m
//  NotificationsTest
//
//  Created by Alex on 9/20/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASDoctor.h"
#import "ASGovernment.h"

@implementation ASDoctor

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        [nc addObserver:self
               selector:@selector(salaryChangedNotification:)
                   name:ASGovernmentSalaryDidChangeNotification
                 object:nil];
        
        [nc addObserver:self
               selector:@selector(averagePriceChangedNotification:)
                   name:ASGovernmentAveragePriceDidChangeNotification
                 object:nil];
        
        [nc addObserver:self
               selector:@selector(inflationChangedNotification:)
                   name:ASGovernmentInflationDidChangeNotification
                 object:nil];
        
        [nc addObserver:self
               selector:@selector(enteredBackgroundNotification)
                   name:UIApplicationDidEnterBackgroundNotification
                 object:nil];
        
        [nc addObserver:self
               selector:@selector(becameActiveNotification)
                   name:UIApplicationDidBecomeActiveNotification
                 object:nil];
        
    }
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void) salaryChangedNotification:(NSNotification *) notification
{
    NSNumber *value = [notification.userInfo objectForKey:ASGovernmentSalaryUserInfoKey];
    
    CGFloat salary = [value floatValue];
    
    if (salary < self.salary)
    {
        NSLog(@"Doctors are NOT happy with their salary");
    }
    else
    {
        NSLog(@"Doctors are happy with their salary");
    }
    
    self.salary = salary;
}



- (void) averagePriceChangedNotification:(NSNotification *) notification
{
    NSNumber *value = [notification.userInfo objectForKey:ASGovernmentAveragePriceUserInfoKey];
    
    CGFloat averagePrice = [value floatValue];
    
    if (averagePrice > self.averagePrice)
    {
        NSLog(@"Doctors are NOT happy with average price");
    }
    
    else
    {
        NSLog(@"Doctors are happy with average price");
    }
    
    self.averagePrice = averagePrice;
}

- (void) inflationChangedNotification:(NSNotification *) notification
{
    NSNumber *value = [notification.userInfo objectForKey:ASGovernmentInflationUserInfoKey];
    CGFloat inflation = [value floatValue];
    
    if (inflation)
    {
        NSLog(@"Doctors are NOT happy with inflation");
    }
    else
    {
        NSLog(@"Doctors are happy with inflation");
    }
    
    CGFloat buyingAvailability = (self.salary / self.averagePrice);
    
    NSLog(@"Doctor's buying availability = %f", buyingAvailability);
    
    if (buyingAvailability <= 80)
    {
        NSLog(@"Doctors staged a strike");
    }
    else
    {
        NSLog(@"Doctors are quiet");
    }
}

- (void) enteredBackgroundNotification
{
    NSLog(@"Doctor is going to sleep");
}

- (void) becameActiveNotification
{
    NSLog(@"Doctor is awake");
}

@end
