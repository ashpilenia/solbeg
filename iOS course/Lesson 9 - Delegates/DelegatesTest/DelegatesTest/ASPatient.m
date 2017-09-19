//
//  ASPatient.m
//  DelegatesTest
//
//  Created by Alex on 9/14/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASPatient.h"

@implementation ASPatient

- (void) takePill
{
    NSLog(@"%@ takes a pill", self.name);
}

- (void) makeShot
{
    NSLog(@"%@ makes a shot", self.name);
}

- (BOOL) howAreYou
{
    BOOL iFeelGood = arc4random() % 2;
    if (!iFeelGood)
    {
        [self.delegate patientFeelsBad:self];
    }
    return iFeelGood;
}



@end
