//
//  ASGovernment.m
//  NotificationsTest
//
//  Created by Alex on 9/19/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASGovernment.h"

NSNotificationName const ASGovernmentTaxLevelDidChangeNotification = @"ASGovernmentTaxLevelDidChangeNotification";
NSNotificationName const ASGovernmentSalaryDidChangeNotification = @"ASGovernmentSalaryDidChangeNotification";
NSNotificationName const ASGovernmentPensionDidChangeNotification = @"ASGovernmentPensionDidChangeNotification";
NSNotificationName const ASGovernmentAveragePriceDidChangeNotification = @"ASGovernmentAveragePriceDidChangeNotification";
NSNotificationName const ASGovernmentInflationDidChangeNotification = @"ASGovernmentInflationDidChangeNotification";

NSString *const ASGovernmentTaxLevelUserInfoKey = @"ASGovernmentTaxLevelUserInfoKey";
NSString *const ASGovernmentSalaryUserInfoKey = @"ASGovernmentSalaryUserInfoKey";
NSString *const ASGovernmentPensionUserInfoKey = @"ASGovernmentPensionUserInfoKey";
NSString *const ASGovernmentAveragePriceUserInfoKey = @"ASGovernmentAveragePriceUserInfoKey";
NSString *const ASGovernmentInflationUserInfoKey = @"ASGovernmentInflationUserInfoKey";

@implementation ASGovernment 

- (instancetype)init
{
    self = [super init];
    if (self) {
        _taxLevel = 5.f;
        _salary = 1000.f;
        _pension = 500.f;
        _averagePrice = 10.f;
        
    }
    return self;
}

- (void) setTaxLevel:(CGFloat)taxLevel
{
    _taxLevel = taxLevel;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:taxLevel] forKey:ASGovernmentTaxLevelUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ASGovernmentTaxLevelDidChangeNotification
                                                        object:nil
                                                      userInfo:dic];
}

- (void) setSalary:(CGFloat)salary
{
    _salary = salary;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:salary] forKey:ASGovernmentSalaryUserInfoKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:ASGovernmentSalaryDidChangeNotification
                                                        object:nil
                                                      userInfo:dic];
}

- (void) setPension:(CGFloat)pension
{
    _pension = pension;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:pension] forKey:ASGovernmentPensionUserInfoKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:ASGovernmentPensionDidChangeNotification
                                                        object:nil
                                                      userInfo:dic];
}

- (void) setAveragePrice:(CGFloat)averagePrice
{
    
    
    _averagePrice = averagePrice;
    
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:averagePrice] forKey:ASGovernmentAveragePriceUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ASGovernmentAveragePriceDidChangeNotification
                                                        object:nil
                                                      userInfo:dic];
}


- (CGFloat) getInflation:(CGFloat) oldAveragePrice
{
    CGFloat inflation = 0.f;
    
    if (oldAveragePrice > self.averagePrice)
    {
        inflation = 0;
        NSLog(@"Deflation is started");
    }
    else
    {
        inflation = ((self.averagePrice - oldAveragePrice) * 100 / oldAveragePrice);
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:inflation] forKey:ASGovernmentInflationUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ASGovernmentInflationDidChangeNotification
                                                        object:nil
                                                      userInfo:dic];
    
    return inflation;
}

- (void) enterSleep:(NSNotification *) notification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];
    NSLog(@"%@",notification.name);
}

@end
