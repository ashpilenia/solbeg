//
//  ASStudent.h
//  BitsTest
//
//  Created by Alex on 10/3/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ASStudentSubjectType){
    
    ASStudentSubjectTypeBiology         = 1 << 0,
    ASStudentSubjectTypeArt             = 1 << 1,
    ASStudentSubjectTypeMath            = 1 << 2,
    ASStudentSubjectTypeDevelopment     = 1 << 3,
    ASStudentSubjectTypeEngineering     = 1 << 4,
    ASStudentSubjectTypeAnatomy         = 1 << 5,
    ASStudentSubjectTypePsychology      = 1 << 6,
    
    ASStudentSubjectTypeAll =
    ASStudentSubjectTypeBiology |
    ASStudentSubjectTypeArt |
    ASStudentSubjectTypeMath |
    ASStudentSubjectTypeDevelopment |
    ASStudentSubjectTypeEngineering |
    ASStudentSubjectTypeAnatomy |
    ASStudentSubjectTypePsychology
};

//ASStudentSubjectType
@interface ASStudent : NSObject


@property (nonatomic, strong) NSString *alias;
@property (nonatomic, assign) ASStudentSubjectType subjectType;

/*
@property (nonatomic, assign) BOOL biology;
@property (nonatomic, assign) BOOL art;
@property (nonatomic, assign) BOOL math;
@property (nonatomic, assign) BOOL development;
@property (nonatomic, assign) BOOL engineering;
@property (nonatomic, assign) BOOL anatomy;
@property (nonatomic, assign) BOOL psychology;
*/

- (id) initWithAlias:(NSString *) anAlias;

+ (NSString *) numberConvertToBinary:(NSInteger) intValue;

@end
