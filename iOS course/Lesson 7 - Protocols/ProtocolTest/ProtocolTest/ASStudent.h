//
//  ASStudent.h
//  ProtocolTest
//
//  Created by Alex on 9/11/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASPatient.h"


@interface ASStudent : NSObject <ASPatient>

@property (nonatomic, strong) NSString* universityNname;
@property (nonatomic, strong) NSString* name;

- (void) study;

@end
