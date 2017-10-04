//
//  ASStudent.m
//  BitsTest
//
//  Created by Alex on 10/3/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASStudent.h"


@implementation ASStudent

/*
- (NSString *) description
{
    return [NSString stringWithFormat: @"Student studies:\n"
                                        "biology = %@\n"
                                        "math = %@\n"
                                        "development = %@\n"
                                        "engineering = %@\n"
                                        "art = %@\n"
                                        "psychology = %@\n"
                                        "anatomy = %@",
                                        self.biology ? @"YES" : @"NO",
                                        self.math ? @"YES" : @"NO",
                                        self.development ? @"YES" : @"NO",
                                        self.engineering ? @"YES" : @"NO",
                                        self.art ? @"YES" : @"NO",
                                        self.psychology ? @"YES" : @"NO",
                                        self.anatomy ? @"YES" : @"NO"];
}

*/
- (NSString *) answerByType:(ASStudentSubjectType) type
{
    return self.subjectType & type ? @"YES" : @"NO";
}

- (NSString *) description
{
    return [NSString stringWithFormat: @"biology = %@\n"
                                        "math = %@\n"
                                        "development = %@\n"
                                        "engineering = %@\n"
                                        "art = %@\n"
                                        "psychology = %@\n"
                                        "anatomy = %@",
                                        [self answerByType:ASStudentSubjectTypeBiology],
                                        [self answerByType:ASStudentSubjectTypeMath],
                                        [self answerByType:ASStudentSubjectTypeDevelopment],
                                        [self answerByType:ASStudentSubjectTypeEngineering],
                                        [self answerByType:ASStudentSubjectTypeArt],
                                        [self answerByType:ASStudentSubjectTypePsychology],
                                        [self answerByType:ASStudentSubjectTypeAnatomy]];
            
            
}

- (id) initWithAlias:(NSString *) anAlias
{
    self = [super init];
    if (self)
    {
        self.alias = anAlias;
    }
    return self;
}

+ (NSString *) numberConvertToBinary:(NSInteger) intValue
{
    NSString *string = @"";
    NSInteger i = intValue;
    
    while (i > 0)
    {
        string = [[NSString stringWithFormat:@"%ld",i&1] stringByAppendingString:string];
        i = i >> 1;
    }
    
    return string;
}



@end
