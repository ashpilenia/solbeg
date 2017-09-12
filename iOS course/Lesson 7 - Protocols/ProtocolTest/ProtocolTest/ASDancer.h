//
//  ASDancer.h
//  ProtocolTest
//
//  Created by Alex on 9/11/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASPatient.h"

@interface ASDancer : NSObject <ASPatient>


@property (nonatomic, strong) NSString* favouriteDance;
@property (nonatomic, strong) NSString* name;

- (void) dance;

@end
