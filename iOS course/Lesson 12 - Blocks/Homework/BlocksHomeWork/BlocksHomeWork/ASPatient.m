//
//  ASPatient.m
//  BlocksHomeWork
//
//  Created by Alex on 9/26/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASPatient.h"
#import "AppDelegate.h"

NSNotificationName const ASPatientGettingWorseNotifiaction = @"ASPatientGettingWorseNotifiaction";

@implementation ASPatient

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.feelsBad = NO;
       [self performSelector:@selector(gettingWorse) withObject:self afterDelay:arc4random_uniform(15)];
    }
    return self;
}


- (BOOL) gettingWorse
{
    BOOL hp = YES; //arc4random() % 2;
    self.feelsBad = YES;
    return hp;
    
}

- (void) setFeelsBad:(BOOL)feelsBad
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ASPatientGettingWorseNotifiaction object:nil];
}

- (NSInteger) organ
{
    NSInteger org = arc4random_uniform(3);
    return org;
}


- (void) firstHelpUpd:(NSInteger) number
{
    switch (number) {
        case 0:
            [self takePill];
            break;
        case 1:
            NSLog(@"Go buy asperin");
            break;
        case 2:
            NSLog(@"no pill will help you with your back");
            break;
        case 3:
            NSLog(@"take those %u pill(s)",arc4random_uniform(10));
            break;
            
        default: NSLog(@"invalid organ");
            break;
    }
}



- (void) urgentHelpUpd:(NSInteger) number
{
    switch (number) {
        case 0:
            NSLog(@"No help for you");
            break;
        case 1:
            NSLog(@"shot to the head");
            break;
        case 2:
            NSLog(@"Shot from behind");
            break;
        case 3:
            [self makeShot];
            break;
            
        default:NSLog(@"invalid organ");
            break;
    }
}


- (NSString*) formatOrganToString:(ASOrgan) organ
{
    NSString* str = nil;
    
    switch (organ)
    {
        case stomach:
            str = @"Stomach";
            break;
        case head:
            str = @"Head";
            break;
        case back:
            str = @"Back";
            break;
        case ass:
            str = @"Ass";
            break;
            
        default: NSLog(@"Invalid organ was entered");
            break;
    }
    return str;
}


- (void) blockHealing:(OurTestBlock) var {
    var(self);
}

- (void) takePill
{
    NSLog(@"A pill has been fed to the patient");
}

- (void) makeShot
{

    NSLog(@"A shot has been done to the patient");
}

- (void) dealloc {
    NSLog(@"object is deallocated");
}

@end
