//
//  ASStudent.m
//  TypesTest
//
//  Created by Alex on 9/6/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASStudent.h"

@implementation ASStudent

- (NSString*) formatRaceToString: (ASRace) formatType {
    NSString* result = nil;
    switch (formatType) {
        case white:
            result = @"white";
            break;
        case black:
            result = @"black";
            break;
        case asian:
            result = @"asian";
            break;
        case mixed:
            result = @"mixed";
            break;
            
        default: [NSException raise:NSGenericException format:@"Unknown data type."];
            break;
    }
    return result;
}

- (NSString*) formatLastNameToString:(ASLastName) formatType {
    NSString* result = nil;
    switch (formatType) {
        case Vasilevskiy:
            result = @"Vasilevskiy";
            break;
        case CaptainAmerika:
            result = @"CaptainAmerica";
            break;
        case Nikitin:
            result = @"Nikitin";
            break;
        case Alexandrovich:
            result = @"Alexandrovich";
            break;
        case Ermak:
            result = @"Ermak";
            break;
        
            
        default: [NSException raise:NSGenericException format:@"Unknown data type."];
            break;
    }
    return result;
}

- (NSString*) formatAgeToString:(ASAge) formatType {
    NSString* result = nil;
    switch (formatType) {
        case aged:
            result = @"aged";
            break;
        case adult:
            result = @"adult";
            break;
        case teenager:
            result = @"teenager";
            break;
        case child:
            result = @"child";
            break;
        
            
        default: [NSException raise:NSGenericException format:@"Unknown data type."];
            break;
    }
    return result;
}

- (NSString*) formatGenderToString:(ASGender) dataType {
    NSString* result = nil;
    switch (dataType) {
        case Male:
            result = @"Male";
            break;
        case Female:
            result = @"Female";
            break;
        case Trans:
            result = @"Transgender";
            break;
            
        default: [NSException raise:NSGenericException format:@"Unknown data type."];
            break;
    }
    return result;
}

@end
