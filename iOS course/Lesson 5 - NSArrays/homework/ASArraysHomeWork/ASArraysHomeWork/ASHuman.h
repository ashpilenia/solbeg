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
#import "ASJumpers.h"

@interface ASHuman : NSObject <ASJumpers>

@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) CGFloat weight;
@property (nonatomic, strong) NSString* gender;


@property (nonatomic, assign) NSInteger p_height;
@property (nonatomic, strong) NSString* p_name;
@property (nonatomic, assign) BOOL balance;

- (void) movement;
- (NSComparisonResult) compare;



@end
