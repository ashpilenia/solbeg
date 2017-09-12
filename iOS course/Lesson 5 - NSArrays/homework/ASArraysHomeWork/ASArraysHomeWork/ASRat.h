//
//  ASRat.h
//  ASArraysHomeWork
//
//  Created by Alex on 9/4/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASAnimal.h"
#import "ASSwimmers.h"

@interface ASRat : ASAnimal <ASSwimmers>

@property (nonatomic, strong) NSString* p_name;
@property (nonatomic, assign) NSInteger age;

- (void) movement;


@end
