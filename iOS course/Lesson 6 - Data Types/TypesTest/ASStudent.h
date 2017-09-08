//
//  ASStudent.h
//  TypesTest
//
//  Created by Alex on 9/6/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASStudent : NSObject


typedef enum {
    Male,
    Female,
    Trans
} ASGender;

typedef enum {
    Vasilevskiy,
    Nikitin,
    Ermak,
    Alexandrovich,
    CaptainAmerika
} ASLastName;

typedef enum {
    child,
    teenager,
    adult,
    aged
} ASAge;

typedef enum{
    white,
    black,
    asian,
    mixed
} ASRace;

@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) ASGender gender;
@property (nonatomic, assign) ASLastName last_name;
@property (nonatomic, assign) ASAge age;
@property (nonatomic, assign) ASRace race;

- (NSString*) formatRaceToString: (ASRace) formatType;
- (NSString*) formatLastNameToString:(ASLastName) formatType;
- (NSString*) formatAgeToString:(ASAge) formatType;
- (NSString*) formatGenderToString:(ASGender) dataType;

@end
