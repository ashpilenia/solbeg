//
//  ASSwimmer.h
//  ASArraysHomeWork
//
//  Created by Alex on 9/4/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#ifndef ASSwimmer_h
#define ASSwimmer_h


#endif /* ASSwimmer_h */
#import "ASHuman.h"
#import "ASSwimmers.h"

@interface ASSwimmer : ASHuman <ASSwimmers>

@property (nonatomic, strong) NSString* p_name;
@property (nonatomic, assign) NSInteger age;


@property (nonatomic, assign) ASSwimStyles style;

- (void) movement;

@end
