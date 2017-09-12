//
//  ASCyclist.h
//  ASArraysHomeWork
//
//  Created by Alex on 9/4/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#ifndef ASCyclist_h
#define ASCyclist_h


#endif /* ASCyclist_h */
#import "ASHuman.h"
#import "ASRunners.h"

@interface ASCyclist : ASHuman <ASRunners>

@property (nonatomic, strong) NSString* p_name;
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) NSInteger distance;

- (void) movement;

@end
