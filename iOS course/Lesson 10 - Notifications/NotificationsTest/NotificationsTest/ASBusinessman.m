//
//  ASBusinessman.m
//  NotificationsTest
//
//  Created by Alex on 9/20/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASBusinessman.h"
#import "ASGovernment.h"

@implementation ASBusinessman

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        [nc addObserver:self
               selector:@selector(taxLevelChangedNotification:)
                   name:ASGovernmentTaxLevelDidChangeNotification
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
        
        self.income = 5000;
        
    }
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void) taxLevelChangedNotification:(NSNotification *) notification
{
    NSNumber *value = [notification.userInfo objectForKey:ASGovernmentTaxLevelUserInfoKey];
    
    CGFloat taxLevel = [value floatValue];
    
    if (taxLevel > self.taxLevel)
    {
        NSLog(@"Businessmen are NOT happy with taxes");
    }
    else
    {
        NSLog(@"Businessmen are happy with taxes");
    }
    
    self.taxLevel = taxLevel;
}

- (void) averagePriceChanged:(NSNotification *) notification
{
    NSNumber *value = [notification.userInfo objectForKey:ASGovernmentAveragePriceUserInfoKey];
    
    CGFloat averagePrice = [value floatValue];
    
    if (self.averagePrice < averagePrice)
    {
        NSLog(@"Businessmen are NOT happy with average price");
    }
    else
    {
        NSLog(@"Businessmen are happy with average price");
    }
    
    self.averagePrice = averagePrice;
}

- (void) inflationChangedNotification:(NSNotification *) notification
{
    NSNumber *value = [notification.userInfo objectForKey:ASGovernmentInflationUserInfoKey];
    CGFloat inflation = [value floatValue];
    
    if (inflation)
    {
        NSLog(@"Businessmen are NOT happy with inflation");
    }
    else
    {
        NSLog(@"Businessmen are happy with inflation");
    }
    
    CGFloat buyingAvailability = ((self.income - self.taxLevel) / self.averagePrice);
    
    NSLog(@"Businessman's buying availability = %f", buyingAvailability);
    
    if (buyingAvailability <= 350)
    {
        NSLog(@"Businessmen are in conspiracy against the government");
    }
    else
    {
        NSLog(@"Businessmen are calm for now");
    }
}

- (void) enteredBackgroundNotification
{
    NSLog(@"Businessman is going to sleep");
}

- (void) becameActiveNotification
{
    NSLog(@"Businessman is awake");
}

@end
