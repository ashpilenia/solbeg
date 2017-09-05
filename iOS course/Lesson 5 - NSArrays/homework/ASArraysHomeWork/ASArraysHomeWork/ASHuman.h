//
//  ASHuman.h
//  ASArraysHomeWork
//
//  Created by Alex on 9/4/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#ifndef ASHuman_h
#define ASHuman_h


#endif /* ASHuman_h */
#import <UIKit/UIKit.h>

@interface ASHuman : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) CGFloat weight;
@property (nonatomic, strong) NSString* gender;

- (void) movement;
- (NSComparisonResult) compare;

@end
