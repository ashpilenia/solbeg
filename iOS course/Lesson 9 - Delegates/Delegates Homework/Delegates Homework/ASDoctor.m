//
//  ASDoctor.m
//  Delegates Homework
//
//  Created by Alex on 9/15/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASDoctor.h"

@implementation ASDoctor

- (void) takePill:(ASPatient *)pill
{
    NSLog(@"Doctor feeds patient %@ with pills", pill.name);
}

- (void) makeShot:(ASPatient *)shot
{
    NSLog(@"Doctor pierced %@'s ass", shot.name);
}



@end
