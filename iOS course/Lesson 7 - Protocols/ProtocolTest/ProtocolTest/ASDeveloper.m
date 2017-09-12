//
//  ASDeveloper.m
//  ProtocolTest
//
//  Created by Alex on 9/11/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASDeveloper.h"

@implementation ASDeveloper

- (void) work {

}

#pragma mark - ASPatient

- (bool) areYouOK {
    bool ok = arc4random() % 2;
    NSLog(@"Is developer %@ ok? %@", self.name, ok ? @"Yes, he is fine." : @"No, he is not.");
    return ok;
}

- (void) takePill {
    NSLog(@"Developer %@ takes a pill.", self.name);
}

- (void) makeShot {
    NSLog(@"Developer %@ makes a shot.", self.name);
}

- (NSString*) howIsYourJob {
    return @"My job is awesome!";
}

@end
