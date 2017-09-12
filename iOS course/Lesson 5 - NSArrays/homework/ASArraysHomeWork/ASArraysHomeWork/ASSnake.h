//
//  ASSnake.h
//  ASArraysHomeWork
//
//  Created by Alex on 9/4/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASAnimal.h"
#import "ASJumpers.h"

@interface ASSnake : ASAnimal  <ASJumpers>

@property (nonatomic, assign) NSInteger p_height;
@property (nonatomic, strong) NSString* p_name;

- (void) movement;

@end
