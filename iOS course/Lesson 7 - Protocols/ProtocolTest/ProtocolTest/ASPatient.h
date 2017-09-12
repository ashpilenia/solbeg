//
//  ASPatient.h
//  ProtocolTest
//
//  Created by Alex on 9/11/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ASPatient <NSObject>

@property (nonatomic, strong) NSString* name;

@required

- (bool) areYouOK;
- (void) takePill;
- (void) makeShot;

@optional
- (NSString*) howIsYourFamily;
- (NSString*) howIsYourJob;

@end
