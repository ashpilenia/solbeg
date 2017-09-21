//
//  ASPensioner.m
//  NotificationsTest
//
//  Created by Alex on 9/20/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASPensioner.h"
#import "ASGovernment.h"

@implementation ASPensioner

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        [nc addObserver:self
               selector:@selector(pensionChangedNotification:)
                   name:ASGovernmentPensionDidChangeNotification
                 object:nil];
        
        [nc addObserver:self
               selector:@selector(averagePriceChanged:)
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

#pragma mark - Notifications

- (void) pensionChangedNotification:(NSNotification *) notification
{
    NSNumber *value = [notification.userInfo objectForKey:ASGovernmentPensionUserInfoKey];
    
    CGFloat pension = [value floatValue];
    
    if (pension < self.pension)
    {
        NSLog(@"Pensioners are NOT happy with their pension");
    }
    else
    {
        NSLog(@"Pensioners are happy with their pension");
    }
    
    self.pension = pension;
}

- (void) averagePriceChanged:(NSNotification *) notification
{
    NSNumber *value = [notification.userInfo objectForKey:ASGovernmentAveragePriceUserInfoKey];
    
    CGFloat averagePrice = [value floatValue];
    
    if (averagePrice > self.averagePrice)
    {
        NSLog(@"Pensioners are NOT happy with average price");
    }
    
    else
    {
        NSLog(@"Pensioners are happy with average price");
    }
    
    self.averagePrice = averagePrice;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) inflationChangedNotification:(NSNotification *) notification
{
    NSNumber *value = [notification.userInfo objectForKey:ASGovernmentInflationUserInfoKey];
    CGFloat inflation = [value floatValue];
    
    if (inflation)
    {
        NSLog(@"Pensioners are NOT happy with inflation");
    }
    else
    {
        NSLog(@"Pensioners are happy with inflation");
    }
    
    CGFloat buyingAvailability = (self.pension / self.averagePrice);
    
    NSLog(@"Pensioner's buying availability = %f", buyingAvailability);
    
    if (buyingAvailability <= 40)
    {
        NSLog(@"Pensioners are dying right now");
    }
    else
    {
        NSLog(@"Pensioners can buy some food");
    }
}

- (void) enteredBackgroundNotification
{
    NSLog(@"Pensioner is going to sleep");
}

- (void) becameActiveNotification
{
    NSLog(@"Pensioner is awake");
}

@end
