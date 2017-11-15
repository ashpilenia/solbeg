//
//  ASEmployee.h
//  UITableView_editing
//
//  Created by Alex on 11/14/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASEmployee : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, assign) NSInteger salary;

+ (ASEmployee *) randomEmployee;

@end
