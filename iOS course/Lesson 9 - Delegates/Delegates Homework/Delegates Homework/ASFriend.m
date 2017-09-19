//
//  ASFriend.m
//  Delegates Homework
//
//  Created by Alex on 9/15/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASFriend.h"

@implementation ASFriend

- (void) takePill:(ASPatient*) pill
{
    NSLog(@"Placebo has been fed to %@", pill.name);
}

- (void) makeShot:(ASPatient*) shot
{
    NSLog(@"gutshot has been made to %@", shot.name);
}

@end
