//
//  ASStudent.h
//  NSDateHomeWork
//
//  Created by Alex on 10/5/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASStudent : NSObject

@property (nonatomic, strong) NSDate *dateOfBirth;
@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *lastName;


- (instancetype) initWithAlias:(NSString *) objName;

@end
