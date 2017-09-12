//
//  ASStudent.m
//  ProtocolTest
//
//  Created by Alex on 9/11/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASStudent.h"

@implementation ASStudent

- (void) study {

}

#pragma mark - ASPatient

- (bool) areYouOK {
    bool ok = arc4random() % 2;
    NSLog(@"Is student %@ ok? %@", self.name, ok ? @"Yes." : @"No.");
    return ok;
}


- (void) takePill {
    NSLog(@"Student %@ takes a pill.", self.name);
}


- (void) makeShot {
    NSLog(@"Student %@ makes a shot", self.name);
}

@end
