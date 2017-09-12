//
//  ASDancer.m
//  ProtocolTest
//
//  Created by Alex on 9/11/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASDancer.h"

@implementation ASDancer

- (void) dance {

}

#pragma mark - ASPatient

- (bool) areYouOK {
    bool ok = arc4random() % 2;
    NSLog(@"Is dancer %@ ok? %@", self.name, ok ? @"Yes." : @"No.");
    return ok;
}


- (void) takePill {
    NSLog(@"Dancer %@ takes a pill.", self.name);
}


- (void) makeShot {
    NSLog(@"Dancer %@ makes a shot", self.name);
}

- (NSString*) howIsYourFamily {
    return @"My family is doing well.";
}

@end
