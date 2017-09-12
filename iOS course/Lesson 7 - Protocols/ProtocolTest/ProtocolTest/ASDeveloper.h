//
//  ASDeveloper.h
//  ProtocolTest
//
//  Created by Alex on 9/11/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ASPatient.h"

@interface ASDeveloper : NSObject <ASPatient>

@property (nonatomic, assign) CGFloat experience;
@property (nonatomic, strong) NSString* name;

- (void) work;


@end
