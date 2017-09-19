//
//  ASPatient.m
//  Delegates Homework
//
//  Created by Alex on 9/15/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASPatient.h"

@implementation ASPatient

- (BOOL) gettingWorse
{
    BOOL hp = TRUE;//arc4random() % 2;
    return hp;
}


- (void) firstHelp
{
    [self.delegate takePill:self];
}

- (void) urgentHelp
{
    [self.delegate makeShot:self];
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
            [self.delegate takePill:self];
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
            [self.delegate makeShot:self];
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



@end
