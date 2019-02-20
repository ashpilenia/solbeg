//
//  ASStudent.h
//  KVCTest
//
//  Created by Alex on 2/18/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASStudent : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;

- (void)changeName;

@end

