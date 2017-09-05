//
//  ASAnimal.h
//  ASArraysHomeWork
//
//  Created by Alex on 9/4/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASAnimal : NSObject

@property (nonatomic, strong) NSString* a_name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSString* a_gender;

- (void) movement;
- (NSComparisonResult) compare;

@end
