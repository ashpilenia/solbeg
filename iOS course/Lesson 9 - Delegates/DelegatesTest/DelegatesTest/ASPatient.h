//
//  ASPatient.h
//  DelegatesTest
//
//  Created by Alex on 9/14/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol ASPatientDelegate;
@interface ASPatient : NSObject


@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) CGFloat temperature;
@property (nonatomic, weak) id <ASPatientDelegate> delegate;

- (void) takePill;
- (void) makeShot;
- (BOOL) howAreYou;

@end



@protocol ASPatientDelegate <NSObject>

- (void) patient:(ASPatient*) patient iHaveQuestion:(NSString*) question;
- (void) patientFeelsBad:(ASPatient*) patient;

 @end
