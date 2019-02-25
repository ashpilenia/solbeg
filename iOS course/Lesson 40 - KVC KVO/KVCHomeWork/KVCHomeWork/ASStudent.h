//
//  ASStudent.h
//  KVCHomeWork
//
//  Created by Alex on 2/21/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger) {
    
    male,
    female,
    transgender
    
} genderOptions;

typedef NS_ENUM(NSInteger) {
    
    highSchool,
    univercity,
    magistr,
    professor
    
} gradeOptions;


@interface ASStudent : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, assign) genderOptions gender;
@property (nonatomic, assign) gradeOptions grade;
@property (nonatomic, strong) NSDate *birthDate;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, weak) ASStudent *buddy;

- (instancetype)initWithInitialParams;
- (NSString *)gradeString;
- (void)clearSettings;

@end

