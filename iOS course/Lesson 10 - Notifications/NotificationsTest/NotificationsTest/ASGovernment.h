//
//  ASGovernment.h
//  NotificationsTest
//
//  Created by Alex on 9/19/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSNotificationName const ASGovernmentTaxLevelDidChangeNotification;
extern NSNotificationName const ASGovernmentSalaryDidChangeNotification;
extern NSNotificationName const ASGovernmentPensionDidChangeNotification;
extern NSNotificationName const ASGovernmentAveragePriceDidChangeNotification;
extern NSNotificationName const ASGovernmentInflationDidChangeNotification;

extern NSString *const ASGovernmentTaxLevelUserInfoKey;
extern NSString *const ASGovernmentSalaryUserInfoKey;
extern NSString *const ASGovernmentPensionUserInfoKey;
extern NSString *const ASGovernmentAveragePriceUserInfoKey;
extern NSString *const ASGovernmentInflationUserInfoKey;

@interface ASGovernment : NSObject

@property (nonatomic, assign) CGFloat taxLevel;
@property (nonatomic, assign) CGFloat salary;
@property (nonatomic, assign) CGFloat pension;
@property (nonatomic, assign) CGFloat averagePrice;



- (CGFloat) getInflation:(CGFloat) oldAveragePrice;
- (void) enterSleep:(NSNotification *) notification;


@end
