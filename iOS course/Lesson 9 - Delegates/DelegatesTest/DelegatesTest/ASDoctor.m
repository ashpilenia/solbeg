//
//  ASDoctor.m
//  DelegatesTest
//
//  Created by Alex on 9/14/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASDoctor.h"
#import "ASPatient.h"

@implementation ASDoctor

#pragma mark ASPatientDelegate

- (void) patient:(ASPatient*) patient iHaveQuestion:(NSString*) question
{
    NSLog(@"Patient %@ has a question: %@", patient.name, question);
}

- (void) patientFeelsBad:(ASPatient*) patient
{
    NSLog(@"Patient %@ feels bad", patient.name);
    if (patient.temperature > 38.f && patient.temperature < 40.f)
    {
        [patient takePill];
    }
    else if (patient.temperature >= 40.f)
    {
        [patient makeShot];
    }
    else
    {
        NSLog(@"Patient %@ should rest", patient.name);
    }
}

@end
