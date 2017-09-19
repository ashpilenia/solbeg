//
//  ASDoctor.h
//  DelegatesTest
//
//  Created by Alex on 9/14/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASPatient.h"

@protocol ASPatientDelegate;



@interface ASDoctor : NSObject <ASPatientDelegate>

@end
